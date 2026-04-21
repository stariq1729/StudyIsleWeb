using System;

namespace StudyIsleWeb
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            // Step 3 will handle OTP logic
            Response.Write("Signup button clicked");
        }

        protected void btnGoogleSignup_Click(object sender, EventArgs e)
        {
            // Reuse Google login logic
            Response.Redirect("Login.aspx");
        }
    }
}