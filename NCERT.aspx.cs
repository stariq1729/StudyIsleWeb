using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace StudyIsleWeb
{
    public partial class NCERT : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResourceTypes();
            }
        }

        private void LoadResourceTypes()
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT ResourceTypeId, TypeName, Slug
                                 FROM ResourceTypes
                                 WHERE IsActive = 1
                                 ORDER BY DisplayOrder";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    rptResourceTypes.DataSource = reader;
                    rptResourceTypes.DataBind();
                }
            }
        }
    }
}