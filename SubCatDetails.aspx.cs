using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class SubCatDetails : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string boardSlug = Request.QueryString["board"];
                string resSlug = Request.QueryString["res"];

                if (string.IsNullOrEmpty(boardSlug) || string.IsNullOrEmpty(resSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadHeader(boardSlug, resSlug);
                LoadSubCategories(boardSlug, resSlug);
            }
        }

        private void LoadHeader(string bSlug, string rSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT B.BoardName, RT.TypeName 
                                 FROM Boards B, ResourceTypes RT 
                                 WHERE B.Slug = @bSlug AND RT.Slug = @rSlug";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", bSlug);
                cmd.Parameters.AddWithValue("@rSlug", rSlug);

                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        litTitle.Text = dr["TypeName"].ToString();
                        litSubtitle.Text = $"Select a category for {dr["BoardName"]}";
                    }
                }
            }
        }

        private void LoadSubCategories(string bSlug, string rSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added B.IsCompetitive to the select list
                string query = @"SELECT S.SubCategoryName, S.Slug, S.IconImage, S.Description, B.IsCompetitive
                                 FROM SubCategories S
                                 INNER JOIN Boards B ON S.BoardId = B.BoardId
                                 INNER JOIN ResourceTypes RT ON S.ResourceTypeId = RT.ResourceTypeId
                                 WHERE B.Slug = @bSlug AND RT.Slug = @rSlug AND S.IsActive = 1
                                 ORDER BY S.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", bSlug);
                cmd.Parameters.AddWithValue("@rSlug", rSlug);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSubCats.DataSource = dt;
                rptSubCats.DataBind();
            }
        }

        // Logic to determine path: CBSE vs Competitive
        protected string GetDynamicUrl(object subCatSlug, object isCompetitive)
        {
            string board = Request.QueryString["board"];
            string res = Request.QueryString["res"];
            bool competitive = isCompetitive != DBNull.Value && Convert.ToBoolean(isCompetitive);

            if (competitive)
            {
                // Send JEE/NEET users to the NEW specialized page
                return $"CompSubSelect.aspx?board={board}&res={res}&subcat={subCatSlug}";
            }
            else
            {
                // Send CBSE/ICSE users to the STANDARD selection page
                return $"BoardResource.aspx?board={board}&res={res}&subcat={subCatSlug}";
            }
        }
    }
}