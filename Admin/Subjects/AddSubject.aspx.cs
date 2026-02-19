using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class AddSubject : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                classContainer.Visible = false;
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();

                ddlBoard.Items.Insert(0, "-- Select Board --");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex == 0)
            {
                classContainer.Visible = false;
                return;
            }

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);

            if (BoardSupportsClasses(boardId))
            {
                LoadClasses(boardId);
                classContainer.Visible = true;
            }
            else
            {
                classContainer.Visible = false;
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId AND IsActive=1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();

                ddlClass.Items.Insert(0, "-- Select Class --");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a board.";
                return;
            }

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int? classId = null;

            if (BoardSupportsClasses(boardId))
            {
                if (ddlClass.SelectedIndex == 0)
                {
                    lblMessage.Text = "Please select a class.";
                    return;
                }

                classId = Convert.ToInt32(ddlClass.SelectedValue);
            }

            string subjectName = txtSubjectName.Text.Trim();
            string slug = GenerateSlug(subjectName);
            string description = txtDescription.Text.Trim();
            bool isActive = chkIsActive.Checked;

            if (IsSlugExists(slug))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"INSERT INTO Subjects
                                (BoardId, ClassId, SubjectName, Slug, Description, IsActive, CreatedAt)
                                VALUES
                                (@BoardId, @ClassId, @SubjectName, @Slug, @Description, @IsActive, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId", (object)classId ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@SubjectName", subjectName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@IsActive", isActive);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageSubjects.aspx");
        }

        private bool BoardSupportsClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT HasClassLayer FROM Boards WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        private bool IsSlugExists(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT COUNT(*) FROM Subjects WHERE Slug=@Slug";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);

                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        private string GenerateSlug(string input)
        {
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", "-").Trim();
            return slug;
        }
    }
}
