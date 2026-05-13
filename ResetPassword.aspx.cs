using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string newPassword =
                txtNewPassword.Text.Trim();

            string confirmPassword =
                txtConfirmPassword.Text.Trim();

            // 🔹 Validation
            if (string.IsNullOrEmpty(newPassword) ||
                string.IsNullOrEmpty(confirmPassword))
            {
                lblMessage.Text =
                    "All fields are required.";

                return;
            }

            // 🔹 Match password
            if (newPassword != confirmPassword)
            {
                lblMessage.Text =
                    "Passwords do not match.";

                return;
            }

            // 🔹 Get email from session
            string email =
                Session["ResetEmail"]?.ToString();

            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text =
                    "Session expired. Please try again.";

                return;
            }

            string cs =
                ConfigurationManager.ConnectionStrings["dbcs"]
                .ConnectionString;

            using (SqlConnection con =
                new SqlConnection(cs))
            {
                con.Open();

                // 🔹 Update password
                string query = @"
                    UPDATE Users
                    SET Password=@Password
                    WHERE Email=@Email";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Password", newPassword);
                cmd.Parameters.AddWithValue("@Email", email);

                cmd.ExecuteNonQuery();
            }

            // 🔹 Clear reset sessions
            Session.Remove("ResetEmail");
            Session.Remove("ResetOTP");

            // 🔹 Redirect to login
            Response.Redirect("Login.aspx");
        }
    }
}