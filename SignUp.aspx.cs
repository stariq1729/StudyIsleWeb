using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

namespace StudyIsleWeb
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // 🔹 Step 1: Basic Validation
            if (string.IsNullOrEmpty(name) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password))
            {
                Response.Write("All fields are required");
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 🔹 Step 2: Check if email already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    Response.Write("Email already exists. Please login.");
                    return;
                }
            }

            // 🔹 Step 3: Generate OTP
            Random rnd = new Random();
            int otp = rnd.Next(100000, 999999);

            // 🔹 Step 4: Store data in Session
            Session["SignupName"] = name;
            Session["SignupEmail"] = email;
            Session["SignupPassword"] = password;
            Session["SignupOTP"] = otp.ToString();

            // 🔹 TEMP (for testing)
            // 🔹 Get SMTP config from Web.config
            string smtpEmail = ConfigurationManager.AppSettings["SmtpEmail"];
            string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"];
            string smtpHost = ConfigurationManager.AppSettings["SmtpHost"];
            int smtpPort = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPort"]);

            try
            {
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(smtpEmail);
                msg.To.Add(email);
                msg.Subject = "StudyIsle - Email Verification OTP";
                msg.Body = "Your OTP for signup is: " + otp;

                SmtpClient smtp = new SmtpClient(smtpHost, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpEmail, smtpPassword);
                smtp.EnableSsl = true;

                smtp.Send(msg);

                // 🔹 Redirect after sending email
                Response.Redirect("VerifyOtp.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("Email sending failed: " + ex.Message);
            }

            // 🔹 Step 5: Redirect (we will enable later)
            // Response.Redirect("VerifyOtp.aspx");
        }

        protected void btnGoogleSignup_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}