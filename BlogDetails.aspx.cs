using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class BlogDetails : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int blogId = 0;

                if (Request.QueryString["blogid"] != null)
                {
                    blogId = Convert.ToInt32(Request.QueryString["blogid"]);
                }
                else if (Request.QueryString["slug"] != null)
                {
                    string slug = Request.QueryString["slug"].ToString();
                    blogId = GetBlogIdFromSlug(slug);
                }
                else
                {
                    Response.Write("Invalid URL");
                    return;
                }

                if (blogId == 0)
                {
                    Response.Write("Blog not found");
                    return;
                }

                LoadBlogMeta(blogId);
                LoadBlogContent(blogId);
            }
        }

        // 🔹 Get BlogId from slug
        private int GetBlogIdFromSlug(string slug)
        {
            int blogId = 0;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT BlogId FROM Blogs WHERE Slug=@Slug AND IsActive=1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Slug", slug);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    blogId = Convert.ToInt32(result);
                }
            }

            return blogId;
        }

        // 🔹 Load Author + Date ONLY
        private void LoadBlogMeta(int blogId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT AuthorName, AuthorImage, CreatedDate FROM Blogs WHERE BlogId=@BlogId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BlogId", blogId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    litAuthor.Text = dr["AuthorName"].ToString();
                    litDate.Text = Convert.ToDateTime(dr["CreatedDate"]).ToString("MMM dd, yyyy");

                    // 🔥 NEW: set author image
                    string authorImage = dr["AuthorImage"] == DBNull.Value ? "" : dr["AuthorImage"].ToString();

                    // keep in hidden literal (optional, for debugging/reuse)
                    litAuthorImage.Text = authorImage;

                    // set image src with fallback
                    imgAuthor.Src = string.IsNullOrEmpty(authorImage)
                        ? "/assets/user.png"
                        : authorImage;
                }
            }
        }

        // 🔹 Blog Content (UPDATED)
        private void LoadBlogContent(int blogId)
        {
            var toc = new List<object>();
            string html = "";

            bool titleSet = false; // 🔥 important

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM BlogBlocks WHERE BlogId=@BlogId ORDER BY DisplayOrder";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BlogId", blogId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                int index = 0;

                while (dr.Read())
                {
                    string type = dr["BlockType"].ToString().Trim().ToLower();
                    string content = dr["Content"]?.ToString();
                    string extra = dr["ExtraData"]?.ToString();

                    string id = "sec_" + index;

                    switch (type)
                    {
                        case "h1":

                            // 🔥 FIRST H1 = PAGE TITLE
                            if (!titleSet)
                            {
                                litTitle.Text = content;
                                titleSet = true;

                                // 🔥 FIX: link TOC to main title
                                toc.Add(new { Text = content, Id = "mainTitle" });

                                break;
                            }

                            // 🔹 Other H1 (rare case)
                            html += $"<h1 id='{id}'>{content}</h1>";
                            toc.Add(new { Text = content, Id = id });
                            break;

                        case "h2":
                            html += $"<h2 id='{id}'>{content}</h2>";
                            toc.Add(new { Text = content, Id = id });
                            break;

                        case "paragraph":
                            html += $"<p>{content}</p>";
                            break;

                        case "image":
                            html += $"<img src='{content}' class='blog-image'/>";
                            break;

                        case "divider":
                            html += "<hr/>";
                            break;

                        case "section":
                            html += $@"
                            <div class='section-block'>
                                <h4 style='font-weight:600; margin-bottom:8px;'>{content}</h4>
                                <p style='margin:0;'>{extra}</p>
                            </div>";
                            break;

                        case "note":
                            html += $@"
    <div class='note-block'>
        <div class='note-title'>{content}</div>
        <div class='note-desc'>{extra}</div>
    </div>";
                            break;

                        case "html":
                            html += $@"
                            <div class='html-block'>
                                <div class='html-code'>
                                    {Server.HtmlEncode(content)}
                                </div>
                                <div class='html-preview'>
                                    {content}
                                </div>
                            </div>";
                            break;

                        case "table":
                            html += RenderTable(extra);
                            break;
                    }

                    index++;
                }
            }

            // 🔹 Render content
            phContent.Controls.Clear();
            phContent.Controls.Add(new Literal { Text = html });

            // 🔹 Bind TOC
            rptTOC.DataSource = toc;
            rptTOC.DataBind();
        }

        // 🔹 Table Renderer
        private string RenderTable(string json)
        {
            if (string.IsNullOrEmpty(json)) return "";

            dynamic data = JsonConvert.DeserializeObject(json);

            string html = "<table class='blog-table'><tr>";

            foreach (var h in data.headers)
            {
                html += $"<th>{h}</th>";
            }

            html += "</tr>";

            foreach (var row in data.rows)
            {
                html += "<tr>";
                foreach (var cell in row)
                {
                    html += $"<td>{cell}</td>";
                }
                html += "</tr>";
            }

            html += "</table>";

            return html;
        }
    }
}