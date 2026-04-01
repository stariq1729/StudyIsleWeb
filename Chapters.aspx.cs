using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class Chapters : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string board = Request.QueryString["board"];
                string res = Request.QueryString["res"];
                string subcat = Request.QueryString["subcat"];
                string subject = Request.QueryString["subject"]; // May be null if redirected from year flow

                if (string.IsNullOrEmpty(board) || string.IsNullOrEmpty(subcat))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                CheckDataFlow(board, res, subcat, subject);
            }
        }

        private void CheckDataFlow(string bSlug, string rSlug, string scSlug, string sSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1. Get IDs for filtering
                int subjectId = 0;
                if (!string.IsNullOrEmpty(sSlug))
                {
                    SqlCommand cmdSub = new SqlCommand("SELECT SubjectId, SubjectName FROM Subjects WHERE Slug=@s", con);
                    cmdSub.Parameters.AddWithValue("@s", sSlug);
                    using (SqlDataReader dr = cmdSub.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            subjectId = (int)dr["SubjectId"];
                            litSubjectName.Text = dr["SubjectName"].ToString();
                        }
                    }
                }

                // 2. PRIORITY: Check for Chapters
                string chapterSql = "SELECT ChapterName, Slug FROM Chapters WHERE IsActive=1 ";
                if (subjectId > 0) chapterSql += " AND SubjectId = @sid";
                else chapterSql += " AND SubCategoryId = (SELECT SubCategoryId FROM SubCategories WHERE Slug=@sc)";

                SqlCommand cmdChap = new SqlCommand(chapterSql, con);
                if (subjectId > 0) cmdChap.Parameters.AddWithValue("@sid", subjectId);
                else cmdChap.Parameters.AddWithValue("@sc", scSlug);

                SqlDataAdapter da = new SqlDataAdapter(cmdChap);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Found Chapters - Show them
                    litResourceTitle.Text = "Book PDF Resources";
                    litCount.Text = dt.Rows.Count.ToString();
                    rptChapters.DataSource = dt;
                    rptChapters.DataBind();
                }
                else
                {
                    // 3. NO CHAPTERS: Check for Sets
                    // We check if any sets exist for this context
                    string setCheckSql = "SELECT COUNT(*) FROM Sets WHERE IsActive=1 AND SubCategoryId = (SELECT SubCategoryId FROM SubCategories WHERE Slug=@sc)";
                    SqlCommand cmdSetCheck = new SqlCommand(setCheckSql, con);
                    cmdSetCheck.Parameters.AddWithValue("@sc", scSlug);

                    int setCount = (int)cmdSetCheck.ExecuteScalar();

                    if (setCount > 0)
                    {
                        // Redirect to Sets page
                        Response.Redirect($"Sets.aspx?board={bSlug}&res={rSlug}&subcat={scSlug}&subject={sSlug}");
                    }
                    else
                    {
                        // 4. NO CHAPTERS & NO SETS: Go straight to ViewResource
                        Response.Redirect($"ViewResource.aspx?board={bSlug}&res={rSlug}&subcat={scSlug}&subject={sSlug}");
                    }
                }
            }
        }

        protected string GetFinalUrl(object chapterSlug)
        {
            string b = Request.QueryString["board"];
            string r = Request.QueryString["res"];
            string s = Request.QueryString["subcat"];
            string sub = Request.QueryString["subject"];

            return $"ViewResources.aspx?board={b}&res={r}&subcat={s}&subject={sub}&chapter={chapterSlug}";
        }
    }
}