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
                BindDropDown("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
                BindDropDown("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId == 0) return;

            bool isComp = CheckIfCompetitive(boardId);
            phComp.Visible = isComp;
            phSchool.Visible = !isComp;

            if (isComp)
                BindDropDown("SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId=" + boardId, ddlSubCategory, "SubCategoryName", "SubCategoryId");
            else
                BindDropDown("SELECT ClassId, ClassName FROM Classes WHERE BoardId=" + boardId, ddlClass, "ClassName", "ClassId");

            // Load chapters immediately for this board (catches chapters with NULL subjects)
            LoadChapters();
            FilterYears();
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e) { FilterYears(); }

        // --- Path A: School Logic ---
        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDropDown("SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=" + ddlClass.SelectedValue, ddlSubject, "SubjectName", "SubjectId");
            LoadChapters();
            FilterYears();
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChapters();
            FilterYears();
        }

        // --- Path B: Competitive Logic ---
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDropDown("SELECT SubjectId, SubjectName FROM Subjects WHERE SubCategoryId=" + ddlSubCategory.SelectedValue, ddlCompSubject, "SubjectName", "SubjectId");
            LoadChapters();
            FilterYears();
        }

        protected void ddlCompSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChapters();
            FilterYears();
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
                    string sql = @"INSERT INTO Sets (BoardId, ResourceTypeId, ClassId, SubjectId, SubCategoryId, ChapterId, YearId, SetName, DisplayOrder, IsActive)
                                   VALUES (@BID, @RTID, @CID, @SID, @SCID, @CHID, @YID, @Name, @Order, 1)";

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

                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "✅ Set added successfully!";
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
    }
}