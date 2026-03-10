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
            if (!IsPostBack)
            {
                BindPrimaryDropdowns();
            }
        }

        private void BindPrimaryDropdowns()
        {
            BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
            BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1", ddlResourceType, "TypeName", "ResourceTypeId");
            BindDDL("SELECT YearId, YearName FROM Years ORDER BY YearName DESC", ddlYear, "YearName", "YearId");

            // Set placeholders for others
            ResetDDL(ddlClass, "-- Select Board First --");
            ResetDDL(ddlSubject, "-- Select Context --");
            ResetDDL(ddlChapter, "-- Select Subject --");
            ResetDDL(ddlSet, "-- Optional --");
            ResetDDL(ddlSubCategory, "-- Optional --");
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId > 0)
            {
                BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}", ddlClass, "ClassName", "ClassId");
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId={boardId}", ddlSubject, "SubjectName", "SubjectId");
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            int classId = Convert.ToInt32(ddlClass.SelectedValue);
            if (classId > 0)
            {
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId={classId}", ddlSubject, "SubjectName", "SubjectId");
            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);
            if (subjectId > 0)
            {
                BindDDL($"SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId={subjectId}", ddlChapter, "ChapterName", "ChapterId");
            }
            RefreshSets();
        }

        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);
            if (typeId > 0)
            {
                BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE ResourceTypeId={typeId}", ddlSubCategory, "SubCategoryName", "SubCategoryId");
            }
        }

        private void RefreshSets()
        {
            string sql = "SELECT SetId, SetName FROM Sets WHERE IsActive=1";
            if (ddlSubject.SelectedIndex > 0) sql += $" AND (SubjectId={ddlSubject.SelectedValue} OR SubjectId IS NULL)";
            if (ddlChapter.SelectedIndex > 0) sql += $" AND (ChapterId={ddlChapter.SelectedValue} OR ChapterId IS NULL)";
            if (ddlYear.SelectedIndex > 0) sql += $" AND (YearId={ddlYear.SelectedValue} OR YearId IS NULL)";

            BindDDL(sql, ddlSet, "SetName", "SetId");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex <= 0 || ddlResourceType.SelectedIndex <= 0 || string.IsNullOrEmpty(txtTitle.Text) || !fuFile.HasFile)
            {
                ShowMessage("Please fill Board, Type, Title, and select a file.", "text-danger");
                return;
            }

            try
            {
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuFile.FileName);
                string path = "/Uploads/Resources/" + fileName;
                fuFile.SaveAs(Server.MapPath("~" + path));

                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Full explicit INSERT with all columns shown in your SELECT * screenshot
                    string query = @"INSERT INTO Resources 
                        (BoardId, ResourceTypeId, ClassId, SubjectId, ChapterId, YearId, SubCategoryId, SetId, Title, FilePath, ContentType, IsPremium, IsActive, CreatedAt, DownloadCount)
                        VALUES (@BID, @RTID, @CID, @SID, @CHID, @YID, @SCID, @SetID, @Title, @Path, @CType, @Prem, 1, GETDATE(), 0)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    // Core Params
                    cmd.Parameters.Add("@BID", SqlDbType.Int).Value = ddlBoard.SelectedValue;
                    cmd.Parameters.Add("@RTID", SqlDbType.Int).Value = ddlResourceType.SelectedValue;

                    // Optional Params with proper DBNull handling
                    cmd.Parameters.Add("@CID", SqlDbType.Int).Value = GetValue(ddlClass);
                    cmd.Parameters.Add("@SID", SqlDbType.Int).Value = GetValue(ddlSubject);
                    cmd.Parameters.Add("@CHID", SqlDbType.Int).Value = GetValue(ddlChapter);
                    cmd.Parameters.Add("@YID", SqlDbType.Int).Value = GetValue(ddlYear);
                    cmd.Parameters.Add("@SCID", SqlDbType.Int).Value = GetValue(ddlSubCategory);
                    cmd.Parameters.Add("@SetID", SqlDbType.Int).Value = GetValue(ddlSet);

                    // Details
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = txtTitle.Text.Trim();
                    cmd.Parameters.Add("@Path", SqlDbType.NVarChar).Value = path;
                    cmd.Parameters.Add("@CType", SqlDbType.NVarChar).Value = fuFile.PostedFile.ContentType;
                    cmd.Parameters.Add("@Prem", SqlDbType.Bit).Value = chkIsPremium.Checked;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageResources.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Critical Error: " + ex.Message, "text-danger");
            }
        }

        private object GetValue(DropDownList ddl)
        {
            return (ddl.SelectedIndex <= 0 || ddl.SelectedValue == "0") ? DBNull.Value : (object)ddl.SelectedValue;
        }

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

        private void ShowMessage(string msg, string css)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = "fw-bold " + css;
        }
    }
}