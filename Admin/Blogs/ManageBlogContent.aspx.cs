using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class ManageBlogContent : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBlogsWithContent();
            }
        }

        // 🔹 Load Blogs + Block Count
        private void LoadBlogsWithContent()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        b.BlogId,
                        b.Title,
                        b.AuthorName,
                        b.IsActive,
                        c.CategoryName,
                        COUNT(bb.BlockId) AS BlockCount
                    FROM Blogs b
                    INNER JOIN BlogCategories c ON b.CategoryId = c.CategoryId
                    LEFT JOIN BlogBlocks bb ON b.BlogId = bb.BlogId
                    GROUP BY 
                        b.BlogId, b.Title, b.AuthorName, b.IsActive, c.CategoryName
                    ORDER BY b.CreatedDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvContent.DataSource = dt;
                gvContent.DataBind();
            }
        }

        // 🔹 Handle Toggle Active
        protected void gvContent_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int blogId = Convert.ToInt32(e.CommandArgument);

                ToggleBlogStatus(blogId);

                LoadBlogsWithContent();
            }
        }

        // 🔹 Toggle Active/Inactive
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