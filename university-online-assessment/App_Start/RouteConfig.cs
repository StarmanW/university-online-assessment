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

            // Main homepage route
            routes.MapPageRoute("MainHomepage", "", "~/Views/Homepage.aspx");
            routes.MapPageRoute("LoginPage", "login", "~/Views/Login.aspx");

            // Admin route
            routes.MapPageRoute("RegisterLecturer", "register/lecturer", "~/Views/Admin/RegisterLecturer.aspx");
        }
    }
}
