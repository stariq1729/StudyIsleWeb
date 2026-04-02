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
                BindAllResources();
            }
        }

        private void BindAllResources()
        {
            // Capture all slugs from the URL
            string b = Request.QueryString["board"];
            string sc = Request.QueryString["subcat"]; // Usually 'notes', 'videos', etc.
            string s = Request.QueryString["subject"];
            string c = Request.QueryString["chapter"];
            string y = Request.QueryString["year"];
            string set = Request.QueryString["set"];
            string resType = Request.QueryString["res"]; // The explicit resource type slug

            using (SqlConnection con = new SqlConnection(cs))
            {
                // BASE QUERY: Start with Board and ResourceType join
                string sql = @"SELECT r.Title, r.Description, r.FilePath, r.ContentType 
                               FROM Resources r 
                               INNER JOIN Boards b ON r.BoardId = b.BoardId
                               INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                               WHERE r.IsActive = 1 AND b.Slug = @bParam";

                SqlCommand cmd = new SqlCommand();
                cmd.Parameters.AddWithValue("@bParam", b);

                // --- THE FIX FOR SUBJECT VISIBILITY ---
                // If a Subject is selected, we filter by Subject but STOP forcing the SubCategoryId.
                // This allows resources that are ONLY linked to a Subject to appear.
                if (!string.IsNullOrEmpty(s))
                {
                    sql += " AND r.SubjectId = (SELECT SubjectId FROM Subjects WHERE Slug = @sParam)";
                    cmd.Parameters.AddWithValue("@sParam", s);
                }
                // If NO subject is selected, we still filter by SubCategory (Class-wise view)
                else if (!string.IsNullOrEmpty(sc))
                {
                    sql += " AND r.SubCategoryId = (SELECT SubCategoryId FROM SubCategories WHERE Slug = @scParam)";
                    cmd.Parameters.AddWithValue("@scParam", sc);
                }

                // --- CHAPTER WISE RESOURCE ---
                if (!string.IsNullOrEmpty(c))
                {
                    sql += " AND r.ChapterId = (SELECT ChapterId FROM Chapters WHERE Slug = @cParam)";
                    cmd.Parameters.AddWithValue("@cParam", c);
                }

                // --- YEAR WISE RESOURCE (Competitive) ---
                if (!string.IsNullOrEmpty(y))
                {
                    sql += " AND r.YearId = (SELECT YearId FROM Years WHERE YearName = @yParam)";
                    cmd.Parameters.AddWithValue("@yParam", y);
                }

                // --- SET WISE RESOURCE (Competitive) ---
                if (!string.IsNullOrEmpty(set))
                {
                    sql += " AND r.SetId = (SELECT SetId FROM Sets WHERE Slug = @setParam)";
                    cmd.Parameters.AddWithValue("@setParam", set);
                }

                // --- RESOURCE TYPE FILTER (Tabs) ---
                if (!string.IsNullOrEmpty(resType))
                {
                    sql += " AND rt.Slug = @resTypeParam";
                    cmd.Parameters.AddWithValue("@resTypeParam", resType);
                }

                cmd.CommandText = sql;
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                try
                {
                    con.Open();
                    da.Fill(dt);
                    rptResources.DataSource = dt;
                    rptResources.DataBind();
                    phEmpty.Visible = (dt.Rows.Count == 0); // Show "No Resources" only if count is 0
                }
                catch { /* Handle error */ }
            }
        }

        // Helper methods for UI styling
        protected string GetTheme(string type)
        {
            string t = type.ToLower();
            if (t.Contains("pdf")) return "bg-pdf";
            if (t.Contains("image")) return "bg-img";
            if (t.Contains("video")) return "bg-vid";
            return "bg-gen";
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