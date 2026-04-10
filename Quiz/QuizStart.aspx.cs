using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizStart : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["quizId"] != null)
                {
                    int quizId;
                    if (int.TryParse(Request.QueryString["quizId"], out quizId))
                    {
                        hfQuizId.Value = quizId.ToString();
                        LoadQuizDetails(quizId);
                    }
                    else
                    {
                        Response.Redirect("~/Quiz/QuizList.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Quiz/QuizList.aspx");
                }
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
            SELECT q.QuizLabel, q.TotalQuestions, q.TimeLimitMinutes,
                   q.TotalMarks, q.Difficulty,
                   q.NegativeMarking, q.NegativeMarks,
                   c.ChapterName
            FROM Quiz q
            INNER JOIN Chapters c ON q.ChapterId = c.ChapterId
            WHERE q.QuizId = @QuizId AND q.IsActive = 1", conn);

                cmd.Parameters.AddWithValue("@QuizId", quizId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Header Information
                    lblChapterName.Text = reader["ChapterName"].ToString();
                    lblQuizLabel.Text = reader["QuizLabel"].ToString();

                    // Quiz Details
                    lblTotalQuestions.Text = reader["TotalQuestions"].ToString();
                    lblTimeLimit.Text = reader["TimeLimitMinutes"] + "m";
                    lblTotalMarks.Text = reader["TotalMarks"].ToString();
                    lblDifficulty.Text = reader["Difficulty"].ToString();

                    // Instruction Section
                    lblInstructionQuestions.Text = reader["TotalQuestions"].ToString();
                    lblInstructionTime.Text = reader["TimeLimitMinutes"].ToString();

                    // Negative Marks Value
                    decimal negativeMarks = 0;
                    if (reader["NegativeMarks"] != DBNull.Value)
                    {
                        negativeMarks = Convert.ToDecimal(reader["NegativeMarks"]);
                    }
                    lblNegativeMarks.Text = negativeMarks.ToString("0.##");

                    // Negative Marking Toggle
                    bool isNegativeMarkingEnabled = false;
                    if (reader["NegativeMarking"] != DBNull.Value)
                    {
                        isNegativeMarkingEnabled = Convert.ToBoolean(reader["NegativeMarking"]);
                    }
                    chkNegativeMarking.Checked = isNegativeMarkingEnabled;
                }

                conn.Close();
            }
        }

        protected void btnBeginTest_Click(object sender, EventArgs e)
        {
            int quizId = Convert.ToInt32(hfQuizId.Value);

            // Store quiz details in session
            Session["QuizId"] = quizId;
            Session["NegativeMarkingEnabled"] = chkNegativeMarking.Checked;
            Session["NegativeMarks"] = lblNegativeMarks.Text;

            Response.Redirect($"~/Quiz/QuizAttempt.aspx?quizId={quizId}");
        }
    }
}