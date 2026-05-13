using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

namespace StudyIsleWeb
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void btnSendOtp_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            // 🔹 Validate
            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Please enter your email.";
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 🔹 Check if email exists
                string query = "SELECT COUNT(*) FROM Users WHERE Email=@Email";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);

                int count = (int)cmd.ExecuteScalar();

                if (count == 0)
                {
                    lblMessage.Text = "Email not found.";
                    return;
                }
            }

            // 🔹 Generate OTP
            Random rnd = new Random();
            int otp = rnd.Next(100000, 999999);

            // 🔹 Store in Session
            Session["ResetEmail"] = email;
            Session["ResetOTP"] = otp.ToString();

            // 🔹 SMTP Config
            string smtpEmail =
                ConfigurationManager.AppSettings["SmtpEmail"];

            string smtpPassword =
                ConfigurationManager.AppSettings["SmtpPassword"];

            string smtpHost =
                ConfigurationManager.AppSettings["SmtpHost"];

            int smtpPort =
                Convert.ToInt32(
                    ConfigurationManager.AppSettings["SmtpPort"]);

            try
            {
                MailMessage msg = new MailMessage();

                msg.From = new MailAddress(smtpEmail);

                msg.To.Add(email);

                msg.Subject = "StudyIsle - Password Reset OTP";

                msg.Body =
                    "Your OTP for password reset is: " + otp;

                SmtpClient smtp =
                    new SmtpClient(smtpHost, smtpPort);

                smtp.Credentials =
                    new NetworkCredential(smtpEmail, smtpPassword);

                smtp.EnableSsl = true;

                smtp.Send(msg);

                // 🔹 Redirect
                Response.Redirect("VerifyResetOtp.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text =
                    "Email sending failed: " + ex.Message;
            }
        }
    }
}