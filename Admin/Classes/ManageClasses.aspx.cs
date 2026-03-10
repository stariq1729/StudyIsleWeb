using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class ManageClasses : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBoards();
                BindGrid();
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards ORDER BY BoardName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoardFilter.DataSource = dt;
                ddlBoardFilter.DataTextField = "BoardName";
                ddlBoardFilter.DataValueField = "BoardId";
                ddlBoardFilter.DataBind();
                ddlBoardFilter.Items.Insert(0, new ListItem("-- Filter by All Boards --", "0"));
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // We INNER JOIN with Boards to display the Board Name in the list
                string query = @"SELECT c.*, b.BoardName 
                                FROM Classes c 
                                INNER JOIN Boards b ON c.BoardId = b.BoardId 
                                WHERE 1=1";

                if (ddlBoardFilter.SelectedValue != "0")
                {
                    query += " AND c.BoardId = @BoardId";
                }

                query += " ORDER BY b.BoardName, c.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                if (ddlBoardFilter.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoardFilter.SelectedValue);
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvClasses.DataSource = dt;
                gvClasses.DataBind();
            }
        }

        protected void ddlBoardFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void gvClasses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int classId = (int)gvClasses.DataKeys[e.RowIndex].Value;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Classes WHERE ClassId=@Id", con);
                cmd.Parameters.AddWithValue("@Id", classId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}