using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Quiz
{
    public partial class ManageQuiz : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBoards();
                BindResourceTypes();
                BindGrid();
            }
        }

        private void BindBoards()
        {
            BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1",
                ddlBoard, "BoardName", "BoardId", "-- All Boards --");
        }

        private void BindResourceTypes()
        {
            BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes",
                ddlResourceType, "TypeName", "ResourceTypeId", "-- All Types --");
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedValue != "0")
            {
                BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={ddlBoard.SelectedValue}",
                    ddlClass, "ClassName", "ClassId", "-- All Classes --");
            }
            BindGrid();
        }

        protected void ddlFilterChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT q.QuizId, b.BoardName, rt.TypeName,
                           c.ClassName, s.SubjectName, ch.ChapterName,
                           q.QuizLabel, q.TotalQuestions, q.TimeLimitMinutes,
                           q.Difficulty, q.IsActive
                    FROM Quiz q
                    INNER JOIN Chapters ch ON q.ChapterId = ch.ChapterId
                    INNER JOIN Boards b ON ch.BoardId = b.BoardId
                    LEFT JOIN ResourceTypes rt ON ch.ResourceTypeId = rt.ResourceTypeId
                    LEFT JOIN Classes c ON ch.ClassId = c.ClassId
                    LEFT JOIN Subjects s ON ch.SubjectId = s.SubjectId
                    WHERE 1=1";

                if (ddlBoard.SelectedValue != "0")
                    query += " AND b.BoardId = @BoardId";

                if (ddlResourceType.SelectedValue != "0")
                    query += " AND rt.ResourceTypeId = @TypeId";

                if (ddlClass.SelectedValue != "0")
                    query += " AND c.ClassId = @ClassId";

                if (ddlSubject.SelectedValue != "0")
                    query += " AND s.SubjectId = @SubjectId";

                SqlCommand cmd = new SqlCommand(query, con);

                if (ddlBoard.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);

                if (ddlResourceType.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@TypeId", ddlResourceType.SelectedValue);

                if (ddlClass.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@ClassId", ddlClass.SelectedValue);

                if (ddlSubject.SelectedValue != "0")
                    cmd.Parameters.AddWithValue("@SubjectId", ddlSubject.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvQuiz.DataSource = dt;
                gvQuiz.DataBind();
            }
        }

        private void BindDDL(string query, System.Web.UI.WebControls.DropDownList ddl,
            string textField, string valueField, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddl.DataSource = dt;
                ddl.DataTextField = textField;
                ddl.DataValueField = valueField;
                ddl.DataBind();

                ddl.Items.Insert(0, new System.Web.UI.WebControls.ListItem(defaultText, "0"));
            }
        }

        protected void gvQuiz_RowCommand(object sender,
            System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            // Reserved for future delete/toggle features
        }
    }
}