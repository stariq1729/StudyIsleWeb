using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

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
                Response.Redirect("~/Admin/Quiz/AddQuiz.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtQuestion.Text) && !fuQuestionImage.HasFile)
                {
                    lblMessage.Text = "⚠️ Please enter question text or upload an image.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                if (ddlCorrect.SelectedValue == "")
                {
                    lblMessage.Text = "⚠️ Please select the correct answer.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Questions
            (QuizId, QuestionText, QuestionImage,
             OptionA, OptionAImage,
             OptionB, OptionBImage,
             OptionC, OptionCImage,
             OptionD, OptionDImage,
             CorrectOption, Explanation, Marks, QuestionOrder)
            VALUES
            (@QuizId, @QText, @QImg,
             @A, @AImg,
             @B, @BImg,
             @C, @CImg,
             @D, @DImg,
             @Correct, @Exp, @Marks, @Order)";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@QuizId", QuizId);
                    cmd.Parameters.AddWithValue("@QText", txtQuestion.Text.Trim());

                    cmd.Parameters.AddWithValue("@QImg",
                        (object)SaveImage(fuQuestionImage) ?? DBNull.Value);

                    cmd.Parameters.AddWithValue("@A", txtA.Text.Trim());
                    cmd.Parameters.AddWithValue("@AImg",
                        (object)SaveImage(fuAImage) ?? DBNull.Value);

                    cmd.Parameters.AddWithValue("@B", txtB.Text.Trim());
                    cmd.Parameters.AddWithValue("@BImg",
                        (object)SaveImage(fuBImage) ?? DBNull.Value);

                    cmd.Parameters.AddWithValue("@C", txtC.Text.Trim());
                    cmd.Parameters.AddWithValue("@CImg",
                        (object)SaveImage(fuCImage) ?? DBNull.Value);

                    cmd.Parameters.AddWithValue("@D", txtD.Text.Trim());
                    cmd.Parameters.AddWithValue("@DImg",
                        (object)SaveImage(fuDImage) ?? DBNull.Value);

                    cmd.Parameters.AddWithValue("@Correct", ddlCorrect.SelectedValue);
                    cmd.Parameters.AddWithValue("@Exp",
                        string.IsNullOrWhiteSpace(txtExplanation.Text)
                            ? (object)DBNull.Value
                            : txtExplanation.Text.Trim());

                    cmd.Parameters.AddWithValue("@Marks",
                        string.IsNullOrEmpty(txtMarks.Text) ? 1 : int.Parse(txtMarks.Text));

                    cmd.Parameters.AddWithValue("@Order",
                        string.IsNullOrEmpty(txtOrder.Text) ? 0 : int.Parse(txtOrder.Text));

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "✅ Question added successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                ClearForm();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private string SaveImage(System.Web.UI.WebControls.FileUpload fu)
        {
            if (!fu.HasFile)
                return null;

            string folder = "~/Uploads/QuizImages/";
            string folderPath = Server.MapPath(folder);

            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string fileName = Guid.NewGuid().ToString() +
                              System.IO.Path.GetExtension(fu.FileName);

            string fullPath = System.IO.Path.Combine(folderPath, fileName);
            fu.SaveAs(fullPath);

            return folder + fileName;
        }

        private void ClearForm()
        {
            txtQuestion.Text = "";
            txtA.Text = "";
            txtB.Text = "";
            txtC.Text = "";
            txtD.Text = "";
            txtExplanation.Text = "";
            ddlCorrect.SelectedIndex = 0;
            txtMarks.Text = "1";
            txtOrder.Text = "";
        }
    }
}