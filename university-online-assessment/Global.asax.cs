using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using university_online_assessment.Models;

namespace university_online_assessment
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Call initialization methods
            initApplicationRoles();
            initProgrammeDatabase();
            initSubjectDatabase();
            initAdminAccount();

            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        /**
         * Private method for initializing
         * aspnet_Roles table in database
         */
        private void initApplicationRoles()
        {
            // Declare roles for this application
            string[] app_roles = {
                "Admin",
                "Lecturer",
                "Student"
            };

            // Loop through roles and create them 
            foreach (string role in app_roles)
            {
                if (!Roles.RoleExists(role))
                {
                    Roles.CreateRole(role);
                }
            }
        }

        /**
         * Private method for initializing
         * aspnet_Roles table in database
         */
        private void initProgrammeDatabase()
        {
            // Declare programmes for this application
            string[] programmes = {
                "[FOCS] Bachelor of Information Technology - Software Systems Development (RSD)",
                "[FOCS] Bachelor of Information Technology - Internet Technology (RIT)",
                "[FCCI] Bachelor of Communication & Creative Industries - Advertising (RAC)",
                "[FCCI] Bachelor of Communication & Creative Industries - Broadcasting (RBC)",
                "[FAFB] Bachelor of Accountancy, Finance & Business - Marketing (RMA)",
                "[FAFB] Bachelor of Accountancy, Finance & Business - Accounting (RAA)",
            };

            /**
            * Temporarily use db connection to insert the programmes
            */
            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                // Loop through each prog and create them 
                foreach (string prog in programmes)
                {
                    // Check if the subject already exist in database
                    if (db.Programme.Where(s => s.progName == prog).FirstOrDefault() is null)
                    {
                        try
                        {
                            // Create new Programme object
                            Programme newProg = new Programme();
                            newProg.progId = Guid.NewGuid();
                            newProg.progName = prog;
                            newProg.faculty = prog.Substring(1, 4);

                            // Save the new programme into database
                            db.Programme.Add(newProg);
                            db.SaveChanges();
                        }
                        catch (Exception ex)
                        {
                            throw new Exception($"An exception occured when inserting programme: {ex.Message}");
                        }
                    }
                }
            }
        }

        /**
         * Private method for creating an
         * admin account.
         */
        private void initAdminAccount()
        {
            // Check if admin account is null or not
            if (Membership.GetUser("admin123") is null)
            {
                // Create an admin account and add it into "Admin" role
                Membership.CreateUser("admin123", "admin12345", "admin@example.com");
                Roles.AddUserToRole("admin123", "Admin");
            }
        }

        /**
         * Private method for initializing
         * Subject table in database
         */
        private void initSubjectDatabase()
        {
            // Declare subjects for the application
            string[] subjects =
            {
                "BACS2053 Object-Oriented Analysis and Design",
                "BACS2063 Data Structures & Algorithms",
                "BAIT2164 Computer Networks",
                "BAIT2113 Web Application Development",
                "AACA2132 Financial Accounting",
                "AACA3232 Principles of Finance",
                "AACA3431 Fundamentals of Auditing",
                "AACA2322 Pricing Strategy",
                "ADMK2563 Digital Marketing",
                "ADMK3262 Principles of Marketing",
                "ACHC2362 Production and Multimedia",
                "ACHC2342 Television Production",
                "ABCI2423 Advanced Photography",
                "ABCC2212 Consumer Behaviour and Culture",
            };

            /**
             * Temporarily use db connection to insert the subjects
             */
            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                // Loop through each subject and create them 
                foreach (string subject in subjects)
                {
                    // Check if the subject already exist in database
                    if (db.Subject.Where(s => s.subjectName == subject).FirstOrDefault() is null)
                    {
                        try
                        {
                            // Create new Subject object
                            Subject sub = new Subject();
                            sub.Id = Guid.NewGuid();
                            sub.subjectName = subject;
                            sub.creditHours = Convert.ToInt32(subject.Substring(7, 1));

                            // Save the new subject into database
                            db.Subject.Add(sub);
                            db.SaveChanges();
                        }
                        catch (Exception ex)
                        {
                            throw new Exception($"An exception occured when inserting subjects: {ex.Message}");
                        }
                    }
                }
            }
        }
    }
}