using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Flashcards
{
    public partial class AddFlashcards : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1",
                    ddlBoard, "BoardName", "BoardId", "-- Select Board --");

                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes",
                    ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Resource Type --");
            }
        }

        #region Dropdown Logic

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            phClass.Visible = false;
            phSubCategory.Visible = false;

            ddlSubject.Items.Clear();
            ddlChapter.Items.Clear();

            if (ddlBoard.SelectedValue != "0")
            {
                int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
                bool isCompetitive = CheckIfCompetitive(boardId);

                if (isCompetitive)
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

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId={ddlClass.SelectedValue}",
                ddlSubject, "SubjectName", "SubjectId", "-- Select Subject --");
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE SubCategoryId={ddlSubCategory.SelectedValue}",
                ddlSubject, "SubjectName", "SubjectId", "-- Select Subject --");
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDL($"SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId={ddlSubject.SelectedValue}",
                ddlChapter, "ChapterName", "ChapterId", "-- Select Chapter --");
        }

        private bool CheckIfCompetitive(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ISNULL(IsCompetitive,0) FROM Boards WHERE BoardId=@ID", con);
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

        #endregion

        #region Flashcard Logic

        protected void btnAddFlashcard_Click(object sender, EventArgs e)
        {
            if (ddlChapter.SelectedValue == "0")
            {
                lblMessage.Text = "⚠ Please select a chapter.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string qImg = SaveImage(fuQuestionImage);
            string aImg = SaveImage(fuAnswerImage);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"INSERT INTO Flashcards
                               (ChapterId, QuestionText, QuestionImagePath,
                                AnswerText, AnswerImagePath, DisplayOrder, IsActive, CreatedDate)
                               VALUES
                               (@ChapterId, @QuestionText, @QuestionImagePath,
                                @AnswerText, @AnswerImagePath, @DisplayOrder, @IsActive, GETDATE())";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ChapterId", ddlChapter.SelectedValue);
                cmd.Parameters.AddWithValue("@QuestionText", txtQuestionText.Text.Trim());
                cmd.Parameters.AddWithValue("@QuestionImagePath", (object)qImg ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@AnswerText", txtAnswerText.Text.Trim());
                cmd.Parameters.AddWithValue("@AnswerImagePath", (object)aImg ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@DisplayOrder", Convert.ToInt32(txtDisplayOrder.Text));
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "✅ Flashcard added successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            ClearFields();
            BindFlashcards();
        }

        private void BindFlashcards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = "SELECT FlashcardId, QuestionText, AnswerText, DisplayOrder FROM Flashcards WHERE ChapterId=@ChapterId ORDER BY DisplayOrder";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ChapterId", ddlChapter.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvFlashcards.DataSource = dt;
                gvFlashcards.DataBind();
            }
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Flashcards/ManageFlashcards.aspx");
        }

        private string SaveImage(FileUpload fu)
        {
            if (!fu.HasFile) return null;

            string folder = "~/Uploads/Flashcards/";
            string path = Server.MapPath(folder);

            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            string fileName = Guid.NewGuid() + Path.GetExtension(fu.FileName);
            fu.SaveAs(Path.Combine(path, fileName));

            return folder + fileName;
        }

        private void ClearFields()
        {
            txtQuestionText.Text = "";
            txtAnswerText.Text = "";
            txtDisplayOrder.Text = "1";
            chkIsActive.Checked = true;
        }

        #endregion
    }
}