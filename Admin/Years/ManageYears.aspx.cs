using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Years
{
    public partial class ManageYears : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilters();
                BindGrid();
            }
        }

        // =====================================================
        // LOAD FILTERS
        // =====================================================

        private void LoadFilters()
        {
            // BOARDS

            BindDDL(
                "SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1 ORDER BY BoardName",
                ddlBoard,
                "BoardName",
                "BoardId",
                "-- All Boards --");

            // RESOURCE TYPES

            BindDDL(
                "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive = 1 ORDER BY TypeName",
                ddlResourceType,
                "TypeName",
                "ResourceTypeId",
                "-- All Resource Types --");

            // YEARS TABLE (NOT YearsMaster)

            BindDDL(
                "SELECT YearId, YearName FROM Years WHERE IsActive = 1 ORDER BY DisplayOrder",
                ddlYear,
                "YearName",
                "YearId",
                "-- All Years --");
        }

        // =====================================================
        // MAIN GRID
        // =====================================================

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

                    SELECT

                        YM.MappingId,
                        YM.IsActive,
                        YM.CreatedAt,

                        Y.YearName,

                        B.BoardName,

                        RT.TypeName,

                        C.ClassName,

                        S.SubjectName,

                        SC.SubCategoryName

                    FROM YearMappings YM

                    INNER JOIN Years Y
                        ON YM.YearId = Y.YearId

                    INNER JOIN Boards B
                        ON YM.BoardId = B.BoardId

                    LEFT JOIN ResourceTypes RT
                        ON YM.ResourceTypeId = RT.ResourceTypeId

                    LEFT JOIN Classes C
                        ON YM.ClassId = C.ClassId

                    LEFT JOIN Subjects S
                        ON YM.SubjectId = S.SubjectId

                    LEFT JOIN SubCategories SC
                        ON YM.SubCategoryId = SC.SubCategoryId

                    WHERE
                        (@BID = 0 OR YM.BoardId = @BID)

                    AND
                        (@RTID = 0 OR YM.ResourceTypeId = @RTID)

                    AND
                        (@YID = 0 OR YM.YearId = @YID)

                    ORDER BY
                        Y.DisplayOrder ASC,
                        YM.CreatedAt DESC";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@BID",
                    ddlBoard.SelectedValue);

                cmd.Parameters.AddWithValue(
                    "@RTID",
                    ddlResourceType.SelectedValue);

                cmd.Parameters.AddWithValue(
                    "@YID",
                    ddlYear.SelectedValue);

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                gvMappings.DataSource = dt;
                gvMappings.DataBind();
            }
        }

        // =====================================================
        // FILTER CHANGED
        // =====================================================

        protected void FilterChanged(
            object sender,
            EventArgs e)
        {
            BindGrid();
        }

        // =====================================================
        // GRID COMMANDS
        // =====================================================

        protected void gvMappings_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            int mappingId =
                Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // TOGGLE ACTIVE

                if (e.CommandName == "ToggleActive")
                {
                    string query = @"

                        UPDATE YearMappings

                        SET IsActive =
                            CASE
                                WHEN IsActive = 1 THEN 0
                                ELSE 1
                            END

                        WHERE MappingId = @ID";

                    SqlCommand cmd =
                        new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue(
                        "@ID",
                        mappingId);

                    cmd.ExecuteNonQuery();
                }

                // DELETE

                else if (e.CommandName == "DeleteMe")
                {
                    SqlCommand cmd =
                        new SqlCommand(
                            "DELETE FROM YearMappings WHERE MappingId = @ID",
                            con);

                    cmd.Parameters.AddWithValue(
                        "@ID",
                        mappingId);

                    cmd.ExecuteNonQuery();
                }
            }

            BindGrid();
        }

        // =====================================================
        // COMMON DDL BIND METHOD
        // =====================================================

        private void BindDDL(
            string query,
            DropDownList ddl,
            string textField,
            string valueField,
            string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da =
                    new SqlDataAdapter(query, con);

                DataTable dt =
                    new DataTable();

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
    }
}