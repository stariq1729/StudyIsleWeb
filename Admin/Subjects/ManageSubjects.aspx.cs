using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class ManageSubjects : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadSubjects();
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName ASC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoardFilter.DataSource = dt;
                ddlBoardFilter.DataTextField = "BoardName";
                ddlBoardFilter.DataValueField = "BoardId";
                ddlBoardFilter.DataBind();
                ddlBoardFilter.Items.Insert(0, new ListItem("-- All Boards --", "0"));
            }
        }

        private void LoadSubjects()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Joins with Boards and Classes to get full context
                string query = @"SELECT s.*, b.BoardName, c.ClassName 
                                 FROM Subjects s
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 LEFT JOIN Classes c ON s.ClassId = c.ClassId";

                if (ddlBoardFilter.SelectedValue != "0")
                {
                    query += " WHERE s.BoardId = @BoardId";
                }

                query += " ORDER BY b.BoardName, c.DisplayOrder, s.SubjectName";

                SqlCommand cmd = new SqlCommand(query, con);
                if (ddlBoardFilter.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoardFilter.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSubjects.DataSource = dt;
                gvSubjects.DataBind();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            LoadSubjects();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlBoardFilter.SelectedIndex = 0;
            LoadSubjects();
        }

        protected void gvSubjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int sid = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "UPDATE Subjects SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE SubjectId = @id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", sid);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadSubjects();
            }
        }

        protected void gvSubjects_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int sid = Convert.ToInt32(gvSubjects.DataKeys[e.RowIndex].Value);
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Note: In production, consider checking for child records (Chapters/Content) before deleting
                    SqlCommand cmd = new SqlCommand("DELETE FROM Subjects WHERE SubjectId = @id", con);
                    cmd.Parameters.AddWithValue("@id", sid);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                lblMessage.Text = "Subject deleted successfully.";
                lblMessage.CssClass = "text-success d-block mb-3";
                LoadSubjects();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: Cannot delete subject. It might have associated data.";
                lblMessage.CssClass = "text-danger d-block mb-3";
            }
        }
    }
}