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

            FilterYears();
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e) { FilterYears(); }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDropDown("SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=" + ddlClass.SelectedValue, ddlSubject, "SubjectName", "SubjectId");
            FilterYears();
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDropDown("SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId=" + ddlSubject.SelectedValue, ddlChapter, "ChapterName", "ChapterId");
            FilterYears();
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e) { FilterYears(); }

        private void FilterYears()
        {
            // The "Perfect Binding" Query
            string sql = @"SELECT DISTINCT Y.YearId, Y.YearName 
                           FROM Years Y 
                           INNER JOIN YearMappings YM ON Y.YearId = YM.YearId 
                           WHERE YM.BoardId = @BID AND YM.ResourceTypeId = @RTID";

            SqlParameter[] queryParams = new SqlParameter[] {
                new SqlParameter("@BID", ddlBoard.SelectedValue),
                new SqlParameter("@RTID", ddlResourceType.SelectedValue)
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
                    cmd.Parameters.AddWithValue("@CID", phSchool.Visible ? (object)ddlClass.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@SID", phSchool.Visible ? (object)ddlSubject.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@SCID", phComp.Visible ? (object)ddlSubCategory.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@CHID", ddlChapter.SelectedIndex > 0 ? (object)ddlChapter.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@YID", ddlYear.SelectedValue);
                    cmd.Parameters.AddWithValue("@Name", txtSetName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Order", txtDisplayOrder.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "Set added successfully!";
                    lblMsg.CssClass = "alert alert-success";
                }
            }
            catch (Exception ex) { lblMsg.Text = "Error: " + ex.Message; lblMsg.CssClass = "alert alert-danger"; }
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