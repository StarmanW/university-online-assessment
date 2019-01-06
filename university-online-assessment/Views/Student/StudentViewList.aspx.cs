using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Student
{
    public partial class StudentViewList : System.Web.UI.Page
    {
        private OnlineAssessmentDBEntities db;

        protected void Page_Load(object sender, EventArgs e)
        {
            db = new OnlineAssessmentDBEntities();

            if (Session["assessCompleted"] != null && Session["assessName"] != null)
            {
                assessName.Text = Session["assessName"].ToString();
                alertPlaceholder.Visible = true;
            }
        }

        protected void displayCurrentAssessmentList_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-current-assessments";
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<university_online_assessment.Models.Assessment> displayCurrentAssessmentList_GetData()
        {
            Guid studentID = (Guid)Membership.GetUser().ProviderUserKey;
            Enrollment enrollment = db.Enrollment.Where(e => e.studId == studentID).FirstOrDefault();
            return db.Assessment.Where(a => a.Subject1.progId == enrollment.progId ||
            db.Student_Assessment.Where(sa => sa.assessmentId == a.Id).FirstOrDefault() == null &&
            a.publicity == 1);
        }

        protected void displayPastAssessmentList_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-past-assessments";
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<university_online_assessment.Models.Student_Assessment> displayPastAssessmentList_GetData()
        {
            Guid studentID = (Guid)Membership.GetUser().ProviderUserKey;
            return db.Student_Assessment.Where(sa => sa.studentId == studentID);
        }
    }
}