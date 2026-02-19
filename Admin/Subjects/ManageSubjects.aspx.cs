using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class ManageSubjects : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSubjects();
            }
        }

        private void LoadSubjects()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT s.SubjectId,
                                        b.BoardName,
                                        c.ClassName,
                                        s.SubjectName,
                                        s.IsActive
                                 FROM Subjects s
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 LEFT JOIN Classes c ON s.ClassId = c.ClassId";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSubjects.DataSource = dt;
                gvSubjects.DataBind();
            }
        }

        protected void gvSubjects_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int subjectId = Convert.ToInt32(e.CommandArgument);
                ToggleSubjectStatus(subjectId);
                LoadSubjects();
            }
        }

        private void ToggleSubjectStatus(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "UPDATE Subjects SET IsActive = ~IsActive WHERE SubjectId=@SubjectId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);

                cmd.ExecuteNonQuery();
            }
        }
    }
}
