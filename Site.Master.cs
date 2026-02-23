using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

                // Reset classes first (important)
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
            }
        }
    }
}