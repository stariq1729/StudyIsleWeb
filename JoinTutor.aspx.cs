using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class JoinTutor : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string fullName = txtName.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            string email = txtEmail.Text.Trim();
            string location = txtLocation.Text.Trim();
            string qualification = ddlQualification.SelectedValue;
            string experience = ddlExperience.SelectedValue;
            string employment = ddlEmployment.SelectedValue;
            string demoLink = txtDemoLink.Text.Trim();

            // Subjects
            string subjects = "";
            if (chkMaths.Checked) subjects += "Maths,";
            if (chkPhysics.Checked) subjects += "Physics,";
            if (chkChemistry.Checked) subjects += "Chemistry,";
            if (chkBiology.Checked) subjects += "Biology,";
            if (chkEnglish.Checked) subjects += "English,";
            
            if (chkComputer.Checked) subjects += "Computer,";

            subjects = subjects.TrimEnd(',');

            // Classes
            string classes = "";
            if (chk6to8.Checked) classes += "Class 6–8,";
            if (chk9to10.Checked) classes += "Class 9–10,";
            if (chk11to12.Checked) classes += "Class 11–12,";

            classes = classes.TrimEnd(',');

            // Boards
            string boards = "";
            if (chkCBSE.Checked) boards += "CBSE,";
            if (chkICSE.Checked) boards += "ICSE,";
            if (chkIB.Checked) boards += "IB,";
            if (chkIGCSE.Checked) boards += "IGCSE,";
            if (chkAP.Checked) boards += "AP,";
            if (chkStateBoard.Checked) boards += "State Board,";

            boards = boards.TrimEnd(',');

            // Resume
            string resumePath = "";

            if (fileResume.HasFile)
            {
                string extension = Path.GetExtension(fileResume.FileName);

                if (extension.ToLower() != ".pdf")
                {
                    Response.Write("<script>alert('Only PDF allowed');</script>");
                    return;
                }

                string fileName = Guid.NewGuid().ToString() + extension;
                string savePath = Server.MapPath("~/Uploads/Resumes/") + fileName;

                fileResume.SaveAs(savePath);

                resumePath = "Uploads/Resumes/" + fileName;
            }

            string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO TutorApplications
        (FullName, Mobile, Email, Location,
         Qualification, Experience, EmploymentStatus,
         Subjects, Classes, Boards,
         DemoLink, ResumePath)
         VALUES
        (@FullName, @Mobile, @Email, @Location,
         @Qualification, @Experience, @EmploymentStatus,
         @Subjects, @Classes, @Boards,
         @DemoLink, @ResumePath)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@Qualification", qualification);
                    cmd.Parameters.AddWithValue("@Experience", experience);
                    cmd.Parameters.AddWithValue("@EmploymentStatus", employment);
                    cmd.Parameters.AddWithValue("@Subjects", subjects);
                    cmd.Parameters.AddWithValue("@Classes", classes);
                    cmd.Parameters.AddWithValue("@Boards", boards);
                    cmd.Parameters.AddWithValue("@DemoLink", demoLink);
                    cmd.Parameters.AddWithValue("@ResumePath", resumePath);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Write("<script>alert('Application Submitted Successfully!'); window.location='Default.aspx';</script>");
        }

    }
}