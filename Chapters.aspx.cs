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

                // 🔹 Chapters Query (Enhanced with Quiz & Flashcard flags)
                string sql = @"
                    SELECT 
                        C.ChapterName,
                        C.ChapterId,
                        C.IsQuizEnabled,
                        C.IsFlashcardEnabled,
                        CASE 
                            WHEN EXISTS (
                                SELECT 1 FROM Sets 
                                WHERE ChapterId = C.ChapterId AND IsActive = 1
                            ) THEN 1 ELSE 0 
                        END AS HasSets
                    FROM Chapters C
                    WHERE C.IsActive = 1";

                if (subjectId > 0)
                {
                    sql += " AND C.SubjectId = @sid";
                }
                else
                {
                    sql += @"
                        AND (
                            C.SubCategoryId = @scid OR
                            C.SubjectId IN (
                                SELECT SubjectId FROM Subjects WHERE SubCategoryId = @scid
                            )
                        )";
                }

                sql += " ORDER BY C.DisplayOrder, C.ChapterName";

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

        /// <summary>
        /// Determines the final redirect URL for a chapter.
        /// Priority: Quiz → Flashcards → Sets → Resources
        /// </summary>
        protected string GetFinalUrl(object chapterId, object hasSets)
        {
            string bid = Request.QueryString["bid"];
            string rid = Request.QueryString["rid"];
            string scid = Request.QueryString["scid"];
            string sid = Request.QueryString["sid"];

            int cid = Convert.ToInt32(chapterId);
            bool setsExist = Convert.ToInt32(hasSets) == 1;

            bool isQuizEnabled = false;
            bool isFlashcardEnabled = false;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT 
                            ISNULL(IsQuizEnabled, 0) AS IsQuizEnabled,
                            ISNULL(IsFlashcardEnabled, 0) AS IsFlashcardEnabled
                         FROM Chapters 
                         WHERE ChapterId = @cid";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@cid", cid);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    isQuizEnabled = reader["IsQuizEnabled"] != DBNull.Value &&
                                    Convert.ToBoolean(reader["IsQuizEnabled"]);

                    isFlashcardEnabled = reader["IsFlashcardEnabled"] != DBNull.Value &&
                                         Convert.ToBoolean(reader["IsFlashcardEnabled"]);
                }
            }

            // 🔹 Priority-Based Redirection
            if (isQuizEnabled)
            {
                return $"~/Quiz/QuizList.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={cid}";
            }
            else if (isFlashcardEnabled)
            {
                return $"~/Flashcards/FlashcardSetList.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={cid}";
            }
            else if (setsExist)
            {
                return $"~/Sets.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={cid}";
            }
            else
            {
                return $"~/ViewResource.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={cid}";
            }
        }

            // 🔹 Priority-Based Redirection
          
        
    }
}