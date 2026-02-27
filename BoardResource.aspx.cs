using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class BoardResource : System.Web.UI.Page
    {
        // Use your connection string from web.config
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string boardSlug = Request.QueryString["board"];
                string classSlug = Request.QueryString["class"];

                // 1. Validation: If no board is provided in URL, redirect to home
                if (string.IsNullOrEmpty(boardSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // 2. Defaulting: If no class is in URL, default to 'class-12' per your requirement
                if (string.IsNullOrEmpty(classSlug))
                {
                    classSlug = "class-12";
                }

                BindClasses(boardSlug);
                BindPageContent(boardSlug, classSlug);
                BindSubjectsAndResources(boardSlug, classSlug);
            }
        }

        private void BindClasses(string boardSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added c.DisplayOrder to the SELECT list to fix the SQL error
                string query = @"SELECT DISTINCT c.ClassName, c.Slug, c.DisplayOrder 
                         FROM Classes c 
                         JOIN Boards b ON c.BoardId = b.BoardId 
                         WHERE b.Slug = @bSlug AND c.IsActive = 1 
                         ORDER BY c.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptClasses.DataSource = dt;
                rptClasses.DataBind();
            }
        }

        private void BindPageContent(string boardSlug, string classSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Fetch the Title and Subtitle specifically for the selected Class/Board
                string query = @"SELECT c.PageTitle, c.PageSubtitle 
                                 FROM Classes c 
                                 JOIN Boards b ON c.BoardId = b.BoardId 
                                 WHERE b.Slug = @bSlug AND c.Slug = @cSlug";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    // Update the Literals in the Header
                    litPageTitle.Text = dr["PageTitle"] != DBNull.Value ? dr["PageTitle"].ToString() : "Board Resources";
                    litPageSubtitle.Text = dr["PageSubtitle"] != DBNull.Value ? dr["PageSubtitle"].ToString() : "Full digital textbooks for all subjects.";
                }
                con.Close();
            }
        }

        private void BindSubjectsAndResources(string boardSlug, string classSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Ensured SubjectName is in both SELECT and ORDER BY
                string query = @"SELECT DISTINCT s.SubjectId, s.SubjectName 
                         FROM Subjects s
                         INNER JOIN Boards b ON s.BoardId = b.BoardId
                         INNER JOIN Classes c ON s.ClassId = c.ClassId
                         WHERE b.Slug = @bSlug AND c.Slug = @cSlug AND s.IsActive = 1
                         ORDER BY s.SubjectName ASC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@bSlug", boardSlug);
                da.SelectCommand.Parameters.AddWithValue("@cSlug", classSlug);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSubjectGroups.DataSource = dt;
                rptSubjectGroups.DataBind();
            }
        }

        protected void rptSubjectGroups_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Get the SubjectId from the current row of the Parent Repeater
                int subjectId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "SubjectId"));
                Repeater rptResources = (Repeater)e.Item.FindControl("rptResources");

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // JOIN Resources with Subjects to ensure 'IconImage' and 'SubjectName' are both available
                    // This prevents the 'Evaluation' error
                    string query = @"SELECT r.ResourceId, r.Title, s.SubjectName, s.IconImage 
                                     FROM Resources r 
                                     INNER JOIN Subjects s ON r.SubjectId = s.SubjectId 
                                     WHERE r.SubjectId = @sId AND r.IsActive = 1";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@sId", subjectId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptResources.DataSource = dt;
                    rptResources.DataBind();
                }
            }
        }
    }
}