using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace university_online_assessment
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            // Error/Not Found routes
            routes.MapPageRoute("GenericError", "Error", "~/Views/Error/Generic.aspx");
            routes.MapPageRoute("404Error", "404", "~/Views/Error/404.aspx");

            // Main homepage route
            routes.MapPageRoute("MainHomepage", "", "~/Views/Homepage.aspx");
            routes.MapPageRoute("LoginPage", "login", "~/Views/Login.aspx");

            // Admin route
            routes.MapPageRoute("RegisterStudent", "register/student", "~/Views/Admin/RegisterStudent.aspx");
            routes.MapPageRoute("RegisterLecturer", "register/lecturer", "~/Views/Admin/RegisterLecturer.aspx");
            routes.MapPageRoute("RegisterSubject", "register/subject", "~/Views/Admin/RegisterSubject.aspx");
            routes.MapPageRoute("ViewLists", "admin/list", "~/Views/Admin/ViewList.aspx");
        }
    }
}
