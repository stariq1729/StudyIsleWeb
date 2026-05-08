using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class AddSubject : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId", "-- Select Board --");
            }
        }
        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshResourceTypes();
        }
        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubCategories();

            // IMPORTANT:
            // If no subcategories exist,
            // classes should still load directly
            if (!phSubCategory.Visible)
            {
                RefreshClasses();
            }
        }
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshClasses();
        }

        //protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    ResetPlaceholders();
        //    if (ddlBoard.SelectedValue != "0")
        //    {
        //        phResourceType.Visible = true;
        //        BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Flow --");
        //    }
        //}

        //protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
        //    phSubCategory.Visible = true;
        //    phClass.Visible = true;

        //    // Load SubCategories filtered by Board
        //    BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId={boardId}", ddlSubCategory, "SubCategoryName", "SubCategoryId", "No Sub-Category (Optional)");

        //    // Load Classes filtered by Board
        //    BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}", ddlClass, "ClassName", "ClassId", "General (No Class)");
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedValue == "0" || ddlResourceType.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtSubjectName.Text))
            {
                ShowError("Board, Resource Type, and Name are required.");
                return;
            }

            string iconName = "default.png";
            if (fuIcon.HasFile)
            {
                iconName = Guid.NewGuid() + Path.GetExtension(fuIcon.FileName);
                fuIcon.SaveAs(Server.MapPath("~/Uploads/SubjectIcons/") + iconName);
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"INSERT INTO Subjects 
(BoardId, ResourceTypeId, SubCategoryId, ClassId, SubjectName, Slug, IconImage, PageTitle, PageSubtitle, Edition, Description, IsActive, CreatedAt)
VALUES (@BID, @RTID, @SCID, @CID, @Name, @Slug, @Icon, @Title, @Subtitle, @Edition, @Desc, 1, GETDATE())";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);
                cmd.Parameters.AddWithValue("@SCID", ddlSubCategory.SelectedValue == "0" ? (object)DBNull.Value : ddlSubCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@CID", ddlClass.SelectedValue == "0" ? (object)DBNull.Value : ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@Name", txtSubjectName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", txtSlug.Text);
                cmd.Parameters.AddWithValue("@Icon", iconName);
                cmd.Parameters.AddWithValue("@Title", txtPageTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Subtitle",
    string.IsNullOrWhiteSpace(txtPageSubtitle.Text)
    ? (object)DBNull.Value
    : txtPageSubtitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Edition",
    string.IsNullOrWhiteSpace(txtEdition.Text)
    ? (object)DBNull.Value
    : txtEdition.Text.Trim());
                cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("ManageSubjects.aspx");
            }
        }

        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt; ddl.DataTextField = text; ddl.DataValueField = value; ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }

        private void ResetDDL(DropDownList ddl, string defaultText)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem(defaultText, "0"));
        }
        private void RefreshResourceTypes()
        {
            // Reset lower hierarchy
            ResetDDL(ddlResourceType, "-- Select Flow --");
            ResetDDL(ddlSubCategory, "No Sub-Category (Optional)");
            ResetDDL(ddlClass, "General (No Class)");

            // Hide lower hierarchy
            phResourceType.Visible = false;
            phSubCategory.Visible = false;
            phClass.Visible = false;

            // Stop if no board selected
            if (ddlBoard.SelectedValue == "0")
                return;

            phResourceType.Visible = true;

            string query = @"
        SELECT DISTINCT rt.ResourceTypeId, rt.TypeName
        FROM ResourceTypes rt
        INNER JOIN BoardResourceMapping brm
            ON rt.ResourceTypeId = brm.ResourceTypeId
        WHERE brm.BoardId = @BoardId
        AND rt.IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();

                ddlResourceType.Items.Insert(0,
                    new ListItem("-- Select Flow --", "0"));
            }
        }
        private void RefreshSubCategories()
        {
            // Reset lower hierarchy first
            ResetDDL(ddlSubCategory, "No Sub-Category (Optional)");
            ResetDDL(ddlClass, "General (No Class)");

            phSubCategory.Visible = false;
            phClass.Visible = false;

            // Stop if resource type not selected
            if (ddlResourceType.SelectedValue == "0")
                return;

            string query = @"
        SELECT SubCategoryId, SubCategoryName
        FROM SubCategories
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId
        AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                // IMPORTANT:
                // Show SubCategory only if records exist
                if (dt.Rows.Count > 0)
                {
                    phSubCategory.Visible = true;

                    ddlSubCategory.DataSource = dt;
                    ddlSubCategory.DataTextField = "SubCategoryName";
                    ddlSubCategory.DataValueField = "SubCategoryId";
                    ddlSubCategory.DataBind();

                    ddlSubCategory.Items.Insert(0,
                        new ListItem("No Sub-Category (Optional)", "0"));
                }
            }
        }
        private void RefreshClasses()
        {
            // Reset first
            ResetDDL(ddlClass, "General (No Class)");

            phClass.Visible = false;

            // Stop if resource type not selected
            if (ddlResourceType.SelectedValue == "0")
                return;

            string query = @"
        SELECT ClassId, ClassName
        FROM Classes
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId";

            // IMPORTANT:
            // Handle optional SubCategory hierarchy
            if (ddlSubCategory.SelectedValue != "0")
            {
                query += " AND SubCategoryId = @SubCategoryId";
            }
            else
            {
                query += " AND SubCategoryId IS NULL";
            }

            query += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                // Only add parameter if subcategory selected
                if (ddlSubCategory.SelectedValue != "0")
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCategoryId",
                        ddlSubCategory.SelectedValue);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Show Class only if records exist
                if (dt.Rows.Count > 0)
                {
                    phClass.Visible = true;

                    ddlClass.DataSource = dt;
                    ddlClass.DataTextField = "ClassName";
                    ddlClass.DataValueField = "ClassId";
                    ddlClass.DataBind();

                    ddlClass.Items.Insert(0,
                        new ListItem("General (No Class)", "0"));
                }
            }
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtSubjectName.Text.ToLower(), @"[^a-z0-9]", "-").Trim('-');
        }

        private void ShowError(string msg) { lblMessage.Text = msg; lblMessage.CssClass = "alert alert-danger"; }
    }
}