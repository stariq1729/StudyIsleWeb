using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

//this page needed a target flow

namespace StudyIsleWeb
{
    public partial class CompSubSelect : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve Slugs from SubCatDetails.aspx
                string boardSlug = Request.QueryString["board"];
                string resSlug = Request.QueryString["res"];
                string subcatSlug = Request.QueryString["subcat"];

                // Validate parameters to prevent blank pages or errors
                if (string.IsNullOrEmpty(boardSlug) || string.IsNullOrEmpty(subcatSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                BindPageData(boardSlug, subcatSlug);
            }
        }

        private void BindPageData(string bSlug, string sSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // First: Get IDs and Names for the Header/Query
                string metaQuery = @"SELECT B.BoardId, B.BoardName, SC.SubCategoryId, SC.SubCategoryName 
                                   FROM Boards B, SubCategories SC 
                                   WHERE B.Slug = @bSlug AND SC.Slug = @sSlug";

                SqlCommand cmdMeta = new SqlCommand(metaQuery, con);
                cmdMeta.Parameters.AddWithValue("@bSlug", bSlug);
                cmdMeta.Parameters.AddWithValue("@sSlug", sSlug);

                int boardId = 0;
                int subCategoryId = 0;

                con.Open();
                using (SqlDataReader dr = cmdMeta.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        litBoardName.Text = dr["BoardName"].ToString();
                        litSubCatName.Text = dr["SubCategoryName"].ToString();
                        boardId = Convert.ToInt32(dr["BoardId"]);
                        subCategoryId = Convert.ToInt32(dr["SubCategoryId"]);
                    }
                    else
                    {
                        // If slugs are invalid/manipulated in URL
                        Response.Redirect("Default.aspx");
                        return;
                    }
                }

                // Second: Bind Subjects based on those IDs
                string subQuery = @"SELECT SubjectName, Slug, IconImage, Description 
                                  FROM Subjects 
                                  WHERE BoardId = @bid AND SubCategoryId = @scid AND IsActive = 1 
                                  ORDER BY SubjectName ASC";

                SqlCommand cmdSub = new SqlCommand(subQuery, con);
                cmdSub.Parameters.AddWithValue("@bid", boardId);
                cmdSub.Parameters.AddWithValue("@scid", subCategoryId);

                SqlDataAdapter da = new SqlDataAdapter(cmdSub);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptSubjects.DataSource = dt;
                    rptSubjects.DataBind();
                    lblNoData.Visible = false;
                }
                else
                {
                    rptSubjects.DataSource = null;
                    rptSubjects.DataBind();
                    lblNoData.Visible = true;
                    lblNoData.Text = "We are currently uploading subjects for this category. Stay tuned!";
                }
            }
        }

        /// <summary>
        /// Builds the URL for the next step (Chapters/Resources)
        /// Passes through the board, resource type, and sub-category context.
        /// </summary>
        protected string GetNavigationUrl(object subjectSlug)
        {
            string b = Request.QueryString["board"];
            string r = Request.QueryString["res"];
            string s = Request.QueryString["subcat"];

            // Format: Chapters.aspx?board=jee&res=pyqs&subcat=syllabus&subject=physics
            return $"Chapters.aspx?board={b}&res={r}&subcat={s}&subject={subjectSlug}";
        }
    }
}