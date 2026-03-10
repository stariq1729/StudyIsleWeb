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
                // Initialize ddlClass as empty/General by default
                ddlClass.Items.Insert(0, new ListItem("-- Select Board First --", "0"));
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new ListItem("-- Select Target Board --", "0"));
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId AND IsActive=1 ORDER BY DisplayOrder ASC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("-- General (No Class) --", "0"));
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedValue != "0")
            {
                LoadClasses(Convert.ToInt32(ddlBoard.SelectedValue));
            }
            else
            {
                ddlClass.Items.Clear();
                ddlClass.Items.Insert(0, new ListItem("-- Select Board First --", "0"));
            }
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtSubjectName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedValue == "0")
            {
                ShowError("Critical: You must select a Board.");
                return;
            }

            string subjectName = txtSubjectName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int classId = Convert.ToInt32(ddlClass.SelectedValue);

            if (string.IsNullOrWhiteSpace(subjectName))
            {
                ShowError("Subject Name is required.");
                return;
            }

            // Image Upload logic
            string iconFileName = "default-sub.png";
            if (fuIcon.HasFile)
            {
                string ext = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "sub_" + DateTime.Now.Ticks + ext;
                string folder = Server.MapPath("~/Uploads/SubjectIcons/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                fuIcon.SaveAs(Path.Combine(folder, iconFileName));
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Subjects 
                                 (BoardId, ClassId, SubjectName, Slug, IconImage, PageTitle, PageSubtitle, Description, IsActive, CreatedAt) 
                                 VALUES (@BID, @CID, @Name, @Slug, @Icon, @PTitle, @PSub, @Desc, @Active, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@BID", boardId);

                    // Allow ClassId to be NULL for Competitive/General subjects
                    cmd.Parameters.AddWithValue("@CID", (classId == 0) ? (object)DBNull.Value : classId);

                    cmd.Parameters.AddWithValue("@Name", subjectName);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@Icon", iconFileName);
                    cmd.Parameters.AddWithValue("@PTitle", txtPageTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@PSub", txtPageSubtitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageSubjects.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowError("Database Error: " + ex.Message);
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

        private void ShowError(string msg)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = "alert alert-danger d-block";
        }
    }
}