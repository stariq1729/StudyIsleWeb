using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Flashcards
{
    public partial class ManageFlashcards : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1",
                    ddlBoard, "BoardName", "BoardId", "-- Select Board --");
            }
        }

        #region Dropdown Bindings

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            phClass.Visible = false;
            phSubCategory.Visible = false;
            ddlSubject.Items.Clear();
            ddlChapter.Items.Clear();

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

        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindFlashcards();
        }

        #endregion

        #region Helper Methods

        private void BindDDL(string query, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
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

        private void BindFlashcards()
        {
            if (ddlChapter.SelectedValue == "0") return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        f.FlashcardId,
                        b.BoardName,
                        ISNULL(c.ClassName, sc.SubCategoryName) AS ClassOrSubCategory,
                        s.SubjectName,
                        ch.ChapterName,
                        f.QuestionText,
                        f.AnswerText,
                        f.DisplayOrder,
                        f.IsActive
                    FROM Flashcards f
                    INNER JOIN Chapters ch ON f.ChapterId = ch.ChapterId
                    INNER JOIN Subjects s ON ch.SubjectId = s.SubjectId
                    LEFT JOIN Classes c ON s.ClassId = c.ClassId
                    LEFT JOIN SubCategories sc ON s.SubCategoryId = sc.SubCategoryId
                    LEFT JOIN Boards b ON 
                        (b.BoardId = c.BoardId OR b.BoardId = sc.BoardId)
                    WHERE f.ChapterId = @ChapterId
                    ORDER BY f.DisplayOrder";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ChapterId", ddlChapter.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvFlashcards.DataSource = dt;
                gvFlashcards.DataBind();
            }
        }

        #endregion

        #region GridView Events

        protected void gvFlashcards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int flashcardId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditFlashcard")
            {
                Response.Redirect($"EditFlashcard.aspx?id={flashcardId}");
            }
            else if (e.CommandName == "DeleteFlashcard")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Flashcards WHERE FlashcardId=@Id", con);
                    cmd.Parameters.AddWithValue("@Id", flashcardId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Flashcard deleted successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                BindFlashcards();
            }
        }

        protected void btnAddFlashcard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Flashcards/AddFlashcards.aspx");
        }

        #endregion
    }
}