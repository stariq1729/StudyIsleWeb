using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class ViewResource : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSpecificResources();
            }
        }

        private void BindSpecificResources()
        {
            // 1. Capture parameters exactly as they appear in your URL screenshot
            string boardSlug = Request.QueryString["board"];   // e.g., "jee"
            string resSlug = Request.QueryString["res"];       // e.g., "jee-advance..."
            string subcatSlug = Request.QueryString["subcat"]; // e.g., "pyq-dummy"
            string setSlug = Request.QueryString["set"];       // e.g., "2027+pyq..."
            string yearName = Request.QueryString["year"];     // e.g., "2027"

            // Note: If you still use cid/sid for CBSE flow, keep them
            string cid = Request.QueryString["cid"];

            using (SqlConnection con = new SqlConnection(cs))
            {
                // 2. Build Query with JOINs to filter by Text Slugs instead of Numeric IDs
                string sql = @"SELECT r.Title, r.Description, r.FilePath, r.ContentType, r.CreatedAt 
                               FROM Resources r 
                               INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                               LEFT JOIN Boards b ON r.BoardId = b.BoardId
                               LEFT JOIN SubCategories sc ON r.SubCategoryId = sc.SubCategoryId
                               LEFT JOIN Sets s ON r.SetId = s.SetId
                               LEFT JOIN Years y ON r.YearId = y.YearId
                               WHERE r.IsActive = 1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // --- PRIORITY LADDER (Using Slugs/Names) ---

                // PRIORITY 1: Chapter ID (Numeric fallback for CBSE flow)
                if (!string.IsNullOrEmpty(cid))
                {
                    sql += " AND r.ChapterId = @cid";
                    cmd.Parameters.AddWithValue("@cid", cid);
                }
                // PRIORITY 2: Competitive Set (Using the 'set' slug from URL)
                else if (!string.IsNullOrEmpty(setSlug))
                {
                    // Match by Set Name or Slug depending on your table column name
                    sql += " AND s.SetName = @setSlug";
                    cmd.Parameters.AddWithValue("@setSlug", setSlug.Replace("+", " ")); // Handle URL encoding

                    if (!string.IsNullOrEmpty(yearName))
                    {
                        sql += " AND y.YearName = @yearName";
                        cmd.Parameters.AddWithValue("@yearName", yearName);
                    }
                }
                // PRIORITY 3: SubCategory/Class (Using 'subcat' slug from URL)
                else if (!string.IsNullOrEmpty(subcatSlug))
                {
                    sql += " AND sc.SubCategoryName = @subcatSlug";
                    cmd.Parameters.AddWithValue("@subcatSlug", subcatSlug);
                }
                // PRIORITY 4: Board Level (Using 'board' slug from URL)
                else if (!string.IsNullOrEmpty(boardSlug))
                {
                    sql += " AND b.BoardName = @boardSlug";
                    cmd.Parameters.AddWithValue("@boardSlug", boardSlug);
                }
                else
                {
                    // Security: If no specific filters, show nothing
                    sql += " AND 1=0";
                }

                // ALWAYS filter by the Resource Type (e.g., 'book-pdf' or 'video')
                if (!string.IsNullOrEmpty(resSlug))
                {
                    sql += " AND rt.Slug = @res";
                    cmd.Parameters.AddWithValue("@res", resSlug);
                }

                cmd.CommandText = sql;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                try
                {
                    con.Open();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptResources.DataSource = dt;
                        rptResources.DataBind();
                        phNoData.Visible = false;
                    }
                    else
                    {
                        rptResources.DataSource = null;
                        rptResources.DataBind();
                        phNoData.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    // Debugging helper (Optional: remove in production)
                    // Response.Write("Error: " + ex.Message);
                    phNoData.Visible = true;
                }
            }
        }

        // --- Helper Methods for UI Icons ---
        protected string GetStatusClass(string type)
        {
            string t = type.ToLower();
            if (t.Contains("pdf")) return "bg-pdf";
            if (t.Contains("image") || t.Contains("png") || t.Contains("jpg")) return "bg-image";
            if (t.Contains("video")) return "bg-video";
            return "bg-default";
        }

        protected string GetIcon(string type)
        {
            string t = type.ToLower();
            if (t.Contains("pdf")) return "fas fa-file-pdf";
            if (t.Contains("image")) return "fas fa-file-image";
            if (t.Contains("video")) return "fas fa-play-circle";
            return "fas fa-file-alt";
        }
    }
}