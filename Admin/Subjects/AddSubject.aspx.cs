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
            ResetPlaceholders();
            if (ddlBoard.SelectedValue != "0")
            {
                phResourceType.Visible = true;
                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Flow --");
            }
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            phSubCategory.Visible = true;
            phClass.Visible = true;

            // Load SubCategories filtered by Board
            BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId={boardId}", ddlSubCategory, "SubCategoryName", "SubCategoryId", "No Sub-Category (Optional)");

            // Load Classes filtered by Board
            BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}", ddlClass, "ClassName", "ClassId", "General (No Class)");
        }

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

        private void ResetPlaceholders() { phResourceType.Visible = phSubCategory.Visible = phClass.Visible = false; }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtSubjectName.Text.ToLower(), @"[^a-z0-9]", "-").Trim('-');
        }

        private void ShowError(string msg) { lblMessage.Text = msg; lblMessage.CssClass = "alert alert-danger"; }
    }
}