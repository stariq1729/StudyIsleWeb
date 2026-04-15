using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizAttempt : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected int RemainingSeconds = 0;

        // --- Existing Properties (Kept to prevent breaking code) ---
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

        // --- Core Fix: LoadQuestion with Option Images ---
        private void LoadQuestion(int index)
        {
            DataTable dt = Session["QuizQuestions"] as DataTable;
            if (dt == null || dt.Rows.Count == 0) return;

            DataRow row = dt.Rows[index];
            hfCurrentQuestion.Value = index.ToString();
            lblQuestionNumber.Text = (index + 1).ToString();
            lblQuestionText.Text = row["QuestionText"]?.ToString();

            // Question Image
            string qImg = row["QuestionImage"]?.ToString();
            imgQuestion.Visible = !string.IsNullOrEmpty(qImg);
            if (imgQuestion.Visible) imgQuestion.ImageUrl = ResolveUrl(qImg);

            // Prepare Options List
            var optionsList = new List<OptionItem>();

            // We pass the raw values to our updated helper method
            AddOptionToList(optionsList, "A", row["OptionA"], row["OptionAImage"]);
            AddOptionToList(optionsList, "B", row["OptionB"], row["OptionBImage"]);
            AddOptionToList(optionsList, "C", row["OptionC"], row["OptionCImage"]);
            AddOptionToList(optionsList, "D", row["OptionD"], row["OptionDImage"]);

            rptOptions.DataSource = optionsList;
            rptOptions.DataBind();

            hfSelectedOption.Value = UserAnswers.ContainsKey(index) ? UserAnswers[index] : "";
            btnPrevious.Enabled = index > 0;
            btnNext.Enabled = index < dt.Rows.Count - 1;

            UpdateStatusCounts();
        }

        private void AddOptionToList(List<OptionItem> list, string key, object text, object img)
        {
            string optionText = text?.ToString() ?? "";
            string imgPath = img?.ToString() ?? "";

            // FIX: Show the option if there is Text OR if there is an Image path
            if (!string.IsNullOrEmpty(optionText) || !string.IsNullOrEmpty(imgPath))
            {
                list.Add(new OptionItem
                {
                    Key = key,
                    Text = optionText,
                    Image = !string.IsNullOrEmpty(imgPath) ? ResolveUrl(imgPath) : ""
                });
            }
        }

        protected string IsChecked(string val)
        {
            return hfSelectedOption.Value == val ? "checked" : "";
        }

        private void SaveAnswer()
        {
            int index;
            if (int.TryParse(hfCurrentQuestion.Value, out index))
            {
                string selected = hfSelectedOption.Value;
                if (!string.IsNullOrEmpty(selected))
                    UserAnswers[index] = selected;
                else if (!UserAnswers.ContainsKey(index))
                    UserAnswers[index] = "";
            }
        }

        private void UpdateStatusCounts()
        {
            DataTable dt = Session["QuizQuestions"] as DataTable;
            if (dt == null) return;

            int total = dt.Rows.Count;
            int answered = UserAnswers.Count(x => !string.IsNullOrEmpty(x.Value));
            int marked = MarkedQuestions.Count;
            int visited = UserAnswers.Count;

            litAnsweredCount.Text = answered.ToString();
            litNotAnsweredCount.Text = (visited - answered).ToString();
            litMarkedCount.Text = marked.ToString();
            litNotVisitedCount.Text = (total - visited).ToString();
            litSummaryCount.Text = answered.ToString();
            litTotalCount.Text = total.ToString();
        }

        // --- UI Navigation Events ---
        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            int nextIndex = Convert.ToInt32(hfCurrentQuestion.Value) + 1;
            LoadQuestion(nextIndex);
            LoadPalette();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            int prevIndex = Convert.ToInt32(hfCurrentQuestion.Value) - 1;
            LoadQuestion(prevIndex);
            LoadPalette();
        }

        protected void btnMarkReview_Click(object sender, EventArgs e)
        {
            int index = Convert.ToInt32(hfCurrentQuestion.Value);
            MarkedQuestions.Add(index);
            LoadPalette();
            UpdateStatusCounts();
        }

        protected void btnPalette_Command(object sender, CommandEventArgs e)
        {
            SaveAnswer();
            LoadQuestion(Convert.ToInt32(e.CommandArgument));
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
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Button btn = (Button)e.Item.FindControl("btnPalette");
                int index = e.Item.ItemIndex;
                int currentIndex = Convert.ToInt32(hfCurrentQuestion.Value);

                btn.CssClass = "palette-btn";
                if (index == currentIndex) btn.CssClass += " current";

                if (MarkedQuestions.Contains(index)) btn.CssClass += " marked";
                else if (UserAnswers.ContainsKey(index) && !string.IsNullOrEmpty(UserAnswers[index])) btn.CssClass += " answered";
                else if (UserAnswers.ContainsKey(index)) btn.CssClass += " notanswered";
                else btn.CssClass += " notvisited";
            }
        }

        // --- Database & Timer Methods ---
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
                if (remaining.TotalSeconds <= 0) { SubmitQuiz(); return; }
                RemainingSeconds = (int)remaining.TotalSeconds;
                lblTimer.Text = remaining.ToString(@"mm\:ss");
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT QuizLabel FROM Quiz WHERE QuizId = @QuizId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuizId", quizId);
                conn.Open();
                object result = cmd.ExecuteScalar();
                lblQuizTitle.Text = result?.ToString() ?? "Quiz";
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

        public class OptionItem
        {
            public string Key { get; set; }
            public string Text { get; set; }
            public string Image { get; set; }
        }
    }
}