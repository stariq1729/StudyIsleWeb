using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class BlogDetails : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
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

            LoadBlogMeta(blogId);
            LoadBlogContent(blogId);
        }
        private int GetBlogIdFromSlug(string slug)
        {
            int blogId = 0;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT BlogId FROM Blogs WHERE Slug = @Slug AND IsActive = 1";

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
        // 🔹 Blog Meta
        private void LoadBlogMeta(int blogId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT Title, AuthorName, CreatedDate FROM Blogs WHERE BlogId=@BlogId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BlogId", blogId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    litTitle.Text = dr["Title"].ToString();
                    litAuthor.Text = dr["AuthorName"].ToString();
                    litDate.Text = Convert.ToDateTime(dr["CreatedDate"]).ToString("MMM dd, yyyy");
                }
            }
        }

        // 🔹 Blog Content
        private void LoadBlogContent(int blogId)
        {
            List<string> toc = new List<string>();
            string html = "";

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
                    string type = dr["BlockType"].ToString();
                    string content = dr["Content"]?.ToString();
                    string extra = dr["ExtraData"]?.ToString();

                    string id = "sec_" + index;

                    switch (type)
                    {
                        case "h1":
                            html += $"<h1 id='{id}'>{content}</h1>";
                            toc.Add($"<a href='#{id}'>{content}</a>");
                            break;

                        case "h2":
                            html += $"<h2 id='{id}'>{content}</h2>";
                            toc.Add($"<a href='#{id}'>• {content}</a>");
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
                            html += $"<div class='section-block'>{content}</div>";
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

            // 🔹 Render HTML content
            phContent.Controls.Clear();
            phContent.Controls.Add(new Literal { Text = html });

            // 🔹 Bind TOC
            var tocList = toc.Select(x => new { Text = x }).ToList();

            rptTOC.DataSource = tocList;
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