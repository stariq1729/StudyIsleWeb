using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class Default : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string country = ddlCountry.SelectedValue;
                string grade = ddlGrade.SelectedValue;
                string board = ddlBoard.SelectedValue;
                string timeline = rblTimeline.SelectedValue;

                // Collect multiple selected subjects
                StringBuilder subjects = new StringBuilder();
                foreach (ListItem item in chkSubjects.Items)
                {
                    if (item.Selected)
                    {
                        subjects.Append(item.Value + ", ");
                    }
                }

                string subjectList = subjects.ToString().TrimEnd(',', ' ');

              

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Enquiries
                            (FullName, Email, Phone, Country, Grade, Board, Subjects, Timeline)
                            VALUES
                            (@FullName, @Email, @Phone, @Country, @Grade, @Board, @Subjects, @Timeline)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Country", country);
                        cmd.Parameters.AddWithValue("@Grade", grade);
                        cmd.Parameters.AddWithValue("@Board", board);
                        cmd.Parameters.AddWithValue("@Subjects", subjectList);
                        cmd.Parameters.AddWithValue("@Timeline", timeline);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                ClearForm();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alert('Enquiry submitted successfully!');", true);
            }

        }
        private void ClearForm()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlCountry.SelectedIndex = 0;
            ddlGrade.SelectedIndex = 0;
            ddlBoard.SelectedIndex = 0;
            rblTimeline.ClearSelection();

            foreach (ListItem item in chkSubjects.Items)
            {
                item.Selected = false;
            }
        }


    }
}