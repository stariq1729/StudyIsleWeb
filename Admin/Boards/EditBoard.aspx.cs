using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class EditBoard : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int boardId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadBoard(boardId);
                }
                else
                {
                    Response.Redirect("ManageBoards.aspx");
                }
            }
        }

        private void LoadBoard(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT * FROM Boards WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    hfBoardId.Value = reader["BoardId"].ToString();
                    txtBoardName.Text = reader["BoardName"].ToString();
                    txtSlug.Text = reader["Slug"].ToString();
                    chkHasClassLayer.Checked = Convert.ToBoolean(reader["HasClassLayer"]);
                    chkIsActive.Checked = Convert.ToBoolean(reader["IsActive"]);
                }
                else
                {
                    Response.Redirect("ManageBoards.aspx");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(hfBoardId.Value);
            string boardName = txtBoardName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            bool hasClassLayer = chkHasClassLayer.Checked;
            bool isActive = chkIsActive.Checked;

            if (IsSlugExists(slug, boardId))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"UPDATE Boards 
                                 SET BoardName=@BoardName,
                                     Slug=@Slug,
                                     HasClassLayer=@HasClassLayer,
                                     IsActive=@IsActive
                                 WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@BoardName", boardName);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@HasClassLayer", hasClassLayer);
                cmd.Parameters.AddWithValue("@IsActive", isActive);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageBoards.aspx");
        }

        private bool IsSlugExists(string slug, int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT COUNT(*) 
                                 FROM Boards 
                                 WHERE Slug=@Slug 
                                 AND BoardId!=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }
}
