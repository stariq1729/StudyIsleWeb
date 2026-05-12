using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class ContactUs : System.Web.UI.Page
    {
        // CONNECTION STRING
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // SUBMIT BUTTON
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // GET VALUES
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string subject = ddlSubject.SelectedValue.Trim();
            string message = txtMessage.Text.Trim();

            // VALIDATION
            if (string.IsNullOrEmpty(fullName))
            {
                ShowMessage("Please enter full name.", "red");
                return;
            }

            if (string.IsNullOrEmpty(email))
            {
                ShowMessage("Please enter email address.", "red");
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter valid email address.", "red");
                return;
            }

            if (string.IsNullOrEmpty(subject))
            {
                ShowMessage("Please select subject.", "red");
                return;
            }

            if (string.IsNullOrEmpty(message))
            {
                ShowMessage("Please enter your message.", "red");
                return;
            }

            // INSERT INTO DATABASE
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                        INSERT INTO ContactMessages
                        (
                            FullName,
                            Email,
                            Subject,
                            Message,
                            IPAddress
                        )
                        VALUES
                        (
                            @FullName,
                            @Email,
                            @Subject,
                            @Message,
                            @IPAddress
                        )";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.Parameters.AddWithValue("@IPAddress", GetIPAddress());

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // SUCCESS MESSAGE
                ShowMessage("Your message has been submitted successfully.", "green");

                // CLEAR FORM
                ClearForm();
            }
            catch (Exception ex)
            {
                ShowMessage("Something went wrong. Please try again.", "red");

                // OPTIONAL
                // Response.Write(ex.Message);
            }
        }

        // SHOW MESSAGE
        private void ShowMessage(string message, string color)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = System.Drawing.Color.FromName(color);
        }

        // CLEAR FORM
        private void ClearForm()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";

            ddlSubject.SelectedIndex = 0;
        }

        // EMAIL VALIDATION
        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);

                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        // GET USER IP ADDRESS
        private string GetIPAddress()
        {
            string ipAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (string.IsNullOrEmpty(ipAddress))
            {
                ipAddress = Request.ServerVariables["REMOTE_ADDR"];
            }

            return ipAddress;
        }
    }
}