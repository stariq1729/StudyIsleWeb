using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class Books : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HandleFlow();
            }
        }

        private void HandleFlow()
        {
            string boardSlug = Request.QueryString["board"];
            string typeSlug = Request.QueryString["type"];
            string classSlug = Request.QueryString["class"];

            if (string.IsNullOrEmpty(boardSlug))
                Response.Redirect("~/Default.aspx");

            int boardId = GetBoardId(boardSlug);

            if (boardId == 0)
                Response.Redirect("~/Default.aspx");

            if (string.IsNullOrEmpty(typeSlug))
            {
                pnlBoardLanding.Visible = true;
                LoadBoardLanding(boardSlug);
                return;
            }

            pnlBoardLanding.Visible = false;

            bool hasClassLayer = GetHasClassLayer(boardId);

            if (hasClassLayer)
            {
                if (string.IsNullOrEmpty(classSlug))
                {
                    Response.Redirect($"Books.aspx?board={boardSlug}&type={typeSlug}&class=class-12");
                    return;
                }

                pnlClassSection.Visible = true;
                pnlSubjectSection.Visible = true;

                LoadClasses(boardId, boardSlug, typeSlug);
                LoadSubjects(classSlug);
            }
        }

        private int GetBoardId(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT BoardId FROM Boards WHERE Slug=@Slug AND IsActive=1";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Slug", slug);
                con.Open();
                object r = cmd.ExecuteScalar();
                return r != null ? Convert.ToInt32(r) : 0;
            }
        }

        private bool GetHasClassLayer(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT HasClassLayer FROM Boards WHERE BoardId=@Id";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Id", boardId);
                con.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        private void LoadBoardLanding(string boardSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT BoardName FROM Boards WHERE Slug=@Slug";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Slug", boardSlug);
                con.Open();
                object r = cmd.ExecuteScalar();

                if (r != null)
                {
                    litBoardTitle.Text = r.ToString() + " Resources";
                    litBoardWhy.Text = r.ToString();
                }
            }

            LoadResourceTypes(boardSlug);
        }

        private void LoadResourceTypes(string boardSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT TypeName, Slug
                             FROM ResourceTypes
                             WHERE IsActive=1
                             AND Slug IN ('books','solutions','sample-papers','previous-papers','notes','syllabus')
                             ORDER BY DisplayOrder";

                SqlCommand cmd = new SqlCommand(q, con);
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dt.Columns.Add("BoardSlug");

                foreach (DataRow row in dt.Rows)
                    row["BoardSlug"] = boardSlug;

                rptResourceTypes.DataSource = dt;
                rptResourceTypes.DataBind();
            }
        }

        private void LoadClasses(int boardId, string boardSlug, string typeSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT ClassName, Slug
                             FROM Classes
                             WHERE BoardId=@BoardId AND IsActive=1
                             ORDER BY DisplayOrder";

                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dt.Columns.Add("BoardSlug");
                dt.Columns.Add("TypeSlug");

                foreach (DataRow row in dt.Rows)
                {
                    row["BoardSlug"] = boardSlug;
                    row["TypeSlug"] = typeSlug;
                }

                rptClasses.DataSource = dt;
                rptClasses.DataBind();
            }
        }

        private void LoadSubjects(string classSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"SELECT SubjectName
                             FROM Subjects s
                             INNER JOIN Classes c ON s.ClassId=c.ClassId
                             WHERE c.Slug=@Slug AND s.IsActive=1
                             ORDER BY s.DisplayOrder";

                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@Slug", classSlug);
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSubjects.DataSource = dt;
                rptSubjects.DataBind();
            }
        }
    }
}