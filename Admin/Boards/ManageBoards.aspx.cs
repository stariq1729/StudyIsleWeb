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
                BindBoards();
            }
        }

        private void BindBoards(string filter = "All")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Boards";

                // Adding logic for the DropDown Filter
                if (filter == "Standard")
                    query += " WHERE IsCompetitive = 0";
                else if (filter == "Competitive")
                    query += " WHERE IsCompetitive = 1";

                query += " ORDER BY CreatedAt DESC";

                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                gvBoards.DataSource = dt;
                gvBoards.DataBind();
            }
        }

        protected void ddlFilterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBoards(ddlFilterType.SelectedValue);
        }

        protected void gvBoards_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int boardId = Convert.ToInt32(gvBoards.DataKeys[e.RowIndex].Value);

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "DELETE FROM Boards WHERE BoardId = @BoardId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BoardId", boardId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                lblStatus.Text = "Board deleted successfully.";
                BindBoards(ddlFilterType.SelectedValue);
            }
            catch (Exception ex)
            {
                lblStatus.ForeColor = System.Drawing.Color.Red;
                lblStatus.Text = "Error: Cannot delete board. It may have linked data.";
            }
        }
    }
}