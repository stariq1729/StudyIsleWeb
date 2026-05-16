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

                // 🔹 Check Edit Mode
                if (Request.QueryString["BlogId"] != null)
                {
                    int blogId = Convert.ToInt32(Request.QueryString["BlogId"]);

                    LoadBlogData(blogId);

                    btnSave.Text = "Update Blog";
                }
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
        // 🔹 Load Existing Blog Data for udpate
        private void LoadBlogData(int blogId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT * FROM Blogs WHERE BlogId = @BlogId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BlogId", blogId);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtAuthor.Text = dr["AuthorName"].ToString();

                    ddlCategory.SelectedValue = dr["CategoryId"].ToString();

                    txtReadTime.Text = dr["ReadTime"].ToString();

                    chkPublish.Checked = Convert.ToBoolean(dr["IsPublished"]);
                }

                con.Close();
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
            // 🔹 Check Edit Mode
            int blogId = 0;

            if (Request.QueryString["BlogId"] != null)
            {
                int.TryParse(Request.QueryString["BlogId"], out blogId);
            }
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
            // 🔹 Save / Update Blog
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // =========================================
                // UPDATE EXISTING BLOG
                // =========================================
                if (blogId > 0)
                {
                    string oldImage = "";

                    // 🔹 Get old image if no new image uploaded
                    SqlCommand getCmd = new SqlCommand(
                        "SELECT AuthorImage FROM Blogs WHERE BlogId=@BlogId", con);

                    getCmd.Parameters.AddWithValue("@BlogId", blogId);

                    object result = getCmd.ExecuteScalar();

                    if (result != null)
                    {
                        oldImage = result.ToString();
                    }

                    // Keep old image if no new upload
                    if (string.IsNullOrEmpty(authorImagePath))
                    {
                        authorImagePath = oldImage;
                    }

                    string updateQuery = @"
UPDATE Blogs
SET 
    CategoryId = @CategoryId,
    AuthorName = @AuthorName,
    AuthorImage = @AuthorImage,
    ReadTime = @ReadTime,
    IsPublished = @IsPublished
WHERE BlogId = @BlogId";

                    SqlCommand cmd = new SqlCommand(updateQuery, con);

                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    cmd.Parameters.AddWithValue("@AuthorName", author);
                    cmd.Parameters.AddWithValue("@AuthorImage", authorImagePath);
                    cmd.Parameters.AddWithValue("@ReadTime", readTime);
                    cmd.Parameters.AddWithValue("@IsPublished", isPublished);
                    cmd.Parameters.AddWithValue("@BlogId", blogId);

                    cmd.ExecuteNonQuery();

                    con.Close();

                    // 🔥 Redirect back to same content
                    
                    Response.Redirect("ManageBlogType.aspx");
                }

                // =========================================
                // INSERT NEW BLOG
                // =========================================
                else
                {
                    string slug = "blog-" + DateTime.Now.Ticks;

                    string insertQuery = @"
INSERT INTO Blogs
(Slug, CategoryId, AuthorName, AuthorImage, ReadTime, IsPublished)
VALUES
(@Slug, @CategoryId, @AuthorName, @AuthorImage, @ReadTime, @IsPublished);

SELECT SCOPE_IDENTITY();";

                    SqlCommand cmd = new SqlCommand(insertQuery, con);

                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    cmd.Parameters.AddWithValue("@AuthorName", author);
                    cmd.Parameters.AddWithValue("@AuthorImage", authorImagePath);
                    cmd.Parameters.AddWithValue("@ReadTime", readTime);
                    cmd.Parameters.AddWithValue("@IsPublished", isPublished);

                    int newBlogId = Convert.ToInt32(cmd.ExecuteScalar());

                    con.Close();

                    // 🔥 Redirect to content editor
                    Response.Redirect("EditBlogContent.aspx?BlogId=" + newBlogId);
                }
            }
        }
    }
}