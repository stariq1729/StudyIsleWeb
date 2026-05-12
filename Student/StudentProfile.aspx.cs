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
            }
        }

        private void LoadDropdowns()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name FROM TargetClasses; SELECT Id, Name FROM TargetBoards; SELECT Id, Name FROM TargetExams;", conn);
                DataSet ds = new DataSet();
                da.Fill(ds);

                ddlClass.DataSource = ds.Tables[0];
                ddlClass.DataTextField = "Name"; ddlClass.DataValueField = "Id"; ddlClass.DataBind();

                ddlBoard.DataSource = ds.Tables[1];
                ddlBoard.DataTextField = "Name"; ddlBoard.DataValueField = "Id"; ddlBoard.DataBind();

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
                    string fullName = dr["FullName"].ToString();

                    // Dashboard Page View
                    lblNameFull.Text = fullName;
                    litFirstName.Text = !string.IsNullOrEmpty(fullName) ? fullName.Split(' ')[0] : "Student";
                    lblExamHeader.Text = dr["ExamName"].ToString();
                    lblClassBadge.Text = dr["ClassName"].ToString();

                    // Bento Tiles
                    lblClassStat.Text = dr["ClassName"].ToString();
                    lblExamStat.Text = dr["ExamName"].ToString();
                    lblBoardStat.Text = dr["BoardName"].ToString();
                    lblCityStat.Text = dr["City"].ToString();
                    lblExamInsight.Text = dr["ExamName"].ToString();

                    // Modal fields (IDs preserved for Update Logic)
                    txtName.Text = fullName;
                    txtEmail.Text = dr["Email"].ToString();
                    if (dr["DOB"] != DBNull.Value)
                        txtDOB.Text = Convert.ToDateTime(dr["DOB"]).ToString("yyyy-MM-dd");

                    txtMobile.Text = dr["MobileNumber"].ToString();
                    txtState.Text = dr["State"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtPincode.Text = dr["Pincode"].ToString();
                    txtArea.Text = dr["Area"].ToString();
                    txtFullAddress.Text = dr["FullAddress"].ToString();

                    if (dr["TargetClassId"] != DBNull.Value) ddlClass.SelectedValue = dr["TargetClassId"].ToString();
                    if (dr["TargetBoardId"] != DBNull.Value) ddlBoard.SelectedValue = dr["TargetBoardId"].ToString();
                    if (dr["TargetExamId"] != DBNull.Value) ddlExam.SelectedValue = dr["TargetExamId"].ToString();

                    // Avatar Sync
                    string profilePic = dr["ProfilePicture"].ToString();
                    if (string.IsNullOrEmpty(profilePic)) profilePic = "../assets/img/Deault_Random_boy.png";

                    imgMainAvatar.ImageUrl = profilePic;
                    imgModalAvatar.ImageUrl = profilePic;
                    hfAvatar.Value = profilePic;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string imagePath = hfAvatar.Value;

            if (fuModalImage.HasFile)
            {
                string extension = System.IO.Path.GetExtension(fuModalImage.FileName).ToLower();
                if (extension == ".jpg" || extension == ".jpeg" || extension == ".png")
                {
                    string fileName = Guid.NewGuid().ToString() + extension;
                    string folderPath = Server.MapPath("~/Uploads/ProfileImages/");
                    if (!System.IO.Directory.Exists(folderPath)) System.IO.Directory.CreateDirectory(folderPath);
                    fuModalImage.SaveAs(System.IO.Path.Combine(folderPath, fileName));
                    imagePath = "/Uploads/ProfileImages/" + fileName;
                }
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"UPDATE StudentAdditionalInfo SET ProfilePicture=@img, MobileNumber=@mob, TargetClassId=@cid, 
                               TargetBoardId=@bid, TargetExamId=@eid, State=@state, City=@city, Pincode=@pin, 
                               Area=@area, FullAddress=@fadd WHERE UserId=@id;";

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

            LoadProfile();
            ClientScript.RegisterStartupScript(this.GetType(), "close", "closeModal();", true);
        }
    }
}