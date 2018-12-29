using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using university_online_assessment.Models;

namespace university_online_assessment
{
    public partial class NavBarUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the request is authenticated
            if (Request.IsAuthenticated)
            {
                // Find label from the loginView control
                Label userNameLbl = loginView.FindControl("userName") as Label;

                // Connect to DB to retrieve first name of the logged-in user
                using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
                {
                    // Find user by UUID
                    aspnet_Users user = db.aspnet_Users.Find(Membership.GetUser().ProviderUserKey);

                    // If the user is not a lecturer
                    if (user.Lecturer_Profile == null && user.Student_Profile != null)
                    {
                        userNameLbl.Text = user.Student_Profile.firstName;
                    }
                    else if (user.Student_Profile == null && user.Lecturer_Profile != null)
                    {
                        userNameLbl.Text = user.Lecturer_Profile.firstName;
                    }
                    else
                    {
                        userNameLbl.Text = user.UserName;
                    }
                }
            }
        }
    }
}