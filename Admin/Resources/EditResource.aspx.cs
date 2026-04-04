using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class EditResource : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPrimaryDropdowns();
                if (Request.QueryString["id"] != null)
                {
                    hfResourceId.Value = Request.QueryString["id"];
                    LoadResourceData(hfResourceId.Value);
                }
            }
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

        private void LoadResourceData(string id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Resources WHERE ResourceId = @ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    // 1. Mandatory Core
                    ddlBoard.SelectedValue = rdr["BoardId"].ToString();
                    ddlResourceType.SelectedValue = rdr["ResourceTypeId"].ToString();

                    // 2. Load Dependent Dropdowns First
                    LoadDependencies();

                    // 3. Set Values (Handle NULLs by checking if they exist in items)
                    SetSelectedValue(ddlSubCategory, rdr["SubCategoryId"]);
                    SetSelectedValue(ddlClass, rdr["ClassId"]);
                    SetSelectedValue(ddlSubject, rdr["SubjectId"]);

                    // Reload Chapters/Sets based on newly set Subject
                    RefreshChapters();
                    SetSelectedValue(ddlChapter, rdr["ChapterId"]);

                    SetSelectedValue(ddlYear, rdr["YearId"]);
                    RefreshSets();
                    SetSelectedValue(ddlSet, rdr["SetId"]);

                    // 4. Details
                    txtTitle.Text = rdr["Title"].ToString();
                    chkIsPremium.Checked = Convert.ToBoolean(rdr["IsPremium"]);
                }
            }
        }

        private void LoadDependencies()
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);

            if (boardId > 0)
            {
                BindDDL($"SELECT ClassId, ClassName FROM Classes WHERE BoardId={boardId}", ddlClass, "ClassName", "ClassId");
                BindDDL($"SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId={boardId}", ddlSubject, "SubjectName", "SubjectId");
            }
            if (typeId > 0)
            {
                BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE ResourceTypeId={typeId}", ddlSubCategory, "SubCategoryName", "SubCategoryId");
            }
        }

        private void SetSelectedValue(DropDownList ddl, object value)
        {
            string val = value == DBNull.Value ? "0" : value.ToString();
            if (ddl.Items.FindByValue(val) != null) ddl.SelectedValue = val;
        }

        // Logic Re-use from Add Page
        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e) { LoadDependencies(); RefreshChapters(); RefreshSets(); }
        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e) { LoadDependencies(); }
        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e) { RefreshChapters(); }
        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e) { RefreshChapters(); RefreshSets(); }
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e) { RefreshChapters(); }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();
        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e) => RefreshSets();

        private void RefreshChapters()
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId == 0) return;
            string sql = $"SELECT ChapterId, ChapterName FROM Chapters WHERE BoardId={boardId}";
            if (ddlSubject.SelectedIndex > 0) sql += $" AND SubjectId={ddlSubject.SelectedValue}";
            if (ddlSubCategory.SelectedIndex > 0) sql += $" AND SubCategoryId={ddlSubCategory.SelectedValue}";
            BindDDL(sql, ddlChapter, "ChapterName", "ChapterId");
        }

        private void RefreshSets()
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId == 0) return;
            string sql = $"SELECT SetId, SetName FROM Sets WHERE BoardId={boardId}";
            if (ddlSubject.SelectedIndex > 0) sql += $" AND (SubjectId={ddlSubject.SelectedValue} OR SubjectId IS NULL)";
            if (ddlYear.SelectedIndex > 0) sql += $" AND (YearId={ddlYear.SelectedValue} OR YearId IS NULL)";
            BindDDL(sql, ddlSet, "SetName", "SetId");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string fileQuery = "";
                    if (fuFile.HasFile)
                    {
                        string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuFile.FileName);
                        string path = "/Uploads/Resources/" + fileName;
                        fuFile.SaveAs(Server.MapPath("~" + path));
                        fileQuery = ", FilePath=@Path, ContentType=@CType";
                    }

                    string query = $@"UPDATE Resources SET 
                        BoardId=@BID, ResourceTypeId=@RTID, ClassId=@CID, SubjectId=@SID, 
                        ChapterId=@CHID, YearId=@YID, SubCategoryId=@SCID, SetId=@SetID, 
                        Title=@Title, IsPremium=@Prem {fileQuery} 
                        WHERE ResourceId=@ID";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ID", hfResourceId.Value);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@CID", GetValue(ddlClass));
                    cmd.Parameters.AddWithValue("@SID", GetValue(ddlSubject));
                    cmd.Parameters.AddWithValue("@CHID", GetValue(ddlChapter));
                    cmd.Parameters.AddWithValue("@YID", GetValue(ddlYear));
                    cmd.Parameters.AddWithValue("@SCID", GetValue(ddlSubCategory));
                    cmd.Parameters.AddWithValue("@SetID", GetValue(ddlSet));
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Prem", chkIsPremium.Checked);

                    if (fuFile.HasFile)
                    {
                        cmd.Parameters.AddWithValue("@Path", "/Uploads/Resources/" + Guid.NewGuid().ToString()); // Placeholder, logic above is better
                        cmd.Parameters.AddWithValue("@CType", fuFile.PostedFile.ContentType);
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageResources.aspx");
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error: " + ex.Message; }
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

        private void ResetDDL(DropDownList ddl, string text) { ddl.Items.Clear(); ddl.Items.Insert(0, new ListItem(text, "0")); }
    }
}