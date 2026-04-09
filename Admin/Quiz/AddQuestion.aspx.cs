using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Quiz
{
    public partial class AddQuestion : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private int QuizId
        {
            get
            {
                return Request.QueryString["quizId"] != null
                    ? Convert.ToInt32(Request.QueryString["quizId"])
                    : 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (QuizId == 0)
            {
                Response.Redirect("~/Admin/Quiz/AddQuiz.aspx");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtQuestion.Text) || ddlCorrect.SelectedValue == "")
                {
                    lblMessage.Text = "⚠️ Question and correct answer required.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Questions
                    (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Explanation, Marks, QuestionOrder)
                    VALUES
                    (@QuizId, @Q, @A, @B, @C, @D, @Correct, @Exp, @Marks, @Order)";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@QuizId", QuizId);
                    cmd.Parameters.AddWithValue("@Q", txtQuestion.Text.Trim());
                    cmd.Parameters.AddWithValue("@A", txtA.Text.Trim());
                    cmd.Parameters.AddWithValue("@B", txtB.Text.Trim());
                    cmd.Parameters.AddWithValue("@C", txtC.Text.Trim());
                    cmd.Parameters.AddWithValue("@D", txtD.Text.Trim());
                    cmd.Parameters.AddWithValue("@Correct", ddlCorrect.SelectedValue);
                    cmd.Parameters.AddWithValue("@Exp", txtExplanation.Text.Trim());
                    cmd.Parameters.AddWithValue("@Marks", string.IsNullOrEmpty(txtMarks.Text) ? 1 : int.Parse(txtMarks.Text));
                    cmd.Parameters.AddWithValue("@Order", string.IsNullOrEmpty(txtOrder.Text) ? 0 : int.Parse(txtOrder.Text));

                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "✅ Question saved!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    ClearForm();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Dashboard.aspx");
        }

        private void ClearForm()
        {
            txtQuestion.Text = "";
            txtA.Text = "";
            txtB.Text = "";
            txtC.Text = "";
            txtD.Text = "";
            ddlCorrect.SelectedIndex = 0;
            txtExplanation.Text = "";
            txtMarks.Text = "1";
            txtOrder.Text = "";
        }
    }
}