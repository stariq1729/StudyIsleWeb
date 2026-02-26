using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class AddResourceType : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e) { }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblMessage.Text = "Type Name is required.";
                return;
            }

            string iconFileName = "default-icon.png"; // Fallback default

            // Handle Image Upload
            if (fuIcon.HasFile)
            {
                try
                {
                    string extension = Path.GetExtension(fuIcon.FileName).ToLower();
                    string[] allowedExtensions = { ".png", ".jpg", ".jpeg", ".svg", ".webp" };

                    if (Array.Exists(allowedExtensions, ext => ext == extension))
                    {
                        // Create unique name to prevent overwriting
                        iconFileName = "resource_" + DateTime.Now.Ticks + extension;
                        string folderPath = Server.MapPath("~/Uploads/ResourceIcons/");

                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        fuIcon.SaveAs(Path.Combine(folderPath, iconFileName));
                    }
                    else
                    {
                        lblMessage.Text = "Only Image files (.png, .jpg, .svg, .webp) are allowed.";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "File upload error: " + ex.Message;
                    return;
                }
            }

            int displayOrder = 0;
            int.TryParse(txtDisplayOrder.Text, out displayOrder);

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO ResourceTypes
                                    (TypeName, Slug, IconImage, IsPremium, IsActive,
                                     DisplayOrder, CreatedAt,
                                     HasClass, HasSubject, HasChapter,
                                     HasYear, HasSubCategory)
                                     VALUES
                                    (@TypeName, @Slug, @IconImage, @IsPremium, @IsActive,
                                     @DisplayOrder, GETDATE(),
                                     @HasClass, @HasSubject, @HasChapter,
                                     @HasYear, @HasSubCategory)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", GenerateSlug(txtSlug.Text));
                    cmd.Parameters.AddWithValue("@IconImage", iconFileName); // Saves filename to DB
                    cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@DisplayOrder", displayOrder);
                    cmd.Parameters.AddWithValue("@HasClass", chkHasClass.Checked);
                    cmd.Parameters.AddWithValue("@HasSubject", chkHasSubject.Checked);
                    cmd.Parameters.AddWithValue("@HasChapter", chkHasChapter.Checked);
                    cmd.Parameters.AddWithValue("@HasYear", chkHasYear.Checked);
                    cmd.Parameters.AddWithValue("@HasSubCategory", chkHasSubCategory.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                Response.Redirect("ManageResourceTypes.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Database Error: " + ex.Message;
            }
        }

        private string GenerateSlug(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            slug = slug.Replace(" ", "-");
            return slug;
        }
    }
}