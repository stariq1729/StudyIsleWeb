using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class AddSubject : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadClasses(0);
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();

                ddlBoard.Items.Insert(0, "-- Select Board --");
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();

                ddlClass.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- No Class --", "0"));
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex > 0)
                LoadClasses(Convert.ToInt32(ddlBoard.SelectedValue));
            else
                LoadClasses(0);
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtSubjectName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a Board.";
                return;
            }

            string subjectName = txtSubjectName.Text.Trim();
            string slug = GenerateSlug(txtSlug.Text.Trim());
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int classId = ddlClass.SelectedValue == "0" ? 0 : Convert.ToInt32(ddlClass.SelectedValue);

            if (string.IsNullOrWhiteSpace(subjectName))
            {
                lblMessage.Text = "Subject Name is required.";
                return;
            }

            if (IsSlugExists(slug, boardId, classId))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO Subjects
                                (BoardId, ClassId, SubjectName, Slug,
                                 Description, IsActive, CreatedAt)
                                 VALUES
                                (@BoardId, @ClassId, @SubjectName, @Slug,
                                 @Description, @IsActive, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId", classId == 0 ? (object)DBNull.Value : classId);
                cmd.Parameters.AddWithValue("@SubjectName", subjectName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageSubjects.aspx");
        }

        private bool IsSlugExists(string slug, int boardId, int classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT COUNT(*)
                                 FROM Subjects
                                 WHERE Slug=@Slug
                                 AND BoardId=@BoardId
                                 AND (ClassId=@ClassId OR (ClassId IS NULL AND @ClassId=0))";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId", classId);

                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        private string GenerateSlug(string input)
        {
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            return slug.Replace(" ", "-");
        }
    }
}