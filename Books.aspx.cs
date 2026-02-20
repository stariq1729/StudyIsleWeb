using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class Books : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserId"] == null)
            //{
            //    Response.Redirect("~/Login.aspx");
            //}

            if (!IsPostBack)
            {
                LoadBoardLanding();
            }
        }

        private void LoadBoardLanding()
        {
            string boardSlug = Request.QueryString["board"];

            if (string.IsNullOrEmpty(boardSlug))
            {
                Response.Redirect("~/Default.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                
                string query = @"SELECT BoardId, BoardName 
                 FROM Boards 
                 WHERE Slug = @Slug AND IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Slug", boardSlug);
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        int boardId = Convert.ToInt32(reader["BoardId"]);
                        string boardName = reader["BoardName"].ToString();

                        litBoardTitle.Text = boardName + " Resources";

                        reader.Close();
                        LoadResourceTypes(boardSlug);
                    }
                    else
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                }
            }
        }

        private void LoadResourceTypes(string boardSlug)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                
                string query = @"SELECT TypeName, Slug 
                 FROM ResourceTypes
                 WHERE IsActive = 1
                 AND Slug IN ('books','solutions','sample-papers','previous-papers','notes','syllabus')
                 ORDER BY DisplayOrder";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    dt.Columns.Add("BoardSlug");

                    foreach (DataRow row in dt.Rows)
                    {
                        row["BoardSlug"] = boardSlug;
                    }

                    rptResourceTypes.DataSource = dt;
                    rptResourceTypes.DataBind();
                }
            }
        }
    }
}