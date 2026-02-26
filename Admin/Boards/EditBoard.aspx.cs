using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class EditBoard : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        private int boardId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Retrieve ID from QueryString and validate
            if (!int.TryParse(Request.QueryString["id"], out boardId))
            {
                Response.Redirect("ManageBoards.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBoard();
            }
        }

        private void LoadBoard()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added HeroTitle and HeroSubtitle to the SELECT query
                string query = @"SELECT BoardName, Slug, HeroTitle, HeroSubtitle, 
                                 HasClassLayer, IsActive 
                                 FROM Boards 
                                 WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtBoardName.Text = dr["BoardName"].ToString();
                    txtSlug.Text = dr["Slug"].ToString();
                    txtHeroTitle.Text = dr["HeroTitle"].ToString();
                    txtHeroSubtitle.Text = dr["HeroSubtitle"].ToString();
                    chkHasClassLayer.Checked = Convert.ToBoolean(dr["HasClassLayer"]);
                    chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);
                }
                else
                {
                    Response.Redirect("ManageBoards.aspx");
                }
            }
        }

        protected void txtBoardName_TextChanged(object sender, EventArgs e)
        {
            // Auto-generate slug on name change if needed
            txtSlug.Text = GenerateSlug(txtBoardName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
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

            // Check if another board already uses this slug
            if (IsSlugExists(slug))
            {
                lblMessage.Text = "This slug is already in use by another board.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Updated Query to include Hero fields
                    string query = @"UPDATE Boards 
                                     SET BoardName=@BoardName, 
                                         Slug=@Slug, 
                                         HeroTitle=@HeroTitle, 
                                         HeroSubtitle=@HeroSubtitle, 
                                         HasClassLayer=@HasClassLayer, 
                                         IsActive=@IsActive 
                                     WHERE BoardId=@BoardId";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@BoardName", boardName);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    // Using DBNull if the field is empty to keep database clean
                    cmd.Parameters.AddWithValue("@HeroTitle", (object)heroTitle ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@HeroSubtitle", (object)heroSubtitle ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@HasClassLayer", hasClassLayer);
                    cmd.Parameters.AddWithValue("@IsActive", isActive);
                    cmd.Parameters.AddWithValue("@BoardId", boardId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

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
                // Ensure we aren't checking against the current board's own slug
                string query = "SELECT COUNT(*) FROM Boards WHERE Slug=@Slug AND BoardId <> @BoardId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

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