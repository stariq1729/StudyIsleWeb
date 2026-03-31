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
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId", "-- Select Board --");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            phClass.Visible = false;
            phSubject.Visible = false;
            lblMessage.Text = "";

            if (ddlBoard.SelectedValue != "0")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Check if Board is Competitive
                    SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=@ID", con);
                    cmd.Parameters.AddWithValue("@ID", ddlBoard.SelectedValue);
                    con.Open();
                    bool isComp = Convert.ToBoolean(cmd.ExecuteScalar());

                    if (isComp)
                    {
                        // Competitive: Choose Subject directly (Class stays NULL)
                        phSubject.Visible = true;
                        BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId={ddlBoard.SelectedValue} AND ClassId IS NULL", ddlSubject, "SubjectName", "SubjectId", "-- Select Subject --");
                    }
                    else
                    {
                        // School Board: Must choose Class first
                        phClass.Visible = true;
                        BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={ddlBoard.SelectedValue}", ddlLevel, "ClassName", "ClassId", "-- Select Class --");
                    }
                }
            }
        }

        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLevel.SelectedValue != "0")
            {
                phSubject.Visible = true;
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId={ddlLevel.SelectedValue}", ddlSubject, "SubjectName", "SubjectId", "-- Select Subject --");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlBoard.SelectedValue == "0" || ddlSubject.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtChapterName.Text))
                {
                    lblMessage.Text = "⚠️ Board, Subject, and Chapter Name are required.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // REMOVED ClassId from here to match your current DB table
                    string sql = @"INSERT INTO Chapters (SubjectId, ChapterName, Slug, DisplayOrder, IsActive, CreatedAt) 
                           VALUES (@SID, @Name, @Slug, @Order, @Active, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@SID", ddlSubject.SelectedValue);
                    cmd.Parameters.AddWithValue("@Name", txtChapterName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());

                    int order = 0;
                    int.TryParse(txtDisplayOrder.Text, out order);
                    cmd.Parameters.AddWithValue("@Order", order);

                    cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageChapters.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }

        protected void txtChapterName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtChapterName.Text.ToLower(), @"[^a-z0-9]", "-").Replace("--", "-").Trim('-');
        }
    }
}