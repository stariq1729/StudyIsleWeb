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
            RefreshResourceTypes();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubjects();
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubjects();
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshChapters();
        }
        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshHierarchyPaths();
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
        private void ResetDDL(DropDownList ddl, string defaultText)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem(defaultText, "0"));
        }
        private void RefreshResourceTypes()
        {
            // Reset everything below Board
            ResetDDL(ddlResourceType, "-- Select Resource Type --");

            ResetDDL(ddlClass, "-- Select Class --");
            ResetDDL(ddlSubCategory, "-- Select Sub-Category --");

            ResetDDL(ddlSubject, "-- Select Subject --");
            ResetDDL(ddlChapter, "-- Select Chapter --");

            // Hide optional hierarchy initially
            phClass.Visible = false;
            phSubCategory.Visible = false;

            // Stop if no board selected
            if (ddlBoard.SelectedValue == "0")
                return;

            string query = @"
        SELECT DISTINCT rt.ResourceTypeId, rt.TypeName
        FROM ResourceTypes rt
        INNER JOIN BoardResourceMapping brm
            ON rt.ResourceTypeId = brm.ResourceTypeId
        WHERE brm.BoardId = @BoardId
        AND rt.IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();

                ddlResourceType.Items.Insert(0,
                    new ListItem("-- Select Resource Type --", "0"));
            }
        }
        private void RefreshHierarchyPaths()
        {
            // Reset lower hierarchy
            ResetDDL(ddlClass, "-- Select Class --");
            ResetDDL(ddlSubCategory, "-- Select Sub-Category --");

            ResetDDL(ddlSubject, "-- Select Subject --");
            ResetDDL(ddlChapter, "-- Select Chapter --");

            phClass.Visible = false;
            phSubCategory.Visible = false;

            // Stop if no resource type selected
            if (ddlResourceType.SelectedValue == "0")
                return;

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);

            bool isCompetitive = CheckIfCompetitive(boardId);

            // =========================
            // COMPETITIVE FLOW
            // =========================
            if (isCompetitive)
            {
                string subQuery = @"
            SELECT SubCategoryId, SubCategoryName
            FROM SubCategories
            WHERE BoardId = @BoardId
            AND ResourceTypeId = @ResourceTypeId
            AND IsActive = 1";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter(subQuery, con);

                    da.SelectCommand.Parameters.AddWithValue("@BoardId",
                        ddlBoard.SelectedValue);

                    da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                        ddlResourceType.SelectedValue);

                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Optional hierarchy visibility
                    if (dt.Rows.Count > 0)
                    {
                        phSubCategory.Visible = true;

                        ddlSubCategory.DataSource = dt;
                        ddlSubCategory.DataTextField = "SubCategoryName";
                        ddlSubCategory.DataValueField = "SubCategoryId";
                        ddlSubCategory.DataBind();

                        ddlSubCategory.Items.Insert(0,
                            new ListItem("-- Select Sub-Category --", "0"));
                    }
                }
            }

            // =========================
            // SCHOOL FLOW
            // =========================
            else
            {
                string classQuery = @"
            SELECT ClassId, ClassName
            FROM Classes
            WHERE BoardId = @BoardId
            AND ResourceTypeId = @ResourceTypeId
            AND IsActive = 1";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter(classQuery, con);

                    da.SelectCommand.Parameters.AddWithValue("@BoardId",
                        ddlBoard.SelectedValue);

                    da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                        ddlResourceType.SelectedValue);

                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Optional hierarchy visibility
                    if (dt.Rows.Count > 0)
                    {
                        phClass.Visible = true;

                        ddlClass.DataSource = dt;
                        ddlClass.DataTextField = "ClassName";
                        ddlClass.DataValueField = "ClassId";
                        ddlClass.DataBind();

                        ddlClass.Items.Insert(0,
                            new ListItem("-- Select Class --", "0"));
                    }
                }
            }
        }
        private void RefreshSubjects()
        {
            ResetDDL(ddlSubject, "-- Select Subject --");
            ResetDDL(ddlChapter, "-- Select Chapter --");

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);

            int classId = ddlClass.SelectedValue == "0"
                ? 0
                : Convert.ToInt32(ddlClass.SelectedValue);

            int subCatId = ddlSubCategory.SelectedValue == "0"
                ? 0
                : Convert.ToInt32(ddlSubCategory.SelectedValue);

            if (boardId == 0 || typeId == 0)
                return;

            string query = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId";

            // Optional Class hierarchy
            if (classId > 0)
            {
                query += " AND ClassId = @ClassId";
            }
            else
            {
                query += " AND ClassId IS NULL";
            }

            // Optional SubCategory hierarchy
            if (subCatId > 0)
            {
                query += " AND SubCategoryId = @SubCategoryId";
            }
            else
            {
                query += " AND SubCategoryId IS NULL";
            }

            query += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    typeId);

                if (classId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@ClassId",
                        classId);
                }

                if (subCatId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCategoryId",
                        subCatId);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0,
                    new ListItem("-- Select Subject --", "0"));
            }
        }
        private void RefreshChapters()
        {
            ResetDDL(ddlChapter, "-- Select Chapter --");

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);

            int classId = ddlClass.SelectedValue == "0"
                ? 0
                : Convert.ToInt32(ddlClass.SelectedValue);

            int subCatId = ddlSubCategory.SelectedValue == "0"
                ? 0
                : Convert.ToInt32(ddlSubCategory.SelectedValue);

            int subjectId = ddlSubject.SelectedValue == "0"
                ? 0
                : Convert.ToInt32(ddlSubject.SelectedValue);

            if (boardId == 0 || typeId == 0)
                return;

            string query = @"
        SELECT ChapterId, ChapterName
        FROM Chapters
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId";

            // Optional Class hierarchy
            if (classId > 0)
            {
                query += " AND ClassId = @ClassId";
            }
            else
            {
                query += " AND ClassId IS NULL";
            }

            // Optional SubCategory hierarchy
            if (subCatId > 0)
            {
                query += " AND SubCategoryId = @SubCategoryId";
            }
            else
            {
                query += " AND SubCategoryId IS NULL";
            }

            // Subject hierarchy
            if (subjectId > 0)
            {
                query += " AND SubjectId = @SubjectId";
            }
            else
            {
                query += " AND SubjectId IS NULL";
            }

            query += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    typeId);

                if (classId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@ClassId",
                        classId);
                }

                if (subCatId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCategoryId",
                        subCatId);
                }

                if (subjectId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubjectId",
                        subjectId);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChapter.DataSource = dt;
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterId";
                ddlChapter.DataBind();

                ddlChapter.Items.Insert(0,
                    new ListItem("-- Select Chapter --", "0"));
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