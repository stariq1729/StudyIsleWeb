using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class Blogs : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        // ✅ NEW: PageIndex (pagination state)
        public int PageIndex
        {
            get { return ViewState["PageIndex"] != null ? (int)ViewState["PageIndex"] : 1; }
            set { ViewState["PageIndex"] = value; }
        }

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

        // 🔹 Load Blogs (UPDATED WITH PAGINATION)
        private void LoadBlogs(int? categoryId = null)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
                SELECT 
                    b.BlogId,
                    b.Slug,
                    b.AuthorName,
                    b.AuthorImage,
                    b.ReadTime,
                    c.CategoryName,

                    -- Title from blocks (H1)
                    ISNULL((
                        SELECT TOP 1 Content 
                        FROM BlogBlocks 
                        WHERE BlogId = b.BlogId AND BlockType = 'h1'
                        ORDER BY DisplayOrder
                    ), 'Untitled Blog') AS Title,

                    -- Image from blocks
                    ISNULL((
                        SELECT TOP 1 Content 
                        FROM BlogBlocks 
                        WHERE BlogId = b.BlogId AND BlockType = 'image'
                        ORDER BY DisplayOrder
                    ), '/uploads/default.jpg') AS CoverImage,

                    -- Description from blocks
                    ISNULL((
                        SELECT TOP 1 Content 
                        FROM BlogBlocks 
                        WHERE BlogId = b.BlogId AND BlockType = 'paragraph'
                        ORDER BY DisplayOrder
                    ), 'No description available') AS ShortDescription

                FROM Blogs b
                INNER JOIN BlogCategories c ON b.CategoryId = c.CategoryId
                WHERE b.IsActive = 1";

                // 🔹 Category Filter
                if (categoryId != null)
                {
                    query += " AND b.CategoryId = @CategoryId";
                }

                // 🔹 Latest First
                query += " ORDER BY b.CreatedDate DESC";

                // ✅ NEW: Pagination
                query += " OFFSET (@PageIndex - 1) * 9 ROWS FETCH NEXT 9 ROWS ONLY";

                SqlCommand cmd = new SqlCommand(query, con);

                // ✅ NEW: PageIndex parameter
                cmd.Parameters.AddWithValue("@PageIndex", PageIndex);

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
            PageIndex = 1; // ✅ reset page
            LoadBlogs();
        }

        // 🔹 Category Click
        protected void Category_Click(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);

            PageIndex = 1; // ✅ reset page on filter change
            LoadBlogs(categoryId);
        }

        // ✅ NEW: Next Page
        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageIndex++;
            LoadBlogs();
        }

        // ✅ NEW: Previous Page
        protected void btnPrev_Click(object sender, EventArgs e)
        {
            if (PageIndex > 1)
                PageIndex--;

            LoadBlogs();
        }
    }
}