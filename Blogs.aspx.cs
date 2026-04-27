using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class Blogs : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadBlogs(); // default = latest
            }
        }

        // 🔹 Load Categories (Tabs)
        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT CategoryId, CategoryName FROM BlogCategories WHERE IsActive=1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
        }

        // 🔹 Load Blogs (Latest or Filtered)
        private void LoadBlogs(int? categoryId = null)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT b.*, c.CategoryName
                    FROM Blogs b
                    INNER JOIN BlogCategories c ON b.CategoryId = c.CategoryId
                    WHERE b.IsPublished = 1";

                if (categoryId != null)
                {
                    query += " AND b.CategoryId = @CategoryId";
                }

                query += " ORDER BY b.CreatedDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                if (categoryId != null)
                {
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptBlogs.DataSource = dt;
                rptBlogs.DataBind();
            }
        }

        // 🔹 Latest Button
        protected void btnLatest_Click(object sender, EventArgs e)
        {
            LoadBlogs();
        }

        // 🔹 Category Click
        protected void Category_Click(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);
            LoadBlogs(categoryId);
        }
    }
}