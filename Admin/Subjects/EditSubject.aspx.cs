using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class EditSubject : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();

                if (Request.QueryString["id"] != null)
                {
                    int subjectId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadSubject(subjectId);
                }
                else
                {
                    Response.Redirect("ManageSubjects.aspx");
                }
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
            }
        }

        private void LoadSubject(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT * FROM Subjects WHERE SubjectId=@SubjectId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    hfSubjectId.Value = reader["SubjectId"].ToString();
                    ddlBoard.SelectedValue = reader["BoardId"].ToString();
                    txtSubjectName.Text = reader["SubjectName"].ToString();
                    txtSlug.Text = reader["Slug"].ToString();
                    txtDescription.Text = reader["Description"].ToString();
                    chkIsActive.Checked = Convert.ToBoolean(reader["IsActive"]);
                }
            }

            ddlBoard_SelectedIndexChanged(null, null);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT ClassId FROM Subjects WHERE SubjectId=@SubjectId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);

                object classId = cmd.ExecuteScalar();

                if (classId != DBNull.Value && classId != null)
                {
                    ddlClass.SelectedValue = classId.ToString();
                }
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
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
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int subjectId = Convert.ToInt32(hfSubjectId.Value);
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int? classId = null;

            if (BoardSupportsClasses(boardId))
            {
                if (ddlClass.SelectedIndex < 0)
                {
                    lblMessage.Text = "Please select class.";
                    return;
                }

                classId = Convert.ToInt32(ddlClass.SelectedValue);
            }

            string subjectName = txtSubjectName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            string description = txtDescription.Text.Trim();
            bool isActive = chkIsActive.Checked;

            if (IsSlugExists(slug, subjectId))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"UPDATE Subjects
                                 SET BoardId=@BoardId,
                                     ClassId=@ClassId,
                                     SubjectName=@SubjectName,
                                     Slug=@Slug,
                                     Description=@Description,
                                     IsActive=@IsActive
                                 WHERE SubjectId=@SubjectId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);
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

        private bool IsSlugExists(string slug, int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT COUNT(*) FROM Subjects 
                                 WHERE Slug=@Slug AND SubjectId!=@SubjectId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);

                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }
}
