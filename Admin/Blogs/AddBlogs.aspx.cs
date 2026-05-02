using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

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

        // 🔹 Save Blog (UPDATED)
        protected void btnSave_Click(object sender, EventArgs e)
        {
            // ✅ Get values from form
            string author = txtAuthor.Text.Trim();
            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            bool isPublished = chkPublish.Checked;

            int readTime = 0;
            int.TryParse(txtReadTime.Text.Trim(), out readTime);

            string authorImagePath = "";

            // 🔹 Upload Author Image
            if (fileAuthorImage != null && fileAuthorImage.HasFile)
            {
                string fileName = Path.GetFileName(fileAuthorImage.FileName);
                string folderPath = Server.MapPath("~/uploads/authors/");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fullPath = Path.Combine(folderPath, fileName);
                fileAuthorImage.SaveAs(fullPath);

                authorImagePath = "/uploads/authors/" + fileName;
            }

            // 🔹 Insert into database
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Blogs 
                (CategoryId, AuthorName, AuthorImage, ReadTime, IsPublished)
                VALUES 
                (@CategoryId, @AuthorName, @AuthorImage, @ReadTime, @IsPublished);
                SELECT SCOPE_IDENTITY();";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    cmd.Parameters.AddWithValue("@AuthorName", author);
                    cmd.Parameters.AddWithValue("@AuthorImage", authorImagePath);
                    cmd.Parameters.AddWithValue("@ReadTime", readTime);
                    cmd.Parameters.AddWithValue("@IsPublished", isPublished);

                    con.Open();
                    int blogId = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();

                    // 🔥 Redirect to content editor
                    Response.Redirect("EditBlogContent.aspx?BlogId=" + blogId);
                }
            }
        }
    }
}