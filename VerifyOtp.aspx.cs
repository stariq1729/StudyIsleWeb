using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class VerifyOtp : System.Web.UI.Page
    {
        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string enteredOtp = txtOtp.Text.Trim();
            string sessionOtp = Session["SignupOTP"]?.ToString();

            if (enteredOtp != sessionOtp)
            {
                lblMessage.Text = "Invalid OTP";
                return;
            }

            // 🔹 Get data from Session
            string name = Session["SignupName"]?.ToString();
            string email = Session["SignupEmail"]?.ToString();
            string password = Session["SignupPassword"]?.ToString();

            string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string insertQuery = @"INSERT INTO Users
                    (FullName, Email, Password, LoginProvider, Role, CreatedAt, LastLoginAt)
                    VALUES
                    (@FullName, @Email, @Password, 'Local', 'Student', GETDATE(), GETDATE())";

                SqlCommand cmd = new SqlCommand(insertQuery, con);
                cmd.Parameters.AddWithValue("@FullName", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                cmd.ExecuteNonQuery();
            }

            // 🔹 Create session (auto login)
            Session["UserEmail"] = email;
            Session["UserName"] = name;
            Session["UserRole"] = "Student";

            // 🔹 Clear signup session
            Session.Remove("SignupOTP");
            Session.Remove("SignupName");
            Session.Remove("SignupEmail");
            Session.Remove("SignupPassword");

            // 🔹 Redirect
            Response.Redirect("~/Student/StudentIndex.aspx");
        }
    }
}