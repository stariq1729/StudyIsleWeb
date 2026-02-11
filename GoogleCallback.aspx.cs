using Google.Apis.Auth;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Data;
using System.Data.SqlClient;



namespace StudyIsleWeb
{
    public partial class GoogleCallback : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                await HandleGoogleLogin();
            }
        }
        private async Task HandleGoogleLogin()
        {
            string code = Request.QueryString["code"];

            if (string.IsNullOrEmpty(code))
            {
                Response.Write("Authorization code missing.");
                return;
            }

            string clientId = ConfigurationManager.AppSettings["GoogleClientId"];
            string clientSecret = ConfigurationManager.AppSettings["GoogleClientSecret"];
            string redirectUri = "https://localhost:44301/GoogleCallback.aspx";

            using (var client = new HttpClient())
            {
                var values = new[]
                {
            new KeyValuePair<string, string>("code", code),
            new KeyValuePair<string, string>("client_id", clientId),
            new KeyValuePair<string, string>("client_secret", clientSecret),
            new KeyValuePair<string, string>("redirect_uri", redirectUri),
            new KeyValuePair<string, string>("grant_type", "authorization_code")
        };

                var content = new FormUrlEncodedContent(values);
                var response = await client.PostAsync("https://oauth2.googleapis.com/token", content);
                var responseString = await response.Content.ReadAsStringAsync();

                var tokenData = JObject.Parse(responseString);
                string idToken = tokenData["id_token"].ToString();

                var payload = await GoogleJsonWebSignature.ValidateAsync(idToken);

                string email = payload.Email;
                string fullName = payload.Name;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Check if user exists
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", email);

                    int userCount = (int)checkCmd.ExecuteScalar();

                    if (userCount == 0)
                    {
                        // Insert new user
                        string insertQuery = @"INSERT INTO Users 
                               (FullName, Email, LoginProvider, CreatedAt, LastLoginAt)
                               VALUES 
                               (@FullName, @Email, 'Google', GETDATE(), GETDATE())";

                        SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                        insertCmd.Parameters.AddWithValue("@FullName", fullName);
                        insertCmd.Parameters.AddWithValue("@Email", email);

                        insertCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        // Update Last Login
                        string updateQuery = "UPDATE Users SET LastLoginAt = GETDATE() WHERE Email=@Email";

                        SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                        updateCmd.Parameters.AddWithValue("@Email", email);

                        updateCmd.ExecuteNonQuery();
                    }
                }

                Response.Write("User Saved Successfully");

            }
        }

    }
}