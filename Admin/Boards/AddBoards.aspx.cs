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
            txtSlug.Text = GenerateSlug(txtBoardName.Text);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string boardName = txtBoardName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            bool hasClassLayer = chkHasClassLayer.Checked;
            bool isActive = chkIsActive.Checked;

            if (string.IsNullOrEmpty(boardName) || string.IsNullOrEmpty(slug))
            {
                lblMessage.Text = "Board Name and Slug are required.";
                return;
            }

            if (IsSlugExists(slug))
            {
               
                lblMessage.Text = "Slug already exists. Please use different slug.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"INSERT INTO Boards 
                                (BoardName, Slug, HasClassLayer, IsActive)
                                VALUES
                                (@BoardName, @Slug, @HasClassLayer, @IsActive)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardName", boardName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@HasClassLayer", hasClassLayer);
                cmd.Parameters.AddWithValue("@IsActive", isActive);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageBoards.aspx");
        }

        private bool IsSlugExists(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT COUNT(*) FROM Boards WHERE Slug=@Slug";

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
