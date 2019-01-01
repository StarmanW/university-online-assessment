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
            routes.MapPageRoute("RegisterStudent", "admin/register/student", "~/Views/Admin/RegisterStudent.aspx");
            routes.MapPageRoute("RegisterLecturer", "admin/register/lecturer", "~/Views/Admin/RegisterLecturer.aspx");
            routes.MapPageRoute("RegisterSubject", "admin/register/subject", "~/Views/Admin/RegisterSubject.aspx");
            routes.MapPageRoute("AdminViewList", "admin/list", "~/Views/Admin/AdminViewList.aspx");

            // Lecturer route
            routes.MapPageRoute("PreCreateQuestion", "lecturer/assessment/pre_create", "~/Views/Lecturer/PreCreateAssessment.aspx");
            routes.MapPageRoute("CreateQuestion", "lecturer/assessment/create", "~/Views/Lecturer/CreateAssessment.aspx");
            routes.MapPageRoute("LecturerViewList", "lecturer/list", "~/Views/Lecturer/LecturerViewList.aspx");
            routes.MapPageRoute("EditAssessment", "lecturer/assessment/{id}/edit", "~/Views/Lecturer/EditAssessment.aspx");
            routes.MapPageRoute("StudentAssessmentList", "lecturer/list/student/assessment", "~/Views/Lecturer/StudentAssessmentsList.aspx");
            routes.MapPageRoute("MarkAssessmentList", "lecturer/list/assessment/{id}", "~/Views/Lecturer/MarkAssessmentList.aspx");
            routes.MapPageRoute("MarkWrittenAssessment", "lecturer/list/assessment/{id}/{studId}/mark", "~/Views/Lecturer/MarkWrittenAssessment.aspx");

            // Student routes
            routes.MapPageRoute("StudentViewLists", "student/list", "~/Views/Student/StudentViewList.aspx");
            routes.MapPageRoute("StudentAssessment", "student/assessment/{id}", "~/Views/Student/StudentAssessment.aspx");
        }
    }
}
