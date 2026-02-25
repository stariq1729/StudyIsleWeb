using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class ManageResources : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadResources();
        }

        private void LoadResources()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT r.ResourceId,
                       b.BoardName,
                       c.ClassName,
                       s.SubjectName,
                       ch.ChapterName,
                       y.YearName,
                       sc.SubCategoryName,
                       rt.TypeName,
                       r.Title,
                       r.IsPremium,
                       r.IsActive
                FROM Resources r
                INNER JOIN Boards b ON r.BoardId = b.BoardId
                LEFT JOIN Classes c ON r.ClassId = c.ClassId
                LEFT JOIN Subjects s ON r.SubjectId = s.SubjectId
                LEFT JOIN Chapters ch ON r.ChapterId = ch.ChapterId
                LEFT JOIN Years y ON r.YearId = y.YearId
                LEFT JOIN SubCategories sc ON r.SubCategoryId = sc.SubCategoryId
                INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                ORDER BY r.CreatedAt DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResources.DataSource = dt;
                gvResources.DataBind();
            }
        }

        protected void gvResources_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvResources.PageIndex = e.NewPageIndex;
            LoadResources();
        }

        protected void gvResources_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Toggle")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "UPDATE Resources SET IsActive = ~IsActive WHERE ResourceId=@Id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadResources();
            }

            if (e.CommandName == "EditItem")
            {
                Response.Redirect("EditResource.aspx?id=" + id);
            }
        }
    }
}