using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class SubjectDetails : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Capture the context from the URL
                string subjectIdStr = Request.QueryString["sid"];
                string resSlug = Request.QueryString["res"]; // Captures 'books' or 'pyq'

                // 2. Security Check: Validate mandatory parameters
                if (string.IsNullOrEmpty(subjectIdStr) || string.IsNullOrEmpty(resSlug))
                {
                    // If sid or res is missing, redirect the user back to safety.
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Convert subject ID to integer
                if (!int.TryParse(subjectIdStr, out int subjectId))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // 3. Set up the dynamic headers and context
                BindHeaderAndContext(subjectId, resSlug);

                // 4. THE CORE LOGIC: Decide which path to show
                if (resSlug.ToLower() == "books")
                {
                    // Show the chapter placeholder
                    phChapterPath.Visible = true;
                }
                else if (resSlug.ToLower() == "pyq")
                {
                    // Show the year placeholder
                    phYearPath.Visible = true;
                }
                else
                {
                    // Handle other resource types (e.g., Sample Papers) or an unhandled case.
                    // For now, we'll just redirect to Default, but in a production app,
                    // we might have a specific fallback logic.
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void BindHeaderAndContext(int subjectId, string resSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // We fetch everything in one join query for efficiency.
                string query = @"SELECT s.SubjectName, c.ClassName, c.Slug AS ClassSlug, b.Slug AS BoardSlug
                                 FROM Subjects s
                                 INNER JOIN Classes c ON s.ClassId = c.ClassId
                                 INNER JOIN Boards b ON s.BoardId = b.BoardId
                                 WHERE s.SubjectId = @sId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sId", subjectId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string subjectName = dr["SubjectName"].ToString();
                    string className = dr["ClassName"].ToString();
                    string boardSlug = dr["BoardSlug"].ToString();
                    string classSlug = dr["ClassSlug"].ToString();

                    // Create the proper page titles based on context
                    if (resSlug.ToLower() == "books")
                    {
                        litPageTitle.Text = $"{subjectName} <span>Books</span>";
                        litPageSubtitle.Text = "Select a chapter to begin reading the NCERT curriculum.";
                    }
                    else if (resSlug.ToLower() == "pyq")
                    {
                        litPageTitle.Text = $"{subjectName} <span>Previous Year Questions</span>";
                        litPageSubtitle.Text = "Download official question papers and verified solutions.";
                    }

                    // Setup the dynamic link and text for breadcrumbs
                    hlBoardClassContext.NavigateUrl = $"BoardResource.aspx?board={boardSlug}&class={classSlug}";
                    hlBoardClassContext.Text = className;
                    litSubjectBreadcrumb.Text = subjectName;
                }
                con.Close();
            }
        }
    }
}