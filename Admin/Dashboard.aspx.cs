using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardCounts();
            }
        }

        private void LoadDashboardCounts()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                litBoards.Text = GetCount(con, "Boards").ToString();
                litClasses.Text = GetCount(con, "Classes").ToString();
                litSubjects.Text = GetCount(con, "Subjects").ToString();
                litResources.Text = GetCount(con, "Resources").ToString();
                LitUsers.Text = GetCount(con, "Users").ToString();
            }
        }

        private int GetCount(SqlConnection con, string tableName)
        {
            string query = $"SELECT COUNT(*) FROM {tableName}";
            SqlCommand cmd = new SqlCommand(query, con);
            return (int)cmd.ExecuteScalar();
        }
    }
}
