using System;

namespace StudyIsleWeb
{
    public partial class VerifyResetOtp : System.Web.UI.Page
    {
        protected void btnVerifyOtp_Click(object sender, EventArgs e)
        {
            string enteredOtp = txtOtp.Text.Trim();

            string sessionOtp =
                Session["ResetOTP"]?.ToString();

            // 🔹 Check session
            if (string.IsNullOrEmpty(sessionOtp))
            {
                lblMessage.Text =
                    "OTP session expired. Please try again.";

                return;
            }

            // 🔹 Verify OTP
            if (enteredOtp != sessionOtp)
            {
                lblMessage.Text =
                    "Invalid OTP.";

                return;
            }

            // 🔹 OTP verified successfully
            Response.Redirect("ResetPassword.aspx");
        }
    }
}