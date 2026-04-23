using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Student
{
    public partial class StudentProfile : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) { Response.Redirect("~/Login.aspx"); return; }

            if (!IsPostBack)
            {
                LoadDropdowns();
                LoadProfile();
                LoadResources();
            }
        }

        private void LoadDropdowns()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Added TargetExams to the SQL string
                SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name FROM TargetClasses; SELECT Id, Name FROM TargetBoards; SELECT Id, Name FROM TargetExams;", conn);
                DataSet ds = new DataSet();
                da.Fill(ds);

                ddlClass.DataSource = ds.Tables[0];
                ddlClass.DataTextField = "Name"; ddlClass.DataValueField = "Id"; ddlClass.DataBind();

                ddlBoard.DataSource = ds.Tables[1];
                ddlBoard.DataTextField = "Name"; ddlBoard.DataValueField = "Id"; ddlBoard.DataBind();

                // New binding for the Exam dropdown
                ddlExam.DataSource = ds.Tables[2];
                ddlExam.DataTextField = "Name"; ddlExam.DataValueField = "Id"; ddlExam.DataBind();
            }
        }

        private void LoadProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT u.FullName, u.Email, s.*, 
                   c.Name AS ClassName, b.Name AS BoardName, e.Name AS ExamName
            FROM Users u
            LEFT JOIN StudentAdditionalInfo s ON u.UserId = s.UserId
            LEFT JOIN TargetClasses c ON s.TargetClassId = c.Id
            LEFT JOIN TargetBoards b ON s.TargetBoardId = b.Id
            LEFT JOIN TargetExams e ON s.TargetExamId = e.Id
            WHERE u.UserId = @UserId";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // Sidebar Labels (What stays on the page)
                    lblName.Text = dr["FullName"].ToString();
                    lblCity.Text = dr["City"].ToString();
                    lblClass.Text = dr["ClassName"].ToString();
                    lblBoard.Text = dr["BoardName"].ToString();
                    lblExam.Text = dr["ExamName"].ToString();

                    // Modal: Read Only Fields
                    txtName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    if (dr["DOB"] != DBNull.Value)
                        txtDOB.Text = Convert.ToDateTime(dr["DOB"]).ToString("yyyy-MM-dd");

                    // Modal: Editable Fields
                    txtMobile.Text = dr["MobileNumber"].ToString();
                    txtState.Text = dr["State"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtPincode.Text = dr["Pincode"].ToString();
                    txtArea.Text = dr["Area"].ToString();
                    txtFullAddress.Text = dr["FullAddress"].ToString();

                    // Dropdown Selections
                    if (dr["TargetClassId"] != DBNull.Value) ddlClass.SelectedValue = dr["TargetClassId"].ToString();
                    if (dr["TargetBoardId"] != DBNull.Value) ddlBoard.SelectedValue = dr["TargetBoardId"].ToString();
                    if (dr["TargetExamId"] != DBNull.Value) ddlExam.SelectedValue = dr["TargetExamId"].ToString();

                    // Avatar Handling (Preserving your logic)
                    string profilePic = dr["ProfilePicture"].ToString();
                    if (string.IsNullOrEmpty(profilePic)) profilePic = "../assets/img/Deault_Random_boy.png";
                    imgAvatar.ImageUrl = profilePic;
                    imgModalAvatar.ImageUrl = profilePic;
                    hfAvatar.Value = profilePic;
                }
            }
        }

        private void LoadResources()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Removed Subject join to fix the 'SubjectId' error
                string query = @"
            SELECT b.BookmarkId, b.ItemType, b.CreatedAt,
                   COALESCE(r.Title, q.QuizLabel, 'Untitled') AS DisplayTitle
            FROM Bookmarks b
            LEFT JOIN Resources r ON b.ItemId = r.ResourceId AND b.ItemType = 'Resource'
            LEFT JOIN Quiz q ON b.ItemId = q.QuizId AND b.ItemType = 'Quiz'
            WHERE b.UserId = @uid 
            ORDER BY b.CreatedAt DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptResources.DataSource = dt;
                rptResources.DataBind();

                // Optional: Update the bookmark count literal if you have one
                // litCount.Text = dt.Rows.Count.ToString();
            }
        }

        // Keep these helper methods for the UI colors and icons
        protected string GetCategoryStyle(string type)
        {
            if (type == "Quiz") return "background: #f5f3ff; color: #7c3aed;";
            if (type == "PDF" || type == "Resource") return "background: #fff1f2; color: #e11d48;";
            return "background: #f0fdf4; color: #16a34a;";
        }

        protected string GetIconClass(string type)
        {
            if (type == "Quiz") return "fas fa-layer-group";
            if (type == "Resource") return "fas fa-file-pdf";
            return "fas fa-play-circle";
        }

        //protected string GetCategoryStyle(string type)
        //{
        //    if (type == "Quiz") return "background: #f5f3ff; color: #7c3aed;";
        //    if (type == "PDF") return "background: #fff1f2; color: #e11d48;";
        //    return "background: #f0fdf4; color: #16a34a;";
        //}

        //protected string GetIconClass(string type)
        //{
        //    return type == "Quiz" ? "fas fa-layer-group" : (type == "PDF" ? "fas fa-file-pdf" : "fas fa-play-circle");
        //}

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string imagePath = hfAvatar.Value;

            // YOUR EXISTING FILE UPLOAD LOGIC (Keep it exactly as is)
            if (fuModalImage.HasFile)
            {
                string extension = System.IO.Path.GetExtension(fuModalImage.FileName).ToLower();
                if (extension == ".jpg" || extension == ".jpeg" || extension == ".png")
                {
                    string fileName = Guid.NewGuid().ToString() + extension;
                    string folderPath = Server.MapPath("~/Uploads/ProfileImages/");
                    if (!System.IO.Directory.Exists(folderPath)) System.IO.Directory.CreateDirectory(folderPath);
                    string fullPath = System.IO.Path.Combine(folderPath, fileName);
                    fuModalImage.SaveAs(fullPath);
                    imagePath = "/Uploads/ProfileImages/" + fileName;
                }
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // SQL query updated to include all new fields
                // Note: FullName and DOB are NOT in this query because they are Read-Only
                string sql = @"
            UPDATE StudentAdditionalInfo SET 
                ProfilePicture=@img, 
                MobileNumber=@mob,
                TargetClassId=@cid, 
                TargetBoardId=@bid, 
                TargetExamId=@eid,
                State=@state,
                City=@city,
                Pincode=@pin,
                Area=@area,
                FullAddress=@fadd
            WHERE UserId=@id;";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@img", imagePath);
                cmd.Parameters.AddWithValue("@mob", txtMobile.Text);
                cmd.Parameters.AddWithValue("@cid", ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@bid", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@eid", ddlExam.SelectedValue);
                cmd.Parameters.AddWithValue("@state", txtState.Text);
                cmd.Parameters.AddWithValue("@city", txtCity.Text);
                cmd.Parameters.AddWithValue("@pin", txtPincode.Text);
                cmd.Parameters.AddWithValue("@area", txtArea.Text);
                cmd.Parameters.AddWithValue("@fadd", txtFullAddress.Text);
                cmd.Parameters.AddWithValue("@id", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Refresh the page data and close the modal
            LoadProfile();
            ClientScript.RegisterStartupScript(this.GetType(), "close", "closeModal();", true);
        }
    }
}