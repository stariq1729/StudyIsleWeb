using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class GalleryDetails : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGalleryDetails();
            }
        }

        private void LoadGalleryDetails()
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("Gallery.aspx");
                return;
            }

            int galleryId;

            if (!int.TryParse(Request.QueryString["id"], out galleryId))
            {
                Response.Redirect("Gallery.aspx");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT *
                    FROM Gallery
                    WHERE GalleryId = @GalleryId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@GalleryId", galleryId);

                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        imgGallery.ImageUrl =
                            reader["ImagePath"].ToString();

                        litTitle.Text =
                            reader["Title"].ToString();

                        litDescription.Text =
                            reader["Description"].ToString();

                        litDate.Text =
                            Convert.ToDateTime(reader["CreatedDate"])
                            .ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        Response.Redirect("Gallery.aspx");
                    }
                }
            }
        }
    }
}