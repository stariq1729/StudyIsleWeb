using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class EditResource : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("ManageResources.aspx");
                }

                int resourceId;
                if (!int.TryParse(Request.QueryString["id"], out resourceId))
                {
                    Response.Redirect("ManageResources.aspx");
                }

                hfResourceId.Value = resourceId.ToString();

                LoadBoards();
                LoadResourceTypes();
                LoadResource(resourceId);
            }
        }

        // ---------------- LOAD BOARDS ----------------

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1 ORDER BY BoardName";

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

        // ---------------- LOAD CLASSES ----------------

        private void LoadClasses(int boardId)
        {
            ddlClass.Items.Clear();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId AND IsActive=1 ORDER BY DisplayOrder";

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

        // ---------------- LOAD SUBJECTS ----------------

        private void LoadSubjects(int boardId, int? classId)
        {
            ddlSubject.Items.Clear();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query;

                if (classId.HasValue)
                {
                    query = @"SELECT SubjectId, SubjectName 
                              FROM Subjects 
                              WHERE BoardId=@BoardId AND ClassId=@ClassId AND IsActive=1 
                              ORDER BY SubjectName";
                }
                else
                {
                    query = @"SELECT SubjectId, SubjectName 
                              FROM Subjects 
                              WHERE BoardId=@BoardId AND ClassId IS NULL AND IsActive=1 
                              ORDER BY SubjectName";
                }

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

        // ---------------- LOAD RESOURCE TYPES ----------------

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1 ORDER BY DisplayOrder";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    ddlType.DataSource = cmd.ExecuteReader();
                    ddlType.DataTextField = "TypeName";
                    ddlType.DataValueField = "ResourceTypeId";
                    ddlType.DataBind();
                }
            }

            ddlType.Items.Insert(0, "-- Select Type --");
        }

        // ---------------- LOAD RESOURCE ----------------

        private void LoadResource(int resourceId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT *
                FROM Resources
                WHERE ResourceId=@Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", resourceId);
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        ddlBoard.SelectedValue = dr["BoardId"].ToString();

                        int boardId = Convert.ToInt32(dr["BoardId"]);
                        object classObj = dr["ClassId"];

                        if (classObj != DBNull.Value)
                        {
                            int classId = Convert.ToInt32(classObj);
                            LoadClasses(boardId);
                            ddlClass.SelectedValue = classId.ToString();
                            LoadSubjects(boardId, classId);
                        }
                        else
                        {
                            LoadSubjects(boardId, null);
                            ddlClass.Visible = false;
                        }

                        ddlSubject.SelectedValue = dr["SubjectId"].ToString();
                        ddlType.SelectedValue = dr["ResourceTypeId"].ToString();

                        txtTitle.Text = dr["Title"].ToString();
                        txtDescription.Text = dr["Description"].ToString();

                        chkPremium.Checked = Convert.ToBoolean(dr["IsPremium"]);
                        chkActive.Checked = Convert.ToBoolean(dr["IsActive"]);

                        lnkCurrentFile.NavigateUrl = dr["FilePath"].ToString();
                        lnkCurrentFile.Text = "View Current File";
                    }
                    else
                    {
                        Response.Redirect("ManageResources.aspx");
                    }
                }
            }
        }

        // ---------------- DROPDOWN EVENTS ----------------

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex > 0)
            {
                int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
                LoadClasses(boardId);
                LoadSubjects(boardId, null);
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex > 0 && ddlClass.SelectedIndex > 0)
            {
                int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
                int classId = Convert.ToInt32(ddlClass.SelectedValue);
                LoadSubjects(boardId, classId);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int resourceId = Convert.ToInt32(hfResourceId.Value);

            if (ddlBoard.SelectedIndex == 0 || ddlSubject.SelectedIndex == 0 || ddlType.SelectedIndex == 0)
                return;

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            int? classId = null;

            if (ddlClass.Visible && ddlClass.SelectedIndex > 0)
                classId = Convert.ToInt32(ddlClass.SelectedValue);

            int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);
            int typeId = Convert.ToInt32(ddlType.SelectedValue);

            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            bool isPremium = chkPremium.Checked;
            bool isActive = chkActive.Checked;

            string existingFilePath = "";
            string newFilePath = "";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Get existing file path
                using (SqlCommand cmd = new SqlCommand("SELECT FilePath FROM Resources WHERE ResourceId=@Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", resourceId);
                    existingFilePath = cmd.ExecuteScalar().ToString();
                }

                newFilePath = existingFilePath;

                // If new file uploaded
                if (fuFile.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(fuFile.FileName).ToLower();

                    // Basic extension validation
                    string[] allowed = { ".pdf", ".doc", ".docx", ".ppt", ".pptx", ".jpg", ".png" };
                    if (!Array.Exists(allowed, ext => ext == extension))
                        return;

                    // Fetch slugs for path rebuild
                    string boardSlug = "";
                    string subjectSlug = "";
                    string typeSlug = "";
                    string className = "";

                    using (SqlCommand cmdMeta = new SqlCommand(@"
                SELECT b.Slug, s.Slug, rt.Slug, c.ClassName
                FROM Boards b
                INNER JOIN Subjects s ON s.SubjectId=@SubjectId
                INNER JOIN ResourceTypes rt ON rt.ResourceTypeId=@TypeId
                LEFT JOIN Classes c ON c.ClassId=@ClassId
                WHERE b.BoardId=@BoardId", con))
                    {
                        cmdMeta.Parameters.AddWithValue("@BoardId", boardId);
                        cmdMeta.Parameters.AddWithValue("@SubjectId", subjectId);
                        cmdMeta.Parameters.AddWithValue("@TypeId", typeId);
                        cmdMeta.Parameters.AddWithValue("@ClassId", (object)classId ?? DBNull.Value);

                        using (SqlDataReader dr = cmdMeta.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                boardSlug = dr[0].ToString();
                                subjectSlug = dr[1].ToString();
                                typeSlug = dr[2].ToString();
                                className = dr[3] == DBNull.Value ? "" : dr[3].ToString();
                            }
                        }
                    }

                    string folderPath = "~/Uploads/" + boardSlug + "/";

                    if (!string.IsNullOrEmpty(className))
                        folderPath += className + "/";

                    folderPath += subjectSlug + "/" + typeSlug + "/";

                    string physicalPath = Server.MapPath(folderPath);

                    if (!System.IO.Directory.Exists(physicalPath))
                        System.IO.Directory.CreateDirectory(physicalPath);

                    string fileName = Guid.NewGuid().ToString() + extension;

                    string fullPath = System.IO.Path.Combine(physicalPath, fileName);

                    fuFile.SaveAs(fullPath);

                    newFilePath = folderPath + fileName;

                    // Delete old file
                    string oldPhysical = Server.MapPath(existingFilePath);
                    if (System.IO.File.Exists(oldPhysical))
                        System.IO.File.Delete(oldPhysical);
                }

                // UPDATE QUERY
                using (SqlCommand cmdUpdate = new SqlCommand(@"
            UPDATE Resources
            SET BoardId=@BoardId,
                ClassId=@ClassId,
                SubjectId=@SubjectId,
                ResourceTypeId=@TypeId,
                Title=@Title,
                Description=@Description,
                FilePath=@FilePath,
                IsPremium=@IsPremium,
                IsActive=@IsActive
            WHERE ResourceId=@Id", con))
                {
                    cmdUpdate.Parameters.AddWithValue("@BoardId", boardId);
                    cmdUpdate.Parameters.AddWithValue("@ClassId", (object)classId ?? DBNull.Value);
                    cmdUpdate.Parameters.AddWithValue("@SubjectId", subjectId);
                    cmdUpdate.Parameters.AddWithValue("@TypeId", typeId);
                    cmdUpdate.Parameters.AddWithValue("@Title", title);
                    cmdUpdate.Parameters.AddWithValue("@Description", description);
                    cmdUpdate.Parameters.AddWithValue("@FilePath", newFilePath);
                    cmdUpdate.Parameters.AddWithValue("@IsPremium", isPremium);
                    cmdUpdate.Parameters.AddWithValue("@IsActive", isActive);
                    cmdUpdate.Parameters.AddWithValue("@Id", resourceId);

                    cmdUpdate.ExecuteNonQuery();
                }
            }

            Response.Redirect("ManageResources.aspx");
        }
    }
}