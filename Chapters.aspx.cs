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
                string bid = Request.QueryString["bid"];
                string rid = Request.QueryString["rid"];
                string scid = Request.QueryString["scid"];
                string sid = Request.QueryString["sid"];

                if (string.IsNullOrEmpty(bid) || string.IsNullOrEmpty(scid))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                InitializeChapterView(
                    Convert.ToInt32(bid),
                    rid,
                    Convert.ToInt32(scid),
                    sid
                );
            }
        }

        private void InitializeChapterView(int boardId, string rId, int subCatId, string sIdStr)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                int subjectId = string.IsNullOrEmpty(sIdStr) ? 0 : Convert.ToInt32(sIdStr);

                // 🔹 Header
                string metaSql = @"SELECT SubjectName FROM Subjects WHERE SubjectId = @sid";

                if (subjectId > 0)
                {
                    SqlCommand cmdMeta = new SqlCommand(metaSql, con);
                    cmdMeta.Parameters.AddWithValue("@sid", subjectId);

                    object res = cmdMeta.ExecuteScalar();
                    litSubjectName.Text = res != null ? res.ToString() : "Resources";
                }
                else
                {
                    litSubjectName.Text = "Resources";
                }

                // 🔹 Chapters Query
                string sql = @"SELECT ChapterName, ChapterId, 
                               CASE WHEN EXISTS 
                               (SELECT 1 FROM Sets WHERE ChapterId = C.ChapterId AND IsActive = 1) 
                               THEN 1 ELSE 0 END as HasSets
                               FROM Chapters C 
                               WHERE IsActive = 1";

                if (subjectId > 0)
                {
                    sql += " AND SubjectId = @sid";
                }
                else
                {
                    sql += @" AND (
                SubCategoryId = @scid
                OR SubjectId IN (
                    SELECT SubjectId FROM Subjects WHERE SubCategoryId = @scid
                )
             )";
                }

                SqlCommand cmd = new SqlCommand(sql, con);

                if (subjectId > 0)
                    cmd.Parameters.AddWithValue("@sid", subjectId);
                else
                    cmd.Parameters.AddWithValue("@scid", subCatId);

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
                    Response.Redirect($"ViewResource.aspx?bid={boardId}&rid={rId}&scid={subCatId}&sid={subjectId}");
                }
            }
        }

        protected string GetFinalUrl(object chapterId, object hasSets)
        {
            string bid = Request.QueryString["bid"];
            string rid = Request.QueryString["rid"];
            string scid = Request.QueryString["scid"];
            string sid = Request.QueryString["sid"];

            bool setsExist = Convert.ToInt32(hasSets) == 1;

            string targetPage = setsExist ? "Sets.aspx" : "ViewResource.aspx";

            return $"{targetPage}?bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={chapterId}";
        }
    }
}