using System;
using System.Data.SqlClient;
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
                // LOGIN / PROFILE LOGIC
                // =========================
                if (Session["UserID"] != null)
                {
                    guestButtons.Visible = false;
                    userProfile.Visible = true;

                    lblUserName.Text = Session["UserName"]?.ToString() ?? "User";
                    lblEmail.Text = Session["UserEmail"]?.ToString() ?? "";

                    // ✅ PROFILE IMAGE FROM SESSION
                    // 🔥 FETCH PROFILE IMAGE FROM DB
                    string imagePath = "";

                    using (SqlConnection con = new SqlConnection(
                        System.Configuration.ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString))
                    {
                        string query = "SELECT ProfilePicture FROM StudentAdditionalInfo WHERE UserId=@UserId";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@UserId", Session["UserID"]);

                            con.Open();
                            object result = cmd.ExecuteScalar();

                            if (result != null && result != DBNull.Value)
                            {
                                imagePath = result.ToString();
                            }
                        }
                    }

                    // APPLY IMAGE
                    if (!string.IsNullOrEmpty(imagePath))
                    {
                        imgUserProfile.ImageUrl = ResolveUrl(imagePath);
                    }
                    else
                    {
                        imgUserProfile.ImageUrl = "~/assets/img/default-user.png";
                    }
                }
                else
                {
                    guestButtons.Visible = true;
                    userProfile.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}