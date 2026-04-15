using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizAttempt : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected int RemainingSeconds = 0;

        // Persistent State via Session
        private Dictionary<int, string> UserAnswers
        {
            get { return (Session["UserAnswers"] as Dictionary<int, string>) ?? (Session["UserAnswers"] = new Dictionary<int, string>()) as Dictionary<int, string>; }
        }
        private HashSet<int> MarkedQuestions
        {
            get { return (Session["MarkedQuestions"] as HashSet<int>) ?? (Session["MarkedQuestions"] = new HashSet<int>()) as HashSet<int>; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int quizId = Convert.ToInt32(Request.QueryString["quizId"]);
                hfCurrentQuestion.Value = "0";
                LoadQuizDetails(quizId);
                LoadQuestions(quizId);
                LoadQuestion(0);
                LoadPalette();
                InitializeTimer(quizId);
            }
            UpdateTimerState();
        }

        private void LoadQuestion(int index)
        {
            DataTable dt = Session["QuizQuestions"] as DataTable;
            if (dt == null || dt.Rows.Count == 0) return;

            DataRow row = dt.Rows[index];
            hfCurrentQuestion.Value = index.ToString();
            lblQuestionNumber.Text = (index + 1).ToString();
            lblQuestionText.Text = row["QuestionText"]?.ToString() ?? "";

            // Restore selection state for this question
            hfSelectedOption.Value = UserAnswers.ContainsKey(index) ? UserAnswers[index] : "";

            // Question Image Logic
            string qImg = row["QuestionImage"]?.ToString();
            imgQuestion.Visible = !string.IsNullOrEmpty(qImg);
            if (imgQuestion.Visible) imgQuestion.ImageUrl = ResolveUrl(qImg);

            // Populate Options (Handles cases where text is null but image exists)
            var options = new List<OptionItem>();
            MapOption(options, "A", row["OptionA"], row["OptionAImage"]);
            MapOption(options, "B", row["OptionB"], row["OptionBImage"]);
            MapOption(options, "C", row["OptionC"], row["OptionCImage"]);
            MapOption(options, "D", row["OptionD"], row["OptionDImage"]);

            rptOptions.DataSource = options;
            rptOptions.DataBind();

            btnPrevious.Enabled = index > 0;
            btnNext.Enabled = index < dt.Rows.Count - 1;
            UpdateStatusCounts();
        }

        private void MapOption(List<OptionItem> list, string key, object text, object img)
        {
            string txt = text?.ToString() ?? "";
            string path = img?.ToString() ?? "";
            // Add if EITHER text or image exists
            if (!string.IsNullOrEmpty(txt) || !string.IsNullOrEmpty(path))
            {
                list.Add(new OptionItem { Key = key, Text = txt, Image = !string.IsNullOrEmpty(path) ? ResolveUrl(path) : "" });
            }
        }

        protected string IsChecked(string val) => hfSelectedOption.Value == val ? "checked" : "";

        private void SaveAnswer()
        {
            if (int.TryParse(hfCurrentQuestion.Value, out int idx))
            {
                string sel = hfSelectedOption.Value;
                UserAnswers[idx] = !string.IsNullOrEmpty(sel) ? sel : "";
            }
        }

        // Navigation & Command Handlers
        protected void btnNext_Click(object sender, EventArgs e) { SaveAnswer(); LoadQuestion(int.Parse(hfCurrentQuestion.Value) + 1); LoadPalette(); }
        protected void btnPrevious_Click(object sender, EventArgs e) { SaveAnswer(); LoadQuestion(int.Parse(hfCurrentQuestion.Value) - 1); LoadPalette(); }
        protected void btnMarkReview_Click(object sender, EventArgs e) { SaveAnswer(); MarkedQuestions.Add(int.Parse(hfCurrentQuestion.Value)); LoadPalette(); UpdateStatusCounts(); }
        protected void btnPalette_Command(object sender, CommandEventArgs e) { SaveAnswer(); LoadQuestion(Convert.ToInt32(e.CommandArgument)); LoadPalette(); }

        private void LoadPalette() { rptPalette.DataSource = (DataTable)Session["QuizQuestions"]; rptPalette.DataBind(); }

        protected void rptPalette_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Button btn = (Button)e.Item.FindControl("btnPalette");
                int idx = e.Item.ItemIndex;
                btn.CssClass = "palette-btn " + (idx == int.Parse(hfCurrentQuestion.Value) ? "current " : "");

                if (MarkedQuestions.Contains(idx)) btn.CssClass += "marked";
                else if (UserAnswers.ContainsKey(idx) && !string.IsNullOrEmpty(UserAnswers[idx])) btn.CssClass += "answered";
                else if (UserAnswers.ContainsKey(idx)) btn.CssClass += "notanswered";
                else btn.CssClass += "notvisited";
            }
        }

        // Timer & UI Detail Loading
        private void InitializeTimer(int qid)
        {
            using (SqlConnection cn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT TimeLimitMinutes FROM Quiz WHERE QuizId=@id", cn);
                cmd.Parameters.AddWithValue("@id", qid);
                cn.Open();
                int mins = Convert.ToInt32(cmd.ExecuteScalar() ?? 15);
                Session["QuizEndTime"] = DateTime.Now.AddMinutes(mins);
            }
        }

        private void UpdateTimerState()
        {
            if (Session["QuizEndTime"] != null)
            {
                TimeSpan diff = (DateTime)Session["QuizEndTime"] - DateTime.Now;
                RemainingSeconds = (int)Math.Max(0, diff.TotalSeconds);
            }
        }

        private void LoadQuizDetails(int qid)
        {
            using (SqlConnection cn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT QuizLabel FROM Quiz WHERE QuizId=@id", cn);
                cmd.Parameters.AddWithValue("@id", qid);
                cn.Open();
                lblQuizTitle.Text = cmd.ExecuteScalar()?.ToString() ?? "Practice Quiz";
            }
        }

        private void LoadQuestions(int qid)
        {
            using (SqlConnection cn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Questions WHERE QuizId=@id AND IsActive=1 ORDER BY QuestionOrder", cn);
                da.SelectCommand.Parameters.AddWithValue("@id", qid);
                DataTable dt = new DataTable();
                da.Fill(dt);
                Session["QuizQuestions"] = dt;
            }
        }

        private void UpdateStatusCounts()
        {
            DataTable dt = Session["QuizQuestions"] as DataTable;
            if (dt == null) return;

            int answered = UserAnswers.Values.Count(v => !string.IsNullOrEmpty(v));
            int total = dt.Rows.Count;

            litAnsweredCount.Text = litSummaryCount.Text = answered.ToString();
            litNotAnsweredCount.Text = (UserAnswers.Count - answered).ToString();
            litMarkedCount.Text = MarkedQuestions.Count.ToString();
            litNotVisitedCount.Text = (total - UserAnswers.Count).ToString();

            // Fixed the missing Control ID error from your screenshot
            litTotalCount.Text = litTotalCountInModal.Text = total.ToString();
        }

        protected void btnSubmitTest_Click(object sender, EventArgs e) { SaveAnswer(); SubmitQuiz(); }
        private void SubmitQuiz() { Response.Redirect($"~/Quiz/QuizResult.aspx?quizId={Request.QueryString["quizId"]}"); }

        public class OptionItem { public string Key { get; set; } public string Text { get; set; } public string Image { get; set; } }
    }
}