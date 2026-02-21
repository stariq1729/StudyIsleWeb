using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Routing;

namespace StudyIsleWeb
{
    public partial class BoardResource : System.Web.UI.Page
    {
        protected string ResourceTypeSlug = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetRouteData();
            }
        }

        private void GetRouteData()
        {
            ResourceTypeSlug = Page.RouteData.Values["resourcetype"]?.ToString();

            if (string.IsNullOrEmpty(ResourceTypeSlug))
            {
                Response.Redirect("~/NCERT.aspx");
                return;
            }

            ValidateAndSetHeading(ResourceTypeSlug);
        }

        private void ValidateAndSetHeading(string slug)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT TypeName 
                                 FROM ResourceTypes
                                 WHERE Slug = @Slug AND IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);

                con.Open();

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    lblHeading.InnerText = "NCERT " + result.ToString();
                }
                else
                {
                    Response.Redirect("~/NCERT.aspx");
                }
            }
        }
    }
}