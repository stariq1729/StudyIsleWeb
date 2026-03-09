using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class AddResources : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadResourceTypes();
            }
        }

        /* -------------------------
           BOARDS
        --------------------------*/

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId,BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();

                ddlBoard.Items.Insert(0, "-- Select Board --");
            }
        }

        /* -------------------------
           RESOURCE TYPES
        --------------------------*/

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT ResourceTypeId,TypeName FROM ResourceTypes WHERE IsActive=1 ORDER BY DisplayOrder", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();

                ddlResourceType.Items.Insert(0, "-- Select Type --");
            }
        }

        /* -------------------------
           CLASSES
        --------------------------*/

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ClassId,ClassName FROM Classes WHERE BoardId=@BoardId ORDER BY DisplayOrder", con);

                cmd.Parameters.AddWithValue("@BoardId", boardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();

                ddlClass.Items.Insert(0, "-- Select Class --");

                ddlClass.Enabled = dt.Rows.Count > 0;
            }
        }

        /* -------------------------
           SUBJECTS
        --------------------------*/

        private void LoadSubjects(int boardId, int? classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT SubjectId,SubjectName
                                 FROM Subjects
                                 WHERE BoardId=@BoardId
                                 AND (@ClassId IS NULL OR ClassId=@ClassId OR ClassId IS NULL)
                                 AND IsActive=1
                                 ORDER BY SubjectName";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassId",
                    classId.HasValue ? (object)classId.Value : DBNull.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, "-- Select Subject --");
            }
        }

        /* -------------------------
           CHAPTERS
        --------------------------*/

        private void LoadChapters(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT ChapterId,ChapterName
                      FROM Chapters
                      WHERE SubjectId=@SubjectId
                      AND IsActive=1
                      ORDER BY DisplayOrder", con);

                cmd.Parameters.AddWithValue("@SubjectId", subjectId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChapter.DataSource = dt;
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterId";
                ddlChapter.DataBind();

                ddlChapter.Items.Insert(0, "-- Select Chapter --");
            }
        }

        /* -------------------------
           YEARS
        --------------------------*/

        private void LoadYears(int typeId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT YearId,YearName FROM Years WHERE ResourceTypeId=@Id ORDER BY YearName DESC", con);

                cmd.Parameters.AddWithValue("@Id", typeId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlYear.DataSource = dt;
                ddlYear.DataTextField = "YearName";
                ddlYear.DataValueField = "YearId";
                ddlYear.DataBind();

                ddlYear.Items.Insert(0, "-- Select Year --");
            }
        }

        /* -------------------------
           SUBCATEGORIES
        --------------------------*/

        private void LoadSubCategories(int typeId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubCategoryId,SubCategoryName FROM SubCategories WHERE ResourceTypeId=@Id ORDER BY SubCategoryName", con);

                cmd.Parameters.AddWithValue("@Id", typeId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubCategory.DataSource = dt;
                ddlSubCategory.DataTextField = "SubCategoryName";
                ddlSubCategory.DataValueField = "SubCategoryId";
                ddlSubCategory.DataBind();

                ddlSubCategory.Items.Insert(0, "-- Select SubCategory --");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);

            LoadClasses(boardId);

            if (ddlClass.Items.Count <= 1)
            {
                ddlClass.Enabled = false;
                LoadSubjects(boardId, null);
            }

            ddlChapter.Items.Clear();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);

            int classId = Convert.ToInt32(ddlClass.SelectedValue);

            LoadSubjects(boardId, classId == 0 ? (int?)null : classId);

            ddlChapter.Items.Clear();
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedIndex == 0)
                return;

            int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);

            LoadChapters(subjectId);

            LoadSets(subjectId, null, null);
        }

        /* ----------- ADDED METHOD ----------- */

        protected void ddlChapter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlChapter.SelectedIndex == 0)
                return;

            int subjectId = ddlSubject.SelectedIndex == 0 ? 0 : Convert.ToInt32(ddlSubject.SelectedValue);
            int chapterId = Convert.ToInt32(ddlChapter.SelectedValue);

            LoadSets(subjectId == 0 ? (int?)null : subjectId, chapterId, null);
        }

        /* ----------- ADDED METHOD ----------- */

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlYear.SelectedIndex == 0)
                return;

            int yearId = Convert.ToInt32(ddlYear.SelectedValue);

            LoadSets(null, null, yearId);
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Added HasSet to the SELECT statement
                SqlCommand cmd = new SqlCommand(
                    @"SELECT HasClass, HasSubject, HasChapter, HasYear, HasSubCategory, HasSet
              FROM ResourceTypes
              WHERE ResourceTypeId=@Id", con);

                cmd.Parameters.AddWithValue("@Id", typeId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    pnlClass.Visible = Convert.ToBoolean(dr["HasClass"]);
                    pnlSubject.Visible = Convert.ToBoolean(dr["HasSubject"]);
                    pnlChapter.Visible = Convert.ToBoolean(dr["HasChapter"]);
                    pnlYear.Visible = Convert.ToBoolean(dr["HasYear"]);
                    pnlSubCategory.Visible = Convert.ToBoolean(dr["HasSubCategory"]);

                    // This will now work perfectly since the column is in the SELECT list
                    pnlSet.Visible = Convert.ToBoolean(dr["HasSet"]);
                }
            }

            LoadYears(typeId);
            LoadSubCategories(typeId);
        }
        protected void btnAddSubCategory_Click(object sender, EventArgs e)
        {
            string name = txtNewSubCategory.Text.Trim();

            if (string.IsNullOrEmpty(name))
            {
                lblMessage.Text = "Enter subcategory name.";
                return;
            }

            if (!int.TryParse(ddlResourceType.SelectedValue, out int typeId) || typeId == 0)
            {
                lblMessage.Text = "Select resource type first.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"IF NOT EXISTS
                        (SELECT 1 FROM SubCategories 
                         WHERE SubCategoryName=@Name 
                         AND ResourceTypeId=@TypeId)

                         INSERT INTO SubCategories
                         (SubCategoryName, ResourceTypeId)
                         VALUES(@Name, @TypeId)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@TypeId", typeId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            txtNewSubCategory.Text = "";

            LoadSubCategories(typeId);
        }

        protected void btnAddYear_Click(object sender, EventArgs e)
        {
            string yearName = txtNewYear.Text.Trim();

            if (string.IsNullOrEmpty(yearName))
            {
                lblMessage.Text = "Enter year.";
                return;
            }

            if (!int.TryParse(ddlResourceType.SelectedValue, out int typeId) || typeId == 0)
            {
                lblMessage.Text = "Select resource type first.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"IF NOT EXISTS
                        (SELECT 1 FROM Years
                         WHERE YearName=@YearName
                         AND ResourceTypeId=@TypeId)

                         INSERT INTO Years
                         (YearName, ResourceTypeId)
                         VALUES(@YearName, @TypeId)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@YearName", yearName);
                cmd.Parameters.AddWithValue("@TypeId", typeId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            txtNewYear.Text = "";

            LoadYears(typeId);
        }

        // SETS
        private void LoadSets(int? subjectId, int? chapterId, int? yearId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT SetId, SetName
                         FROM Sets
                         WHERE IsActive = 1
                         AND (@SubjectId IS NULL OR SubjectId=@SubjectId)
                         AND (@ChapterId IS NULL OR ChapterId=@ChapterId)
                         AND (@YearId IS NULL OR YearId=@YearId)
                         ORDER BY DisplayOrder";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@SubjectId",
                    subjectId.HasValue ? (object)subjectId.Value : DBNull.Value);

                cmd.Parameters.AddWithValue("@ChapterId",
                    chapterId.HasValue ? (object)chapterId.Value : DBNull.Value);

                cmd.Parameters.AddWithValue("@YearId",
                    yearId.HasValue ? (object)yearId.Value : DBNull.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSet.DataSource = dt;
                ddlSet.DataTextField = "SetName";
                ddlSet.DataValueField = "SetId";
                ddlSet.DataBind();

                ddlSet.Items.Insert(0, "-- Select Set --");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!fuFile.HasFile)
            {
                lblMessage.Text = "File required.";
                return;
            }

            string folder = Server.MapPath("~/Uploads/");

            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);

            string fileName = Guid.NewGuid() + Path.GetExtension(fuFile.FileName);

            fuFile.SaveAs(folder + fileName);

            string filePath = "/Uploads/" + fileName;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(

@"INSERT INTO Resources
(BoardId,ResourceTypeId,ClassId,SubjectId,ChapterId,YearId,SubCategoryId,SetId,
Title,Description,FilePath,ContentType,IsPremium,IsActive,DownloadCount,CreatedAt)

VALUES
(@BoardId,@TypeId,@ClassId,@SubjectId,@ChapterId,@YearId,@SubCategoryId, @SetId,
@Title,@Description,@FilePath,@ContentType,@IsPremium,1,0,GETDATE())", con);

                cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@TypeId", ddlResourceType.SelectedValue);

                cmd.Parameters.AddWithValue("@ClassId",
                    ddlClass.SelectedIndex == 0 ? (object)DBNull.Value : ddlClass.SelectedValue);

                cmd.Parameters.AddWithValue("@SubjectId",
                    ddlSubject.SelectedIndex == 0 ? (object)DBNull.Value : ddlSubject.SelectedValue);

                cmd.Parameters.AddWithValue("@ChapterId",
                    ddlChapter.SelectedIndex == 0 ? (object)DBNull.Value : ddlChapter.SelectedValue);

                cmd.Parameters.AddWithValue("@YearId",
                    ddlYear.SelectedIndex == 0 ? (object)DBNull.Value : ddlYear.SelectedValue);

                cmd.Parameters.AddWithValue("@SubCategoryId",
                    ddlSubCategory.SelectedIndex == 0 ? (object)DBNull.Value : ddlSubCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@SetId",
                     ddlSet.SelectedIndex <= 0 ? (object)DBNull.Value : ddlSet.SelectedValue);

                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@FilePath", filePath);
                cmd.Parameters.AddWithValue("@ContentType", fuFile.PostedFile.ContentType);
                cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageResources.aspx");
        }
    }
}