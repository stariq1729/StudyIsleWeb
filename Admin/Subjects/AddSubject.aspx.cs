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
                LoadBoards();
                LoadClasses(0);
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName ASC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new ListItem("-- Select Board --", "0"));
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId ORDER BY DisplayOrder ASC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("-- No Class (General) --", "0"));
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
            if (ddlBoard.SelectedValue == "0")
            {
                lblMessage.Text = "Please select a Board.";
                return;
            }

            string subjectName = txtSubjectName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int classId = Convert.ToInt32(ddlClass.SelectedValue);

            if (string.IsNullOrWhiteSpace(subjectName))
            {
                lblMessage.Text = "Subject Name is required.";
                return;
            }

            if (IsSlugExists(slug, boardId, classId))
            {
                lblMessage.Text = "Slug already exists for this board/class combination.";
                return;
            }

            // Image Upload Logic (using your ResourceType style)
            string iconFileName = "Default-icon.png";
            if (fuIcon.HasFile)
            {
                string extension = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "subject_" + DateTime.Now.Ticks + extension;
                string folderPath = Server.MapPath("~/Uploads/SubjectIcons/");

                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                fuIcon.SaveAs(Path.Combine(folderPath, iconFileName));
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO Subjects
                                (BoardId, ClassId, SubjectName, Slug, IconImage, 
                                 PageTitle, PageSubtitle, Description, IsActive, CreatedAt)
                                 VALUES
                                (@BoardId, @ClassId, @SubjectName, @Slug, @IconImage, 
                                 @PageTitle, @PageSubtitle, @Description, @IsActive, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId", classId == 0 ? (object)DBNull.Value : classId);
                cmd.Parameters.AddWithValue("@SubjectName", subjectName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@IconImage", iconFileName);
                cmd.Parameters.AddWithValue("@PageTitle", txtPageTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@PageSubtitle", txtPageSubtitle.Text.Trim());
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
                string query = @"SELECT COUNT(*) FROM Subjects WHERE Slug=@Slug AND BoardId=@BoardId 
                                 AND (ClassId=@ClassId OR (ClassId IS NULL AND @ClassId=0))";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId", classId);

                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private string GenerateSlug(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            return slug.Replace(" ", "-");
        }
    }
}