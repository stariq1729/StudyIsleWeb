using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class AddResources : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { BindPrimaryDropdowns(); }
        }

        private void BindPrimaryDropdowns()
        {
            BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
            BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1", ddlResourceType, "TypeName", "ResourceTypeId");
            BindDDL("SELECT YearId, YearName FROM Years ORDER BY YearName DESC", ddlYear, "YearName", "YearId");

            ResetDDL(ddlSubCategory, "-- Optional --");
            ResetDDL(ddlClass, "-- Optional --");
            ResetDDL(ddlSubject, "-- Optional --");
            ResetDDL(ddlChapter, "-- Optional --");
            ResetDDL(ddlSet, "-- Optional --");
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId > 0)
            {
                BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}", ddlClass, "ClassName", "ClassId");
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId={boardId}", ddlSubject, "SubjectName", "SubjectId");

                // Allow Chapter and Set to open immediately based on Board
                RefreshChapters();
                RefreshSets();
            }
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);
            if (typeId > 0)
            {
                BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE ResourceTypeId={typeId}", ddlSubCategory, "SubCategoryName", "SubCategoryId");
            }
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshChapters(); // SubCategory might influence which Chapters appear
            RefreshSets();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            int classId = Convert.ToInt32(ddlClass.SelectedValue);
            if (classId > 0)
            {
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId={classId}", ddlSubject, "SubjectName", "SubjectId");
            }
            RefreshChapters();
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshChapters();
            RefreshSets();
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();
        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();

        private void RefreshChapters()
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);
            int subCatId = Convert.ToInt32(ddlSubCategory.SelectedValue);

            if (boardId == 0) { ResetDDL(ddlChapter, "-- Select Board First --"); return; }

            // LOGIC: If Subject is missing (JEE), it searches by Board + SubCategory
            string sql = $"SELECT ChapterId, ChapterName FROM Chapters WHERE BoardId={boardId}";
            if (subjectId > 0) sql += $" AND SubjectId={subjectId}";
            if (subCatId > 0) sql += $" AND SubCategoryId={subCatId}";

            BindDDL(sql, ddlChapter, "ChapterName", "ChapterId");
        }

        private void RefreshSets()
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);
            int yearId = Convert.ToInt32(ddlYear.SelectedValue);

            if (boardId == 0) { ResetDDL(ddlSet, "-- Select Board First --"); return; }

            string sql = $"SELECT SetId, SetName FROM Sets WHERE BoardId={boardId}";
            if (subjectId > 0) sql += $" AND (SubjectId={subjectId} OR SubjectId IS NULL)";
            if (yearId > 0) sql += $" AND (YearId={yearId} OR YearId IS NULL)";

            BindDDL(sql, ddlSet, "SetName", "SetId");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex <= 0 || ddlResourceType.SelectedIndex <= 0 || !fuFile.HasFile)
            {
                ShowMessage("Board, Type, and File are required.", "text-danger");
                return;
            }

            try
            {
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuFile.FileName);
                string path = "/Uploads/Resources/" + fileName;
                fuFile.SaveAs(Server.MapPath("~" + path));

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Resources 
                        (BoardId, ResourceTypeId, ClassId, SubjectId, ChapterId, YearId, SubCategoryId, SetId, Title, FilePath, ContentType, IsPremium, IsActive, CreatedAt, DownloadCount)
                        VALUES (@BID, @RTID, @CID, @SID, @CHID, @YID, @SCID, @SetID, @Title, @Path, @CType, @Prem, 1, GETDATE(), 0)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@CID", GetValue(ddlClass));
                    cmd.Parameters.AddWithValue("@SID", GetValue(ddlSubject));
                    cmd.Parameters.AddWithValue("@CHID", GetValue(ddlChapter));
                    cmd.Parameters.AddWithValue("@YID", GetValue(ddlYear));
                    cmd.Parameters.AddWithValue("@SCID", GetValue(ddlSubCategory));
                    cmd.Parameters.AddWithValue("@SetID", GetValue(ddlSet));
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Path", path);
                    cmd.Parameters.AddWithValue("@CType", fuFile.PostedFile.ContentType);
                    cmd.Parameters.AddWithValue("@Prem", chkIsPremium.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageResources.aspx");
                }
            }
            catch (Exception ex) { ShowMessage("Error: " + ex.Message, "text-danger"); }
        }

        private object GetValue(DropDownList ddl) => (ddl.SelectedIndex <= 0 || ddl.SelectedValue == "0") ? DBNull.Value : (object)ddl.SelectedValue;

        private void BindDDL(string sql, DropDownList ddl, string text, string value)
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
                ddl.Items.Insert(0, new ListItem("-- Optional --", "0"));
            }
        }

        private void ResetDDL(DropDownList ddl, string text)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem(text, "0"));
        }

        private void ShowMessage(string msg, string css) { lblMessage.Text = msg; lblMessage.CssClass = css; }
    }
}