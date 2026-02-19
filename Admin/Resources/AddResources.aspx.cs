using StudyIsleWeb.Admin.Classes;
using StudyIsleWeb.Admin.ResourceTypes;
using StudyIsleWeb.Admin.Subjects;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class AddResource : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["StudyIsleDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadResourceTypes();
            }
        }

        // ===============================
        // LOAD DROPDOWNS
        // ===============================

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

        // ===============================
        // DROPDOWN EVENTS
        // ===============================

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlClass.Items.Clear();
            ddlSubject.Items.Clear();

            if (int.TryParse(ddlBoard.SelectedValue, out int boardId))
            {
                LoadClasses(boardId);
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

        // ===============================
        // SAVE RESOURCE
        // ===============================

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!ValidateForm())
                return;

            string filePath = SaveFile();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    INSERT INTO Resources
                    (BoardId, ClassId, SubjectId, ResourceTypeId,
                     Title, Description, FilePath,
                     IsPremium, IsActive, DownloadCount, CreatedAt)
                    VALUES
                    (@BoardId, @ClassId, @SubjectId, @ResourceTypeId,
                     @Title, @Description, @FilePath,
                     @IsPremium, @IsActive, 0, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@ClassId",
                        string.IsNullOrEmpty(ddlClass.SelectedValue) ? (object)DBNull.Value : ddlClass.SelectedValue);
                    cmd.Parameters.AddWithValue("@SubjectId", ddlSubject.SelectedValue);
                    cmd.Parameters.AddWithValue("@ResourceTypeId", ddlResourceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", DBNull.Value);
                    cmd.Parameters.AddWithValue("@FilePath", filePath);
                    cmd.Parameters.AddWithValue("@IsPremium", false);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("ManageResources.aspx");
        }

        // ===============================
        // VALIDATION
        // ===============================

        private bool ValidateForm()
        {
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

        // ===============================
        // FILE SAVE ENGINE
        // ===============================

        private string SaveFile()
        {
            string boardSlug = GetSlug("Boards", "BoardId", ddlBoard.SelectedValue);
            string classSlug = ddlClass.SelectedIndex > 0
                ? GetSlug("Classes", "ClassId", ddlClass.SelectedValue)
                : null;
            string subjectSlug = GetSlug("Subjects", "SubjectId", ddlSubject.SelectedValue);
            string typeSlug = GetSlug("ResourceTypes", "ResourceTypeId", ddlResourceType.SelectedValue);

            string basePath = Server.MapPath("~/Uploads/");
            string folderPath = basePath + boardSlug + "\\";

            if (classSlug != null)
                folderPath += classSlug + "\\";

            folderPath += subjectSlug + "\\" + typeSlug + "\\";

            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string cleanFileName = Regex.Replace(txtTitle.Text.Trim(), @"[^a-zA-Z0-9]", "_");
            string ext = Path.GetExtension(fileUpload.FileName);
            string fullPath = folderPath + cleanFileName + ext;

            fileUpload.SaveAs(fullPath);

            string relativePath = fullPath.Replace(Server.MapPath("~/"), "").Replace("\\", "/");

            return "/" + relativePath;
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
                    return cmd.ExecuteScalar().ToString();
                }
            }
        }
    }
}
