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
                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Resource Type --");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            phClass.Visible = false;
            phSubCategory.Visible = false;
            ddlSubject.Items.Clear();

            if (ddlBoard.SelectedValue != "0")
            {
                int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
                bool isComp = CheckIfCompetitive(boardId);

                if (isComp)
                {
                    phSubCategory.Visible = true;
                    BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId={boardId}", ddlSubCategory, "SubCategoryName", "SubCategoryId", "-- Select Sub-Category --");
                }
                else
                {
                    phClass.Visible = true;
                    BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}", ddlLevel, "ClassName", "ClassId", "-- Select Class --");
                }
            }
        }

        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLevel.SelectedValue != "0")
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId={ddlLevel.SelectedValue}", ddlSubject, "SubjectName", "SubjectId", "-- Select Subject (Optional) --");
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubCategory.SelectedValue != "0")
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE SubCategoryId={ddlSubCategory.SelectedValue}", ddlSubject, "SubjectName", "SubjectId", "-- Select Subject (Optional) --");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlBoard.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtChapterName.Text))
                {
                    lblMessage.Text = "⚠️ Board and Chapter Name are required.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Updated SQL to include your new nullable columns
                    string sql = @"INSERT INTO Chapters (BoardId, ResourceTypeId, SubCategoryId, SubjectId, ChapterName, Slug, DisplayOrder, IsActive, CreatedAt) 
                                   VALUES (@BID, @RTID, @SCID, @SID, @Name, @Slug, @Order, @Active, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue != "0" ? (object)ddlResourceType.SelectedValue : DBNull.Value);

                    // Handle SubCategory/Class logic
                    cmd.Parameters.AddWithValue("@SCID", phSubCategory.Visible && ddlSubCategory.SelectedValue != "0" ? (object)ddlSubCategory.SelectedValue : DBNull.Value);

                    // The Fix: Explicitly send DBNull if Subject is not selected
                    if (ddlSubject.SelectedIndex > 0)
                        cmd.Parameters.AddWithValue("@SID", ddlSubject.SelectedValue);
                    else
                        cmd.Parameters.AddWithValue("@SID", DBNull.Value);

                    cmd.Parameters.AddWithValue("@Name", txtChapterName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@Order", string.IsNullOrEmpty(txtDisplayOrder.Text) ? 0 : int.Parse(txtDisplayOrder.Text));
                    cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "✅ Chapter added successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Database Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // --- Helper Methods ---
        private bool CheckIfCompetitive(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", boardId);
                con.Open(); return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt; ddl.DataTextField = text; ddl.DataValueField = value; ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }

        protected void txtChapterName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtChapterName.Text.ToLower(), @"[^a-z0-9]", "-").Replace("--", "-").Trim('-');
        }
    }
}