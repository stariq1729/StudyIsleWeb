using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Sets
{
    public partial class ManageSets : System.Web.UI.Page
    {
        string cs =
            ConfigurationManager
            .ConnectionStrings["dbcs"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilters();
                BindGrid();
            }
        }

        private void LoadFilters()
        {
            FillDDL(
                "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1",
                ddlBoard,
                "BoardName",
                "BoardId",
                "All Boards");

            FillDDL(
                "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1",
                ddlResourceType,
                "TypeName",
                "ResourceTypeId",
                "All Types");

            FillDDL(
                "SELECT YearId, YearName FROM Years WHERE IsActive=1",
                ddlYear,
                "YearName",
                "YearId",
                "All Years");
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"
                    SELECT
                        S.*,
                        B.BoardName,
                        RT.TypeName,
                        C.ClassName,
                        SB.SubjectName,
                        SC.SubCategoryName,
                        CH.ChapterName,
                        Y.YearName
                    FROM Sets S

                    INNER JOIN Boards B
                        ON S.BoardId = B.BoardId

                    LEFT JOIN ResourceTypes RT
                        ON S.ResourceTypeId = RT.ResourceTypeId

                    LEFT JOIN Classes C
                        ON S.ClassId = C.ClassId

                    LEFT JOIN Subjects SB
                        ON S.SubjectId = SB.SubjectId

                    LEFT JOIN SubCategories SC
                        ON S.SubCategoryId = SC.SubCategoryId

                    LEFT JOIN Chapters CH
                        ON S.ChapterId = CH.ChapterId

                    LEFT JOIN Years Y
                        ON S.YearId = Y.YearId

                    WHERE
                        (@BID = 0 OR S.BoardId = @BID)
                    AND
                        (@RTID = 0 OR S.ResourceTypeId = @RTID)
                    AND
                        (@YID = 0 OR S.YearId = @YID)

                    ORDER BY S.SetId DESC";

                SqlCommand cmd =
                    new SqlCommand(sql, con);

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

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvSets.DataSource = dt;
                gvSets.DataBind();

                lblCount.Text =
                    "Total Sets: " + dt.Rows.Count;
            }
        }

        protected void gvSets_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            int id =
                Convert.ToInt32(
                    e.CommandArgument);

            using (SqlConnection con =
                new SqlConnection(cs))
            {
                con.Open();

                if (e.CommandName == "ToggleActive")
                {
                    string sql =
                        "UPDATE Sets SET IsActive = ~IsActive WHERE SetId=@ID";

                    SqlCommand cmd =
                        new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@ID", id);

                    cmd.ExecuteNonQuery();
                }

                else if (e.CommandName == "DeleteMe")
                {
                    string sql =
                        "DELETE FROM Sets WHERE SetId=@ID";

                    SqlCommand cmd =
                        new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@ID", id);

                    cmd.ExecuteNonQuery();
                }
            }

            BindGrid();
        }

        private void FillDDL(
            string sql,
            DropDownList ddl,
            string text,
            string value,
            string defaultText)
        {
            using (SqlConnection con =
                new SqlConnection(cs))
            {
                SqlDataAdapter da =
                    new SqlDataAdapter(sql, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();

                ddl.Items.Insert(
                    0,
                    new ListItem(defaultText, "0"));
            }
        }
    }
}