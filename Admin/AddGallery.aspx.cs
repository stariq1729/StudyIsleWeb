using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace StudyIsleWeb.Admin
{
    public partial class AddGallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            try
            {
                // VALIDATION

                if (string.IsNullOrWhiteSpace(txtTitle.Text))
                {
                    ShowMessage("Please enter title.", false);
                    return;
                }

                if (!fuGalleryImage.HasFile)
                {
                    ShowMessage("Please select image.", false);
                    return;
                }

                // IMAGE EXTENSION CHECK

                string extension = Path.GetExtension(fuGalleryImage.FileName).ToLower();

                string[] allowedExtensions = { ".jpg", ".jpeg", ".png" };

                if (Array.IndexOf(allowedExtensions, extension) < 0)
                {
                    ShowMessage("Only JPG, JPEG and PNG allowed.", false);
                    return;
                }

                // GENERATE UNIQUE FILE NAME

                string fileName = Guid.NewGuid().ToString() + extension;

                // SAVE PATH

                string folderPath = Server.MapPath("~/Uploads/Gallery/");

                // CREATE FOLDER IF NOT EXISTS

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fullPath = Path.Combine(folderPath, fileName);

                // SAVE IMAGE

                fuGalleryImage.SaveAs(fullPath);

                // DB IMAGE PATH

                string imagePath = "/Uploads/Gallery/" + fileName;

                // DATE

                DateTime galleryDate = DateTime.Now;

                if (!string.IsNullOrWhiteSpace(txtDate.Text))
                {
                    galleryDate = Convert.ToDateTime(txtDate.Text);
                }

                // INSERT INTO DATABASE

                string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO Gallery
                                    (
                                        Title,
                                        Description,
                                        ImagePath,
                                        CreatedDate
                                    )
                                    VALUES
                                    (
                                        @Title,
                                        @Description,
                                        @ImagePath,
                                        @CreatedDate
                                    )";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());

                        cmd.Parameters.AddWithValue("@Description",
                            string.IsNullOrWhiteSpace(txtDescription.Text)
                            ? (object)DBNull.Value
                            : txtDescription.Text.Trim());

                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                        cmd.Parameters.AddWithValue("@CreatedDate", galleryDate);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // SUCCESS

                ShowMessage("Gallery item added successfully.", true);

                ClearFields();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, false);
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Visible = true;

            lblMessage.Text = message;

            lblMessage.CssClass = success
                ? "success-message"
                : "error-message";
        }

        private void ClearFields()
        {
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtDate.Text = "";
        }
    }
}