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
                BindBoards();
                BindGrid();
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards ORDER BY BoardName", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoardFilter.DataSource = dt;
                ddlBoardFilter.DataTextField = "BoardName";
                ddlBoardFilter.DataValueField = "BoardId";
                ddlBoardFilter.DataBind();
                ddlBoardFilter.Items.Insert(0, new ListItem("-- All Boards --", "0"));
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // LEFT JOIN is crucial here: it ensures subjects show up even if ClassId is NULL
                string query = @"SELECT s.*, b.BoardName, ISNULL(c.ClassName, '') as ClassName 
                                FROM Subjects s 
                                INNER JOIN Boards b ON s.BoardId = b.BoardId 
                                LEFT JOIN Classes c ON s.ClassId = c.ClassId 
                                WHERE 1=1";

                if (ddlBoardFilter.SelectedValue != "0")
                {
                    query += " AND s.BoardId = @BoardId";
                }

                query += " ORDER BY b.BoardName, c.DisplayOrder, s.SubjectName";

                SqlCommand cmd = new SqlCommand(query, con);
                if (ddlBoardFilter.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoardFilter.SelectedValue);
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvSubjects.DataSource = dt;
                gvSubjects.DataBind();
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlBoardFilter.SelectedIndex = 0;
            BindGrid();
        }

        protected void gvSubjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int subjectId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Subjects SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END WHERE SubjectId=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", subjectId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindGrid();
            }
        }

        protected void gvSubjects_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int subjectId = (int)gvSubjects.DataKeys[e.RowIndex].Value;
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Note: Consider Cascading Deletes in DB or handle linked chapters here
                SqlCommand cmd = new SqlCommand("DELETE FROM Subjects WHERE SubjectId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", subjectId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}