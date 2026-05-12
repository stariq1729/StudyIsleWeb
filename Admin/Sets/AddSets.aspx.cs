using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddSets : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDown(
                    "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1",
                    ddlBoard,
                    "BoardName",
                    "BoardId");

                BindDropDown(
                    "SELECT ResourceTypeId, TypeName FROM ResourceTypes",
                    ddlResourceType,
                    "TypeName",
                    "ResourceTypeId");

                // EDIT MODE

                if (Request.QueryString["id"] != null)
                {
                    hfSetId.Value =
                        Request.QueryString["id"];

                    btnSave.Text =
                        "Update Set";

                    LoadSetForEdit(
                        Convert.ToInt32(hfSetId.Value));
                }
            }
        }
        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshResourceTypes();
        }
        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshHierarchyPaths();
        }
        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSchoolSubjects();
        }
        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChapters();
            FilterYears();
        }
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshCompSubjects();
        }
        protected void ddlCompSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChapters();
            FilterYears();
        }


        private void LoadSetForEdit(int setId)
        {
            using (SqlConnection con =
                new SqlConnection(cs))
            {
                string query =
                    "SELECT * FROM Sets WHERE SetId=@ID";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@ID", setId);

                con.Open();

                string boardId = "";
                string rtId = "";
                string classId = "";
                string subjectId = "";
                string subCatId = "";
                string chapterId = "";
                string yearId = "";

                using (SqlDataReader rdr =
                    cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        boardId =
                            rdr["BoardId"].ToString();

                        if (rdr["ResourceTypeId"] != DBNull.Value)
                            rtId =
                                rdr["ResourceTypeId"].ToString();

                        if (rdr["ClassId"] != DBNull.Value)
                            classId =
                                rdr["ClassId"].ToString();

                        if (rdr["SubjectId"] != DBNull.Value)
                            subjectId =
                                rdr["SubjectId"].ToString();

                        if (rdr["SubCategoryId"] != DBNull.Value)
                            subCatId =
                                rdr["SubCategoryId"].ToString();

                        if (rdr["ChapterId"] != DBNull.Value)
                            chapterId =
                                rdr["ChapterId"].ToString();

                        if (rdr["YearId"] != DBNull.Value)
                            yearId =
                                rdr["YearId"].ToString();

                        txtSetName.Text =
                            rdr["SetName"].ToString();

                        txtDisplayOrder.Text =
                            rdr["DisplayOrder"].ToString();
                    }
                }

                // BOARD

                ddlBoard.SelectedValue = boardId;

                RefreshResourceTypes();

                // RESOURCE TYPE

                if (!string.IsNullOrEmpty(rtId))
                {
                    ddlResourceType.SelectedValue = rtId;
                }

                RefreshHierarchyPaths();

                // SCHOOL FLOW

                if (phSchool.Visible)
                {
                    if (!string.IsNullOrEmpty(classId))
                    {
                        ddlClass.SelectedValue = classId;

                        RefreshSchoolSubjects();
                    }

                    if (!string.IsNullOrEmpty(subjectId))
                    {
                        ddlSubject.SelectedValue = subjectId;

                        LoadChapters();
                        FilterYears();
                    }
                }

                // COMP FLOW

                if (phComp.Visible)
                {
                    if (!string.IsNullOrEmpty(subCatId))
                    {
                        ddlSubCategory.SelectedValue = subCatId;

                        RefreshCompSubjects();
                    }

                    if (!string.IsNullOrEmpty(subjectId))
                    {
                        ddlCompSubject.SelectedValue = subjectId;

                        LoadChapters();
                        FilterYears();
                    }
                }

                // YEAR

                if (!string.IsNullOrEmpty(yearId)
                    && ddlYear.Items.FindByValue(yearId) != null)
                {
                    ddlYear.SelectedValue = yearId;
                }

                // CHAPTER

                if (!string.IsNullOrEmpty(chapterId)
                    && ddlChapter.Items.FindByValue(chapterId) != null)
                {
                    ddlChapter.SelectedValue = chapterId;
                }
            }
        }



        // --- Core Logic: Load Chapters (Subject is Optional) ---
        private void LoadChapters()
        {
            string boardId = ddlBoard.SelectedValue;
            string subCatId = phComp.Visible ? ddlSubCategory.SelectedValue : "0";
            string classId = phSchool.Visible ? ddlClass.SelectedValue : "0";
            string subjectId = phSchool.Visible ? ddlSubject.SelectedValue : ddlCompSubject.SelectedValue;

            // Logic: Filter by Board. If Subject is selected, show those. 
            // If no Subject, show chapters linked directly to SubCat/Class where Subject IS NULL.
            string sql = "SELECT ChapterId, ChapterName FROM Chapters WHERE BoardId = @BID";

            if (subjectId != "0" && !string.IsNullOrEmpty(subjectId))
            {
                sql += " AND SubjectId = @SID";
            }
            else if (subCatId != "0" && subCatId != "")
            {
                sql += " AND SubCategoryId = @SCID AND SubjectId IS NULL";
            }
            else if (classId != "0" && classId != "")
            {
                sql += " AND ClassId = @CID AND SubjectId IS NULL";
            }
            else
            {
                sql += " AND SubjectId IS NULL";
            }

            SqlParameter[] ps = {
                new SqlParameter("@BID", boardId),
                new SqlParameter("@SID", subjectId ?? (object)DBNull.Value),
                new SqlParameter("@SCID", subCatId),
                new SqlParameter("@CID", classId)
            };

            BindDropDown(sql, ddlChapter, "ChapterName", "ChapterId", ps);
        }

        private void FilterYears()
        {
            string activeSubId = phSchool.Visible ? ddlSubject.SelectedValue : ddlCompSubject.SelectedValue;

            string sql = @"SELECT DISTINCT Y.YearId, Y.YearName 
                           FROM Years Y 
                           INNER JOIN YearMappings YM ON Y.YearId = YM.YearId 
                           WHERE YM.BoardId = @BID AND YM.ResourceTypeId = @RTID";

            if (activeSubId != "0" && !string.IsNullOrEmpty(activeSubId))
            {
                sql += " AND YM.SubjectId = @SID";
            }

            SqlParameter[] queryParams = new SqlParameter[] {
                new SqlParameter("@BID", ddlBoard.SelectedValue),
                new SqlParameter("@RTID", ddlResourceType.SelectedValue),
                new SqlParameter("@SID", activeSubId ?? "0")
            };

            BindDropDown(sql, ddlYear, "YearName", "YearId", queryParams);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    bool isEditMode =
    !string.IsNullOrEmpty(hfSetId.Value);
                    string sql = "";

                    if (isEditMode)
                    {
                        sql = @"
        UPDATE Sets
        SET
            BoardId = @BID,
            ResourceTypeId = @RTID,
            ClassId = @CID,
            SubjectId = @SID,
            SubCategoryId = @SCID,
            ChapterId = @CHID,
            YearId = @YID,
            SetName = @Name,
            DisplayOrder = @Order
        WHERE SetId = @ID";
                    }
                    else
                    {
                        sql = @"
        INSERT INTO Sets
        (
            BoardId,
            ResourceTypeId,
            ClassId,
            SubjectId,
            SubCategoryId,
            ChapterId,
            YearId,
            SetName,
            DisplayOrder,
            IsActive
        )
        VALUES
        (
            @BID,
            @RTID,
            @CID,
            @SID,
            @SCID,
            @CHID,
            @YID,
            @Name,
            @Order,
            1
        )";
                    }

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);

                    // Handle Class/SubCat Nulls
                    cmd.Parameters.AddWithValue("@CID", phSchool.Visible && ddlClass.SelectedValue != "0" ? (object)ddlClass.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@SCID", phComp.Visible && ddlSubCategory.SelectedValue != "0" ? (object)ddlSubCategory.SelectedValue : DBNull.Value);

                    // Handle Subject Nulls
                    object subjectId = phSchool.Visible ? (object)ddlSubject.SelectedValue : (object)ddlCompSubject.SelectedValue;
                    cmd.Parameters.AddWithValue("@SID", (subjectId == null || subjectId.ToString() == "0") ? DBNull.Value : subjectId);

                    // Handle Chapter Nulls
                    cmd.Parameters.AddWithValue("@CHID", ddlChapter.SelectedIndex > 0 ? (object)ddlChapter.SelectedValue : DBNull.Value);

                    // --- THE FIX: Handle Year as Optional (NULL) ---
                    if (ddlYear.SelectedIndex > 0 && ddlYear.SelectedValue != "0")
                        cmd.Parameters.AddWithValue("@YID", ddlYear.SelectedValue);
                    else
                        cmd.Parameters.AddWithValue("@YID", DBNull.Value);

                    cmd.Parameters.AddWithValue("@Name", txtSetName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Order", string.IsNullOrEmpty(txtDisplayOrder.Text) ? "0" : txtDisplayOrder.Text);
                    if (isEditMode)
                    {
                        cmd.Parameters.AddWithValue(
                            "@ID",
                            hfSetId.Value);
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Text =
    isEditMode
    ? "✅ Set updated successfully!"
    : "✅ Set added successfully!";
                    lblMsg.CssClass = "alert alert-success";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "❌ Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        // --- Helpers ---
        private bool CheckIfCompetitive(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", boardId);
                con.Open(); return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        private void BindDropDown(string sql, DropDownList ddl, string text, string value, SqlParameter[] ps = null)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                if (ps != null) cmd.Parameters.AddRange(ps);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable(); da.Fill(dt);
                ddl.DataSource = dt; ddl.DataTextField = text; ddl.DataValueField = value; ddl.DataBind();
                ddl.Items.Insert(0, new ListItem("-- Select --", "0"));
            }
        }
        private void ResetDDL(DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem("-- Select --", "0"));
        }
        private void RefreshResourceTypes()
        {
            // Reset everything below Board
            ResetDDL(ddlResourceType);

            ResetDDL(ddlClass);
            ResetDDL(ddlSubject);

            ResetDDL(ddlSubCategory);
            ResetDDL(ddlCompSubject);

            ResetDDL(ddlYear);
            ResetDDL(ddlChapter);

            // Hide both paths initially
            phSchool.Visible = false;
            phComp.Visible = false;

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
                    new ListItem("-- Select --", "0"));
            }
        }
        private void RefreshHierarchyPaths()
        {
            // Reset lower hierarchy first
            ResetDDL(ddlClass);
            ResetDDL(ddlSubject);

            ResetDDL(ddlSubCategory);
            ResetDDL(ddlCompSubject);

            ResetDDL(ddlYear);
            ResetDDL(ddlChapter);

            phSchool.Visible = false;
            phComp.Visible = false;

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
                        phComp.Visible = true;

                        ddlSubCategory.DataSource = dt;
                        ddlSubCategory.DataTextField = "SubCategoryName";
                        ddlSubCategory.DataValueField = "SubCategoryId";
                        ddlSubCategory.DataBind();

                        ddlSubCategory.Items.Insert(0,
                            new ListItem("-- Select --", "0"));
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
                        phSchool.Visible = true;

                        ddlClass.DataSource = dt;
                        ddlClass.DataTextField = "ClassName";
                        ddlClass.DataValueField = "ClassId";
                        ddlClass.DataBind();

                        ddlClass.Items.Insert(0,
                            new ListItem("-- Select --", "0"));
                    }
                }
            }

            // IMPORTANT:
            // Load fallback content immediately
            LoadChapters();
            FilterYears();
        }
        private void RefreshSchoolSubjects()
        {
            ResetDDL(ddlSubject);

            // Stop if no class selected
            if (ddlClass.SelectedValue == "0")
            {
                LoadChapters();
                FilterYears();
                return;
            }

            string query = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId
        AND ClassId = @ClassId
        AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ClassId",
                    ddlClass.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0,
                    new ListItem("-- Select --", "0"));
            }

            // Preserve fallback resolution behavior
            LoadChapters();
            FilterYears();
        }
        private void RefreshCompSubjects()
        {
            ResetDDL(ddlCompSubject);

            // Stop if no subcategory selected
            if (ddlSubCategory.SelectedValue == "0")
            {
                LoadChapters();
                FilterYears();
                return;
            }

            string query = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId
        AND SubCategoryId = @SubCategoryId
        AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@SubCategoryId",
                    ddlSubCategory.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCompSubject.DataSource = dt;
                ddlCompSubject.DataTextField = "SubjectName";
                ddlCompSubject.DataValueField = "SubjectId";
                ddlCompSubject.DataBind();

                ddlCompSubject.Items.Insert(0,
                    new ListItem("-- Select --", "0"));
            }

            // Preserve fallback resolution behavior
            LoadChapters();
            FilterYears();
        }
    }
}