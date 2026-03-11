using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class ViewResources : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindResources();
            }
        }

        private void BindResources()
        {
            // Get all possible routing IDs from the URL
            string sid = Request.QueryString["sid"];
            string res = Request.QueryString["res"];
            string yid = Request.QueryString["yid"];
            string setid = Request.QueryString["setid"];
            string cid = Request.QueryString["cid"];

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Notice the 'r.' prefix added to Title, Description, and CreatedAt
                string sql = @"SELECT 
                        r.Title, 
                        r.Description, 
                        r.FilePath, 
                        r.ContentType, 
                        r.CreatedAt 
                       FROM Resources r 
                       INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
                       WHERE r.IsActive = 1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // Path filtering logic
                if (!string.IsNullOrEmpty(cid))
                {
                    sql += " AND r.ChapterId = @cid";
                    cmd.Parameters.AddWithValue("@cid", cid);
                }
                else if (!string.IsNullOrEmpty(setid))
                {
                    sql += " AND r.SetId = @setid AND r.SubjectId = @sid AND r.YearId = @yid";
                    cmd.Parameters.AddWithValue("@setid", setid);
                    cmd.Parameters.AddWithValue("@sid", sid);
                    cmd.Parameters.AddWithValue("@yid", yid);
                }
                else if (!string.IsNullOrEmpty(sid))
                {
                    sql += " AND r.SubjectId = @sid AND rt.Slug = @res";
                    cmd.Parameters.AddWithValue("@sid", sid);
                    cmd.Parameters.AddWithValue("@res", res);
                }

                cmd.CommandText = sql;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt); // This should now work without the red error!

                if (dt.Rows.Count > 0)
                {
                    rptResources.DataSource = dt;
                    rptResources.DataBind();
                }
                else
                {
                    phNoData.Visible = true;
                }
            }
        }

        // Logic to show different icons for PDF vs Flashcards/Mindmaps (Images)
        protected string GetStatusClass(string type)
        {
            if (type.Contains("pdf")) return "bg-pdf";
            if (type.Contains("image")) return "bg-image";
            return "bg-default";
        }

        protected string GetIcon(string type)
        {
            if (type.Contains("pdf")) return "fas fa-file-pdf";
            if (type.Contains("image")) return "fas fa-file-image";
            return "fas fa-file-alt";
        }
    }
}