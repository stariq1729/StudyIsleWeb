using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class ManageChapters : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId", "All Boards");
                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "All Types");
                BindDDL("SELECT YearId, YearName FROM Years", ddlYear, "YearName", "YearId", "All Years");
                BindGrid();
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId > 0)
            {
                bool isComp = CheckIfCompetitive(boardId);
                phCompFilters.Visible = isComp;
                phSchoolFilters.Visible = !isComp;

                if (isComp)
                    BindDDL("SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId=" + boardId, ddlSubCategory, "SubCategoryName", "SubCategoryId", "All SubCategories");
                else
                    BindDDL("SELECT ClassId, ClassName FROM Classes WHERE BoardId=" + boardId, ddlClass, "ClassName", "ClassId", "All Classes");

                // Load Sets for this board
                BindDDL("SELECT SetId, SetName FROM Sets WHERE BoardId=" + boardId, ddlSet, "SetName", "SetId", "All Sets");
            }
            BindGrid();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDL("SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=" + ddlClass.SelectedValue, ddlSubject, "SubjectName", "SubjectId", "All Subjects");
            BindGrid();
        }

        protected void FilterChanged(object sender, EventArgs e) { BindGrid(); }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // COALESCE logic to show Subject Name (Path A) or SubCategory (Path B) as the Context
                string sql = @"
                    SELECT C.ChapterId, C.ChapterName, C.DisplayOrder, C.IsActive, 
                           B.BoardName, Y.YearName, ISNULL(S.SetName, 'N/A') as SetName,
                           COALESCE(Sub.SubjectName, SC.SubCategoryName, 'General') as ContextName
                    FROM Chapters C
                    INNER JOIN Boards B ON C.BoardId = B.BoardId
                    LEFT JOIN Years Y ON C.YearId = Y.YearId
                    LEFT JOIN Sets S ON C.SetId = S.SetId
                    LEFT JOIN Subjects Sub ON C.SubjectId = Sub.SubjectId
                    LEFT JOIN SubCategories SC ON C.SubCategoryId = SC.SubCategoryId
                    WHERE (@BID = 0 OR C.BoardId = @BID)
                      AND (@RTID = 0 OR C.ResourceTypeId = @RTID)
                      AND (@CID = 0 OR Sub.ClassId = @CID)
                      AND (@SID = 0 OR C.SubjectId = @SID)
                      AND (@SCID = 0 OR C.SubCategoryId = @SCID)
                      AND (@YID = 0 OR C.YearId = @YID)
                      AND (@SetID = 0 OR C.SetId = @SetID)
                    ORDER BY C.ChapterId DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);
                cmd.Parameters.AddWithValue("@CID", phSchoolFilters.Visible ? ddlClass.SelectedValue : "0");
                cmd.Parameters.AddWithValue("@SID", phSchoolFilters.Visible ? ddlSubject.SelectedValue : "0");
                cmd.Parameters.AddWithValue("@SCID", phCompFilters.Visible ? ddlSubCategory.SelectedValue : "0");
                cmd.Parameters.AddWithValue("@YID", ddlYear.SelectedValue);
                cmd.Parameters.AddWithValue("@SetID", ddlSet.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvChapters.DataSource = dt;
                gvChapters.DataBind();
            }
        }

        protected void gvChapters_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Chapters SET IsActive = ~IsActive WHERE ChapterId=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open(); cmd.ExecuteNonQuery();
                }
                BindGrid();
            }
        }

        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt; ddl.DataTextField = text; ddl.DataValueField = value; ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }

        private bool CheckIfCompetitive(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", boardId);
                con.Open(); return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }
    }
}