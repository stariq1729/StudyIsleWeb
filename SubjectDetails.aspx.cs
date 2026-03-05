using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class SubjectDetails : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string subjectIdStr = Request.QueryString["sid"];
                string resSlug = Request.QueryString["res"];

                if (int.TryParse(subjectIdStr, out int subjectId) && !string.IsNullOrEmpty(resSlug))
                {
                    BindHeaderAndContext(subjectId, resSlug);

                    // Dynamic Data Routing
                    if (CheckIfResTypeUsesYears(resSlug))
                    {
                        phYearPath.Visible = true;
                        BindYears(resSlug);
                    }
                    else if (CheckIfSubjectHasChapters(subjectId))
                    {
                        phChapterPath.Visible = true;
                        BindChapters(subjectId);
                    }
                }
                else { Response.Redirect("Default.aspx"); }
            }
        }

        private void BindHeaderAndContext(int subjectId, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT s.SubjectName, s.IconImage, c.ClassName, c.Slug AS ClassSlug, b.Slug AS BoardSlug
                                 FROM Subjects s
                                 LEFT JOIN Classes c ON s.ClassId = c.ClassId
                                 LEFT JOIN Boards b ON s.BoardId = b.BoardId
                                 WHERE s.SubjectId = @sId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sId", subjectId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    ViewState["SubName"] = dr["SubjectName"].ToString();
                    ViewState["SubIcon"] = dr["IconImage"] == DBNull.Value || string.IsNullOrEmpty(dr["IconImage"].ToString()) ? "default.png" : dr["IconImage"].ToString();

                    litSubjectBreadcrumb.Text = dr["SubjectName"].ToString();
                    litPageTitle.Text = dr["SubjectName"].ToString() + " <span class='text-primary'>" + resSlug.ToUpper() + "</span>";

                    hlBoardClassContext.Text = dr["ClassName"].ToString();
                    hlBoardClassContext.NavigateUrl = $"BoardResource.aspx?board={dr["BoardSlug"]}&class={dr["ClassSlug"]}&res={resSlug}";
                }
            }
        }

        private void BindYears(string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                //
                string query = @"SELECT y.YearId, y.YearName FROM Years y 
                                 JOIN ResourceTypes rt ON y.ResourceTypeId = rt.ResourceTypeId 
                                 WHERE rt.Slug = @res AND y.IsActive = 1 ORDER BY y.DisplayOrder DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@res", resSlug);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptYears.DataSource = dt;
                rptYears.DataBind();
            }
        }

        private void BindChapters(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                //
                string query = "SELECT ChapterName, Slug, DisplayOrder FROM Chapters WHERE SubjectId = @sId AND IsActive = 1 ORDER BY DisplayOrder ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@sId", subjectId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptChapters.DataSource = dt;
                rptChapters.DataBind();
                litChapterCount.Text = dt.Rows.Count.ToString();
            }
        }

        private bool CheckIfResTypeUsesYears(string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                //
                string query = "SELECT COUNT(*) FROM Years y JOIN ResourceTypes rt ON y.ResourceTypeId = rt.ResourceTypeId WHERE rt.Slug = @res";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@res", resSlug);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private bool CheckIfSubjectHasChapters(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                //
                string query = "SELECT COUNT(*) FROM Chapters WHERE SubjectId = @sid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sid", subjectId);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }
    }
}