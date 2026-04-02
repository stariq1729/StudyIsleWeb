using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class Sets : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string board = Request.QueryString["board"];
                string res = Request.QueryString["res"];
                string subcat = Request.QueryString["subcat"];
                string year = Request.QueryString["year"];
                string chapter = Request.QueryString["chapter"];

                if (string.IsNullOrEmpty(board) || string.IsNullOrEmpty(subcat))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadSets(board, res, subcat, year, chapter);
            }
        }

        private void LoadSets(string bSlug, string rSlug, string scSlug, string ySlug, string cSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // We now select the actual 'Slug' column you just created
                string sql = "SELECT SetName, Slug FROM Sets WHERE IsActive = 1 ";

                if (!string.IsNullOrEmpty(cSlug))
                {
                    sql += " AND ChapterId = (SELECT ChapterId FROM Chapters WHERE Slug = @chapter)";
                }
                else if (!string.IsNullOrEmpty(ySlug))
                {
                    sql += " AND YearId = (SELECT YearId FROM Years WHERE YearName = @year)";
                }

                sql += " AND SubCategoryId = (SELECT SubCategoryId FROM SubCategories WHERE Slug = @subcat)";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@subcat", scSlug);
                if (!string.IsNullOrEmpty(cSlug)) cmd.Parameters.AddWithValue("@chapter", cSlug);
                if (!string.IsNullOrEmpty(ySlug)) cmd.Parameters.AddWithValue("@year", ySlug);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptSets.DataSource = dt;
                    rptSets.DataBind();
                }
                else
                {
                    // If no specific sets exist, push directly to ViewResource.aspx
                    string redirectUrl = $"ViewResource.aspx?board={bSlug}&res={rSlug}&subcat={scSlug}";
                    if (!string.IsNullOrEmpty(ySlug)) redirectUrl += $"&year={ySlug}";
                    if (!string.IsNullOrEmpty(cSlug)) redirectUrl += $"&chapter={cSlug}";

                    Response.Redirect(redirectUrl);
                }
            }
        }

        protected string GetResourceUrl(object setSlug)
        {
            string b = Request.QueryString["board"];
            string r = Request.QueryString["res"];
            string sc = Request.QueryString["subcat"];
            string y = Request.QueryString["year"];
            string c = Request.QueryString["chapter"];

            // The 'set' parameter will now carry the SetName text
            string url = $"ViewResource.aspx?board={b}&res={r}&subcat={sc}&set={HttpUtility.UrlEncode(setSlug.ToString())}";
            if (!string.IsNullOrEmpty(y)) url += $"&year={y}";
            if (!string.IsNullOrEmpty(c)) url += $"&chapter={c}";

            return url;
        }
    }
}