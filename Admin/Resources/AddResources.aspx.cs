using StudyIsleWeb.Admin.Classes;
using StudyIsleWeb.Admin.ResourceTypes;
using StudyIsleWeb.Admin.Subjects;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
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
                LoadBoards();
                LoadResourceTypes();
            }
        }

        // =========================
        // LOAD DROPDOWNS
        // =========================

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    ddlBoard.DataSource = cmd.ExecuteReader();
                    ddlBoard.DataTextField = "BoardName";
                    ddlBoard.DataValueField = "BoardId";
                    ddlBoard.DataBind();
                }
            }
            ddlBoard.Items.Insert(0, "-- Select Board --");
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId AND IsActive=1";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BoardId", boardId);
                    con.Open();
                    ddlClass.DataSource = cmd.ExecuteReader();
                    ddlClass.DataTextField = "ClassName";
                    ddlClass.DataValueField = "ClassId";
                    ddlClass.DataBind();
                }
            }
            ddlClass.Items.Insert(0, "-- Select Class --");
        }

        private void LoadSubjects(int boardId, int? classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = classId.HasValue
                    ? "SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId=@BoardId AND ClassId=@ClassId AND IsActive=1"
                    : "SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId=@BoardId AND ClassId IS NULL AND IsActive=1";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BoardId", boardId);
                    if (classId.HasValue)
                        cmd.Parameters.AddWithValue("@ClassId", classId.Value);

                    con.Open();
                    ddlSubject.DataSource = cmd.ExecuteReader();
                    ddlSubject.DataTextField = "SubjectName";
                    ddlSubject.DataValueField = "SubjectId";
                    ddlSubject.DataBind();
                }
            }
            ddlSubject.Items.Insert(0, "-- Select Subject --");
        }

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1 ORDER BY DisplayOrder";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    ddlResourceType.DataSource = cmd.ExecuteReader();
                    ddlResourceType.DataTextField = "TypeName";
                    ddlResourceType.DataValueField = "ResourceTypeId";
                    ddlResourceType.DataBind();
                }
            }
            ddlResourceType.Items.Insert(0, "-- Select Type --");
        }

        // =========================
        // EVENTS
        // =========================

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlClass.Items.Clear();
            ddlSubject.Items.Clear();

            if (int.TryParse(ddlBoard.SelectedValue, out int boardId))
            {
                bool hasClassLayer = BoardHasClassLayer(boardId);

                if (hasClassLayer)
                {
                    LoadClasses(boardId);
                }
                else
                {
                    // No class layer → load subjects directly
                    LoadSubjects(boardId, null);
                }
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSubject.Items.Clear();

            if (int.TryParse(ddlBoard.SelectedValue, out int boardId))
            {
                int? classId = null;
                if (int.TryParse(ddlClass.SelectedValue, out int cid))
                    classId = cid;

                LoadSubjects(boardId, classId);
            }
        }

        // =========================
        // SAVE RESOURCE
        // =========================

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!ValidateForm())
                return;

            lblMessage.Text = "SaveFile starting...";
            string slug = GenerateSlug(txtTitle.Text.Trim());

            string filePath = SaveFile();

            lblMessage.Text = "File saved at: " + filePath;
            

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
INSERT INTO Resources
(BoardId, ClassId, SubjectId, ResourceTypeId,
 Title, Slug, Description, FilePath,
 IsPremium, IsActive, DownloadCount, CreatedAt)
VALUES
(@BoardId, @ClassId, @SubjectId, @ResourceTypeId,
 @Title, @Slug, @Description, @FilePath,
 @IsPremium, @IsActive, 0, GETDATE())";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@ClassId",
                        ddlClass.SelectedIndex > 0 ? (object)ddlClass.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@SubjectId", ddlSubject.SelectedValue);
                    cmd.Parameters.AddWithValue("@ResourceTypeId", ddlResourceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@FilePath", filePath);
                    cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("ManageResources.aspx");
        }

        // =========================
        // VALIDATION
        // =========================

        private bool ValidateForm()
        {
            // Enforce Class Layer Rule
            if (ddlBoard.SelectedIndex > 0)
            {
                int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
                bool hasClassLayer = BoardHasClassLayer(boardId);

                if (hasClassLayer && ddlClass.SelectedIndex == 0)
                {
                    lblMessage.Text = "This board requires a class selection.";
                    return false;
                }

                if (!hasClassLayer && ddlClass.SelectedIndex > 0)
                {
                    lblMessage.Text = "This board does not support classes.";
                    return false;
                }
            }
            if (ddlBoard.SelectedIndex == 0 ||
                ddlSubject.SelectedIndex == 0 ||
                ddlResourceType.SelectedIndex == 0 ||
                string.IsNullOrEmpty(txtTitle.Text))
            {
                lblMessage.Text = "All required fields must be filled.";
                return false;
            }

            if (!fileUpload.HasFile)
            {
                lblMessage.Text = "Please upload a file.";
                return false;
            }

            string ext = Path.GetExtension(fileUpload.FileName).ToLower();
            string[] allowed = { ".pdf", ".docx", ".pptx", ".jpg", ".png" };

            if (Array.IndexOf(allowed, ext) < 0)
            {
                lblMessage.Text = "Invalid file type.";
                return false;
            }

            return true;
        }

        // =========================
        // FILE SAVE
        // =========================

        private string SaveFile()
        {
            // Get Board Slug
            string boardSlug = GetSlug("Boards", "BoardId", ddlBoard.SelectedValue);

            // Base Upload path
            string basePath = Server.MapPath("~/Uploads/");

            // Create Board folder path
            string folderPath = Path.Combine(basePath, boardSlug);
            // Add Class folder if selected
            if (ddlClass.SelectedIndex > 0)
            {
                string classFolder = CleanFolderName(ddlClass.SelectedItem.Text);
                folderPath = Path.Combine(folderPath, classFolder);
            }
            // Add Subject folder
            string subjectSlug = GetSlug("Subjects", "SubjectId", ddlSubject.SelectedValue);
            folderPath = Path.Combine(folderPath, subjectSlug);
            // Add ResourceType folder
            string typeSlug = GetSlug("ResourceTypes", "ResourceTypeId", ddlResourceType.SelectedValue);
            folderPath = Path.Combine(folderPath, typeSlug);

            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            // Clean file name
            string cleanFileName = Regex.Replace(txtTitle.Text.Trim(), @"[^a-zA-Z0-9]", "_");

            string ext = Path.GetExtension(fileUpload.FileName);
            string fullPath = Path.Combine(folderPath, cleanFileName + ext);

            // Save file
            lblMessage.Text = "Saving to: " + fullPath;
            fileUpload.SaveAs(fullPath);

            // Convert to relative path
            string relativePath = fullPath
                .Replace(Server.MapPath("~/"), "")
                .Replace("\\", "/");

            return "/" + relativePath;
        }
        private string CleanFolderName(string text)
        {
            return Regex.Replace(text.ToLower(), @"[^a-z0-9]", "-");
        }
        private string GetSlug(string table, string idField, string idValue)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = $"SELECT Slug FROM {table} WHERE {idField}=@Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", idValue);
                    con.Open();

                    object result = cmd.ExecuteScalar();
                    return result != null ? result.ToString() : "";
                }
            }
        }

        private bool BoardHasClassLayer(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT HasClassLayer FROM Boards WHERE BoardId=@BoardId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BoardId", boardId);
                    con.Open();

                    return Convert.ToBoolean(cmd.ExecuteScalar());
                }
            }
        }
        private string GenerateSlug(string title)
        {
            // Convert to lowercase
            string slug = title.ToLower().Trim();

            // Replace invalid chars with dash
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", "-");
            slug = Regex.Replace(slug, @"-+", "-");

            string originalSlug = slug;
            int count = 2;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                while (true)
                {
                    string query = "SELECT COUNT(*) FROM Resources WHERE Slug = @Slug";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Slug", slug);

                        int exists = (int)cmd.ExecuteScalar();

                        if (exists == 0)
                            break;

                        slug = originalSlug + "-" + count;
                        count++;
                    }
                }
            }

            return slug;
        }
    }
}