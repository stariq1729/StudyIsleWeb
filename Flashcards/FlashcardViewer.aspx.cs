using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Flashcards
{
    public partial class FlashcardViewer : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private DataTable Flashcards
        {
            get { return ViewState["Flashcards"] as DataTable; }
            set { ViewState["Flashcards"] = value; }
        }

        private int CurrentIndex
        {
            get { return ViewState["CurrentIndex"] != null ? (int)ViewState["CurrentIndex"] : 0; }
            set { ViewState["CurrentIndex"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["cid"] != null)
                {
                    int chapterId = Convert.ToInt32(Request.QueryString["cid"]);
                    LoadFlashcards(chapterId);
                }
            }
        }

        private void LoadFlashcards(int chapterId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT FlashcardId, QuestionText, QuestionImagePath,
                           AnswerText, AnswerImagePath
                    FROM Flashcards
                    WHERE ChapterId = @ChapterId AND IsActive = 1
                    ORDER BY DisplayOrder";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ChapterId", chapterId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                Flashcards = dt;
                CurrentIndex = 0;

                if (dt.Rows.Count > 0)
                {
                    DisplayFlashcard();
                }
                else
                {
                    pnlFlashcard.Visible = false;
                }
            }
        }

        private void DisplayFlashcard()
        {
            DataRow row = Flashcards.Rows[CurrentIndex];

            lblQuestion.Text = row["QuestionText"].ToString();
            lblAnswer.Text = row["AnswerText"].ToString();

            // Question Image Logic
            string qImg = row["QuestionImagePath"].ToString();
            if (!string.IsNullOrEmpty(qImg))
            {
                imgQuestion.ImageUrl = qImg;
                divQuestionImg.Visible = true;
            }
            else
            {
                divQuestionImg.Visible = false;
            }

            // Answer Image Logic
            string aImg = row["AnswerImagePath"].ToString();
            if (!string.IsNullOrEmpty(aImg))
            {
                imgAnswer.ImageUrl = aImg;
                divAnswerImg.Visible = true;
            }
            else
            {
                divAnswerImg.Visible = false;
            }

            // Update Counter & Progress
            int total = Flashcards.Rows.Count;
            lblCardCount.Text = $"CARD {CurrentIndex + 1} OF {total}";

            double progress = ((double)(CurrentIndex + 1) / total) * 100;
            progressBar.Style["width"] = progress + "%";

            btnPrevious.Enabled = CurrentIndex > 0;
            btnNext.Text = (CurrentIndex == total - 1) ? "Finish Set" : "Next Card";
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (CurrentIndex < Flashcards.Rows.Count - 1)
            {
                CurrentIndex++;
                DisplayFlashcard();
            }
            else
            {
                pnlFlashcard.Visible = false;
                pnlCompletion.Visible = true;
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentIndex > 0)
            {
                CurrentIndex--;
                DisplayFlashcard();
            }
        }

        protected void btnReviewAgain_Click(object sender, EventArgs e)
        {
            pnlCompletion.Visible = false;
            pnlFlashcard.Visible = true;
            CurrentIndex = 0;
            DisplayFlashcard();
        }

        protected void btnNewTopic_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Chapters.aspx");
        }
    }
}