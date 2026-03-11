using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

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
                // We pull the Resource Type name to make the header dynamic 
                // e.g., "CBSE - Question Papers"
                string query = @"SELECT B.BoardName, RT.TypeName 
                                 FROM Boards B, ResourceTypes RT 
                                 WHERE B.Slug = @bSlug AND RT.Slug = @rSlug";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", bSlug);
                cmd.Parameters.AddWithValue("@rSlug", rSlug);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litTitle.Text = dr["TypeName"].ToString();
                    litSubtitle.Text = $"Select a category for {dr["BoardName"]}";
                }
            }
        }

        private void LoadSubCategories(string bSlug, string rSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT S.SubCategoryName, S.Slug, S.IconImage, S.Description 
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
    }
}