using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace StudyIsleWeb
{
    public partial class BoardResource : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string boardSlug = Request.QueryString["board"];
                string resSlug = Request.QueryString["res"];
                string classSlug = Request.QueryString["class"];

                if (string.IsNullOrEmpty(boardSlug) || string.IsNullOrEmpty(resSlug))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // 1. Bind Classes and identify the default (DisplayOrder 1)
                DataTable dtClasses = BindClasses(boardSlug, resSlug);

                // 2. Logic for default class selection
                if (string.IsNullOrEmpty(classSlug) && ViewState["DefaultClassSlug"] != null)
                {
                    classSlug = ViewState["DefaultClassSlug"].ToString();
                }

                if (!string.IsNullOrEmpty(classSlug))
                {
                    BindPageContent(boardSlug, classSlug);
                    BindSubjects(boardSlug, classSlug, resSlug);

                    litBoardName.Text = boardSlug.ToUpper();
                    litClassNameCrumb.Text = classSlug.Replace("-", " ").ToUpper();
                }
            }
        }

        protected string GetResourceName()
        {
            string res = Request.QueryString["res"];
            return string.IsNullOrEmpty(res) ? "Resource" : res.Replace("-", " ").ToUpper();
        }

        private DataTable BindClasses(string boardSlug, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Ensure we order by DisplayOrder
                string query = @"SELECT c.ClassName, c.Slug, c.DisplayOrder 
                                 FROM Classes c 
                                 INNER JOIN Boards b ON c.BoardId = b.BoardId
                                 INNER JOIN ResourceTypes rt ON c.ResourceTypeId = rt.ResourceTypeId
                                 WHERE b.Slug = @bSlug AND rt.Slug = @resSlug AND c.IsActive = 1 
                                 ORDER BY c.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@resSlug", resSlug);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Store the first one (DisplayOrder 1) as the default for the UI
                    ViewState["DefaultClassSlug"] = dt.Rows[0]["Slug"].ToString();
                }

                rptClasses.DataSource = dt;
                rptClasses.DataBind();
                return dt;
            }
        }

        private void BindPageContent(string boardSlug, string classSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT PageTitle, PageSubtitle FROM Classes c 
                                 JOIN Boards b ON c.BoardId = b.BoardId 
                                 WHERE b.Slug = @bSlug AND c.Slug = @cSlug";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string rawTitle = dr["PageTitle"] != DBNull.Value ? dr["PageTitle"].ToString() : "";

                    if (rawTitle.Contains("-"))
                    {
                        var parts = rawTitle.Split('-');
                        litPageTitle.Text = parts[0] + " - <span>" + parts[1] + "</span>";
                    }
                    else
                    {
                        litPageTitle.Text = rawTitle;
                    }

                    litPageSubtitle.Text = dr["PageSubtitle"] != DBNull.Value ? dr["PageSubtitle"].ToString() : "";
                }
                con.Close();
            }
        }

        private void BindSubjects(string boardSlug, string classSlug, string resSlug)
        {
            string subcatSlug = Request.QueryString["subcat"];

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added EditionText to the query
                string query = @"SELECT s.SubjectId, s.SubjectName, s.IconImage, s.PageTitle, s.Edition
                                 FROM Subjects s
                                 INNER JOIN Classes c ON s.ClassId = c.ClassId
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 INNER JOIN ResourceTypes rt ON s.ResourceTypeId = rt.ResourceTypeId
                                 LEFT JOIN SubCategories sc ON s.SubCategoryId = sc.SubCategoryId
                                 WHERE b.Slug = @bSlug 
                                 AND c.Slug = @cSlug 
                                 AND rt.Slug = @resSlug 
                                 AND (@subcatSlug IS NULL OR sc.Slug = @subcatSlug)
                                 AND s.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bSlug", boardSlug);
                cmd.Parameters.AddWithValue("@cSlug", classSlug);
                cmd.Parameters.AddWithValue("@resSlug", resSlug);
                cmd.Parameters.AddWithValue("@subcatSlug", (object)subcatSlug ?? DBNull.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSubjectGroups.DataSource = dt;
                rptSubjectGroups.DataBind();
            }
        }
    }
}