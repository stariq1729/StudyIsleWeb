using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class EditBoard : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private int boardId;

        protected void Page_Load(object sender, EventArgs e)
        {
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
                string query = @"SELECT BoardName, Slug, 
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
            txtSlug.Text = GenerateSlug(txtBoardName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string boardName = txtBoardName.Text.Trim();
            string slug = GenerateSlug(txtSlug.Text.Trim());
            bool hasClassLayer = chkHasClassLayer.Checked;
            bool isActive = chkIsActive.Checked;

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
                lblMessage.Text = "Slug already exists. Please use different slug.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Boards
                                 SET BoardName=@BoardName,
                                     Slug=@Slug,
                                     HasClassLayer=@HasClassLayer,
                                     IsActive=@IsActive
                                 WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@BoardName", boardName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@HasClassLayer", hasClassLayer);
                cmd.Parameters.AddWithValue("@IsActive", isActive);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageBoards.aspx");
        }

        private bool IsSlugExists(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT COUNT(*)
                                 FROM Boards
                                 WHERE Slug=@Slug
                                 AND BoardId<>@BoardId";

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
            slug = slug.Replace(" ", "-");
            return slug;
        }
    }
}