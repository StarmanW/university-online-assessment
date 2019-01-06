using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Lecturer
{
    public partial class MarkAssessmentList : System.Web.UI.Page
    {
        private OnlineAssessmentDBEntities db;

        protected void Page_Load(object sender, EventArgs e)
        {
            db = new OnlineAssessmentDBEntities();
            Guid assessID = Guid.Empty;
            try
            {
                assessID = Guid.Parse(Page.RouteData.Values["id"].ToString());
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            Student_Assessment student_Assessments = db.Student_Assessment.Where(sa => sa.assessmentId == assessID).FirstOrDefault();
            if (student_Assessments == null)
            {
                Response.Redirect("/lecturer/list");
            }

            assessName.Text = student_Assessments.Assessment.assessName;
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<university_online_assessment.Models.Student_Assessment> displayStudentAssessmentList_GetData()
        {
            Guid assessIDGuid = Guid.Empty;
            try
            {
                assessIDGuid = Guid.Parse(Page.RouteData.Values["id"].ToString());
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            return db.Student_Assessment.Where(sa => sa.assessmentId == assessIDGuid);
        }
    }
}