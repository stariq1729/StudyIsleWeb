using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class ManageChapters : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInitialFilters();
                BindGrid();
            }
        }

        // =========================================================
        // INITIAL LOAD
        // =========================================================

        private void LoadInitialFilters()
        {
            FillDDL(
                "SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1 ORDER BY BoardName",
                ddlBoard,
                "BoardName",
                "BoardId",
                "-- Select Board --");

            FillDDL(
                "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive = 1 ORDER BY TypeName",
                ddlResourceType,
                "TypeName",
                "ResourceTypeId",
                "-- Select Resource Type --");

            ResetDDL(ddlClass, "-- Select Class --");
            ResetDDL(ddlSubject, "-- Select Subject --");
            ResetDDL(ddlSubCategory, "-- Select Sub-Category --");
        }

        // =========================================================
        // BOARD CHANGED
        // =========================================================

        protected void ddlBoard_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            ResetDDL(ddlClass, "-- Select Class --");
            ResetDDL(ddlSubject, "-- Select Subject --");
            ResetDDL(ddlSubCategory, "-- Select Sub-Category --");

            phSchool.Visible = false;
            phCompetitive.Visible = false;

            if (ddlBoard.SelectedValue == "0")
            {
                BindGrid();
                return;
            }

            bool isCompetitive =
                IsCompetitiveBoard(
                    Convert.ToInt32(ddlBoard.SelectedValue));

            phCompetitive.Visible = isCompetitive;
            phSchool.Visible = !isCompetitive;

            if (isCompetitive)
            {
                FillDDL(
                    "SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId = " +
                    ddlBoard.SelectedValue +
                    " AND IsActive = 1 ORDER BY SubCategoryName",

                    ddlSubCategory,
                    "SubCategoryName",
                    "SubCategoryId",
                    "-- All Sub-Categories --");
            }
            else
            {
                FillDDL(
                    "SELECT ClassId, ClassName FROM Classes WHERE BoardId = " +
                    ddlBoard.SelectedValue +
                    " AND IsActive = 1 ORDER BY DisplayOrder",

                    ddlClass,
                    "ClassName",
                    "ClassId",
                    "-- All Classes --");
            }

            BindGrid();
        }

        // =========================================================
        // CLASS CHANGED
        // =========================================================

        protected void ddlClass_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            ResetDDL(ddlSubject, "-- Select Subject --");

            if (ddlClass.SelectedValue != "0")
            {
                FillDDL(
                    "SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId = " +
                    ddlClass.SelectedValue +
                    " AND IsActive = 1 ORDER BY SubjectName",

                    ddlSubject,
                    "SubjectName",
                    "SubjectId",
                    "-- All Subjects --");
            }

            BindGrid();
        }

        // =========================================================
        // COMMON FILTER
        // =========================================================

        protected void FilterChanged(
            object sender,
            EventArgs e)
        {
            BindGrid();
        }

        // =========================================================
        // MAIN GRID
        // =========================================================

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"
                    SELECT
                        C.ChapterId,
                        C.ChapterName,
                        C.IsActive,
                        C.DisplayOrder,

                        B.BoardName,

                        RT.TypeName,

                        COALESCE(
                            S.SubjectName,
                            SC.SubCategoryName,
                            CL.ClassName,
                            'General'
                        ) AS HierarchyPath

                    FROM Chapters C

                    INNER JOIN Boards B
                        ON C.BoardId = B.BoardId

                    LEFT JOIN ResourceTypes RT
                        ON C.ResourceTypeId = RT.ResourceTypeId

                    LEFT JOIN Subjects S
                        ON C.SubjectId = S.SubjectId

                    LEFT JOIN SubCategories SC
                        ON C.SubCategoryId = SC.SubCategoryId

                    LEFT JOIN Classes CL
                        ON C.ClassId = CL.ClassId

                    WHERE
                        (@BID = 0 OR C.BoardId = @BID)
                        AND
                        (@RTID = 0 OR C.ResourceTypeId = @RTID)
                        AND
                        (@SID = 0 OR C.SubjectId = @SID)
                        AND
                        (@SCID = 0 OR C.SubCategoryId = @SCID)

                    ORDER BY
                        C.DisplayOrder ASC,
                        C.ChapterId DESC";

                SqlCommand cmd =
                    new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue(
                    "@BID",
                    ddlBoard.SelectedValue);

                cmd.Parameters.AddWithValue(
                    "@RTID",
                    ddlResourceType.SelectedValue);

                cmd.Parameters.AddWithValue(
                    "@SID",
                    phSchool.Visible
                    ? ddlSubject.SelectedValue
                    : "0");

                cmd.Parameters.AddWithValue(
                    "@SCID",
                    phCompetitive.Visible
                    ? ddlSubCategory.SelectedValue
                    : "0");

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvChapters.DataSource = dt;
                gvChapters.DataBind();
            }
        }

        // =========================================================
        // GRID COMMANDS
        // =========================================================

        protected void gvChapters_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            int id =
                Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                if (e.CommandName == "ToggleActive")
                {
                    string query = @"
                        UPDATE Chapters
                        SET IsActive =
                            CASE
                                WHEN IsActive = 1 THEN 0
                                ELSE 1
                            END
                        WHERE ChapterId = @ID";

                    SqlCommand cmd =
                        new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@ID", id);

                    cmd.ExecuteNonQuery();
                }

                else if (e.CommandName == "DeleteMe")
                {
                    SqlCommand cmd =
                        new SqlCommand(
                            "DELETE FROM Chapters WHERE ChapterId = @ID",
                            con);

                    cmd.Parameters.AddWithValue("@ID", id);

                    cmd.ExecuteNonQuery();
                }
            }

            BindGrid();
        }

        // =========================================================
        // COMMON DDL METHOD
        // =========================================================

        private void FillDDL(
            string sql,
            DropDownList ddl,
            string textField,
            string valueField,
            string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da =
                    new SqlDataAdapter(sql, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddl.DataSource = dt;
                ddl.DataTextField = textField;
                ddl.DataValueField = valueField;
                ddl.DataBind();

                ddl.Items.Insert(
                    0,
                    new ListItem(defaultText, "0"));
            }
        }

        // =========================================================
        // RESET DDL
        // =========================================================

        private void ResetDDL(
            DropDownList ddl,
            string defaultText)
        {
            ddl.Items.Clear();

            ddl.Items.Insert(
                0,
                new ListItem(defaultText, "0"));
        }

        // =========================================================
        // BOARD TYPE CHECK
        // =========================================================

        private bool IsCompetitiveBoard(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId = @ID",
                        con);

                cmd.Parameters.AddWithValue(
                    "@ID",
                    boardId);

                con.Open();

                return Convert.ToBoolean(
                    cmd.ExecuteScalar());
            }
        }
    }
}