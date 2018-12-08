using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Lecturer
{
    public partial class ViewList : System.Web.UI.Page
    {
        private OnlineAssessmentDBEntities db;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.db = new OnlineAssessmentDBEntities();
        }

        protected void displayLectAssessGrid_Sorted(object sender, EventArgs e)
        {

        }

        public IQueryable<university_online_assessment.Models.Lecturer_Assessment> getLecturerAssessments()
        {
            Guid lecturerID = (Guid)Membership.GetUser().ProviderUserKey;
            return this.db.Lecturer_Assessment.Where(la => la.lecturerId == lecturerID);
        }
    }
}