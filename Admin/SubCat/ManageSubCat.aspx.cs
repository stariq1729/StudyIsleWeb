using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.SubCat
{
    public partial class ManageSubCat : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // We join with Boards to get the BoardName
                string query = @"SELECT s.*, b.BoardName 
                                FROM SubCategories s 
                                INNER JOIN Boards b ON s.BoardId = b.BoardId 
                                ORDER BY s.SubCategoryId DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSubCategories.DataSource = dt;
                gvSubCategories.DataBind();
            }
        }

        protected void gvSubCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvSubCategories.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM SubCategories WHERE SubCategoryId = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
                BindGrid(); // Refresh the list
            }
        }
    }
}