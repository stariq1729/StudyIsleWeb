using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddChapter : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindInitialData();
            }
        }

        private void BindInitialData()
        {
            // The root starts with Boards
            BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName", ddlBoard, "BoardName", "BoardId");
            ResetAllFrom(ddlResourceType);
        }

        // --- Event Handlers (Mirroring the Resource logic for proper cascading) ---

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshResourceTypes();
            // Reset everything below and load next layers
            ResetAllFrom(ddlSubCategory);
            RefreshSubCategories();
            RefreshClasses();

            // Toggle placeholders based on selection
            int boardId = GetSelVal(ddlBoard);
            phClass.Visible = (boardId > 0);
            phSubCategory.Visible = (boardId > 0);
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubCategories();
            RefreshClasses();
            ResetAllFrom(ddlSubject);
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshClasses();
            RefreshSubjects();
        }

        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e) // Level = Class
        {
            RefreshSubjects();
        }

        // --- Refresh Methods (Strict Filtering Logic) ---

        private void RefreshResourceTypes()
        {
            int boardId = GetSelVal(ddlBoard);
            if (boardId == 0) { ResetDDL(ddlResourceType, "-- Optional --"); return; }

            // Using the Mapping Table (Matches Resource page logic)
            string sql = $@"SELECT rt.ResourceTypeId, rt.TypeName FROM ResourceTypes rt
                            INNER JOIN BoardResourceMapping brm ON rt.ResourceTypeId = brm.ResourceTypeId
                            WHERE brm.BoardId = {boardId} AND rt.IsActive = 1 ORDER BY rt.TypeName";
            BindDDL(sql, ddlResourceType, "TypeName", "ResourceTypeId");
        }

        private void RefreshSubCategories()
        {
            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);

            if (boardId == 0) { ResetDDL(ddlSubCategory, "-- Optional --"); return; }

            // Filter by Board. Only filter by Type if Type is selected.
            string sql = $"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId={boardId}";
            if (typeId > 0) sql += $" AND ResourceTypeId={typeId}";

            BindDDL(sql, ddlSubCategory, "SubCategoryName", "SubCategoryId");
        }

        private void RefreshClasses()
        {
            int boardId = GetSelVal(ddlBoard);
            int subCatId = GetSelVal(ddlSubCategory);
            int typeId = GetSelVal(ddlResourceType);

            if (boardId == 0) { ResetDDL(ddlLevel, "-- Optional --"); return; }

            string sql = $"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}";

            // Add optional filters
            if (subCatId > 0) sql += $" AND SubCategoryId={subCatId}";
            if (typeId > 0) sql += $" AND ResourceTypeId={typeId}";

            BindDDL(sql, ddlLevel, "ClassName", "ClassId");
        }

        private void RefreshSubjects()
        {
            int boardId = GetSelVal(ddlBoard);
            int subCatId = GetSelVal(ddlSubCategory);
            int classId = GetSelVal(ddlLevel);

            if (boardId == 0) { ResetDDL(ddlSubject, "-- Optional --"); return; }

            // If neither Class nor SubCat is selected, we don't show subjects (prevents "Show All")
            if (subCatId == 0 && classId == 0)
            {
                ResetDDL(ddlSubject, "-- Select Class First --");
                return;
            }

            string sql = $"SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId={boardId}";
            if (subCatId > 0) sql += $" AND SubCategoryId={subCatId}";
            if (classId > 0) sql += $" AND ClassId={classId}";

            BindDDL(sql, ddlSubject, "SubjectName", "SubjectId");
        }

        // --- Save Operation ---

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (GetSelVal(ddlBoard) == 0 || string.IsNullOrWhiteSpace(txtChapterName.Text))
            {
                ShowMessage("Board and Chapter Name are required.", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"INSERT INTO Chapters 
                (BoardId, ResourceTypeId, SubCategoryId, ClassId, SubjectId, ChapterName, Slug, DisplayOrder, IsActive, IsQuizEnabled, IsFlashcardEnabled, CreatedAt)
                VALUES (@BID, @RTID, @SCID, @ClassId, @SID, @Name, @Slug, @Order, @Active, @IsQuiz, @IsFlash, GETDATE())";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@RTID", GetValueForDB(ddlResourceType));
                cmd.Parameters.AddWithValue("@SCID", GetValueForDB(ddlSubCategory));
                cmd.Parameters.AddWithValue("@ClassId", GetValueForDB(ddlLevel));
                cmd.Parameters.AddWithValue("@SID", GetValueForDB(ddlSubject));
                cmd.Parameters.AddWithValue("@Name", txtChapterName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                cmd.Parameters.AddWithValue("@Order", string.IsNullOrEmpty(txtDisplayOrder.Text) ? 0 : int.Parse(txtDisplayOrder.Text));
                cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@IsQuiz", chkIsQuizEnabled.Checked);
                cmd.Parameters.AddWithValue("@IsFlash", chkIsFlashcardEnabled.Checked);

                con.Open();
                cmd.ExecuteNonQuery();
                ShowMessage("✅ Chapter added successfully!", false);
            }
        }

        // --- Core Helpers (Aligned with Resources Page) ---

        private int GetSelVal(DropDownList ddl) =>
            (ddl.SelectedItem != null && !string.IsNullOrEmpty(ddl.SelectedValue)) ? Convert.ToInt32(ddl.SelectedValue) : 0;

        private object GetValueForDB(DropDownList ddl) =>
            (GetSelVal(ddl) <= 0) ? DBNull.Value : (object)ddl.SelectedValue;

        private void BindDDL(string sql, DropDownList ddl, string text, string value)
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
                ddl.Items.Insert(0, new ListItem("-- Optional --", "0"));
            }
        }

        private void ResetDDL(DropDownList ddl, string text)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem(text, "0"));
        }

        private void ResetAllFrom(DropDownList startDdl)
        {
            DropDownList[] chain = { ddlResourceType, ddlSubCategory, ddlLevel, ddlSubject };
            bool startClearing = false;
            foreach (var ddl in chain)
            {
                if (ddl == startDdl) startClearing = true;
                if (startClearing) ResetDDL(ddl, "-- Optional --");
            }
        }

        private void ShowMessage(string msg, bool isError)
        {
            lblMessage.Text = msg;
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
        }

        protected void txtChapterName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtChapterName.Text.ToLower(), @"[^a-z0-9]", "-").Replace("--", "-").Trim('-');
        }
    }
}