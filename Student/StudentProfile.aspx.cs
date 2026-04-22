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
                SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name FROM TargetClasses; SELECT Id, Name FROM TargetBoards;", conn);
                DataSet ds = new DataSet();
                da.Fill(ds);

                ddlClass.DataSource = ds.Tables[0];
                ddlClass.DataTextField = "Name";
                ddlClass.DataValueField = "Id";
                ddlClass.DataBind();

                ddlBoard.DataSource = ds.Tables[1];
                ddlBoard.DataTextField = "Name";
                ddlBoard.DataValueField = "Id";
                ddlBoard.DataBind();
            }
        }

        private void LoadProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT u.FullName, s.City, s.Avatar, s.DOB, s.TargetClassId, s.TargetBoardId,
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
                    lblName.Text = dr["FullName"].ToString();
                    lblCity.Text = dr["City"].ToString();
                    lblClass.Text = dr["ClassName"].ToString();
                    lblBoard.Text = dr["BoardName"].ToString();
                    lblExam.Text = dr["ExamName"].ToString();

                    string avatar = dr["Avatar"].ToString();
                    imgAvatar.ImageUrl = string.IsNullOrEmpty(avatar) ? "../assets/img/Deault_Random_boy.png" : avatar;
                    imgModalAvatar.ImageUrl = imgAvatar.ImageUrl;
                    hfAvatar.Value = imgAvatar.ImageUrl;

                    txtName.Text = dr["FullName"].ToString();
                    if (dr["DOB"] != DBNull.Value)
                        txtDOB.Text = Convert.ToDateTime(dr["DOB"]).ToString("yyyy-MM-dd");

                    ddlClass.SelectedValue = dr["TargetClassId"].ToString();
                    ddlBoard.SelectedValue = dr["TargetBoardId"].ToString();
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
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"
                    UPDATE Users SET FullName=@n WHERE UserId=@id;
                    UPDATE StudentAdditionalInfo SET Avatar=@a, DOB=@dob, TargetClassId=@cid, TargetBoardId=@bid WHERE UserId=@id;";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@n", txtName.Text);
                cmd.Parameters.AddWithValue("@a", hfAvatar.Value);
                cmd.Parameters.AddWithValue("@dob", txtDOB.Text);
                cmd.Parameters.AddWithValue("@cid", ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@bid", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@id", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
            LoadProfile();
            ClientScript.RegisterStartupScript(this.GetType(), "close", "closeModal();", true);
        }
    }
}