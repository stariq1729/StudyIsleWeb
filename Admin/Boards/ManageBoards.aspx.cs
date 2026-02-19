using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

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

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT BoardId, BoardName, HasClassLayer, IsActive FROM Boards";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBoards.DataSource = dt;
                gvBoards.DataBind();
            }
        }

        protected void gvBoards_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int boardId = Convert.ToInt32(e.CommandArgument);
                ToggleBoardStatus(boardId);
                LoadBoards();
            }
        }

        private void ToggleBoardStatus(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "UPDATE Boards SET IsActive = ~IsActive WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                cmd.ExecuteNonQuery();
            }
        }
    }
}
