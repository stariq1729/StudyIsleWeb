using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class Gallery : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHeroGallery();
                LoadGalleryFeed();
            }
        }

        private void LoadHeroGallery()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT TOP 1 *
                    FROM Gallery
                    ORDER BY CreatedDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptHeroGallery.DataSource = dt;
                        rptHeroGallery.DataBind();
                    }
                }
            }
        }
        private void LoadGalleryFeed()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT *
            FROM Gallery
            WHERE GalleryId NOT IN
            (
                SELECT TOP 1 GalleryId
                FROM Gallery
                ORDER BY CreatedDate DESC
            )
            ORDER BY CreatedDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptGalleryFeed.DataSource = dt;
                        rptGalleryFeed.DataBind();
                    }
                }
            }
        }
    }
}