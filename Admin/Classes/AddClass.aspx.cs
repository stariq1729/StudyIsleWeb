using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class AddClass : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

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
                // We load only active boards. Boards act as the parent for these classes.
                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new ListItem("-- Assign to a Board --", "0"));
            }
        }

        protected void txtClassName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtClassName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Validation
            if (ddlBoard.SelectedValue == "0")
            {
                ShowError("Critical: You must assign this class to a Board.");
                return;
            }

            string className = txtClassName.Text.Trim();
            string slug = string.IsNullOrWhiteSpace(txtSlug.Text) ? GenerateSlug(className) : GenerateSlug(txtSlug.Text);
            int boardId = int.Parse(ddlBoard.SelectedValue);

            if (string.IsNullOrEmpty(className))
            {
                ShowError("Class Name cannot be empty.");
                return;
            }

            // Slug Collision Check
            if (IsSlugExists(slug, boardId))
            {
                ShowError("This URL Slug is already used by another class on this board.");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Classes 
                                    (BoardId, ClassName, Slug, DisplayOrder, IsActive, PageTitle, PageSubtitle, CreatedAt) 
                                    VALUES 
                                    (@BoardId, @ClassName, @Slug, @DisplayOrder, @IsActive, @PageTitle, @PageSubtitle, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BoardId", boardId);
                    cmd.Parameters.AddWithValue("@ClassName", className);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@DisplayOrder", string.IsNullOrEmpty(txtDisplayOrder.Text) ? 0 : int.Parse(txtDisplayOrder.Text));
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                    // Handling optional text fields with DBNull
                    cmd.Parameters.AddWithValue("@PageTitle", string.IsNullOrWhiteSpace(txtPageTitle.Text) ? (object)DBNull.Value : txtPageTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@PageSubtitle", string.IsNullOrWhiteSpace(txtPageSubtitle.Text) ? (object)DBNull.Value : txtPageSubtitle.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageClasses.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowError("Database Error: " + ex.Message);
            }
        }

        private bool IsSlugExists(string slug, int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Classes WHERE Slug=@Slug AND BoardId=@BoardId", con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private string GenerateSlug(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", ""); // Remove invalid chars
            slug = Regex.Replace(slug, @"\s+", " ").Trim(); // Remove multiple spaces
            return slug.Replace(" ", "-"); // Replace space with dash
        }

        private void ShowError(string msg)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = "alert alert-danger d-block";
        }
    }
}