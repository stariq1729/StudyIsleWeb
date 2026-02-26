using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class ManageBoards : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
            }
        }

        // Logic for Search Filter
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadBoards(txtSearch.Text.Trim());
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadBoards(txtSearch.Text.Trim());
        }

        private void LoadBoards(string searchTerm = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added HeroTitle and HeroSubtitle to the SELECT statement
                string query = @"SELECT BoardId, BoardName, Slug, HeroTitle, HeroSubtitle, 
                                 HasClassLayer, IsActive, CreatedAt 
                                 FROM Boards";

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    query += " WHERE BoardName LIKE @Search OR HeroTitle LIKE @Search";
                }

                query += " ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + searchTerm + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvBoards.DataSource = dt;
                    gvBoards.DataBind();
                }
            }
        }

        protected void gvBoards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int boardId = Convert.ToInt32(e.CommandArgument);
                ToggleBoardStatus(boardId);
            }
        }

        private void ToggleBoardStatus(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Boards 
                                 SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END 
                                 WHERE BoardId = @BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            LoadBoards(txtSearch.Text.Trim());
        }
    }
}