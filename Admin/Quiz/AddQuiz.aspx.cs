using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Quiz
{
    public partial class AddQuiz : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId", "-- Select Board --");
                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Resource Type --");
            }
        }

        // ✅ Board Change
        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            phClass.Visible = false;
            phSubCategory.Visible = false;
            ddlSubject.Items.Clear();
            ddlChapter.Items.Clear();

            if (ddlBoard.SelectedValue != "0")
            {
                int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
                bool isComp = CheckIfCompetitive(boardId);

                if (isComp)
                {
                    phSubCategory.Visible = true;
                    BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId={boardId}",
                        ddlSubCategory, "SubCategoryName", "SubCategoryId", "-- Select Sub-Category --");
                }
                else
                {
                    phClass.Visible = true;
                    BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}",
                        ddlClass, "ClassName", "ClassId", "-- Select Class --");
                }
            }
        }

        // ✅ Class Change
        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlClass.SelectedValue != "0")
            {
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId={ddlClass.SelectedValue}",
                    ddlSubject, "SubjectName", "SubjectId", "-- Select Subject --");
            }
        }

        // ✅ SubCategory Change
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubCategory.SelectedValue != "0")
            {
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE SubCategoryId={ddlSubCategory.SelectedValue}",
                    ddlSubject, "SubjectName", "SubjectId", "-- Select Subject --");
            }
        }

        // ✅ Subject Change → Load Chapters
        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedValue != "0")
            {
                BindDDL($"SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId={ddlSubject.SelectedValue}",
                    ddlChapter, "ChapterName", "ChapterId", "-- Select Chapter --");
            }
        }

        // 🔧 Helper Methods
        private bool CheckIfCompetitive(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive,0) FROM Boards WHERE BoardId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", boardId);
                con.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();

                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlChapter.SelectedValue == "0")
                {
                    lblMessage.Text = "⚠️ Please select a chapter.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Quiz 
            (ChapterId, QuizLabel, TotalQuestions, TimeLimitMinutes, TotalMarks, Difficulty, CreatedAt)
            VALUES 
            (@ChapterId, @Label, @TotalQ, @Time, @Marks, @Difficulty,  GETDATE());
            SELECT SCOPE_IDENTITY();";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@ChapterId", ddlChapter.SelectedValue);
                    cmd.Parameters.AddWithValue("@Label", txtQuizLabel.Text.Trim());
                    cmd.Parameters.AddWithValue("@TotalQ", string.IsNullOrEmpty(txtTotalQuestions.Text) ? 0 : int.Parse(txtTotalQuestions.Text));
                    cmd.Parameters.AddWithValue("@Time", string.IsNullOrEmpty(txtTimeLimit.Text) ? 0 : int.Parse(txtTimeLimit.Text));
                    cmd.Parameters.AddWithValue("@Marks", string.IsNullOrEmpty(txtTotalMarks.Text) ? 0 : int.Parse(txtTotalMarks.Text));
                    cmd.Parameters.AddWithValue("@Difficulty", ddlDifficulty.SelectedValue);
                    //cmd.Parameters.AddWithValue("@Neg", chkNegativeMarking.Checked);

                    con.Open();

                    int quizId = Convert.ToInt32(cmd.ExecuteScalar());

                    // ✅ Redirect to Add Questions Page
                    Response.Redirect("~/Admin/Quiz/AddQuestion.aspx?quizId=" + quizId);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}