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
                string boardSlug = Request.QueryString["board"];
                string classSlug = Request.QueryString["class"];
                string resSlug = Request.QueryString["res"] ?? "cbse"; // Default to cbse if null

                if (string.IsNullOrEmpty(boardSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // If no class selected, we don't hardcode "class-12" yet, 
                // we'll handle it after binding the available classes.
                BindClasses(boardSlug, resSlug);

                // Re-check classSlug after BindClasses logic
                if (string.IsNullOrEmpty(classSlug)) classSlug = "class-12";

                BindPageContent(boardSlug, classSlug);
                BindSubjectsAndResources(boardSlug, classSlug, resSlug);
            }
        }

        private void BindClasses(string boardSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Only show classes that HAVE resources for this board and resource type
                string query = @"SELECT DISTINCT c.ClassName, c.Slug, c.DisplayOrder 
                                 FROM Classes c 
                                 INNER JOIN Boards b ON c.BoardId = b.BoardId 
                                 INNER JOIN Resources r ON r.ClassId = c.ClassId
                                 INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                                 WHERE b.Slug = @bSlug AND rt.Slug = @resSlug AND c.IsActive = 1 
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
                string query = @"SELECT c.PageTitle, c.PageSubtitle FROM Classes c 
                                 JOIN Boards b ON c.BoardId = b.BoardId 
                                 WHERE b.Slug = @bSlug AND c.Slug = @cSlug";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litPageTitle.Text = dr["PageTitle"].ToString();
                    litPageSubtitle.Text = dr["PageSubtitle"].ToString();
                }
                con.Close();
            }
        }

        private void BindSubjectsAndResources(string boardSlug, string classSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // ADDED 's.IconImage' to the SELECT list below
                string query = @"SELECT DISTINCT s.SubjectId, s.SubjectName, s.IconImage 
                         FROM Subjects s
                         INNER JOIN Classes c ON s.ClassId = c.ClassId
                         INNER JOIN Boards b ON s.BoardId = b.BoardId
                         INNER JOIN Resources r ON r.SubjectId = s.SubjectId
                         INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                         WHERE b.Slug = @bSlug 
                         AND c.Slug = @cSlug 
                         AND rt.Slug = @resSlug 
                         AND s.IsActive = 1 
                         AND r.IsActive = 1";

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

        //protected void rptSubjectGroups_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        int subjectId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "SubjectId"));
        //        string resSlug = Request.QueryString["res"] ?? "cbse";
        //        string classSlug = Request.QueryString["class"] ?? "class-12";

        //        Repeater rptResources = (Repeater)e.Item.FindControl("rptResources");

        //        using (SqlConnection con = new SqlConnection(cs))
        //        {
        //            // Filter individual resource cards by the current context
        //            string query = @"SELECT r.ResourceId, r.Title, s.SubjectName, s.IconImage 
        //                             FROM Resources r 
        //                             INNER JOIN Subjects s ON r.SubjectId = s.SubjectId
        //                             INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
        //                             INNER JOIN Classes c ON r.ClassId = c.ClassId
        //                             WHERE r.SubjectId = @sId AND rt.Slug = @resSlug AND c.Slug = @cSlug";

        //            SqlCommand cmd = new SqlCommand(query, con);
        //            cmd.Parameters.AddWithValue("@sId", subjectId);
        //            cmd.Parameters.AddWithValue("@resSlug", resSlug);
        //            cmd.Parameters.AddWithValue("@cSlug", classSlug);
        //            SqlDataAdapter da = new SqlDataAdapter(cmd);
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);

        //            rptResources.DataSource = dt;
        //            rptResources.DataBind();
        //        }
        //    }
        //}
    }
}