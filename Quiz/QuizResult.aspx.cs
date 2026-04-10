using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizResult : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent caching and back navigation
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);

            if (!IsPostBack)
            {
                LoadResult();
            }
        }

        private void LoadResult()
        {
            int quizId;

            // Validate QuizId
            if (Request.QueryString["quizId"] != null)
            {
                quizId = Convert.ToInt32(Request.QueryString["quizId"]);
            }
            else if (Session["QuizId"] != null)
            {
                quizId = Convert.ToInt32(Session["QuizId"]);
            }
            else
            {
                Response.Redirect("~/Quiz/QuizList.aspx");
                return;
            }

            // Retrieve user answers from session
            Dictionary<int, string> userAnswers =
                Session["UserAnswers"] as Dictionary<int, string>;

            if (userAnswers == null)
            {
                Response.Redirect("~/Quiz/QuizList.aspx");
                return;
            }

            bool negativeMarkingEnabled =
                Session["NegativeMarkingEnabled"] != null &&
                Convert.ToBoolean(Session["NegativeMarkingEnabled"]);

            decimal negativeMarks = 0.25m;
            if (Session["NegativeMarks"] != null)
            {
                decimal.TryParse(Session["NegativeMarks"].ToString(), out negativeMarks);
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        QuestionId,
                        QuestionText,
                        OptionA,
                        OptionB,
                        OptionC,
                        OptionD,
                        CorrectOption AS CorrectAnswer,
                        Explanation,
                        Marks,
                        QuestionImage,
                        OptionAImage,
                        OptionBImage,
                        OptionCImage,
                        OptionDImage,
                        QuestionOrder
                    FROM Questions
                    WHERE QuizId = @QuizId AND IsActive = 1
                    ORDER BY QuestionOrder";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@QuizId", quizId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('No questions found for this quiz.');window.location='QuizList.aspx';</script>");
                    return;
                }

                // Add calculated columns
                dt.Columns.Add("UserAnswer");
                dt.Columns.Add("Status");
                dt.Columns.Add("QuestionNumber", typeof(int));

                int correct = 0, wrong = 0, unattempted = 0;
                decimal totalMarks = 0;
                decimal obtainedMarks = 0;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow row = dt.Rows[i];
                    row["QuestionNumber"] = i + 1;

                    string correctAns = row["CorrectAnswer"].ToString();
                    decimal marks = Convert.ToDecimal(row["Marks"]);
                    totalMarks += marks;

                    string userAns = userAnswers.ContainsKey(i)
                        ? userAnswers[i]
                        : "";

                    row["UserAnswer"] = string.IsNullOrEmpty(userAns) ? "-" : userAns;

                    if (string.IsNullOrEmpty(userAns))
                    {
                        unattempted++;
                        row["Status"] = "Unattempted";
                    }
                    else if (userAns == correctAns)
                    {
                        correct++;
                        obtainedMarks += marks;
                        row["Status"] = "Correct";
                    }
                    else
                    {
                        wrong++;
                        if (negativeMarkingEnabled)
                        {
                            obtainedMarks -= negativeMarks;
                        }
                        row["Status"] = "Wrong";
                    }
                }

                int attempted = correct + wrong;
                decimal accuracy = attempted > 0
                    ? Math.Round(((decimal)correct / attempted) * 100, 2)
                    : 0;

                decimal penalty = negativeMarkingEnabled
                    ? wrong * negativeMarks
                    : 0;

                // Bind Summary Cards
                lblScore.Text = $"{obtainedMarks:0.##} / {totalMarks:0.##}";
                lblScoreDetails.Text = $"+{correct} Correct, -{penalty:0.##} Penalized";
                lblAccuracy.Text = $"{accuracy:0.##}%";
                lblAttempted.Text = $"{attempted} / {dt.Rows.Count}";
                lblTime.Text = "~" + (Session["QuizTime"] ?? "0") + "m";

                // Bind Chart Data
                lblCorrect.Text = correct.ToString();
                lblWrong.Text = wrong.ToString();
                lblUnattempted.Text = unattempted.ToString();

                // Bind Question Review Grid
                gvQuestions.DataSource = dt;
                gvQuestions.DataBind();

                // Bind Detailed Review Repeater
                rptQuestionDetails.DataSource = dt;
                rptQuestionDetails.DataBind();

                // Show Recommended Revision Panel
                if (accuracy < 50)
                {
                    pnlRevision.Visible = true;
                    lblRevisionAccuracy.Text = $"{accuracy:0.##}%";
                }
                else
                {
                    pnlRevision.Visible = false;
                }

                // Render Doughnut Chart
                string script = $"renderChart({correct}, {wrong}, {unattempted});";
                ClientScript.RegisterStartupScript(this.GetType(), "renderChart", script, true);
            }

            // Clear session to prevent back navigation to quiz
            Session.Remove("QuizQuestions");
            Session.Remove("UserAnswers");
        }

        protected string GetOptionClass(object correct, object user, string option)
        {
            string correctAns = correct.ToString();
            string userAns = user.ToString();

            if (option == correctAns)
                return "correct-answer";

            if (option == userAns && userAns != correctAns)
                return "wrong-answer";

            return "";
        }

        protected void btnRetake_Click(object sender, EventArgs e)
        {
            int quizId = Convert.ToInt32(Request.QueryString["quizId"]);
            Response.Redirect($"~/Quiz/QuizAttempt.aspx?quizId={quizId}");
        }

        protected void btnCourses_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Courses.aspx");
        }
    }
}