using System;
using System.Configuration;
using System.Data.SqlClient;

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

        private void LoadResources()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
    SELECT r.ResourceId,
           b.BoardName,
           c.ClassName,
           s.SubjectName,
           rt.TypeName,
           r.Title,
           r.IsActive
    FROM Resources r
    INNER JOIN Boards b ON r.BoardId = b.BoardId
    LEFT JOIN Classes c ON r.ClassId = c.ClassId
    INNER JOIN Subjects s ON r.SubjectId = s.SubjectId
    INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
    ORDER BY r.CreatedAt DESC";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    gvResources.DataSource = cmd.ExecuteReader();
                    gvResources.DataBind();
                }
            }
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
