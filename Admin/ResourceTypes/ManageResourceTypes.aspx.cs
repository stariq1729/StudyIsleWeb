using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class ManageResourceTypes : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResourceTypes();
            }
        }

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT 
                                    ResourceTypeId,
                                    TypeName,
                                    Slug,
                                    IsPremium,
                                    IsActive,
                                    DisplayOrder,
                                    HasClass,
                                    HasSubject,
                                    HasChapter,
                                    HasYear,
                                    HasSubCategory
                                 FROM ResourceTypes
                                 ORDER BY DisplayOrder ASC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResourceTypes.DataSource = dt;
                gvResourceTypes.DataBind();
            }
        }

        protected void gvResourceTypes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE ResourceTypes
                                     SET IsActive =
                                     CASE WHEN IsActive = 1 THEN 0 ELSE 1 END
                                     WHERE ResourceTypeId = @Id";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadResourceTypes();
            }
        }
    }
}
