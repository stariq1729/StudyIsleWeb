using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class BoardResource : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string boardSlug = Request.QueryString["board"];
                string classSlug = Request.QueryString["class"];
                string resSlug = Request.QueryString["res"] ?? "cbse"; // Default to cbse if null

                if (string.IsNullOrEmpty(boardSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // If no class selected, we don't hardcode "class-12" yet, 
                // we'll handle it after binding the available classes.
                BindClasses(boardSlug, resSlug);

                // Re-check classSlug after BindClasses logic
                if (string.IsNullOrEmpty(classSlug)) classSlug = "class-12";

                BindPageContent(boardSlug, classSlug);
                BindSubjectsAndResources(boardSlug, classSlug, resSlug);
            }
        }

        private void BindClasses(string boardSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Only show classes that HAVE resources for this board and resource type
                string query = @"SELECT DISTINCT c.ClassName, c.Slug, c.DisplayOrder 
                                 FROM Classes c 
                                 INNER JOIN Boards b ON c.BoardId = b.BoardId 
                                 INNER JOIN Resources r ON r.ClassId = c.ClassId
                                 INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                                 WHERE b.Slug = @bSlug AND rt.Slug = @resSlug AND c.IsActive = 1 
                                 ORDER BY c.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@resSlug", resSlug);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptClasses.DataSource = dt;
                rptClasses.DataBind();
            }
        }

        private void BindPageContent(string boardSlug, string classSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT c.PageTitle, c.PageSubtitle FROM Classes c 
                                 JOIN Boards b ON c.BoardId = b.BoardId 
                                 WHERE b.Slug = @bSlug AND c.Slug = @cSlug";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litPageTitle.Text = dr["PageTitle"].ToString();
                    litPageSubtitle.Text = dr["PageSubtitle"].ToString();
                }
                con.Close();
            }
        }

        private void BindSubjectsAndResources(string boardSlug, string classSlug, string resSlug)
        {
            string subcatSlug = Request.QueryString["subcat"]; // Capture the new parameter

            using (SqlConnection con = new SqlConnection(cs))
            {
                // We use LEFT JOIN or a flexible WHERE clause to handle the subcat
                string query = @"SELECT DISTINCT s.SubjectId, s.SubjectName, s.IconImage 
                         FROM Subjects s
                         INNER JOIN Classes c ON s.ClassId = c.ClassId
                         INNER JOIN Boards b ON s.BoardId = b.BoardId
                         INNER JOIN Resources r ON r.SubjectId = s.SubjectId
                         INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                         LEFT JOIN SubCategories sc ON r.SubCategoryId = sc.SubCategoryId
                         WHERE b.Slug = @bSlug 
                         AND c.Slug = @cSlug 
                         AND rt.Slug = @resSlug 
                         AND (@subcatSlug IS NULL OR sc.Slug = @subcatSlug)
                         AND s.IsActive = 1 AND r.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);
                cmd.Parameters.AddWithValue("@resSlug", resSlug);
                // If subcat is missing from URL, we pass DBNull to ignore that filter
                cmd.Parameters.AddWithValue("@subcatSlug", (object)subcatSlug ?? DBNull.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSubjectGroups.DataSource = dt;
                rptSubjectGroups.DataBind();
            }
        }


    }
}