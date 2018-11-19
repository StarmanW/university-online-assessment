using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Admin
{
    public partial class ViewLecturerList : System.Web.UI.Page
    {
        private OnlineAssessmentDBEntities db;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.db = new OnlineAssessmentDBEntities();
        }

        // Method to get Student list
        public IQueryable<university_online_assessment.Models.Student_Profile> getStudents()
        {
            return this.db.Student_Profile;
        }

        // Method to get Programme list
        public IQueryable<Programme> getProgrammes()
        {
            return this.db.Programme;
        }

        // Method to get Student list
        public IQueryable<Lecturer_Profile> getLecturers()
        {
            return this.db.Lecturer_Profile;
        }

        protected void displayStudGrid_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-students";
        }

        protected void displayProgGrid_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-programmes";
        }

        protected void displayLectGrid_Sorted(object sender, EventArgs e)
        {
            hfTab.Value = "nav-lecturers";
        }
    }
}