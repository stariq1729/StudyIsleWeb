using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class BoardResourceTypes : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string boardSlug = Request.QueryString["board"] ?? "cbse";
                LoadDynamicBoardHero(boardSlug);
                LoadResources();
            }
        }

        private void LoadDynamicBoardHero(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Querying HeroTitle and HeroSubtitle from the database column as requested
                string query = "SELECT HeroTitle, HeroSubtitle FROM Boards WHERE Slug = @Slug";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litHeroTitle.Text = dr["HeroTitle"].ToString();
                    litHeroSubtitle.Text = dr["HeroSubtitle"].ToString();
                }
            }
        }

        private void LoadResources()
        {
            // 1. Get the current board slug from the URL (e.g., 'cbse')
            string boardSlug = Request.QueryString["board"] ?? "cbse";

            using (SqlConnection con = new SqlConnection(cs))
            {
                // 2. This query joins ResourceTypes with the Mapping and Boards tables
                string query = @"
            SELECT RT.TypeName, RT.Slug, RT.IconImage, RT.Description, RT.HasClass 
            FROM ResourceTypes RT
            INNER JOIN BoardResourceMapping BRM ON RT.ResourceTypeId = BRM.ResourceTypeId
            INNER JOIN Boards B ON BRM.BoardId = B.BoardId
            WHERE B.Slug = @BoardSlug AND RT.IsActive = 1
            ORDER BY RT.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardSlug", boardSlug);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // 3. Bind the filtered results to your Repeater
                rptResources.DataSource = dt;
                rptResources.DataBind();
            }
        }

        protected string GetNavigationUrl(object resSlug, object hasClass)
        {
            string boardSlug = Request.QueryString["board"] ?? "cbse";

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Logic: Check if this specific Board + Resource Type has any SubCategories
                string query = @"SELECT COUNT(*) FROM SubCategories s
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 INNER JOIN ResourceTypes rt ON s.ResourceTypeId = rt.ResourceTypeId
                                 WHERE b.Slug = @bSlug AND rt.Slug = @rSlug AND s.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@rSlug", resSlug.ToString());

                con.Open();
                int subCatCount = (int)cmd.ExecuteScalar();

                // ROUTING DECISION
                if (subCatCount > 0)
                {
                    // Redirect to SubCategory selection first
                    return $"SubCatDetails.aspx?board={boardSlug}&res={resSlug}";
                }
                else
                {
                    // Skip directly to Class/Subject selection
                    bool needsClass = Convert.ToBoolean(hasClass);
                    return needsClass ? $"BoardResource.aspx?board={boardSlug}&res={resSlug}" : $"ViewContent.aspx?board={boardSlug}&res={resSlug}";
                }
            }
        }
    }
}