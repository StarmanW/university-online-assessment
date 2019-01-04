using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Lecturer
{
    public partial class StudentAssessmentsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String studID = "";
            try
            {
                studID = Page.RouteData.Values["id"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Guid studIDParsed = Guid.Parse(studID);
                aspnet_Users student = db.aspnet_Users.Find(studIDParsed);
                if (student != null)
                {
                    studInfoHeader.Text = $"{student.Student_Profile.firstName} {student.Student_Profile.lastName} - {student.UserName}";
                }
                else
                {
                    Response.Redirect("/lecturer/list");
                }
            }
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<university_online_assessment.Models.Student_Assessment> displayStudAssessList_GetData()
        {
            String studID = "";
            try
            {
                studID = Page.RouteData.Values["id"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities();
            Guid studIDParsed = Guid.Parse(studID);
            return db.Student_Assessment.Where(sa => sa.studentId == studIDParsed);
        }
    }
}