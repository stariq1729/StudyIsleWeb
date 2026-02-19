using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class AddResourceType : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            bool isActive = chkIsActive.Checked;

            // Basic validation
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(slug))
            {
                lblMessage.Text = "Name and Slug are required.";
                return;
            }

            if (IsSlugExists(slug))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO ResourceTypes 
(TypeName, Slug, IsPremium, IsActive, DisplayOrder, CreatedAt)
VALUES
(@TypeName, @Slug, @IsPremium, @IsActive, @DisplayOrder, GETDATE())
";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TypeName", name);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@IsActive", isActive);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("ManageResourceTypes.aspx");
        }

        private bool IsSlugExists(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM ResourceTypes WHERE Slug=@Slug";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    con.Open();

                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private string GenerateSlug(string text)
        {
            text = text.ToLower();
            text = Regex.Replace(text, @"[^a-z0-9\s-]", "");
            text = Regex.Replace(text, @"\s+", " ").Trim();
            text = text.Replace(" ", "-");
            return text;
        }
    }
}
