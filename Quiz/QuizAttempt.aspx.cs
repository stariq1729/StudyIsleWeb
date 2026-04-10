using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Quiz
{
    public partial class QuizAttempt : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private Dictionary<int, string> UserAnswers
        {
            get
            {
                if (Session["UserAnswers"] == null)
                    Session["UserAnswers"] = new Dictionary<int, string>();

                return (Dictionary<int, string>)Session["UserAnswers"];
            }
            set { Session["UserAnswers"] = value; }
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
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT QuizLabel, TimeLimitMinutes FROM Quiz WHERE QuizId=@QuizId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@QuizId", quizId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblQuizTitle.Text = reader["QuizLabel"].ToString();
                    hfDuration.Value = reader["TimeLimitMinutes"].ToString();
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

            if (index < 0 || index >= dt.Rows.Count)
                return;

            DataRow row = dt.Rows[index];

            hfCurrentQuestion.Value = index.ToString();
            lblQuestionNumber.Text = "Question " + (index + 1);
            lblQuestionText.Text = row["QuestionText"].ToString();

            // Load Question Image
            string questionImage = row["QuestionImage"]?.ToString();
            if (!string.IsNullOrEmpty(questionImage))
            {
                imgQuestion.ImageUrl = ResolveUrl(questionImage);
                imgQuestion.CssClass = "question-img";
                imgQuestion.Visible = true;
            }
            else
            {
                imgQuestion.Visible = false;
            }

            // Load Options with Images
            rblOptions.Items.Clear();
            AddOptionWithImage(row, "A", "OptionA", "OptionAImage");
            AddOptionWithImage(row, "B", "OptionB", "OptionBImage");
            AddOptionWithImage(row, "C", "OptionC", "OptionCImage");
            AddOptionWithImage(row, "D", "OptionD", "OptionDImage");

            // Restore selected answer
            if (Session["UserAnswers"] is Dictionary<int, string> answers &&
                answers.ContainsKey(index))
            {
                rblOptions.SelectedValue = answers[index];
            }

            btnPrevious.Enabled = index > 0;
            btnNext.Enabled = index < dt.Rows.Count - 1;
        }
        private void AddOptionWithImage(DataRow row, string optionValue,
                                 string optionColumn, string imageColumn)
        {
            string optionText = row[optionColumn]?.ToString() ?? "";
            string imagePath = "";

            // Check if the image column exists
            if (row.Table.Columns.Contains(imageColumn) &&
                row[imageColumn] != DBNull.Value)
            {
                imagePath = row[imageColumn].ToString();
            }

            string html = "<div class='option-container'><table class='option-table'><tr>";

            // Option text
            html += "<td style='width:85%;'>" +
                    "<strong>" + optionValue + ".</strong> " + optionText +
                    "</td>";

            // Option image (if available)
            if (!string.IsNullOrEmpty(imagePath))
            {
                html += "<td style='text-align:right;'>" +
                        "<img src='" + ResolveUrl(imagePath) +
                        "' class='option-img' />" +
                        "</td>";
            }

            html += "</tr></table></div>";

            ListItem item = new ListItem(html, optionValue);
            item.Attributes.Add("style", "display:block;");
            rblOptions.Items.Add(item);
        }

        private void SaveAnswer()
        {
            int index = Convert.ToInt32(hfCurrentQuestion.Value);
            if (rblOptions.SelectedValue != "")
                UserAnswers[index] = rblOptions.SelectedValue;
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            int index = Convert.ToInt32(hfCurrentQuestion.Value);
            LoadQuestion(index + 1);
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            int index = Convert.ToInt32(hfCurrentQuestion.Value);
            LoadQuestion(index - 1);
        }

        protected void btnPalette_Command(object sender, CommandEventArgs e)
        {
            SaveAnswer();
            LoadQuestion(Convert.ToInt32(e.CommandArgument));
        }

        protected void btnMarkReview_Click(object sender, EventArgs e)
        {
            SaveAnswer();
        }

        private void LoadPalette()
        {
            DataTable dt = (DataTable)Session["QuizQuestions"];
            rptPalette.DataSource = dt;
            rptPalette.DataBind();
        }

        protected void btnSubmitTest_Click(object sender, EventArgs e)
        {
            SaveAnswer();
            Response.Redirect("~/Quiz/QuizResult.aspx");
        }
    }
}