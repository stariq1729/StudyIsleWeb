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
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Capture all context from the URL
                string boardSlug = Request.QueryString["board"];
                string classSlug = Request.QueryString["class"];
                string resSlug = Request.QueryString["res"]; // Captures "cbse", "solutions", or "pyq"

                if (string.IsNullOrEmpty(boardSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Default context if parameters are missing
                if (string.IsNullOrEmpty(resSlug)) resSlug = "cbse";
                if (string.IsNullOrEmpty(classSlug)) classSlug = "class-12";

                // 2. Pass the 'resSlug' to every method to ensure context-specific data
                BindClasses(boardSlug, resSlug);
                BindPageContent(boardSlug, classSlug);
                BindSubjectsAndResources(boardSlug, classSlug, resSlug);
            }
        }

        private void BindClasses(string boardSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // This query ensures Class Tabs ONLY appear if they have resources for the clicked card
                // Perfect for PYQs where only Class 10 & 12 should show.
                string query = @"SELECT DISTINCT c.ClassName, c.Slug, c.DisplayOrder 
                                 FROM Classes c 
                                 JOIN Boards b ON c.BoardId = b.BoardId 
                                 JOIN Resources r ON r.ClassId = c.ClassId
                                 JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                                 WHERE b.Slug = @bSlug 
                                 AND rt.Slug = @resSlug 
                                 AND c.IsActive = 1 
                                 ORDER BY c.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@resSlug", resSlug);

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
                    litPageTitle.Text = dr["PageTitle"] != DBNull.Value ? dr["PageTitle"].ToString() : "Board Resources";
                    litPageSubtitle.Text = dr["PageSubtitle"] != DBNull.Value ? dr["PageSubtitle"].ToString() : "Full digital access.";
                }
                con.Close();
            }
        }

        private void BindSubjectsAndResources(string boardSlug, string classSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // We filter the Subject groups so only Subjects belonging to the clicked ResourceType appear
                string query = @"SELECT DISTINCT s.SubjectId, s.SubjectName 
                                 FROM Subjects s
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 INNER JOIN Classes c ON s.ClassId = c.ClassId
                                 INNER JOIN Resources r ON r.SubjectId = s.SubjectId
                                 INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                                 WHERE b.Slug = @bSlug 
                                 AND c.Slug = @cSlug 
                                 AND rt.Slug = @resSlug 
                                 AND s.IsActive = 1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@bSlug", boardSlug);
                da.SelectCommand.Parameters.AddWithValue("@cSlug", classSlug);
                da.SelectCommand.Parameters.AddWithValue("@resSlug", resSlug);

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
                int subjectId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "SubjectId"));
                string resSlug = Request.QueryString["res"] ?? "cbse"; // Re-capture context for inner repeater

                Repeater rptResources = (Repeater)e.Item.FindControl("rptResources");

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // This query ensures that the cards INSIDE the group also match the clicked ResourceType
                    string query = @"SELECT r.ResourceId, r.Title, s.SubjectName, s.IconImage 
                                     FROM Resources r 
                                     INNER JOIN Subjects s ON r.SubjectId = s.SubjectId 
                                     INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                                     WHERE r.SubjectId = @sId 
                                     AND rt.Slug = @resSlug 
                                     AND r.IsActive = 1";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@sId", subjectId);
                    cmd.Parameters.AddWithValue("@resSlug", resSlug);

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