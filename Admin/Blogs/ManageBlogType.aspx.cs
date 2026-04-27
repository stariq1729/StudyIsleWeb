using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class ManageBlogType : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBlogs();
            }
        }

        // 🔹 Load Blogs
        private void LoadBlogs()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT b.BlogId, b.Title, b.AuthorName, b.IsActive,
                           c.CategoryName
                    FROM Blogs b
                    INNER JOIN BlogCategories c ON b.CategoryId = c.CategoryId
                    ORDER BY b.CreatedDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBlogs.DataSource = dt;
                gvBlogs.DataBind();
            }
        }

        // 🔹 Handle Actions
        protected void gvBlogs_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int blogId = Convert.ToInt32(e.CommandArgument);

                ToggleBlogStatus(blogId);

                LoadBlogs();
            }
        }

        // 🔹 Toggle IsActive
        private void ToggleBlogStatus(int blogId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
                    UPDATE Blogs 
                    SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END
                    WHERE BlogId = @BlogId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BlogId", blogId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}