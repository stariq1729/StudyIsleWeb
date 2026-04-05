using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class ViewResource : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Safety: Redirect if Board is missing entirely
                if (string.IsNullOrEmpty(Request.QueryString["board"]))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }
                BindAllResources();
            }
        }

        private void BindAllResources()
        {
            // 1. Capture all URL parameters
            string b = Request.QueryString["board"];
            string sc = Request.QueryString["subcat"];
            string s = Request.QueryString["subject"];
            string c = Request.QueryString["chapter"];
            string y = Request.QueryString["year"];
            string set = Request.QueryString["set"];
            string rt = Request.QueryString["res"]; // Resource Type (Tabs)

            using (SqlConnection con = new SqlConnection(cs))
            {
                // BASE QUERY: Start with Joins for Slugs
                string sql = @"
                    SELECT r.Title, r.Description, r.FilePath, r.ContentType 
                    FROM Resources r 
                    INNER JOIN Boards b ON r.BoardId = b.BoardId
                    LEFT JOIN SubCategories subc ON r.SubCategoryId = subc.SubCategoryId
                    LEFT JOIN Subjects subj ON r.SubjectId = subj.SubjectId
                    LEFT JOIN Chapters chap ON r.ChapterId = chap.ChapterId
                    LEFT JOIN Years yr ON r.YearId = yr.YearId
                    LEFT JOIN Sets st ON r.SetId = st.SetId
                    LEFT JOIN ResourceTypes rtype ON r.ResourceTypeId = rtype.ResourceTypeId
                    WHERE r.IsActive = 1 AND b.Slug = @b";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // Fix for the "@b not supplied" error: ensure it's never a C# null
                cmd.Parameters.AddWithValue("@b", b ?? (object)DBNull.Value);

                // --- GLOBAL FILTERS ---
                if (!string.IsNullOrEmpty(sc))
                {
                    sql += " AND subc.Slug = @sc";
                    cmd.Parameters.AddWithValue("@sc", sc);
                }
                if (!string.IsNullOrEmpty(rt))
                {
                    sql += " AND rtype.Slug = @rt";
                    cmd.Parameters.AddWithValue("@rt", rt);
                }

                // --- DYNAMIC PATH SILOS (The Fix) ---
                // Rule: If the URL has it, match the Slug. If it DOESN'T, force the DB column to be NULL.

                // Subject Filter
                if (!string.IsNullOrEmpty(s))
                {
                    sql += " AND subj.Slug = @s";
                    cmd.Parameters.AddWithValue("@s", s);
                }
                else
                {
                    sql += " AND r.SubjectId IS NULL";
                }

                // Chapter Filter
                if (!string.IsNullOrEmpty(c))
                {
                    sql += " AND chap.Slug = @c";
                    cmd.Parameters.AddWithValue("@c", c);
                }
                else
                {
                    sql += " AND r.ChapterId IS NULL";
                }

                // Year Filter
                if (!string.IsNullOrEmpty(y))
                {
                    sql += " AND (yr.YearName = @y OR yr.Slug = @y)";
                    cmd.Parameters.AddWithValue("@y", y);
                }
                else
                {
                    sql += " AND r.YearId IS NULL";
                }

                // Set Filter
                if (!string.IsNullOrEmpty(set))
                {
                    sql += " AND st.Slug = @set";
                    cmd.Parameters.AddWithValue("@set", set);
                }
                else
                {
                    sql += " AND r.SetId IS NULL";
                }

                cmd.CommandText = sql;

                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptResources.DataSource = dt;
                    rptResources.DataBind();

                    if (phEmpty != null) phEmpty.Visible = (dt.Rows.Count == 0);
                }
                catch (SqlException)
                {
                    // Log error
                }
            }
        }

        protected string GetTheme(string type) => (type ?? "").ToLower().Contains("pdf") ? "bg-pdf" : "bg-gen";
        protected string GetIcon(string type) => (type ?? "").ToLower().Contains("pdf") ? "fas fa-file-pdf" : "fas fa-file-alt";
    }
}