using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class SubjectDetails : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

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

        private void LoadSubjectInfo(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Pulling Subject Name and Icon for the Sidebar
                string sql = "SELECT SubjectName, IconImage FROM Subjects WHERE SubjectId = @id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", sid);
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        string sName = dr["SubjectName"].ToString();
                        litBookTitle.Text = sName;
                        litBreadcrumb.Text = sName;

                        if (imgSubject != null)
                        {
                            string imgPath = dr["IconImage"] != DBNull.Value ? dr["IconImage"].ToString() : "";
                            imgSubject.ImageUrl = !string.IsNullOrEmpty(imgPath)
                                ? "~/Uploads/SubjectIcons/" + imgPath
                                : "~/Images/default-book.png";
                        }
                    }
                }
            }
        }

        private void DetermineFlow(string sid, string res)
        {
            if (CheckChaptersExist(sid))
            {
                phChapterPath.Visible = true;
                phYearPath.Visible = false;
                phSidebar.Visible = true; // Enable the sticky book card
                BindChapters(sid);
            }
            else if (CheckDataExists("YearId", sid, res))
            {
                phYearPath.Visible = true;
                phChapterPath.Visible = false;
                phSidebar.Visible = false; // Hide sidebar for full-width grid
                BindYears(sid, res);
            }
            else
            {
                Response.Redirect($"ViewResources.aspx?sid={sid}&res={res}");
            }
        }

        private void BindChapters(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"
                    SELECT ChapterId, ChapterName, 
                           ISNULL(IsQuizEnabled, 0) AS IsQuizEnabled, 
                           ISNULL(IsFlashcardEnabled, 0) AS IsFlashcardEnabled
                    FROM Chapters
                    WHERE SubjectId = @sid AND IsActive = 1
                    ORDER BY DisplayOrder, ChapterName ASC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                litChapterCount.Text = dt.Rows.Count.ToString();
                rptChapters.DataSource = dt;
                rptChapters.DataBind();
            }
        }

        private void BindYears(string sid, string res)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"SELECT DISTINCT y.YearId, y.YearName 
                               FROM Years y 
                               JOIN Resources r ON y.YearId = r.YearId 
                               JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
                               WHERE r.SubjectId = @sid AND rt.Slug = @res AND y.IsActive = 1 
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

        protected string GetChapterRedirectUrl(object cid, object quiz, object flash)
        {
            string sid = Request.QueryString["sid"];
            string res = Request.QueryString["res"];
            bool isQuiz = Convert.ToBoolean(quiz);
            bool isFlash = Convert.ToBoolean(flash);

            if (isQuiz) return $"~/Quiz/QuizList.aspx?sid={sid}&res={res}&cid={cid}";
            if (isFlash) return $"~/Flashcards/FlashcardSetList.aspx?sid={sid}&res={res}&cid={cid}";
            return $"~/ViewResources.aspx?sid={sid}&res={res}&cid={cid}";
        }

        private bool CheckChaptersExist(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Chapters WHERE SubjectId = @sid AND IsActive = 1", con);
                cmd.Parameters.AddWithValue("@sid", sid);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private bool CheckDataExists(string col, string sid, string res)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = $@"SELECT COUNT(*) FROM Resources r 
                                INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
                                WHERE r.SubjectId = @sid AND rt.Slug = @res AND r.{col} IS NOT NULL";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@res", res);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }
    }
}