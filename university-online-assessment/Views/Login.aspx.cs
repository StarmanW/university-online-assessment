using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace university_online_assessment.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void studentLoginBtn_Click(object sender, EventArgs e)
        {
            // Remember the current tab is student
            hfTab.Value = "student";

            // Try validate the login credential
            if (Membership.ValidateUser(studId.Text, studPassword.Text))
            {
                FormsAuthentication.RedirectFromLoginPage(studId.Text, studentRememberMe.Checked);
            }
            else
            {
                studentLoginInfo.Text = "The ID or password entered is incorrect, please try again.";
            }
        }

        protected void lecturerLoginBtn_Click(object sender, EventArgs e)
        {
            // Remember the current tab is lecturer
            hfTab.Value = "lecturer";

            // Try validate the login credential
            if (Membership.ValidateUser(lecturerId.Text, lecturerPassword.Text))
            {
                FormsAuthentication.RedirectFromLoginPage(lecturerId.Text, lecturerRememberMe.Checked);
            }
            else
            {
                lecturerLoginInfo.Text = "The ID or password entered is incorrect, please try again.";
            }
        }

        protected void adminLoginBtn_Click(object sender, EventArgs e)
        {
            // Remember the current tab is admin
            hfTab.Value = "admin";

            // Try validate the login credential
            if (Membership.ValidateUser(adminId.Text, adminPassword.Text))
            {
                FormsAuthentication.RedirectFromLoginPage(adminId.Text, adminRememberMe.Checked);
            }
            else
            {
                adminLoginInfo.Text = "The ID or password entered is incorrect, please try again.";
            }
        }
    }
}