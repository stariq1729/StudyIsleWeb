using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizAttempt : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected int RemainingSeconds = 0;

        private Dictionary<int, string> UserAnswers
        {
            get
            {
                if (Session["UserAnswers"] == null)
                    Session["UserAnswers"] = new Dictionary<int, string>();
                return (Dictionary<int, string>)Session["UserAnswers"];
            }
        }

        private HashSet<int> MarkedQuestions
        {
            get
            {
                if (Session["MarkedQuestions"] == null)
                    Session["MarkedQuestions"] = new HashSet<int>();
                return (HashSet<int>)Session["MarkedQuestions"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            int quizId = Convert.ToInt32(Request.QueryString["quizId"]);

            if (!IsPostBack)
            {
                hfCurrentQuestion.Value = "0";
                LoadQuizDetails(quizId);
                LoadQuestions(quizId);
                LoadQuestion(0);
                LoadPalette();
                InitializeTimer(quizId);
            }

            UpdateTimer();
        }

        private void InitializeTimer(int quizId)
        {
            if (Session["QuizEndTime"] == null)
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT TimeLimitMinutes FROM Quiz WHERE QuizId=@QuizId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@QuizId", quizId);

                    conn.Open();
                    int duration = Convert.ToInt32(cmd.ExecuteScalar());
                    Session["QuizEndTime"] = DateTime.Now.AddMinutes(duration);
                }
            }
        }

        private void UpdateTimer()
        {
            if (Session["QuizEndTime"] != null)
            {
                DateTime endTime = (DateTime)Session["QuizEndTime"];
                TimeSpan remaining = endTime - DateTime.Now;

                if (remaining.TotalSeconds <= 0)
                {
                    SubmitQuiz();
                    return;
                }

                RemainingSeconds = (int)remaining.TotalSeconds;
                lblTimer.Text = remaining.ToString(@"mm\:ss");
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT ISNULL(QuizLabel, 'Untitled Quiz') 
            FROM Quiz 
            WHERE QuizId = @QuizId";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuizId", quizId);

                conn.Open();
                object result = cmd.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    lblQuizTitle.Text = result.ToString();
                }
                else
                {
                    lblQuizTitle.Text = "Quiz";
                    Response.Redirect("~/Quiz/QuizList.aspx");
                }
            }
        }

        private void LoadQuestions(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Questions WHERE QuizId=@QuizId AND IsActive=1 ORDER BY QuestionOrder";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@QuizId", quizId);

                DataTable dt = new DataTable();
                da.Fill(dt);
                Session["QuizQuestions"] = dt;
            }
        }

        private void LoadQuestion(int index)
        {
            DataTable dt = Session["QuizQuestions"] as DataTable;
            if (dt == null || dt.Rows.Count == 0)
            {
                Response.Redirect("~/Quiz/QuizList.aspx");
                return;
            }

            DataRow row = dt.Rows[index];

            hfCurrentQuestion.Value = index.ToString();
            lblQuestionNumber.Text = (index + 1).ToString();
            lblQuestionText.Text = row["QuestionText"].ToString();

            string image = row["QuestionImage"]?.ToString();
            imgQuestion.Visible = !string.IsNullOrEmpty(image);
            imgQuestion.ImageUrl = ResolveUrl(image);

            rblOptions.Items.Clear();
            AddOption(row, "A", "OptionA");
            AddOption(row, "B", "OptionB");
            AddOption(row, "C", "OptionC");
            AddOption(row, "D", "OptionD");

            if (UserAnswers.ContainsKey(index))
                rblOptions.SelectedValue = UserAnswers[index];

            btnPrevious.Enabled = index > 0;
            btnNext.Enabled = index < dt.Rows.Count - 1;
        }

        private void AddOption(DataRow row, string value, string column)
        {
            string text = row[column]?.ToString() ?? "";
            rblOptions.Items.Add(new ListItem($"<b>{value}.</b> {text}", value));
        }

        private void SaveAnswer()
        {
            int index = Convert.ToInt32(hfCurrentQuestion.Value);

            if (!string.IsNullOrEmpty(rblOptions.SelectedValue))
                UserAnswers[index] = rblOptions.SelectedValue;
            else if (!UserAnswers.ContainsKey(index))
                UserAnswers[index] = "";
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            LoadQuestion(Convert.ToInt32(hfCurrentQuestion.Value) + 1);
            LoadPalette();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            LoadQuestion(Convert.ToInt32(hfCurrentQuestion.Value) - 1);
            LoadPalette();
        }

        protected void btnPalette_Command(object sender, CommandEventArgs e)
        {
            SaveAnswer();
            LoadQuestion(Convert.ToInt32(e.CommandArgument));
            LoadPalette();
        }

        protected void btnMarkReview_Click(object sender, EventArgs e)
        {
            int index = Convert.ToInt32(hfCurrentQuestion.Value);
            MarkedQuestions.Add(index);
            LoadPalette();
        }

        private void LoadPalette()
        {
            DataTable dt = (DataTable)Session["QuizQuestions"];
            rptPalette.DataSource = dt;
            rptPalette.DataBind();
        }

        protected void rptPalette_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Button btn = (Button)e.Item.FindControl("btnPalette");
            int index = e.Item.ItemIndex;

            btn.CssClass = "palette-btn";

            if (index == Convert.ToInt32(hfCurrentQuestion.Value))
                btn.CssClass += " current";
            else if (MarkedQuestions.Contains(index))
                btn.CssClass += " marked";
            else if (UserAnswers.ContainsKey(index) && UserAnswers[index] != "")
                btn.CssClass += " answered";
            else if (UserAnswers.ContainsKey(index))
                btn.CssClass += " notanswered";
            else
                btn.CssClass += " notvisited";
        }

        protected void btnSubmitTest_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            SubmitQuiz();
        }

        private void SubmitQuiz()
        {
            int quizId = Convert.ToInt32(Request.QueryString["quizId"]);

            Session["QuizId"] = quizId;
            Session["QuizEndTime"] = null;

            Response.Redirect($"~/Quiz/QuizResult.aspx?quizId={quizId}");
        }
    }
}