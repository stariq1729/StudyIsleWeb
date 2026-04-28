using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class AddBlogs : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        // 🔹 Load only active categories
        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT CategoryId, CategoryName FROM BlogCategories WHERE IsActive = 1";

                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlCategory.DataSource = dt;
                    ddlCategory.DataTextField = "CategoryName";
                    ddlCategory.DataValueField = "CategoryId";
                    ddlCategory.DataBind();

                    ddlCategory.Items.Insert(0, "-- Select Category --");
                }
            }
        }

        // 🔹 Auto-generate slug
        protected void txtTitle_TextChanged(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim().ToLower();
            

            string slug = Regex.Replace(title, @"[^a-z0-9\s-]", ""); // remove special chars
            slug = Regex.Replace(slug, @"\s+", "-"); // spaces → hyphen

            txtSlug.Text = slug;
        }

        // 🔹 Save Blog
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string slug = txtSlug.Text.Trim();
            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            string description = txtDescription.Text.Trim();
            bool isPublished = chkPublish.Checked;
            string author = txtAuthor.Text.Trim();

            string imagePath = "";

            // 🔹 Image Upload
            if (fileCoverImage.HasFile)
            {
                string fileName = Path.GetFileName(fileCoverImage.FileName);
                string folderPath = Server.MapPath("~/uploads/blogs/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fullPath = folderPath + fileName;
                fileCoverImage.SaveAs(fullPath);

                imagePath = "/uploads/blogs/" + fileName;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Blogs 
                (Title, Slug, CategoryId, CoverImage, ShortDescription, AuthorName, IsPublished)
                VALUES 
                (@Title, @Slug, @CategoryId, @CoverImage, @ShortDescription, @AuthorName, @IsPublished);
                SELECT SCOPE_IDENTITY();";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    cmd.Parameters.AddWithValue("@CoverImage", imagePath);
                    cmd.Parameters.AddWithValue("@ShortDescription", description);
                    cmd.Parameters.AddWithValue("@IsPublished", isPublished);
                    cmd.Parameters.AddWithValue("@AuthorName", author);


                    con.Open();
                    int blogId = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();

                    // 🔥 IMPORTANT: Redirect to block editor (next phase)
                    Response.Redirect("EditBlogContent.aspx?BlogId=" + blogId);
                }
            }
        }
    }
}