using System;
using System.Web;
using System.Web.UI;

namespace StudyIsleWeb
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // =========================
                // EXISTING NAVBAR LOGIC (UNCHANGED)
                // =========================
                string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

                navHome.Attributes["class"] = "nav-link nav-custom";
                navLive.Attributes["class"] = "nav-link nav-custom";
                navTest.Attributes["class"] = "nav-link nav-custom";
                navCareer.Attributes["class"] = "nav-link nav-custom";
                navBlogs.Attributes["class"] = "nav-link nav-custom";

                if (currentPage == "default.aspx")
                    navHome.Attributes["class"] += " active";

                else if (currentPage == "liveclasses.aspx")
                    navLive.Attributes["class"] += " active";

                else if (currentPage == "testseries.aspx")
                    navTest.Attributes["class"] += " active";

                else if (currentPage == "careerguidance.aspx")
                    navCareer.Attributes["class"] += " active";

                else if (currentPage == "blogs.aspx")
                    navBlogs.Attributes["class"] += " active";


                // =========================
                // NEW LOGIN / PROFILE LOGIC (ADDED SAFELY)
                // =========================
                if (Session["UserID"] != null)
                {
                    // User Logged In
                    guestButtons.Visible = false;
                    userProfile.Visible = true;

                    lblUserName.Text = Session["UserName"] != null ? Session["UserName"].ToString() : "User";
                    lblEmail.Text = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "";
                }
                else
                {
                    // Guest User
                    guestButtons.Visible = true;
                    userProfile.Visible = false;
                }
            }
        }

        // =========================
        // LOGOUT FUNCTION
        // =========================
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}