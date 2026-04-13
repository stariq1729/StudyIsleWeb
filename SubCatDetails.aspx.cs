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
                string query = @"SELECT 
                                    S.SubCategoryId,
                                    S.SubCategoryName, 
                                    S.IconImage, 
                                    S.Description, 
                                    B.IsCompetitive
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

        // 🔥 ID-based navigation
        protected string GetDynamicUrl(object subCatId, object isCompetitive)
        {
            string boardSlug = Request.QueryString["board"];
            string resSlug = Request.QueryString["res"];

            bool competitive = isCompetitive != DBNull.Value && Convert.ToBoolean(isCompetitive);

            int scid = Convert.ToInt32(subCatId);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                if (competitive)
                {
                    // Competitive Flow (ID-based navigation)
                    string query = @"SELECT B.BoardId, RT.ResourceTypeId
                             FROM Boards B, ResourceTypes RT
                             WHERE B.Slug = @b AND RT.Slug = @r";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@b", boardSlug);
                    cmd.Parameters.AddWithValue("@r", resSlug);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            int bid = Convert.ToInt32(dr["BoardId"]);
                            int rid = Convert.ToInt32(dr["ResourceTypeId"]);

                            return $"CompSubSelect.aspx?bid={bid}&rid={rid}&scid={scid}";
                        }
                    }
                }
                else
                {
                    // Academic Flow (Slug-based navigation)
                    string subcatSlugQuery = @"SELECT Slug 
                                       FROM SubCategories 
                                       WHERE SubCategoryId = @scid";

                    SqlCommand cmd = new SqlCommand(subcatSlugQuery, con);
                    cmd.Parameters.AddWithValue("@scid", scid);

                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        string subcatSlug = result.ToString();
                        return $"BoardResource.aspx?board={boardSlug}&res={resSlug}&subcat={subcatSlug}";
                    }

                    // Fallback if slug is missing
                    return $"BoardResource.aspx?board={boardSlug}&res={resSlug}";
                }
            }

            // Final fallback
            return "Default.aspx";
        }
    }
}