using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Student
{
    public partial class StudentRegister : System.Web.UI.Page
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
                LoadUser();
                BindStep2();
            }
        }

        private void LoadUser()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT FullName, Email FROM Users WHERE UserId=@id", conn);
                cmd.Parameters.AddWithValue("@id", userId);

                conn.Open();
                var dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                }
            }
        }

        private void BindStep2()
        {
            Bind("TargetExams", rptExam);
            Bind("TargetClasses", rptClass);
            Bind("TargetBoards", rptBoard);
        }

        private void Bind(string table, Repeater rpt)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter($"SELECT Id, Name FROM {table}", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rpt.DataSource = dt;
                rpt.DataBind();
            }
        }

        protected void btnStep1Next_Click(object sender, EventArgs e)
        {
            if (!Regex.IsMatch(txtMobile.Text, @"^\d{10}$"))
            {
                Response.Write("<script>alert('Invalid Mobile');</script>");
                return;
            }

            if (!DateTime.TryParse(txtDOB.Text, out DateTime dob))
            {
                Response.Write("<script>alert('Invalid DOB');</script>");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM StudentAdditionalInfo WHERE UserId=@id", conn);
                check.Parameters.AddWithValue("@id", userId);

                int exists = (int)check.ExecuteScalar();

                SqlCommand cmd;

                if (exists == 0)
                {
                    cmd = new SqlCommand("INSERT INTO StudentAdditionalInfo (UserId,MobileNumber,DOB) VALUES (@id,@m,@d)", conn);
                }
                else
                {
                    cmd = new SqlCommand("UPDATE StudentAdditionalInfo SET MobileNumber=@m,DOB=@d WHERE UserId=@id", conn);
                }

                cmd.Parameters.AddWithValue("@id", userId);
                cmd.Parameters.AddWithValue("@m", txtMobile.Text);
                cmd.Parameters.AddWithValue("@d", dob);

                cmd.ExecuteNonQuery();
            }

            pnlStep1.Visible = false;
            pnlStep2.Visible = true;
        }

        protected void btnStep2Next_Click(object sender, EventArgs e)
        {
            if (hfExam.Value == "" || hfClass.Value == "" || hfBoard.Value == "")
            {
                Response.Write("<script>alert('Select all');</script>");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"UPDATE StudentAdditionalInfo
                    SET TargetExamId=@e,TargetClassId=@c,TargetBoardId=@b WHERE UserId=@id", conn);

                cmd.Parameters.AddWithValue("@e", hfExam.Value);
                cmd.Parameters.AddWithValue("@c", hfClass.Value);
                cmd.Parameters.AddWithValue("@b", hfBoard.Value);
                cmd.Parameters.AddWithValue("@id", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            pnlStep2.Visible = false;
            pnlStep3.Visible = true;
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            if (!Regex.IsMatch(txtPincode.Text, @"^\d{6}$"))
            {
                Response.Write("<script>alert('Invalid Pincode');</script>");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"UPDATE StudentAdditionalInfo
                    SET State=@s,City=@c,Pincode=@p,Area=@a,FullAddress=@f,IsProfileComplete=1
                    WHERE UserId=@id", conn);

                cmd.Parameters.AddWithValue("@s", txtState.Text);
                cmd.Parameters.AddWithValue("@c", txtCity.Text);
                cmd.Parameters.AddWithValue("@p", txtPincode.Text);
                cmd.Parameters.AddWithValue("@a", txtArea.Text);
                cmd.Parameters.AddWithValue("@f", txtAddress.Text);
                cmd.Parameters.AddWithValue("@id", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("~/Student/StudentProfile.aspx");
        }

        protected void btnBackStep2_Click(object sender, EventArgs e)
        {
            pnlStep2.Visible = false;
            pnlStep1.Visible = true;
        }

        protected void btnBackStep3_Click(object sender, EventArgs e)
        {
            pnlStep3.Visible = false;
            pnlStep2.Visible = true;
        }
    }
}