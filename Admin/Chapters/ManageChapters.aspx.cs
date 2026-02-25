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
                LoadBoards();
                LoadClasses(0);
                LoadSubjects(0, 0);
                LoadChapters();
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

        private void LoadSubjects(int boardId, int classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT SubjectId, SubjectName FROM Subjects WHERE 1=1";

                if (boardId > 0)
                    query += " AND BoardId=@BoardId";

                if (classId > 0)
                    query += " AND ClassId=@ClassId";

                SqlCommand cmd = new SqlCommand(query, con);

                if (boardId > 0)
                    cmd.Parameters.AddWithValue("@BoardId", boardId);

                if (classId > 0)
                    cmd.Parameters.AddWithValue("@ClassId", classId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubjectFilter.DataSource = dt;
                ddlSubjectFilter.DataTextField = "SubjectName";
                ddlSubjectFilter.DataValueField = "SubjectId";
                ddlSubjectFilter.DataBind();

                ddlSubjectFilter.Items.Insert(0,
                    new ListItem("-- All Subjects --", "0"));
            }
        }

        private void LoadChapters()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT ch.ChapterId,
                           b.BoardName,
                           ISNULL(c.ClassName, 'No Class') AS ClassName,
                           s.SubjectName,
                           ch.ChapterName,
                           ch.DisplayOrder,
                           ch.IsActive
                    FROM Chapters ch
                    INNER JOIN Subjects s ON ch.SubjectId = s.SubjectId
                    INNER JOIN Boards b ON s.BoardId = b.BoardId
                    LEFT JOIN Classes c ON s.ClassId = c.ClassId
                    WHERE 1=1";

                if (ddlBoardFilter.SelectedValue != "0")
                    query += " AND b.BoardId=@BoardId";

                if (ddlClassFilter.SelectedValue != "0")
                    query += " AND c.ClassId=@ClassId";

                if (ddlSubjectFilter.SelectedValue != "0")
                    query += " AND s.SubjectId=@SubjectId";

                query += " ORDER BY ch.DisplayOrder";

                SqlCommand cmd = new SqlCommand(query, con);

                if (ddlBoardFilter.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoardFilter.SelectedValue);

                if (ddlClassFilter.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@ClassId", ddlClassFilter.SelectedValue);

                if (ddlSubjectFilter.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@SubjectId", ddlSubjectFilter.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvChapters.DataSource = dt;
                gvChapters.DataBind();
            }
        }

        protected void ddlBoardFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoardFilter.SelectedValue);
            LoadClasses(boardId);
            LoadSubjects(boardId, 0);
            LoadChapters();
        }

        protected void ddlClassFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoardFilter.SelectedValue);
            int classId = Convert.ToInt32(ddlClassFilter.SelectedValue);
            LoadSubjects(boardId, classId);
            LoadChapters();
        }

        protected void ddlSubjectFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChapters();
        }

        protected void gvChapters_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"UPDATE Chapters
                          SET IsActive =
                          CASE WHEN IsActive=1 THEN 0 ELSE 1 END
                          WHERE ChapterId=@Id", con);

                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadChapters();
            }
        }
    }
}