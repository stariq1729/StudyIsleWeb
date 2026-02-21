using System;
using System.Web;
using System.Web.Routing;

namespace StudyIsleWeb
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.Ignore("{resource}.axd/{*pathInfo}");

            // NCERT route
            routes.MapPageRoute(
     "NCERTResourceRoute",
     "ncert/{resourcetype}",
     "~/BoardResource.aspx"
 );
        }
    }
}