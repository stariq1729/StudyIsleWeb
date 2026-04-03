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
                LoadInitialFilters();
                BindGrid();
            }
        }

        private void LoadInitialFilters()
        {
            FillDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId", "Select Board");
            FillDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "Select Type");
            FillDDL("SELECT YearId, YearName FROM Years", ddlYear, "YearName", "YearId", "Select Year (Optional)");
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int bid = Convert.ToInt32(ddlBoard.SelectedValue);
            if (bid == 0) return;

            bool isComp = IsCompetitiveBoard(bid);
            phCompetitive.Visible = isComp;
            phSchool.Visible = !isComp;

            if (isComp)
                FillDDL("SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId=" + bid, ddlSubCategory, "SubCategoryName", "SubCategoryId", "All Sub-Categories");
            else
                FillDDL("SELECT ClassId, ClassName FROM Classes WHERE BoardId=" + bid, ddlClass, "ClassName", "ClassId", "All Classes");

            BindGrid();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillDDL("SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=" + ddlClass.SelectedValue, ddlSubject, "SubjectName", "SubjectId", "All Subjects");
            BindGrid();
        }

        protected void FilterChanged(object sender, EventArgs e) { BindGrid(); }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // The query uses COALESCE and LEFT JOIN to prevent empty rows when data is optional
                string sql = @"
                    SELECT C.ChapterId, C.ChapterName, C.IsActive, C.DisplayOrder,
                           B.BoardName,
                           ISNULL(Y.YearName, '--') as YearDisplay,
                           ISNULL(ST.SetName, 'Direct Resource') as SetName,
                           COALESCE(S.SubjectName, SC.SubCategoryName, CL.ClassName, 'General') as HierarchyPath
                    FROM Chapters C
                    INNER JOIN Boards B ON C.BoardId = B.BoardId
                    LEFT JOIN Subjects S ON C.SubjectId = S.SubjectId
                    LEFT JOIN SubCategories SC ON C.SubCategoryId = SC.SubCategoryId
                    LEFT JOIN Classes CL ON C.ClassId = CL.ClassId
                    LEFT JOIN Sets ST ON C.SetId = ST.SetId
                    LEFT JOIN Years Y ON C.YearId = Y.YearId
                    WHERE (@BID = 0 OR C.BoardId = @BID)
                      AND (@RTID = 0 OR C.ResourceTypeId = @RTID)
                      AND (@SID = 0 OR C.SubjectId = @SID)
                      AND (@SCID = 0 OR C.SubCategoryId = @SCID)
                      AND (@YID = 0 OR C.YearId = @YID)
                    ORDER BY C.ChapterId DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);
                cmd.Parameters.AddWithValue("@SID", phSchool.Visible ? ddlSubject.SelectedValue : "0");
                cmd.Parameters.AddWithValue("@SCID", phCompetitive.Visible ? ddlSubCategory.SelectedValue : "0");
                cmd.Parameters.AddWithValue("@YID", ddlYear.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvChapters.DataSource = dt;
                gvChapters.DataBind();
            }
        }

        protected void gvChapters_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                if (e.CommandName == "ToggleActive")
                    new SqlCommand("UPDATE Chapters SET IsActive = ~IsActive WHERE ChapterId=" + id, con).ExecuteNonQuery();
                else if (e.CommandName == "DeleteMe")
                    new SqlCommand("DELETE FROM Chapters WHERE ChapterId=" + id, con).ExecuteNonQuery();
            }
            BindGrid();
        }

        private void FillDDL(string sql, DropDownList ddl, string t, string v, string def)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt; ddl.DataTextField = t; ddl.DataValueField = v; ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(def, "0"));
            }
        }

        private bool IsCompetitiveBoard(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=" + id, con);
                con.Open(); return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }
    }
}