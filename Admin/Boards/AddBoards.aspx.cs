using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class AddBoards : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialization if needed
        }

        protected void txtBoardName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtBoardName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string boardName = txtBoardName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            string heroTitle = txtHeroTitle.Text.Trim();
            string heroSubtitle = txtHeroSubtitle.Text.Trim();
            bool isCompetitive = chkIsCompetitive.Checked;
            bool hasClassLayer = chkHasClassLayer.Checked;
            bool isActive = chkIsActive.Checked;

            // 1. Validation
            if (string.IsNullOrWhiteSpace(boardName))
            {
                lblMessage.Text = "Board Name is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(slug))
            {
                slug = GenerateSlug(boardName);
            }

            if (IsSlugExists(slug))
            {
                lblMessage.Text = "This slug is already in use. Please modify the Board Name or Slug.";
                return;
            }

            // 2. Database Operation
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Boards 
                                    (BoardName, Slug, HeroTitle, HeroSubtitle, IsCompetitive, HasClassLayer, IsActive, CreatedAt) 
                                    VALUES 
                                    (@BoardName, @Slug, @HeroTitle, @HeroSubtitle, @IsCompetitive, @HasClassLayer, @IsActive, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@BoardName", boardName);
                        cmd.Parameters.AddWithValue("@Slug", slug);
                        cmd.Parameters.AddWithValue("@HeroTitle", (object)heroTitle ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@HeroSubtitle", (object)heroSubtitle ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@IsCompetitive", isCompetitive);
                        cmd.Parameters.AddWithValue("@HasClassLayer", hasClassLayer);
                        cmd.Parameters.AddWithValue("@IsActive", isActive);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Success - Move to Manage Page
                Response.Redirect("ManageBoards.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Database Error: " + ex.Message;
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
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", ""); // Remove invalid chars
            slug = Regex.Replace(slug, @"\s+", " ").Trim(); // Convert multiple spaces to one
            slug = slug.Replace(" ", "-"); // Replace spaces with hyphens
            return slug;
        }
    }
}