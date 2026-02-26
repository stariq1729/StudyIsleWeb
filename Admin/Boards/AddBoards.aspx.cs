using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class AddBoards : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void txtBoardName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtBoardName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string boardName = txtBoardName.Text.Trim();
            string slug = GenerateSlug(txtSlug.Text.Trim());
            string heroTitle = txtHeroTitle.Text.Trim();
            string heroSubtitle = txtHeroSubtitle.Text.Trim();
            bool hasClassLayer = chkHasClassLayer.Checked;
            bool isActive = chkIsActive.Checked;

            // Basic Validation
            if (string.IsNullOrWhiteSpace(boardName))
            {
                lblMessage.Text = "Board Name is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(slug))
            {
                lblMessage.Text = "Slug is required.";
                return;
            }

            if (IsSlugExists(slug))
            {
                lblMessage.Text = "Slug already exists. Please use a different slug.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Updated Query with HeroTitle and HeroSubtitle
                    string query = @"INSERT INTO Boards 
                                    (BoardName, Slug, HeroTitle, HeroSubtitle, HasClassLayer, IsActive, CreatedAt) 
                                    VALUES 
                                    (@BoardName, @Slug, @HeroTitle, @HeroSubtitle, @HasClassLayer, @IsActive, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@BoardName", boardName);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@HeroTitle", (object)heroTitle ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@HeroSubtitle", (object)heroSubtitle ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@HasClassLayer", hasClassLayer);
                    cmd.Parameters.AddWithValue("@IsActive", isActive);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                Response.Redirect("ManageBoards.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private bool IsSlugExists(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM Boards WHERE Slug=@Slug";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);

                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        private string GenerateSlug(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            slug = slug.Replace(" ", "-");
            return slug;
        }
    }
}