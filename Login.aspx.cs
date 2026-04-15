using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is already logged in, redirect accordingly
            if (Session["UserRole"] != null)
            {
                RedirectUser(Session["UserRole"].ToString());
            }
        }

        // 🔹 Email & Password Login
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT UserId, FullName, Role 
                                 FROM Users 
                                 WHERE Email=@Email 
                                 AND Password=@Password 
                                 AND IsActive=1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    Session["UserId"] = reader["UserId"];
                    Session["UserName"] = reader["FullName"].ToString();
                    Session["UserRole"] = reader["Role"].ToString();
                    Session["UserEmail"] = email;

                    RedirectUser(reader["Role"].ToString());
                }
                else
                {
                    // Optional: Display error message
                    // lblError.Text = "Invalid email or password.";
                }
            }
        }

        // 🔹 Google Login Button Click
        protected void btnGoogleLogin_Click(object sender, EventArgs e)
        {
            string clientId = ConfigurationManager.AppSettings["GoogleClientId"];

            // Get ReturnUrl from query string
            string returnUrl = Request.QueryString["ReturnUrl"];

            // Append ReturnUrl to GoogleCallback
            string redirectUri = "https://localhost:44301/GoogleCallback.aspx";

            if (!string.IsNullOrEmpty(returnUrl))
            {
                redirectUri += "?ReturnUrl=" + HttpUtility.UrlEncode(returnUrl);
            }

            string scope = "openid email profile";

            string googleAuthUrl =
                "https://accounts.google.com/o/oauth2/v2/auth" +
                "?client_id=" + clientId +
                "&redirect_uri=" + HttpUtility.UrlEncode(redirectUri) +
                "&response_type=code" +
                "&scope=" + HttpUtility.UrlEncode(scope) +
                "&access_type=offline" +
                "&prompt=select_account";

            Response.Redirect(googleAuthUrl);
        }

        // 🔹 Centralized Role-Based Redirect
        private void RedirectUser(string role)
        {
            if (role == "Admin")
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
            }
            else
            {
                Response.Redirect("~/Student/StudentIndex.aspx");
            }
        }
    }
}