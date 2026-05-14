using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Reflection;
using System.Security.Policy;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;



namespace StudyIsleWeb
{
    public partial class Blogs : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        // ✅ Pagination State
        public int PageIndex
        {
            get { return ViewState["PageIndex"] != null ? (int)ViewState["PageIndex"] : 1; }
            set { ViewState["PageIndex"] = value; }
        }

        // ✅ Total Pages
        public int TotalPages
        {
            get { return ViewState["TotalPages"] != null ? (int)ViewState["TotalPages"] : 0; }
            set { ViewState["TotalPages"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();

                int? categoryId = null;

                if (Request.QueryString["category"] != null)
                {
                    categoryId = Convert.ToInt32(Request.QueryString["category"]);
                }

                // ✅ PAGE QUERY STRING
                if (Request.QueryString["page"] != null)
                {
                    PageIndex = Convert.ToInt32(Request.QueryString["page"]);
                }
                else
                {
                    PageIndex = 1;
                }

                LoadBlogs(categoryId);
            }
        }
        //this section is For the active state of category and page buttons
        protected string GetCategoryClass(object categoryId)
        {
            string activeCategory = Request.QueryString["category"];

            if (activeCategory == categoryId.ToString())
            {
                return "btn btn-secondary me-2 active";
            }

            return "btn btn-outline-secondary me-2";
        }
        //this function for pagination actuve class
        protected string GetPageClass(object pageNumber)
        {
            int currentPage = 1;

            if (Request.QueryString["page"] != null)
            {
                currentPage = Convert.ToInt32(Request.QueryString["page"]);
            }

            if (currentPage == Convert.ToInt32(pageNumber))
            {
                return "page-number-btn active";
            }

            return "page-number-btn";
        }
        // 🔹 Load Categories
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

        // 🔹 Load Blogs
        private void LoadBlogs(int? categoryId = null)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // ✅ COUNT TOTAL BLOGS
                string countQuery = "SELECT COUNT(*) FROM Blogs WHERE IsActive = 1";

                if (categoryId != null)
                {
                    countQuery += " AND CategoryId = @CategoryId";
                }

                SqlCommand countCmd = new SqlCommand(countQuery, con);

                if (categoryId != null)
                {
                    countCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                }

                int totalBlogs = Convert.ToInt32(countCmd.ExecuteScalar());

                // ✅ CALCULATE TOTAL PAGES
                int pageSize = 9;
                TotalPages = (int)Math.Ceiling((double)totalBlogs / pageSize);

                // 🔹 MAIN BLOG QUERY
                string query = @"
               
                   SELECT
    b.BlogId,
    b.Slug,
    b.AuthorName,
    b.AuthorImage,
    b.ReadTime,
    b.CreatedDate,
    c.CategoryName,

                    ISNULL((
                        SELECT TOP 1 Content
                        FROM BlogBlocks
                        WHERE BlogId = b.BlogId AND BlockType = 'h1'
                        ORDER BY DisplayOrder
                    ), 'Untitled Blog') AS Title,

                    ISNULL((
                        SELECT TOP 1 Content
                        FROM BlogBlocks
                        WHERE BlogId = b.BlogId AND BlockType = 'image'
                        ORDER BY DisplayOrder
                    ), '/uploads/default.jpg') AS CoverImage,

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

                // 🔹 Pagination
                query += " ORDER BY b.CreatedDate DESC";
                query += " OFFSET (@PageIndex - 1) * 9 ROWS FETCH NEXT 9 ROWS ONLY";

                SqlCommand cmd = new SqlCommand(query, con);

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

                // ✅ LOAD PAGE NUMBERS
                LoadPagination();
            }
        }

        // ✅ LOAD PAGE NUMBERS
        private void LoadPagination()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PageNumber");

            for (int i = 1; i <= TotalPages; i++)
            {
                dt.Rows.Add(i);
            }

            rptPagination.DataSource = dt;
            rptPagination.DataBind();
        }

        // ✅ PAGE CLICK EVENT
        //protected void Page_Changed(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        //{
        //    PageIndex = Convert.ToInt32(e.CommandArgument);
        //    LoadBlogs();
        //}

        // 🔹 Latest Button
        protected void btnLatest_Click(object sender, EventArgs e)
        {
            PageIndex = 1;
            LoadBlogs();
        }

        // 🔹 Category Click
        protected void Category_Click(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);

            PageIndex = 1;
            LoadBlogs(categoryId);
        }
    }
}
