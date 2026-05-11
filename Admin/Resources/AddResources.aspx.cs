using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class AddResources : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { BindInitialData(); }
        }

        private void BindInitialData()
        {
            // Load the primary root
            BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
            ResetAllFrom(ddlResourceType);
        }

        // --- Event Handlers (Cascading Logic) ---

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshResourceTypes();
            ResetAllFrom(ddlSubCategory);
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubCategories();
            RefreshClasses();
            RefreshYears(); // Refresh year when type changes
            ResetAllFrom(ddlSubject);
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshClasses();
            RefreshSubjects();
            RefreshYears();
            RefreshChapters();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSubjects();
            RefreshYears();
            RefreshChapters();
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshYears();
            RefreshChapters();
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();
        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();

        // --- Refresh Methods ---

        private void RefreshYears()
        {
            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);
            int classId = GetSelVal(ddlClass);
            int subjectId = GetSelVal(ddlSubject);
            int subCatId = GetSelVal(ddlSubCategory);

            if (boardId == 0) { ResetDDL(ddlYear, "-- Optional --"); return; }

            // FIX: Querying the YearMappings table to get context-specific years
            string sql = $@"SELECT DISTINCT y.YearId, y.YearName 
                            FROM Years y
                            INNER JOIN YearMappings ym ON y.YearId = ym.YearId
                            WHERE ym.BoardId = {boardId} AND ym.IsActive = 1";

            if (typeId > 0) sql += $" AND ym.ResourceTypeId = {typeId}";
            if (classId > 0) sql += $" AND ym.ClassId = {classId}";
            if (subjectId > 0) sql += $" AND ym.SubjectId = {subjectId}";
            if (subCatId > 0) sql += $" AND ym.SubCategoryId = {subCatId}";

            sql += " ORDER BY y.YearName DESC";

            BindDDL(sql, ddlYear, "YearName", "YearId");
        }

        private void RefreshResourceTypes()
        {
            int boardId = GetSelVal(ddlBoard);
            string sql = $@"SELECT rt.ResourceTypeId, rt.TypeName FROM ResourceTypes rt
                            INNER JOIN BoardResourceMapping brm ON rt.ResourceTypeId = brm.ResourceTypeId
                            WHERE brm.BoardId = {boardId} AND rt.IsActive = 1";
            BindDDL(sql, ddlResourceType, "TypeName", "ResourceTypeId");
        }

        private void RefreshSubCategories()
        {
            ResetDDL(ddlSubCategory, "-- Optional --");

            phSubCategory.Visible = false;

            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);

            if (boardId == 0 || typeId == 0)
                return;

            string sql = @"
        SELECT SubCategoryId, SubCategoryName
        FROM SubCategories
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @TypeId
        AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);
                da.SelectCommand.Parameters.AddWithValue("@TypeId", typeId);

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
                        new ListItem("-- Optional --", "0"));
                }
            }
        }

        private void RefreshClasses()
        {
            ResetDDL(ddlClass, "-- Optional --");

            phClass.Visible = false;

            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);
            int subCatId = GetSelVal(ddlSubCategory);

            if (boardId == 0 || typeId == 0)
                return;

            string sql = @"
        SELECT ClassId, ClassName
        FROM Classes
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @TypeId";

            // Optional SubCategory hierarchy
            if (subCatId > 0)
            {
                sql += " AND SubCategoryId = @SubCatId";
            }
            else
            {
                sql += " AND SubCategoryId IS NULL";
            }

            sql += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);
                da.SelectCommand.Parameters.AddWithValue("@TypeId", typeId);

                if (subCatId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCatId", subCatId);
                }

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
                        new ListItem("-- Optional --", "0"));
                }
            }
        }

        private void RefreshSubjects()
        {
            ResetDDL(ddlSubject, "-- Optional --");

            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);
            int subCatId = GetSelVal(ddlSubCategory);
            int classId = GetSelVal(ddlClass);

            if (boardId == 0 || typeId == 0)
                return;

            string sql = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @TypeId";

            // Optional SubCategory hierarchy
            if (subCatId > 0)
            {
                sql += " AND SubCategoryId = @SubCatId";
            }
            else
            {
                sql += " AND SubCategoryId IS NULL";
            }

            // Optional Class hierarchy
            if (classId > 0)
            {
                sql += " AND ClassId = @ClassId";
            }
            else
            {
                sql += " AND ClassId IS NULL";
            }

            sql += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);
                da.SelectCommand.Parameters.AddWithValue("@TypeId", typeId);

                if (subCatId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCatId", subCatId);
                }

                if (classId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@ClassId", classId);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0,
                    new ListItem("-- Optional --", "0"));
            }
        }

        private void RefreshChapters()
        {
            ResetDDL(ddlChapter, "-- Optional --");

            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);
            int subCatId = GetSelVal(ddlSubCategory);
            int classId = GetSelVal(ddlClass);
            int subjectId = GetSelVal(ddlSubject);

            if (boardId == 0 || typeId == 0)
                return;

            string sql = @"
        SELECT ChapterId, ChapterName
        FROM Chapters
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @TypeId";

            // Optional SubCategory hierarchy
            if (subCatId > 0)
            {
                sql += " AND SubCategoryId = @SubCatId";
            }
            else
            {
                sql += " AND SubCategoryId IS NULL";
            }

            // Optional Class hierarchy
            if (classId > 0)
            {
                sql += " AND ClassId = @ClassId";
            }
            else
            {
                sql += " AND ClassId IS NULL";
            }

            // Optional Subject hierarchy
            if (subjectId > 0)
            {
                sql += " AND SubjectId = @SubjectId";
            }
            else
            {
                sql += " AND SubjectId IS NULL";
            }

            sql += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);
                da.SelectCommand.Parameters.AddWithValue("@TypeId", typeId);

                if (subCatId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCatId", subCatId);
                }

                if (classId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@ClassId", classId);
                }

                if (subjectId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubjectId", subjectId);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChapter.DataSource = dt;
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterId";
                ddlChapter.DataBind();

                ddlChapter.Items.Insert(0,
                    new ListItem("-- Optional --", "0"));
            }
        }

        private void RefreshSets()
        {
            ResetDDL(ddlSet, "-- Optional --");

            int boardId = GetSelVal(ddlBoard);
            int typeId = GetSelVal(ddlResourceType);
            int subCatId = GetSelVal(ddlSubCategory);
            int classId = GetSelVal(ddlClass);
            int subjectId = GetSelVal(ddlSubject);
            int chapterId = GetSelVal(ddlChapter);
            int yearId = GetSelVal(ddlYear);

            if (boardId == 0 || typeId == 0)
                return;

            string sql = @"
        SELECT SetId, SetName
        FROM Sets
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @TypeId";

            // Optional SubCategory hierarchy
            if (subCatId > 0)
            {
                sql += " AND SubCategoryId = @SubCatId";
            }
            else
            {
                sql += " AND SubCategoryId IS NULL";
            }

            // Optional Class hierarchy
            if (classId > 0)
            {
                sql += " AND ClassId = @ClassId";
            }
            else
            {
                sql += " AND ClassId IS NULL";
            }

            // Optional Subject hierarchy
            if (subjectId > 0)
            {
                sql += " AND SubjectId = @SubjectId";
            }
            else
            {
                sql += " AND SubjectId IS NULL";
            }

            // Optional Chapter hierarchy
            if (chapterId > 0)
            {
                sql += " AND ChapterId = @ChapterId";
            }
            else
            {
                sql += " AND ChapterId IS NULL";
            }

            // Optional Year hierarchy
            if (yearId > 0)
            {
                sql += " AND YearId = @YearId";
            }
            else
            {
                sql += " AND YearId IS NULL";
            }

            sql += " AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", boardId);
                da.SelectCommand.Parameters.AddWithValue("@TypeId", typeId);

                if (subCatId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubCatId", subCatId);
                }

                if (classId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@ClassId", classId);
                }

                if (subjectId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@SubjectId", subjectId);
                }

                if (chapterId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@ChapterId", chapterId);
                }

                if (yearId > 0)
                {
                    da.SelectCommand.Parameters.AddWithValue("@YearId", yearId);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSet.DataSource = dt;
                ddlSet.DataTextField = "SetName";
                ddlSet.DataValueField = "SetId";
                ddlSet.DataBind();

                ddlSet.Items.Insert(0,
                    new ListItem("-- Optional --", "0"));
            }
        }

        // --- Save Operation ---

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (GetSelVal(ddlBoard) == 0 || string.IsNullOrEmpty(txtTitle.Text) || !fuFile.HasFile)
            {
                ShowMessage("Please provide Board, Title, and File.", "text-danger");
                return;
            }

            try
            {
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuFile.FileName);
                string savePath = "/Uploads/Resources/" + fileName;
                fuFile.SaveAs(Server.MapPath("~" + savePath));

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Resources 
                        (BoardId, ResourceTypeId, ClassId, SubjectId, ChapterId, YearId, SubCategoryId, SetId, Title, FilePath, ContentType, IsPremium, IsActive, CreatedAt)
                        VALUES (@BID, @RTID, @CID, @SID, @CHID, @YID, @SCID, @SetID, @Title, @Path, @CType, @Prem, 1, GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", GetValueForDB(ddlResourceType));
                    cmd.Parameters.AddWithValue("@CID", GetValueForDB(ddlClass));
                    cmd.Parameters.AddWithValue("@SID", GetValueForDB(ddlSubject));
                    cmd.Parameters.AddWithValue("@CHID", GetValueForDB(ddlChapter));
                    cmd.Parameters.AddWithValue("@YID", GetValueForDB(ddlYear));
                    cmd.Parameters.AddWithValue("@SCID", GetValueForDB(ddlSubCategory));
                    cmd.Parameters.AddWithValue("@SetID", GetValueForDB(ddlSet));
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Path", savePath);
                    cmd.Parameters.AddWithValue("@CType", fuFile.PostedFile.ContentType);
                    cmd.Parameters.AddWithValue("@Prem", chkIsPremium.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageResources.aspx");
                }
            }
            catch (Exception ex) { ShowMessage("Error: " + ex.Message, "text-danger"); }
        }

        // --- Helpers ---

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
            DropDownList[] chain = { ddlResourceType, ddlSubCategory, ddlClass, ddlSubject, ddlYear, ddlChapter, ddlSet };
            bool startClearing = false;
            foreach (var ddl in chain)
            {
                if (ddl == startDdl) startClearing = true;
                if (startClearing) ResetDDL(ddl, "-- Optional --");
            }
        }

        private void ShowMessage(string msg, string css)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = "d-block mb-3 " + css;
        }
    }
}