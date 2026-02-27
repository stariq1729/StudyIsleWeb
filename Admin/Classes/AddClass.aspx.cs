using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

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
                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Board --", "0"));
            }
        }

        protected void txtClassName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtClassName.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a Board.";
                return;
            }

            string className = txtClassName.Text.Trim();
            string slug = GenerateSlug(txtSlug.Text.Trim());
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);

            int.TryParse(txtDisplayOrder.Text, out int displayOrder);

            if (string.IsNullOrWhiteSpace(className))
            {
                lblMessage.Text = "Class Name is required.";
                return;
            }

            if (IsSlugExists(slug, boardId))
            {
                lblMessage.Text = "Slug already exists for this board.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Updated query with PageTitle and PageSubtitle
                string query = @"INSERT INTO Classes 
                                (BoardId, ClassName, Slug, DisplayOrder, IsActive, PageTitle, PageSubtitle, CreatedAt) 
                                VALUES 
                                (@BoardId, @ClassName, @Slug, @DisplayOrder, @IsActive, @PageTitle, @PageSubtitle, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassName", className);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@DisplayOrder", displayOrder);
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                // New Parameters
                cmd.Parameters.AddWithValue("@PageTitle", (object)txtPageTitle.Text.Trim() ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PageSubtitle", (object)txtPageSubtitle.Text.Trim() ?? DBNull.Value);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageClasses.aspx");
        }

        private bool IsSlugExists(string slug, int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM Classes WHERE Slug=@Slug AND BoardId=@BoardId";
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
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            return slug.Replace(" ", "-");
        }
    }
}