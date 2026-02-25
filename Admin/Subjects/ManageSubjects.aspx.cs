using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class ManageSubjects : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadClasses(0);
                LoadSubjects();
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoardFilter.DataSource = dt;
                ddlBoardFilter.DataTextField = "BoardName";
                ddlBoardFilter.DataValueField = "BoardId";
                ddlBoardFilter.DataBind();

                ddlBoardFilter.Items.Insert(0,
                    new ListItem("-- All Boards --", "0"));
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ClassId, ClassName FROM Classes";

                if (boardId > 0)
                    query += " WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);

                if (boardId > 0)
                    cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClassFilter.DataSource = dt;
                ddlClassFilter.DataTextField = "ClassName";
                ddlClassFilter.DataValueField = "ClassId";
                ddlClassFilter.DataBind();

                ddlClassFilter.Items.Insert(0,
                    new ListItem("-- All Classes --", "0"));
            }
        }

        private void LoadSubjects()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT s.SubjectId,
                                        b.BoardName,
                                        ISNULL(c.ClassName, 'No Class') AS ClassName,
                                        s.SubjectName,
                                        s.Slug,
                                        s.IsActive
                                 FROM Subjects s
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 LEFT JOIN Classes c ON s.ClassId = c.ClassId
                                 WHERE 1=1";

                if (ddlBoardFilter.SelectedValue != "0")
                    query += " AND s.BoardId=@BoardId";

                if (ddlClassFilter.SelectedValue != "0")
                    query += " AND s.ClassId=@ClassId";

                query += " ORDER BY s.SubjectName";

                SqlCommand cmd = new SqlCommand(query, con);

                if (ddlBoardFilter.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@BoardId",
                        ddlBoardFilter.SelectedValue);

                if (ddlClassFilter.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@ClassId",
                        ddlClassFilter.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSubjects.DataSource = dt;
                gvSubjects.DataBind();
            }
        }

        protected void ddlBoardFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoardFilter.SelectedValue);
            LoadClasses(boardId);
            LoadSubjects();
        }

        protected void ddlClassFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSubjects();
        }

        protected void gvSubjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"UPDATE Subjects
                          SET IsActive =
                          CASE WHEN IsActive=1 THEN 0 ELSE 1 END
                          WHERE SubjectId=@Id", con);

                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadSubjects();
            }
        }
    }
}