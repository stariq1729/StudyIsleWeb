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
                string subject = Request.QueryString["subject"];

                if (string.IsNullOrEmpty(board) || string.IsNullOrEmpty(subcat))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                InitializeChapterView(board, res, subcat, subject);
            }
        }

        private void InitializeChapterView(string bSlug, string rSlug, string scSlug, string sSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1. Resolve IDs and Subject Header
                int subjectId = 0, subCatId = 0;
                string metaSql = @"SELECT S.SubjectId, S.SubjectName, SC.SubCategoryId 
                                   FROM SubCategories SC 
                                   LEFT JOIN Subjects S ON S.Slug = @s 
                                   WHERE SC.Slug = @sc";

                SqlCommand cmdMeta = new SqlCommand(metaSql, con);
                cmdMeta.Parameters.AddWithValue("@s", (object)sSlug ?? DBNull.Value);
                cmdMeta.Parameters.AddWithValue("@sc", scSlug);

                using (SqlDataReader dr = cmdMeta.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        subCatId = (int)dr["SubCategoryId"];
                        if (dr["SubjectId"] != DBNull.Value) subjectId = (int)dr["SubjectId"];
                        litSubjectName.Text = dr["SubjectName"]?.ToString() ?? "Resources";
                    }
                }

                // 2. Fetch Chapters and Check for Sets (Requirement: "If chapter exist show me that")
                // We use a BIT (1 or 0) to flag if sets exist for each chapter
                string sql = @"SELECT ChapterName, Slug, 
                               CASE WHEN EXISTS (SELECT 1 FROM Sets WHERE ChapterId = C.ChapterId AND IsActive = 1) 
                               THEN 1 ELSE 0 END as HasSets
                               FROM Chapters C 
                               WHERE IsActive = 1 ";

                if (subjectId > 0) sql += " AND SubjectId = @sid";
                else sql += " AND SubCategoryId = @scid";

                SqlCommand cmd = new SqlCommand(sql, con);
                if (subjectId > 0) cmd.Parameters.AddWithValue("@sid", subjectId);
                else cmd.Parameters.AddWithValue("@scid", subCatId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptChapters.DataSource = dt;
                    rptChapters.DataBind();
                }
                else
                {
                    // 3. (Requirement: "If chapters don't exists directly send them to view resource")
                    Response.Redirect($"ViewResource.aspx?board={bSlug}&res={rSlug}&subcat={scSlug}&subject={sSlug}");
                }
            }
        }

        protected string GetFinalUrl(object chapterSlug, object hasSets)
        {
            string b = Request.QueryString["board"];
            string r = Request.QueryString["res"];
            string s = Request.QueryString["subcat"];
            string sub = Request.QueryString["subject"];

            // 4. (Requirement: "if user click... check any sets exists... redirect to sets.aspx else... view resource")
            bool setsExist = Convert.ToInt32(hasSets) == 1;
            string targetPage = setsExist ? "Sets.aspx" : "ViewResource.aspx";

            return $"{targetPage}?board={b}&res={r}&subcat={s}&subject={sub}&chapter={chapterSlug}";
        }
    }
}