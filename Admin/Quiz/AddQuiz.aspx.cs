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
            RefreshResourceTypes();
        }

        // ✅ Class Change
        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubjects();
        }

        // ✅ SubCategory Change
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubjects();
        }

        // ✅ Subject Change → Load Chapters
        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshChapters();
        }
        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshHierarchyPaths();
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

            bool isComp = CheckIfCompetitive(boardId);

            // =========================
            // COMPETITIVE FLOW
            // =========================
            if (isComp)
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