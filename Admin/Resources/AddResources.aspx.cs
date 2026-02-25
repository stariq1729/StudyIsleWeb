using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;

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

        #region Load Dropdowns

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, "-- Select Board --");
            }
        }

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();
                ddlResourceType.Items.Insert(0, "-- Select Type --");
            }
        }

        private void LoadYears(int typeId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT YearId, YearName FROM Years WHERE ResourceTypeId=@Id", con);
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

        private void LoadSubCategories(int typeId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE ResourceTypeId=@Id", con);
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

        #endregion

        #region Dropdown Events

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlBoard.SelectedValue, out int boardId))
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId", con);
                    cmd.Parameters.AddWithValue("@BoardId", boardId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlClass.DataSource = dt;
                    ddlClass.DataTextField = "ClassName";
                    ddlClass.DataValueField = "ClassId";
                    ddlClass.DataBind();
                    ddlClass.Items.Insert(0, "-- Select Class --");
                }
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlClass.SelectedValue, out int classId))
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=@ClassId", con);
                    cmd.Parameters.AddWithValue("@ClassId", classId);

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
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlSubject.SelectedValue, out int subjectId))
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId=@SubjectId", con);
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
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!int.TryParse(ddlResourceType.SelectedValue, out int typeId)) return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT HasClass, HasSubject, HasChapter, HasYear, HasSubCategory
                                 FROM ResourceTypes WHERE ResourceTypeId=@Id";
                SqlCommand cmd = new SqlCommand(query, con);
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
                }
            }

            LoadYears(typeId);
            LoadSubCategories(typeId);
        }

        #endregion

        #region Add Year / SubCategory

        protected void btnAddYear_Click(object sender, EventArgs e)
        {
            string yearName = txtNewYear.Text.Trim();
            if (!int.TryParse(ddlResourceType.SelectedValue, out int typeId)) return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"IF NOT EXISTS (SELECT 1 FROM Years WHERE YearName=@YearName AND ResourceTypeId=@TypeId)
                                 INSERT INTO Years(YearName, ResourceTypeId) VALUES(@YearName, @TypeId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@YearName", yearName);
                cmd.Parameters.AddWithValue("@TypeId", typeId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadYears(typeId);
        }

        protected void btnAddSubCategory_Click(object sender, EventArgs e)
        {
            string name = txtNewSubCategory.Text.Trim();
            if (!int.TryParse(ddlResourceType.SelectedValue, out int typeId)) return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"IF NOT EXISTS (SELECT 1 FROM SubCategories WHERE SubCategoryName=@Name AND ResourceTypeId=@TypeId)
                                 INSERT INTO SubCategories(SubCategoryName, ResourceTypeId) VALUES(@Name, @TypeId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@TypeId", typeId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadSubCategories(typeId);
        }

        #endregion

        #region Save Resource

protected void btnSave_Click(object sender, EventArgs e)
{
    int typeId = Convert.ToInt32(ddlResourceType.SelectedValue);

    bool hasClass = false;
    bool hasSubject = false;
    bool hasChapter = false;
    bool hasYear = false;
    bool hasSubCategory = false;

    // Get resource type settings
    using (SqlConnection con = new SqlConnection(cs))
    {
        SqlCommand cmd = new SqlCommand(
            @"SELECT HasClass, HasSubject, HasChapter, 
                     HasYear, HasSubCategory
              FROM ResourceTypes
              WHERE ResourceTypeId=@Id", con);

        cmd.Parameters.AddWithValue("@Id", typeId);

        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            hasClass = Convert.ToBoolean(dr["HasClass"]);
            hasSubject = Convert.ToBoolean(dr["HasSubject"]);
            hasChapter = Convert.ToBoolean(dr["HasChapter"]);
            hasYear = Convert.ToBoolean(dr["HasYear"]);
            hasSubCategory = Convert.ToBoolean(dr["HasSubCategory"]);
        }
    }

    // Dropdown validation
    if (hasClass && ddlClass.SelectedIndex == 0)
    {
        lblMessage.Text = "Class is required for this resource type.";
        return;
    }

    if (hasSubject && ddlSubject.SelectedIndex == 0)
    {
        lblMessage.Text = "Subject is required for this resource type.";
        return;
    }

    if (hasChapter && ddlChapter.SelectedIndex == 0)
    {
        lblMessage.Text = "Chapter is required for this resource type.";
        return;
    }

    if (hasYear && ddlYear.SelectedIndex == 0)
    {
        lblMessage.Text = "Year is required for this resource type.";
        return;
    }

    if (hasSubCategory && ddlSubCategory.SelectedIndex == 0)
    {
        lblMessage.Text = "SubCategory is required for this resource type.";
        return;
    }

    // File Upload - mandatory
    if (!fuFile.HasFile)
    {
        lblMessage.Text = "File upload is required.";
        return;
    }

    string filePath = "";
    string contentType = "";

    string folder = Server.MapPath("~/Uploads/");
    if (!Directory.Exists(folder))
        Directory.CreateDirectory(folder);

    string fileName = Guid.NewGuid() + Path.GetExtension(fuFile.FileName);
    fuFile.SaveAs(folder + fileName);
    filePath = "/Uploads/" + fileName;
    contentType = fuFile.PostedFile.ContentType; // Set ContentType

    // Insert into database
    using (SqlConnection con = new SqlConnection(cs))
    {
        string query = @"INSERT INTO Resources
            (BoardId, ResourceTypeId, ClassId, SubjectId,
             ChapterId, YearId, SubCategoryId,
             Title, Description, FilePath, ContentType,
             IsPremium, IsActive, DownloadCount, CreatedAt)
             VALUES
            (@BoardId, @TypeId, @ClassId, @SubjectId,
             @ChapterId, @YearId, @SubCategoryId,
             @Title, @Description, @FilePath, @ContentType,
             @IsPremium, 1, 0, GETDATE())";

        SqlCommand cmd = new SqlCommand(query, con);

        cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
        cmd.Parameters.AddWithValue("@TypeId", typeId);

        cmd.Parameters.AddWithValue("@ClassId",
            hasClass ? (object)ddlClass.SelectedValue : DBNull.Value);
        cmd.Parameters.AddWithValue("@SubjectId",
            hasSubject ? (object)ddlSubject.SelectedValue : DBNull.Value);
        cmd.Parameters.AddWithValue("@ChapterId",
            hasChapter ? (object)ddlChapter.SelectedValue : DBNull.Value);
        cmd.Parameters.AddWithValue("@YearId",
            hasYear ? (object)ddlYear.SelectedValue : DBNull.Value);
        cmd.Parameters.AddWithValue("@SubCategoryId",
            hasSubCategory ? (object)ddlSubCategory.SelectedValue : DBNull.Value);

        cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
        cmd.Parameters.AddWithValue("@FilePath", filePath);
        cmd.Parameters.AddWithValue("@ContentType", contentType); // <-- added
        cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    Response.Redirect("ManageResources.aspx");
}

        #endregion
    }
}