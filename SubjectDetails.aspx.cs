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
                string sId = Request.QueryString["sid"];
                string res = Request.QueryString["res"];

                if (string.IsNullOrEmpty(sId) || string.IsNullOrEmpty(res))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadSubjectInfo(sId);
                DetermineFlow(sId, res);
            }
        }

        private void DetermineFlow(string sid, string res)
        {
            // Check for Chapters first
            if (CheckDataExists("ChapterId", sid, res))
            {
                phChapterPath.Visible = true;
                BindChapters(sid);
            }
            // If no chapters, check for Years
            else if (CheckDataExists("YearId", sid, res))
            {
                phYearPath.Visible = true;
                BindYears(sid, res);
            }
            // If nothing, go straight to final list
            else
            {
                Response.Redirect($"ViewResources.aspx?sid={sid}&res={res}");
            }
        }

        private bool CheckDataExists(string column, string sid, string res)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = $@"SELECT COUNT(*) FROM Resources r 
                               INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
                               WHERE r.SubjectId = @sid AND rt.Slug = @res AND r.{column} IS NOT NULL";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@res", res);
                con.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private void BindYears(string sid, string res)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Use @sid and @res as placeholders
                string sql = @"SELECT DISTINCT y.YearId, y.YearName 
                       FROM Years y 
                       JOIN Resources r ON y.YearId = r.YearId 
                       JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
                       WHERE r.SubjectId = @sid 
                       AND rt.Slug = @res 
                       AND y.IsActive = 1 
                       ORDER BY y.YearName DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@res", res);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptYears.DataSource = dt;
                rptYears.DataBind();
            }
        }

        private void BindChapters(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = "SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId = @sid AND IsActive = 1 ORDER BY ChapterName ASC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptChapters.DataSource = dt;
                rptChapters.DataBind();
            }
        }

        private void LoadSubjectInfo(string sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT SubjectName FROM Subjects WHERE SubjectId = @id", con);
                cmd.Parameters.AddWithValue("@id", sid);
                con.Open();
                litSubjectName.Text = cmd.ExecuteScalar()?.ToString();
            }
        }

        private DataTable GetData(string sql)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}