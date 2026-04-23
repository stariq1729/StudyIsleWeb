using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizList : System.Web.UI.Page
    {
        private readonly string connStr =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int chapterId = GetChapterId();

                if (chapterId > 0)
                {
                    LoadQuizzes(chapterId);
                }
                else
                {
                    ShowNoData("Invalid or missing Chapter ID.");
                }
            }
        }

        /// <summary>
        /// Retrieves Chapter ID from Query String.
        /// Supports both 'cid' and 'chapterId'.
        /// </summary>
        private int GetChapterId()
        {
            int chapterId = 0;

            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                int.TryParse(Request.QueryString["cid"], out chapterId);
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["chapterId"]))
            {
                int.TryParse(Request.QueryString["chapterId"], out chapterId);
            }

            return chapterId;
        }

        /// <summary>
        /// Loads quizzes from the database.
        /// </summary>
        private void LoadQuizzes(int chapterId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
    SELECT q.QuizId, q.QuizLabel, q.TotalQuestions,
           q.TimeLimitMinutes, q.TotalMarks, q.Difficulty,
           CASE 
               WHEN b.BookmarkId IS NOT NULL THEN 1 
               ELSE 0 
           END AS IsBookmarked
    FROM Quiz q
    LEFT JOIN Bookmarks b 
        ON q.QuizId = b.ItemId 
        AND b.ItemType = 'Quiz'
        AND b.UserId = @uid
    WHERE q.ChapterId = @ChapterId AND q.IsActive = 1
    ORDER BY q.CreatedAt";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ChapterId", chapterId);
                    cmd.Parameters.AddWithValue("@uid", Session["UserId"] ?? 0);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptQuizzes.DataSource = dt;
                        rptQuizzes.DataBind();
                        lblQuizCount.Text = dt.Rows.Count + " Quizzes Available";
                        pnlNoData.Visible = false;
                    }
                    else
                    {
                        ShowNoData("No quizzes available for this chapter.");
                    }
                }
            }
        }
        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "StartQuiz")
            {
                // 🔐 Check if user is logged in
                if (Session["UserEmail"] == null)
                {
                    string returnUrl = Request.RawUrl;
                    Response.Redirect("~/Login.aspx?ReturnUrl=" +
                                      Server.UrlEncode(returnUrl));
                    return;
                }

                // ✅ User is logged in
                string quizId = e.CommandArgument.ToString();

                // Preserve existing query parameters
                string bid = Request.QueryString["bid"];
                string rid = Request.QueryString["rid"];
                string scid = Request.QueryString["scid"];
                string sid = Request.QueryString["sid"];
                string cid = Request.QueryString["cid"];

                // Redirect to Quiz Start page
                Response.Redirect(
                    $"~/Quiz/QuizStart.aspx?quizId={quizId}&bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={cid}");
            }
            else if (e.CommandName == "Bookmark")
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);
                int quizId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string checkQuery = @"SELECT COUNT(*) FROM Bookmarks 
                             WHERE UserId=@uid AND ItemId=@iid AND ItemType='Quiz'";

                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@uid", userId);
                    checkCmd.Parameters.AddWithValue("@iid", quizId);

                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        string deleteQuery = @"DELETE FROM Bookmarks 
                                  WHERE UserId=@uid AND ItemId=@iid AND ItemType='Quiz'";

                        SqlCommand delCmd = new SqlCommand(deleteQuery, con);
                        delCmd.Parameters.AddWithValue("@uid", userId);
                        delCmd.Parameters.AddWithValue("@iid", quizId);
                        delCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        string insertQuery = @"INSERT INTO Bookmarks 
(UserId, ItemId, ItemType, ChapterId)
VALUES 
(@uid, @iid, 'Quiz', @cid)";

                        SqlCommand insCmd = new SqlCommand(insertQuery, con);
                        insCmd.Parameters.AddWithValue("@uid", userId);
                        insCmd.Parameters.AddWithValue("@iid", quizId);
                        insCmd.Parameters.AddWithValue("@cid", Request.QueryString["cid"] ?? (object)DBNull.Value);
                        insCmd.ExecuteNonQuery();
                    }
                }

                // reload quizzes
                int chapterId = GetChapterId();
                LoadQuizzes(chapterId);
            }
        }

        /// <summary>
        /// Displays no data message.
        /// </summary>
        private void ShowNoData(string message)
        {
            pnlNoData.Visible = true;
            pnlNoData.Controls.Clear();
            pnlNoData.Controls.Add(new System.Web.UI.LiteralControl(message));
            lblQuizCount.Text = "0 Quizzes Available";
        }

        /// <summary>
        /// Returns CSS class based on difficulty.
        /// </summary>
        protected string GetDifficultyClass(string difficulty)
        {
            switch (difficulty.ToLower())
            {
                case "easy":
                    return "easy";
                case "medium":
                    return "medium";
                case "hard":
                    return "hard";
                default:
                    return "easy";
            }
        }
    }
}