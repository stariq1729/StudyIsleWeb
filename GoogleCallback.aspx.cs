using Google.Apis.Auth;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

namespace StudyIsleWeb
{
    public partial class GoogleCallback : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private string role = string.Empty;

        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                await HandleGoogleLogin();
            }
        }

        /// <summary>
        /// Handles Google OAuth authentication and user session creation.
        /// </summary>
        private async Task HandleGoogleLogin()
        {
            try
            {
                string code = Request.QueryString["code"];

                if (string.IsNullOrEmpty(code))
                {
                    Response.Write("Authorization code missing.");
                    return;
                }

                string clientId = ConfigurationManager.AppSettings["GoogleClientId"];
                string clientSecret = ConfigurationManager.AppSettings["GoogleClientSecret"];
                string redirectUri = ConfigurationManager.AppSettings["GoogleRedirectUri"];

                using (var client = new HttpClient())
                {
                    // Exchange authorization code for tokens
                    var values = new[]
                    {
                        new KeyValuePair<string, string>("code", code),
                        new KeyValuePair<string, string>("client_id", clientId),
                        new KeyValuePair<string, string>("client_secret", clientSecret),
                        new KeyValuePair<string, string>("redirect_uri", redirectUri),
                        new KeyValuePair<string, string>("grant_type", "authorization_code")
                    };

                    var content = new FormUrlEncodedContent(values);
                    var response = await client.PostAsync(
                        "https://oauth2.googleapis.com/token", content);

                    var responseString = await response.Content.ReadAsStringAsync();
                    var tokenData = JObject.Parse(responseString);

                    string idToken = tokenData["id_token"]?.ToString();

                    if (string.IsNullOrEmpty(idToken))
                    {
                        Response.Write("Invalid Google token.");
                        return;
                    }

                    // Validate ID Token
                    var payload = await GoogleJsonWebSignature.ValidateAsync(idToken);

                    string email = payload.Email;
                    string fullName = payload.Name;

                    // Store or update user in database
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        con.Open();

                        // Check if user exists
                        string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                        {
                            checkCmd.Parameters.AddWithValue("@Email", email);
                            int userCount = (int)checkCmd.ExecuteScalar();

                            if (userCount == 0)
                            {
                                // Insert new user
                                string insertQuery = @"
                                    INSERT INTO Users
                                    (FullName, Email, LoginProvider, Role, CreatedAt, LastLoginAt)
                                    VALUES
                                    (@FullName, @Email, 'Google', 'Student', GETDATE(), GETDATE())";

                                using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                                {
                                    insertCmd.Parameters.AddWithValue("@FullName", fullName);
                                    insertCmd.Parameters.AddWithValue("@Email", email);
                                    insertCmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // Update last login
                                string updateQuery = @"
                                    UPDATE Users 
                                    SET LastLoginAt = GETDATE() 
                                    WHERE Email=@Email";

                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                                {
                                    updateCmd.Parameters.AddWithValue("@Email", email);
                                    updateCmd.ExecuteNonQuery();
                                }
                            }
                        }

                        // Fetch user role
                        string roleQuery = "SELECT Role FROM Users WHERE Email=@Email";
                        using (SqlCommand roleCmd = new SqlCommand(roleQuery, con))
                        {
                            roleCmd.Parameters.AddWithValue("@Email", email);
                            role = Convert.ToString(roleCmd.ExecuteScalar());
                        }
                    }

                    // Create user session
                    Session["UserEmail"] = email;
                    Session["UserName"] = fullName;
                    Session["UserRole"] = role;

                    // Retrieve ReturnUrl from OAuth state parameter
                    string returnUrl = Request.QueryString["state"];

                    // Redirect safely
                    if (!string.IsNullOrEmpty(returnUrl) && IsLocalUrl(returnUrl))
                    {
                        Response.Redirect(returnUrl, false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }

                    // Role-based fallback redirection
                    RedirectUserByRole(role);
                }
            }
            catch (Exception ex)
            {
                Response.Write("Google Authentication Error: " + ex.Message);
            }
        }

        /// <summary>
        /// Ensures the URL is local to prevent open redirect vulnerabilities.
        /// </summary>
        private bool IsLocalUrl(string url)
        {
            if (string.IsNullOrEmpty(url))
                return false;

            return ((url.StartsWith("/") && !url.StartsWith("//") && !url.StartsWith("/\\"))
                    || url.StartsWith("~/"));
        }

        /// <summary>
        /// Redirects users based on their role.
        /// </summary>
        private void RedirectUserByRole(string role)
        {
            if (role == "Admin")
            {
                Response.Redirect("~/Admin/AdminIndex.aspx", false);
            }
            else if (role == "Student")
            {
                Response.Redirect("~/Student/StudentIndex.aspx", false);
            }
            else
            {
                Response.Redirect("~/Login.aspx", false);
            }

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}