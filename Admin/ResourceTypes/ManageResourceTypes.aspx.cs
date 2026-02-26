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

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadResourceTypes();
        }

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added IconImage to SELECT
                string query = @"SELECT * FROM ResourceTypes WHERE 1=1";

                // Apply Filters
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    query += " AND (TypeName LIKE @Search OR Slug LIKE @Search)";
                }

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                {
                    query += " AND IsActive = @Status";
                }

                query += " ORDER BY DisplayOrder ASC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                        cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");

                    if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvResourceTypes.DataSource = dt;
                    gvResourceTypes.DataBind();
                }
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
                                     SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END 
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