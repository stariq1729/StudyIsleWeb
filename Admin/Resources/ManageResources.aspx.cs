using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class ManageResources : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResources();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvResources.PageIndex = 0;
            LoadResources(txtSearch.Text.Trim());
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            gvResources.PageIndex = 0;
            LoadResources();
        }
        private void LoadResources(string keyword = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
            SELECT 
                r.ResourceId,
                b.BoardName,
                c.ClassName,
                s.SubjectName,
                rt.TypeName,
                r.Title,
                r.IsPremium,
                r.IsActive,
                r.DownloadCount,
                r.FilePath
            FROM Resources r
            INNER JOIN Boards b 
                ON r.BoardId = b.BoardId
            LEFT JOIN Classes c 
                ON r.ClassId = c.ClassId
            INNER JOIN Subjects s 
                ON r.SubjectId = s.SubjectId
            INNER JOIN ResourceTypes rt 
                ON r.ResourceTypeId = rt.ResourceTypeId
            WHERE 
                (@Keyword = '' OR 
                 r.Title LIKE '%' + @Keyword + '%' OR
                 b.BoardName LIKE '%' + @Keyword + '%' OR
                 s.SubjectName LIKE '%' + @Keyword + '%')
            ORDER BY r.CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Keyword", keyword);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvResources.DataSource = dt;
                        gvResources.DataBind();
                    }
                }
            }
        }
        protected void gvResources_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvResources.PageIndex = e.NewPageIndex;
            LoadResources(txtSearch.Text.Trim());
        }

        protected void gvResources_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "UPDATE Resources SET IsActive = ~IsActive WHERE ResourceId=@Id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadResources();
            }

            if (e.CommandName == "EditResource")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                Response.Redirect("EditResource.aspx?id=" + id);
            }
        }
    }
}
