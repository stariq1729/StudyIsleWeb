using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin
{
    public partial class ManageGallery : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGallery();
            }
        }

        private void LoadGallery()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT *
                    FROM Gallery
                    ORDER BY CreatedDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptGallery.DataSource = dt;
                        rptGallery.DataBind();

                        pnlEmpty.Visible = dt.Rows.Count == 0;
                    }
                }
            }
        }

        protected void rptGallery_ItemCommand(object source,
            RepeaterCommandEventArgs e)
        {
            int galleryId =
                Convert.ToInt32(e.CommandArgument);

            // EDIT

            if (e.CommandName == "EditGallery")
            {
                Response.Redirect(
                    "AddGallery.aspx?id=" + galleryId);
            }

            // TOGGLE STATUS

            else if (e.CommandName == "ToggleStatus")
            {
                ToggleGalleryStatus(galleryId);
            }

            // DELETE

            else if (e.CommandName == "DeleteGallery")
            {
                DeleteGallery(galleryId);
            }
        }

        private void ToggleGalleryStatus(int galleryId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    UPDATE Gallery
                    SET IsActive =
                        CASE
                            WHEN IsActive = 1 THEN 0
                            ELSE 1
                        END
                    WHERE GalleryId = @GalleryId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@GalleryId", galleryId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadGallery();
        }

        private void DeleteGallery(int galleryId)
        {
            string imagePath = "";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // GET IMAGE PATH

                string getImageQuery = @"
                    SELECT ImagePath
                    FROM Gallery
                    WHERE GalleryId = @GalleryId";

                using (SqlCommand cmd =
                    new SqlCommand(getImageQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@GalleryId", galleryId);

                    conn.Open();

                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        imagePath = result.ToString();
                    }

                    conn.Close();
                }

                // DELETE DATABASE RECORD

                string deleteQuery = @"
                    DELETE FROM Gallery
                    WHERE GalleryId = @GalleryId";

                using (SqlCommand cmd =
                    new SqlCommand(deleteQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@GalleryId", galleryId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // DELETE IMAGE FILE

            if (!string.IsNullOrEmpty(imagePath))
            {
                string fullPath =
                    Server.MapPath(imagePath);

                if (File.Exists(fullPath))
                {
                    File.Delete(fullPath);
                }
            }

            LoadGallery();
        }
    }
}