using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class SubjectDetails : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sId = Request.QueryString["sid"];
                string res = Request.QueryString["res"];

                if (string.IsNullOrEmpty(sId) || string.IsNullOrEmpty(res))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadSubjectInfo(sId);
                DetermineFlow(sId, res);
            }
        }

        /// <summary>
        /// Determines whether to show chapters or year-wise materials.
        /// Chapters are now visible even if no resources are uploaded.
        /// </summary>
        private void DetermineFlow(string sid, string res)
        {
            // ✅ Show chapters if they exist (independent of resources)
            if (CheckChaptersExist(sid))
            {
                phChapterPath.Visible = true;
                phYearPath.Visible = false;
                BindChapters(sid);
            }
            // 🔹 If no chapters, check for year-based resources
            else if (CheckDataExists("YearId", sid, res))
            {
                phYearPath.Visible = true;
                phChapterPath.Visible = false;
                BindYears(sid, res);
            }
            // 🔹 If nothing exists, redirect to resources
            else
            {
                Response.Redirect($"ViewResources.aspx?sid={sid}&res={res}");
            }
        }

        /// <summary>
        /// Checks if chapters exist for the selected subject.
        /// </summary>
        private bool CheckChaptersExist(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"SELECT COUNT(*) 
                               FROM Chapters 
                               WHERE SubjectId = @sid 
                               AND IsActive = 1";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);

                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        /// <summary>
        /// Checks if year-based resources exist.
        /// </summary>
        private bool CheckDataExists(string column, string sid, string res)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = $@"SELECT COUNT(*) 
                                FROM Resources r 
                                INNER JOIN ResourceTypes rt 
                                    ON r.ResourceTypeId = rt.ResourceTypeId 
                                WHERE r.SubjectId = @sid 
                                AND rt.Slug = @res 
                                AND r.{column} IS NOT NULL";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@res", res);

                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        /// <summary>
        /// Binds year-wise materials.
        /// </summary>
        private void BindYears(string sid, string res)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"SELECT DISTINCT y.YearId, y.YearName 
                               FROM Years y 
                               JOIN Resources r ON y.YearId = r.YearId 
                               JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
                               WHERE r.SubjectId = @sid 
                               AND rt.Slug = @res 
                               AND y.IsActive = 1 
                               ORDER BY y.YearName DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@res", res);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptYears.DataSource = dt;
                rptYears.DataBind();
            }
        }

        /// <summary>
        /// Binds chapters for the selected subject.
        /// </summary>
        private void BindChapters(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"
                    SELECT 
                        ChapterId,
                        ChapterName,
                        ISNULL(IsQuizEnabled, 0) AS IsQuizEnabled,
                        ISNULL(IsFlashcardEnabled, 0) AS IsFlashcardEnabled
                    FROM Chapters
                    WHERE SubjectId = @sid
                    AND IsActive = 1
                    ORDER BY DisplayOrder, ChapterName ASC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptChapters.DataSource = dt;
                rptChapters.DataBind();
            }
        }

        /// <summary>
        /// Loads subject name.
        /// </summary>
        private void LoadSubjectInfo(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubjectName FROM Subjects WHERE SubjectId = @id", con);

                cmd.Parameters.AddWithValue("@id", sid);
                con.Open();

                litSubjectName.Text = cmd.ExecuteScalar()?.ToString();
            }
        }

        /// <summary>
        /// Redirects based on feature availability.
        /// </summary>
        protected string GetChapterRedirectUrl(object chapterIdObj,
                                               object quizObj,
                                               object flashObj)
        {
            string sid = Request.QueryString["sid"];
            string res = Request.QueryString["res"];

            int cid = Convert.ToInt32(chapterIdObj);
            bool isQuizEnabled = Convert.ToBoolean(quizObj);
            bool isFlashcardEnabled = Convert.ToBoolean(flashObj);

            if (isQuizEnabled)
            {
                return $"~/Quiz/QuizList.aspx?sid={sid}&res={res}&cid={cid}";
            }
            else if (isFlashcardEnabled)
            {
                return $"~/Flashcards/FlashcardSetList.aspx?sid={sid}&res={res}&cid={cid}";
            }
            else
            {
                return $"~/ViewResources.aspx?sid={sid}&res={res}&cid={cid}";
            }
        }

        private DataTable GetData(string sql)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}