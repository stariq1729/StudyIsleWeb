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

        // 2️⃣ Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
            }
        }

        // 3️⃣ Load Boards into GridView
        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT 
                                    BoardId,
                                    BoardName,
                                    Slug,
                                    HasClassLayer,
                                    IsActive,
                                    CreatedAt
                                 FROM Boards
                                 ORDER BY CreatedAt DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBoards.DataSource = dt;
                gvBoards.DataBind();
            }
        }

        // 4️⃣ GridView Row Command (Toggle Active)
        protected void gvBoards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int boardId = Convert.ToInt32(e.CommandArgument);

                ToggleBoardStatus(boardId);
            }
        }

        // 5️⃣ Toggle Active / Inactive
        private void ToggleBoardStatus(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Boards
                                 SET IsActive =
                                 CASE WHEN IsActive = 1 THEN 0 ELSE 1 END
                                 WHERE BoardId = @BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Reload grid after update
            LoadBoards();
        }
    }
}
