using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class NcertBook : System.Web.UI.Page
    {
        protected int SelectedClassId = 0;

        private int NCERTBoardId = 5;          // Confirmed
        private int BooksResourceTypeId = 6;   // Correct from your DB

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetDefaultClass();
                LoadClasses();
                LoadSubjects();
            }
        }

        private void SetDefaultClass()
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString))
            {
                string query = @"SELECT ClassId 
                                 FROM Classes
                                 WHERE BoardId = @BoardId 
                                 AND ClassName = 'Class 12'";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", NCERTBoardId);

                con.Open();
                SelectedClassId = Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private void LoadClasses()
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString))
            {
                string query = @"SELECT ClassId, ClassName 
                                 FROM Classes
                                 WHERE BoardId = @BoardId AND IsActive = 1
                                 ORDER BY ClassId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", NCERTBoardId);

                con.Open();
                rptClasses.DataSource = cmd.ExecuteReader();
                rptClasses.DataBind();
            }
        }

        private void LoadSubjects()
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString))
            {
                string query = @"SELECT SubjectId, SubjectName
                                 FROM Subjects
                                 WHERE BoardId = @BoardId
                                 AND ClassId = @ClassId
                                 AND IsActive = 1
                                 ORDER BY SubjectName";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", NCERTBoardId);
                cmd.Parameters.AddWithValue("@ClassId", SelectedClassId);

                con.Open();
                rptSubjects.DataSource = cmd.ExecuteReader();
                rptSubjects.DataBind();
            }
        }

        protected void rptSubjects_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
                e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int subjectId = Convert.ToInt32(
                    DataBinder.Eval(e.Item.DataItem, "SubjectId"));

                Repeater rptBooks = (Repeater)e.Item.FindControl("rptBooks");
                LoadBooks(rptBooks, subjectId);
            }
        }

        private void LoadBooks(Repeater rptBooks, int subjectId)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString))
            {
                string query = @"SELECT Title, ThumbnailPath
                                 FROM Resources
                                 WHERE BoardId = @BoardId
                                 AND ClassId = @ClassId
                                 AND SubjectId = @SubjectId
                                 AND ResourceTypeId = @ResourceTypeId
                                 AND IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", NCERTBoardId);
                cmd.Parameters.AddWithValue("@ClassId", SelectedClassId);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);
                cmd.Parameters.AddWithValue("@ResourceTypeId", BooksResourceTypeId);

                con.Open();
                rptBooks.DataSource = cmd.ExecuteReader();
                rptBooks.DataBind();
            }
        }

        protected void Class_Command(object sender, CommandEventArgs e)
        {
            SelectedClassId = Convert.ToInt32(e.CommandArgument);
            LoadClasses();
            LoadSubjects();
        }
    }
}