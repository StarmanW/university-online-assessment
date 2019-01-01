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

            if (Session["assessCreated"] != null && Session["assessName"] != null)
            {
                assessName.Text = Session["assessName"].ToString();
                alertPlaceholder.Visible = true;
            }
        }

        protected void displayLectAssessGrid_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-assessments";
        }

        public IQueryable<university_online_assessment.Models.Lecturer_Assessment> getLecturerAssessments()
        {
            Guid lecturerID = (Guid)Membership.GetUser().ProviderUserKey;
            return this.db.Lecturer_Assessment.Where(la => la.lecturerId == lecturerID);
        }

        protected void displayStudentList_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-students";
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<university_online_assessment.Models.Enrollment> displayStudentList_GetData()
        {
            return db.Enrollment.Where(e => e.Programme.faculty.Equals("FOCS"));
        }
    }
}