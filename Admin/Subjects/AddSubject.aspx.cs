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
                ddlSubCategory.Items.Insert(0, new ListItem("-- Select Board First --", "0"));
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

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId > 0)
            {
                LoadHierarchyData(boardId);
            }
            else
            {
                ddlSubCategory.Items.Clear();
                ddlClass.Items.Clear();
                ddlSubCategory.Items.Insert(0, new ListItem("-- Select Board First --", "0"));
                ddlClass.Items.Insert(0, new ListItem("-- Select Board First --", "0"));
            }
        }

        private void LoadHierarchyData(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Load relevant Sub-Categories
                string subCatQuery = "SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE IsActive=1";
                SqlDataAdapter daSub = new SqlDataAdapter(subCatQuery, con);
                DataTable dtSub = new DataTable();
                daSub.Fill(dtSub);

                ddlSubCategory.DataSource = dtSub;
                ddlSubCategory.DataTextField = "SubCategoryName";
                ddlSubCategory.DataValueField = "SubCategoryId";
                ddlSubCategory.DataBind();
                ddlSubCategory.Items.Insert(0, new ListItem("-- Select Sub-Category --", "0"));

                // Load Classes for the selected board
                string classQuery = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId AND IsActive=1 ORDER BY DisplayOrder ASC";
                SqlCommand cmdClass = new SqlCommand(classQuery, con);
                cmdClass.Parameters.AddWithValue("@BoardId", boardId);
                SqlDataAdapter daClass = new SqlDataAdapter(cmdClass);
                DataTable dtClass = new DataTable();
                daClass.Fill(dtClass);

                ddlClass.DataSource = dtClass;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("-- General / No Class --", "0"));
            }
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtSubjectName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedValue == "0" || ddlSubCategory.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtSubjectName.Text))
            {
                ShowError("Board, Sub-Category, and Subject Name are mandatory.");
                return;
            }

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
                    // Added SubCategoryId to the INSERT statement
                    string sql = @"INSERT INTO Subjects 
                                 (BoardId, SubCategoryId, ClassId, SubjectName, Slug, IconImage, PageTitle, PageSubtitle, Description, IsActive, CreatedAt) 
                                 VALUES (@BID, @SCID, @CID, @Name, @Slug, @Icon, @PTitle, @PSub, @Desc, @Active, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@SCID", ddlSubCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@CID", (ddlClass.SelectedValue == "0") ? (object)DBNull.Value : ddlClass.SelectedValue);
                    cmd.Parameters.AddWithValue("@Name", txtSubjectName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
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
                ShowError("Error: " + ex.Message);
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