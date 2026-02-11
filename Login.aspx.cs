using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGoogleLogin_Click(object sender, EventArgs e)
        {
            string clientId = ConfigurationManager.AppSettings["GoogleClientId"];
            string redirectUri = "https://localhost:44301/GoogleCallback.aspx";
        

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
    }
}