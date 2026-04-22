using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Student
{
    public partial class StudentProfile : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
                LoadResources();
            }
        }

        private void LoadProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                SELECT u.FullName,
                       s.City,
                       s.Avatar,
                       c.Name AS ClassName,
                       b.Name AS BoardName,
                       e.Name AS ExamName
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
                    imgAvatar.ImageUrl = string.IsNullOrEmpty(avatar) ? "/images/avatar1.png" : avatar;
                    imgModalAvatar.ImageUrl = imgAvatar.ImageUrl;

                    txtName.Text = dr["FullName"].ToString();
                }
            }
        }

        private void LoadResources()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
        SELECT 
            b.ItemType,
            b.ItemId,
            r.Title,
            q.QuizLabel
        FROM Bookmarks b
        LEFT JOIN Resources r 
            ON b.ItemId = r.ResourceId 
            AND b.ItemType = 'Resource'
        LEFT JOIN Quiz q 
            ON b.ItemId = q.QuizId 
            AND b.ItemType = 'Quiz'
        WHERE b.UserId = @uid
        ORDER BY b.CreatedAt DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uid", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptResources.DataSource = dt;
                rptResources.DataBind();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmd1 = new SqlCommand("UPDATE Users SET FullName=@n WHERE UserId=@id", conn);
                cmd1.Parameters.AddWithValue("@n", txtName.Text);
                cmd1.Parameters.AddWithValue("@id", userId);
                cmd1.ExecuteNonQuery();

                SqlCommand cmd2 = new SqlCommand("UPDATE StudentAdditionalInfo SET Avatar=@a WHERE UserId=@id", conn);
                cmd2.Parameters.AddWithValue("@a", hfAvatar.Value);
                cmd2.Parameters.AddWithValue("@id", userId);
                cmd2.ExecuteNonQuery();
            }

            LoadProfile();
        }
    }
}