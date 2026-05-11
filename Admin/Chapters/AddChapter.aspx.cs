using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddChapter : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1",
                    ddlBoard, "BoardName", "BoardId", "-- Select Board --");

                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes",
                    ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Resource Type --");
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
            // classes may still exist directly
            RefreshClasses();

            RefreshSubjects();
        }
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshClasses();

            RefreshSubjects();
        }
        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubjects();
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Validation
                if (chkIsQuizEnabled.Checked && chkIsFlashcardEnabled.Checked)
                {
                    lblMessage.Text = "⚠️ Only one option allowed: Quiz OR Flashcards.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                if (ddlBoard.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtChapterName.Text))
                {
                    lblMessage.Text = "⚠️ Board and Chapter Name are required.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // ✅ UPDATED: Added ClassId
                    string sql = @"INSERT INTO Chapters 
                    (BoardId, ResourceTypeId, SubCategoryId, ClassId, SubjectId, ChapterName, Slug, DisplayOrder, IsActive, IsQuizEnabled, IsFlashcardEnabled, CreatedAt) 
                    VALUES 
                    (@BID, @RTID, @SCID, @ClassId, @SID, @Name, @Slug, @Order, @Active, @IsQuiz, @IsFlash, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);

                    cmd.Parameters.AddWithValue("@RTID",
                        ddlResourceType.SelectedValue != "0"
                        ? (object)ddlResourceType.SelectedValue
                        : DBNull.Value);

                    cmd.Parameters.AddWithValue("@SCID",
                        ddlSubCategory.SelectedValue != "0"
                        ? (object)ddlSubCategory.SelectedValue
                        : DBNull.Value);

                    // ✅ FIX: ClassId now saving
                    cmd.Parameters.AddWithValue("@ClassId",
                        ddlLevel.SelectedValue != "0"
                        ? (object)ddlLevel.SelectedValue
                        : DBNull.Value);

                    cmd.Parameters.AddWithValue("@SID",
                        ddlSubject.SelectedIndex > 0
                        ? (object)ddlSubject.SelectedValue
                        : DBNull.Value);

                    cmd.Parameters.AddWithValue("@Name", txtChapterName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());

                    cmd.Parameters.AddWithValue("@Order",
                        string.IsNullOrEmpty(txtDisplayOrder.Text)
                        ? 0
                        : int.Parse(txtDisplayOrder.Text));

                    cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);

                    cmd.Parameters.AddWithValue("@IsQuiz", chkIsQuizEnabled.Checked);
                    cmd.Parameters.AddWithValue("@IsFlash", chkIsFlashcardEnabled.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "✅ Chapter added successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Database Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // Helper Methods
        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();

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
            // Reset everything below Board
            ResetDDL(ddlResourceType, "-- Select Resource Type --");

            ResetDDL(ddlSubCategory, "-- Select Sub-Category --");
            ResetDDL(ddlLevel, "-- Select Class --");
            ResetDDL(ddlSubject, "-- Select Subject (Optional) --");

            // Hide optional hierarchy initially
            phSubCategory.Visible = false;
            phClass.Visible = false;

            // Stop if no board selected
            if (ddlBoard.SelectedValue == "0")
                return;

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

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();

                ddlResourceType.Items.Insert(0,
                    new ListItem("-- Select Resource Type --", "0"));
            }
        }
        private void RefreshSubCategories()
        {
            // Reset lower hierarchy first
            ResetDDL(ddlSubCategory, "-- Select Sub-Category --");
            ResetDDL(ddlSubject, "-- Select Subject (Optional) --");

            phSubCategory.Visible = false;

            // Stop if no resource type selected
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

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Show hierarchy only if records exist
                if (dt.Rows.Count > 0)
                {
                    phSubCategory.Visible = true;

                    ddlSubCategory.DataSource = dt;
                    ddlSubCategory.DataTextField = "SubCategoryName";
                    ddlSubCategory.DataValueField = "SubCategoryId";
                    ddlSubCategory.DataBind();

                    ddlSubCategory.Items.Insert(0,
                        new ListItem("-- Select Sub-Category --", "0"));
                }
            }
        }
        private void RefreshClasses()
        {
            // Reset lower hierarchy
            ResetDDL(ddlLevel, "-- Select Class --");
            ResetDDL(ddlSubject, "-- Select Subject (Optional) --");

            phClass.Visible = false;

            // Stop if no resource type selected
            if (ddlResourceType.SelectedValue == "0")
                return;

            string query = @"
        SELECT ClassId, ClassName
        FROM Classes
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId";

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

                // Show hierarchy only if records exist
                if (dt.Rows.Count > 0)
                {
                    phClass.Visible = true;

                    ddlLevel.DataSource = dt;
                    ddlLevel.DataTextField = "ClassName";
                    ddlLevel.DataValueField = "ClassId";
                    ddlLevel.DataBind();

                    ddlLevel.Items.Insert(0,
                        new ListItem("-- Select Class --", "0"));
                }
            }
        }
        private void RefreshSubjects()
        {
            ResetDDL(ddlSubject, "-- Select Subject (Optional) --");

            // Stop if no resource type selected
            if (ddlResourceType.SelectedValue == "0")
                return;

            string query = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId";

            // Handle optional SubCategory
            if (ddlSubCategory.SelectedValue != "0")
            {
                query += " AND SubCategoryId = @SubCategoryId";
            }
            else
            {
                query += " AND SubCategoryId IS NULL";
            }

            // Handle optional Class
            if (ddlLevel.SelectedValue != "0")
            {
                query += " AND ClassId = @ClassId";
            }
            else
            {
                query += " AND ClassId IS NULL";
            }

            query += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                // Optional SubCategory parameter
                if (ddlSubCategory.SelectedValue != "0")
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCategoryId",
                        ddlSubCategory.SelectedValue);
                }

                // Optional Class parameter
                if (ddlLevel.SelectedValue != "0")
                {
                    da.SelectCommand.Parameters.AddWithValue("@ClassId",
                        ddlLevel.SelectedValue);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0,
                    new ListItem("-- Select Subject (Optional) --", "0"));
            }
        }

        protected void txtChapterName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtChapterName.Text.ToLower(), @"[^a-z0-9]", "-")
                                .Replace("--", "-")
                                .Trim('-');
        }
    }
}