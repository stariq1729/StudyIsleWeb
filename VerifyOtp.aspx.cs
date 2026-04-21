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

            // 🔹 Validate OTP
            if (string.IsNullOrEmpty(sessionOtp) || enteredOtp != sessionOtp)
            {
                lblMessage.Text = "Invalid OTP";
                return;
            }

            // 🔹 Get data from Session
            string name = Session["SignupName"]?.ToString();
            string email = Session["SignupEmail"]?.ToString();
            string password = Session["SignupPassword"]?.ToString();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Session expired. Please signup again.";
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
            int userId = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 🔹 Insert + get newly created UserId
                string insertQuery = @"
                    INSERT INTO Users
                    (FullName, Email, Password, LoginProvider, Role, CreatedAt, LastLoginAt)
                    VALUES
                    (@FullName, @Email, @Password, 'Local', 'Student', GETDATE(), GETDATE());

                    SELECT CAST(SCOPE_IDENTITY() AS INT);
                ";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        userId = Convert.ToInt32(result);
                    }
                }
            }

            if (userId == 0)
            {
                lblMessage.Text = "Something went wrong. Please try again.";
                return;
            }

            // 🔹 Create session (IMPORTANT: include UserId)
            Session["UserId"] = userId;
            Session["UserEmail"] = email;
            Session["UserName"] = name;
            Session["UserRole"] = "Student";

            // 🔹 Flag: profile setup pending
            Session["IsProfileSetupPending"] = true;

            // 🔹 Clear signup session
            Session.Remove("SignupOTP");
            Session.Remove("SignupName");
            Session.Remove("SignupEmail");
            Session.Remove("SignupPassword");

            // 🔹 Redirect to profile setup
            Response.Redirect("~/Student/StudentRegister.aspx");
        }
    }
}