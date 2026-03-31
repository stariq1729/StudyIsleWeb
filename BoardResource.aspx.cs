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
                string resSlug = Request.QueryString["res"]; // e.g., 'ncert-solutions'
                string classSlug = Request.QueryString["class"];

                if (string.IsNullOrEmpty(boardSlug) || string.IsNullOrEmpty(resSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // 1. Load available classes for this Board and Resource Type
                DataTable dtClasses = BindClasses(boardSlug, resSlug);

                // 2. Determine which class to show (QueryString or first available)
                if (string.IsNullOrEmpty(classSlug) && dtClasses.Rows.Count > 0)
                {
                    classSlug = dtClasses.Rows[0]["Slug"].ToString();
                }

                // 3. Update Hero Section & Subjects if a class exists
                if (!string.IsNullOrEmpty(classSlug))
                {
                    BindPageContent(boardSlug, classSlug);
                    BindSubjects(boardSlug, classSlug, resSlug);
                }
            }
        }

        private DataTable BindClasses(string boardSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Removed INNER JOIN Resources so classes show up even if empty
                string query = @"SELECT c.ClassName, c.Slug 
                                 FROM Classes c 
                                 INNER JOIN Boards b ON c.BoardId = b.BoardId
                                 INNER JOIN ResourceTypes rt ON c.ResourceTypeId = rt.ResourceTypeId
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
                return dt;
            }
        }

        private void BindPageContent(string boardSlug, string classSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Pulling Hero Title and Subtitle directly from Class table
                string query = @"SELECT PageTitle, PageSubtitle FROM Classes c 
                                 JOIN Boards b ON c.BoardId = b.BoardId 
                                 WHERE b.Slug = @bSlug AND c.Slug = @cSlug";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litPageTitle.Text = dr["PageTitle"] != DBNull.Value ? dr["PageTitle"].ToString() : "";
                    litPageSubtitle.Text = dr["PageSubtitle"] != DBNull.Value ? dr["PageSubtitle"].ToString() : "";
                }
                con.Close();
            }
        }

        private void BindSubjects(string boardSlug, string classSlug, string resSlug)
        {
            string subcatSlug = Request.QueryString["subcat"];

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Show subjects linked to this Board, Class, and ResourceType
                string query = @"SELECT s.SubjectId, s.SubjectName, s.IconImage 
                                 FROM Subjects s
                                 INNER JOIN Classes c ON s.ClassId = c.ClassId
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 INNER JOIN ResourceTypes rt ON s.ResourceTypeId = rt.ResourceTypeId
                                 LEFT JOIN SubCategories sc ON s.SubCategoryId = sc.SubCategoryId
                                 WHERE b.Slug = @bSlug 
                                 AND c.Slug = @cSlug 
                                 AND rt.Slug = @resSlug 
                                 AND (@subcatSlug IS NULL OR sc.Slug = @subcatSlug)
                                 AND s.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);
                cmd.Parameters.AddWithValue("@resSlug", resSlug);
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