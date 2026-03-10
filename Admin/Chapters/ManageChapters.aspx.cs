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
            BindDDL("SELECT BoardId, BoardName FROM Boards", ddlBoardFilter, "BoardName", "BoardId", "All Boards");
            BindDDL("SELECT ClassId, ClassName FROM Classes", ddlClassFilter, "ClassName", "ClassId", "All Classes");
            BindDDL("SELECT YearId, YearName FROM Years", ddlYearFilter, "YearName", "YearId", "All Years");
            ddlSubjectFilter.Items.Insert(0, new ListItem("All Subjects", "0"));
            ddlSetFilter.Items.Insert(0, new ListItem("All Sets", "0"));
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            // If board changes, we could optionally reload subjects, but BindGrid handles the logic
            BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // The key logic: COALESCE handles showing ClassName or YearName in the same column
                string sql = @"
                    SELECT C.ChapterId, C.ChapterName, C.DisplayOrder, C.IsActive, 
                           B.BoardName, S.SubjectName, 
                           ISNULL(SetTable.SetName, 'No Set') as SetName,
                           COALESCE(Cl.ClassName, Y.YearName, 'N/A') as LevelName
                    FROM Chapters C
                    INNER JOIN Subjects S ON C.SubjectId = S.SubjectId
                    INNER JOIN Boards B ON S.BoardId = B.BoardId
                    LEFT JOIN Classes Cl ON S.ClassId = Cl.ClassId
                    LEFT JOIN Years Y ON C.YearId = Y.YearId
                    LEFT JOIN Sets SetTable ON C.SetId = SetTable.SetId
                    WHERE (@BID = 0 OR B.BoardId = @BID)
                      AND (@CID = 0 OR S.ClassId = @CID)
                      AND (@YID = 0 OR C.YearId = @YID)
                      AND (@SID = 0 OR S.SubjectId = @SID)
                      AND (@SetID = 0 OR C.SetId = @SetID)
                    ORDER BY B.BoardName, LevelName, C.DisplayOrder";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoardFilter.SelectedValue);
                cmd.Parameters.AddWithValue("@CID", ddlClassFilter.SelectedValue);
                cmd.Parameters.AddWithValue("@YID", ddlYearFilter.SelectedValue);
                cmd.Parameters.AddWithValue("@SID", ddlSubjectFilter.SelectedValue);
                cmd.Parameters.AddWithValue("@SetID", ddlSetFilter.SelectedValue);

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
                    SqlCommand cmd = new SqlCommand("UPDATE Chapters SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END WHERE ChapterId=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
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
                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }
    }
}