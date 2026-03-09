using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class SubCatDetails : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindSubCategories();
        }

        private void BindSubCategories()
        {
            // Check if the query strings exist. 
            // Make sure the names "board" and "res" match exactly what is in your URL
            string bSlug = Request.QueryString["board"];
            string rSlug = Request.QueryString["res"];

            // If they are null, redirect back to home or show an error instead of crashing
            if (string.IsNullOrEmpty(bSlug) || string.IsNullOrEmpty(rSlug))
            {
                Response.Write("Error: Board or Resource type is missing in the URL.");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT s.* FROM SubCategories s
                         INNER JOIN Boards b ON s.BoardId = b.BoardId
                         INNER JOIN ResourceTypes rt ON s.ResourceTypeId = rt.ResourceTypeId
                         WHERE b.Slug = @bSlug AND rt.Slug = @rSlug AND s.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                // Using cmd.Parameters.Add instead of AddWithValue is safer for parameter types
                cmd.Parameters.Add("@bSlug", SqlDbType.NVarChar).Value = bSlug;
                cmd.Parameters.Add("@rSlug", SqlDbType.NVarChar).Value = rSlug;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                try
                {
                    da.Fill(dt);
                    rptSubCategories.DataSource = dt;
                    rptSubCategories.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("Database Error: " + ex.Message);
                }
            }
        }
    }
}