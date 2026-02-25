using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class EditSubject : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private int subjectId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out subjectId))
            {
                Response.Redirect("ManageSubjects.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBoards();
                LoadSubject();
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId, BoardName FROM Boards", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
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

        private void LoadSubject()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM Subjects WHERE SubjectId=@Id", con);

                cmd.Parameters.AddWithValue("@Id", subjectId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    ddlBoard.SelectedValue = dr["BoardId"].ToString();

                    int boardId = Convert.ToInt32(dr["BoardId"]);
                    LoadClasses(boardId);

                    if (dr["ClassId"] != DBNull.Value)
                        ddlClass.SelectedValue = dr["ClassId"].ToString();
                    else
                        ddlClass.SelectedValue = "0";

                    txtSubjectName.Text = dr["SubjectName"].ToString();
                    txtSlug.Text = dr["Slug"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);
                }
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadClasses(Convert.ToInt32(ddlBoard.SelectedValue));
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtSubjectName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string slug = GenerateSlug(txtSlug.Text.Trim());
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int classId = ddlClass.SelectedValue == "0"
                ? 0 : Convert.ToInt32(ddlClass.SelectedValue);

            if (IsSlugExists(slug, boardId, classId))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"UPDATE Subjects
                      SET BoardId=@BoardId,
                          ClassId=@ClassId,
                          SubjectName=@SubjectName,
                          Slug=@Slug,
                          Description=@Description,
                          IsActive=@IsActive
                      WHERE SubjectId=@Id", con);

                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId",
                    classId == 0 ? (object)DBNull.Value : classId);
                cmd.Parameters.AddWithValue("@SubjectName", txtSubjectName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@Id", subjectId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageSubjects.aspx");
        }

        private bool IsSlugExists(string slug, int boardId, int classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT COUNT(*)
                      FROM Subjects
                      WHERE Slug=@Slug
                      AND BoardId=@BoardId
                      AND (ClassId=@ClassId OR (ClassId IS NULL AND @ClassId=0))
                      AND SubjectId<>@Id", con);

                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId", classId);
                cmd.Parameters.AddWithValue("@Id", subjectId);

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