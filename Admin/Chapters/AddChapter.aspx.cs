using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddChapter : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                ResetDropDown(ddlLevel, "-- Select Board First --");
                ResetDropDown(ddlSubject, "-- Select Level First --");
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName, IsCompetitive FROM Boards WHERE IsActive=1", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new ListItem("-- Select Board --", "0"));
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId == 0) return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Use ISNULL in the SQL query to default to 0 (False) if the value is NULL
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", boardId);
                con.Open();

                object result = cmd.ExecuteScalar();

                // Safely convert to boolean
                bool isComp = (result != null && result != DBNull.Value) ? Convert.ToBoolean(result) : false;

                if (isComp)
                {
                    litLevelLabel.Text = "Select Year";
                    LoadYears(boardId);
                }
                else
                {
                    litLevelLabel.Text = "Select Class";
                    LoadClasses(boardId);
                }
                ResetDropDown(ddlSubject, "-- Select Level First --");
                phSets.Visible = false;
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT ClassId, ClassName FROM Classes WHERE BoardId=" + boardId, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlLevel.DataSource = dt;
                ddlLevel.DataTextField = "ClassName";
                ddlLevel.DataValueField = "ClassId";
                ddlLevel.DataBind();
                ddlLevel.Items.Insert(0, new ListItem("-- Select Class --", "0"));
            }
        }

        private void LoadYears(int boardId)
        {
            // Assuming you have a Years table for competitive exams
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT YearId, YearName FROM Years ORDER BY YearName DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlLevel.DataSource = dt;
                ddlLevel.DataTextField = "YearName";
                ddlLevel.DataValueField = "YearId";
                ddlLevel.DataBind();
                ddlLevel.Items.Insert(0, new ListItem("-- Select Year --", "0"));
            }
        }

        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSubjects();
        }

        private void LoadSubjects()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // This logic connects Chapters to Subjects based on the Board/Class hierarchy
                string query = "SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId=@BID";
                if (litLevelLabel.Text.Contains("Class"))
                    query += " AND ClassId=@LID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@LID", ddlLevel.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();
                ddlSubject.Items.Insert(0, new ListItem("-- Select Subject --", "0"));
            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            // If it's a competitive board, load Sets after Subject is chosen
            if (litLevelLabel.Text.Contains("Year"))
            {
                phSets.Visible = true;
                LoadSets(Convert.ToInt32(ddlSubject.SelectedValue));
            }
        }

        private void LoadSets(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT SetId, SetName FROM Sets WHERE SubjectId=" + subjectId, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlSet.DataSource = dt;
                ddlSet.DataTextField = "SetName";
                ddlSet.DataValueField = "SetId";
                ddlSet.DataBind();
                ddlSet.Items.Insert(0, new ListItem("-- No Specific Set --", "0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Chapters (SubjectId, SetId, YearId, ChapterName, Slug, DisplayOrder, IsActive, CreatedAt) 
                                 VALUES (@SID, @SetID, @YID, @Name, @Slug, @Order, @Active, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@SID", ddlSubject.SelectedValue);
                    cmd.Parameters.AddWithValue("@SetID", phSets.Visible && ddlSet.SelectedValue != "0" ? (object)ddlSet.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@YID", litLevelLabel.Text.Contains("Year") ? (object)ddlLevel.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@Name", txtChapterName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@Order", txtDisplayOrder.Text);
                    cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageChapters.aspx");
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error: " + ex.Message; }
        }

        private void ResetDropDown(DropDownList ddl, string text)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem(text, "0"));
        }

        protected void txtChapterName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtChapterName.Text.ToLower(), @"[^a-z0-9]", "-").Replace("--", "-").Trim('-');
        }
    }
}