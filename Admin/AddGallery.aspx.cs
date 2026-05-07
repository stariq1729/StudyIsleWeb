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
            if (!IsPostBack)
            {
                // EDIT MODE

                if (Request.QueryString["id"] != null)
                {
                    LoadGalleryData();

                    btnPublish.Text = "UPDATE NOW";
                }
            }
        }

        // =====================================
        // LOAD DATA FOR EDIT MODE
        // =====================================

        private void LoadGalleryData()
        {
            int galleryId =
                Convert.ToInt32(Request.QueryString["id"]);

            string connStr =
                ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection conn =
                new SqlConnection(connStr))
            {
                string query = @"
                    SELECT *
                    FROM Gallery
                    WHERE GalleryId = @GalleryId";

                using (SqlCommand cmd =
                    new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue(
                        "@GalleryId",
                        galleryId);

                    conn.Open();

                    SqlDataReader reader =
                        cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hfGalleryId.Value =
                            reader["GalleryId"].ToString();

                        txtTitle.Text =
                            reader["Title"].ToString();

                        txtDescription.Text =
                            reader["Description"].ToString();

                        txtDate.Text =
                            Convert.ToDateTime(
                                reader["CreatedDate"])
                                .ToString("yyyy-MM-dd");

                        // OLD IMAGE

                        string imagePath =
                            reader["ImagePath"].ToString();

                        hfOldImagePath.Value =
                            imagePath;

                        imgPreview.ImageUrl =
                            imagePath;

                        imgPreview.Style["display"] =
                            "block";

                        uploadContent.Style["display"] =
                            "none";
                    }
                }
            }
        }

        // =====================================
        // ADD / UPDATE BUTTON
        // =====================================

        protected void btnPublish_Click(
            object sender,
            EventArgs e)
        {
            try
            {
                // ================================
                // TITLE VALIDATION
                // ================================

                if (string.IsNullOrWhiteSpace(
                    txtTitle.Text))
                {
                    ShowMessage(
                        "Please enter title.",
                        false);

                    return;
                }

                // ================================
                // IMAGE REQUIRED FOR ADD MODE
                // ================================

                if (string.IsNullOrEmpty(
                    hfGalleryId.Value)
                    && !fuGalleryImage.HasFile)
                {
                    ShowMessage(
                        "Please select image.",
                        false);

                    return;
                }

                // ================================
                // IMAGE VALIDATION
                // ================================

                if (fuGalleryImage.HasFile)
                {
                    string extension =
                        Path.GetExtension(
                            fuGalleryImage.FileName)
                            .ToLower();

                    string[] allowedExtensions =
                    {
                        ".jpg",
                        ".jpeg",
                        ".png"
                    };

                    if (Array.IndexOf(
                        allowedExtensions,
                        extension) < 0)
                    {
                        ShowMessage(
                            "Only JPG, JPEG and PNG allowed.",
                            false);

                        return;
                    }
                }

                // ================================
                // DATE
                // ================================

                DateTime galleryDate =
                    DateTime.Now;

                if (!string.IsNullOrWhiteSpace(
                    txtDate.Text))
                {
                    galleryDate =
                        Convert.ToDateTime(
                            txtDate.Text);
                }

                // ================================
                // CONNECTION
                // ================================

                string connStr =
                    ConfigurationManager
                    .ConnectionStrings["dbcs"]
                    .ConnectionString;

                using (SqlConnection conn =
                    new SqlConnection(connStr))
                {
                    conn.Open();

                    // =====================================
                    // UPDATE MODE
                    // =====================================

                    if (!string.IsNullOrEmpty(
                        hfGalleryId.Value))
                    {
                        // KEEP OLD IMAGE

                        string imagePath =
                            hfOldImagePath.Value;

                        // NEW IMAGE UPLOADED

                        if (fuGalleryImage.HasFile)
                        {
                            // DELETE OLD IMAGE

                            string oldImageFullPath =
                                Server.MapPath(
                                    hfOldImagePath.Value);

                            if (File.Exists(
                                oldImageFullPath))
                            {
                                File.Delete(
                                    oldImageFullPath);
                            }

                            // NEW IMAGE DETAILS

                            string extension =
                                Path.GetExtension(
                                    fuGalleryImage.FileName)
                                    .ToLower();

                            string fileName =
                                Guid.NewGuid().ToString()
                                + extension;

                            string folderPath =
                                Server.MapPath(
                                    "~/Uploads/Gallery/");

                            // CREATE FOLDER

                            if (!Directory.Exists(
                                folderPath))
                            {
                                Directory.CreateDirectory(
                                    folderPath);
                            }

                            string fullPath =
                                Path.Combine(
                                    folderPath,
                                    fileName);

                            // SAVE NEW IMAGE

                            fuGalleryImage.SaveAs(
                                fullPath);

                            imagePath =
                                "/Uploads/Gallery/"
                                + fileName;
                        }

                        // UPDATE QUERY

                        string query = @"
                            UPDATE Gallery
                            SET
                                Title = @Title,
                                Description = @Description,
                                ImagePath = @ImagePath,
                                CreatedDate = @CreatedDate
                            WHERE GalleryId = @GalleryId";

                        using (SqlCommand cmd =
                            new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue(
                                "@GalleryId",
                                hfGalleryId.Value);

                            cmd.Parameters.AddWithValue(
                                "@Title",
                                txtTitle.Text.Trim());

                            cmd.Parameters.AddWithValue(
                                "@Description",
                                string.IsNullOrWhiteSpace(
                                    txtDescription.Text)
                                ? (object)DBNull.Value
                                : txtDescription.Text.Trim());

                            cmd.Parameters.AddWithValue(
                                "@ImagePath",
                                imagePath);

                            cmd.Parameters.AddWithValue(
                                "@CreatedDate",
                                galleryDate);

                            cmd.ExecuteNonQuery();
                        }

                        ShowMessage(
                            "Gallery updated successfully.",
                            true);
                    }

                    // =====================================
                    // ADD MODE
                    // =====================================

                    else
                    {
                        // IMAGE DETAILS

                        string extension =
                            Path.GetExtension(
                                fuGalleryImage.FileName)
                                .ToLower();

                        string fileName =
                            Guid.NewGuid().ToString()
                            + extension;

                        string folderPath =
                            Server.MapPath(
                                "~/Uploads/Gallery/");

                        // CREATE FOLDER

                        if (!Directory.Exists(
                            folderPath))
                        {
                            Directory.CreateDirectory(
                                folderPath);
                        }

                        string fullPath =
                            Path.Combine(
                                folderPath,
                                fileName);

                        // SAVE IMAGE

                        fuGalleryImage.SaveAs(
                            fullPath);

                        // DB IMAGE PATH

                        string imagePath =
                            "/Uploads/Gallery/"
                            + fileName;

                        // INSERT QUERY

                        string query = @"
                            INSERT INTO Gallery
                            (
                                Title,
                                Description,
                                ImagePath,
                                CreatedDate,
                                IsActive
                            )
                            VALUES
                            (
                                @Title,
                                @Description,
                                @ImagePath,
                                @CreatedDate,
                                1
                            )";

                        using (SqlCommand cmd =
                            new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue(
                                "@Title",
                                txtTitle.Text.Trim());

                            cmd.Parameters.AddWithValue(
                                "@Description",
                                string.IsNullOrWhiteSpace(
                                    txtDescription.Text)
                                ? (object)DBNull.Value
                                : txtDescription.Text.Trim());

                            cmd.Parameters.AddWithValue(
                                "@ImagePath",
                                imagePath);

                            cmd.Parameters.AddWithValue(
                                "@CreatedDate",
                                galleryDate);

                            cmd.ExecuteNonQuery();
                        }

                        ShowMessage(
                            "Gallery item added successfully.",
                            true);

                        ClearFields();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    ex.Message,
                    false);
            }
        }

        // =====================================
        // MESSAGE
        // =====================================

        private void ShowMessage(
            string message,
            bool success)
        {
            lblMessage.Visible = true;

            lblMessage.Text = message;

            lblMessage.CssClass = success
                ? "success-message"
                : "error-message";
        }

        // =====================================
        // CLEAR
        // =====================================

        private void ClearFields()
        {
            txtTitle.Text = "";

            txtDescription.Text = "";

            txtDate.Text = "";

            hfGalleryId.Value = "";

            hfOldImagePath.Value = "";

            imgPreview.ImageUrl = "";

            imgPreview.Style["display"] = "none";

            uploadContent.Style["display"] = "block";
        }
    }
}