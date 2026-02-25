using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddChapter : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
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
                SqlCommand cmd = new SqlCommand(
                    "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId", con);

                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();

                ddlClass.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem("-- No Class --", "0"));
            }
        }

        private void LoadSubjects(int boardId, int classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT SubjectId, SubjectName
                                 FROM Subjects
                                 WHERE BoardId=@BoardId";

                if (classId > 0)
                    query += " AND ClassId=@ClassId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                if (classId > 0)
                    cmd.Parameters.AddWithValue("@ClassId", classId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem("-- Select Subject --", "0"));
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            LoadClasses(boardId);
            ddlSubject.Items.Clear();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int classId = ddlClass.SelectedValue == "0"
                ? 0 : Convert.ToInt32(ddlClass.SelectedValue);

            LoadSubjects(boardId, classId);
        }

        protected void txtChapterName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtChapterName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a Subject.";
                return;
            }

            int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);
            string chapterName = txtChapterName.Text.Trim();
            string slug = GenerateSlug(txtSlug.Text.Trim());

            if (IsSlugExists(slug, subjectId))
            {
                lblMessage.Text = "Slug already exists for this subject.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO Chapters
                      (SubjectId, ChapterName, Slug, DisplayOrder, IsActive, CreatedAt)
                      VALUES
                      (@SubjectId, @ChapterName, @Slug, @DisplayOrder, @IsActive, GETDATE())", con);

                cmd.Parameters.AddWithValue("@SubjectId", subjectId);
                cmd.Parameters.AddWithValue("@ChapterName", chapterName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@DisplayOrder", txtDisplayOrder.Text);
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageChapters.aspx");
        }

        private bool IsSlugExists(string slug, int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Chapters WHERE Slug=@Slug AND SubjectId=@SubjectId", con);

                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);

                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
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