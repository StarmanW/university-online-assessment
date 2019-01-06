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
    public partial class PreCreateQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Get the subject dropdown list
                DropDownList subjectDrpDwnList = subject;

                // Get the current logged-in lecturer user ID
                Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());

                // Using DB connection
                using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
                {
                    // Get the current logged-in lecturer
                    Lecturer_Profile lecturer = db.Lecturer_Profile.Where(l => l.Id == userId).FirstOrDefault();

                    // Get only the subjects for the faculty that the lecturer is in
                    List<Subject> subjects = db.Subject.Where(s => s.Programme.faculty == lecturer.faculty).ToList();

                    // Populate the dropdown list
                    foreach (var subject in subjects)
                    {
                        subjectDrpDwnList.Items.Add(new ListItem(subject.subjectName, subject.Id.ToString()));
                    }
                }
            }
            catch (Exception)
            {
                Response.Redirect("/");
            }
        }

        protected void createAssessBtn_Click(object sender, EventArgs e)
        {
            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Guid subjectID = Guid.Parse(subject.SelectedItem.Value);
                int publicity = Convert.ToInt16(assessPublicity.SelectedItem.Value);
                int type = Convert.ToInt16(assessType.SelectedItem.Value);

                Assessment assessment = db.Assessment.Where(a => a.Subject1.Id == subjectID && a.publicity == publicity && a.type == type && a.assessName.Equals(assessName.Text)).FirstOrDefault();

                // Check if assessment already exist
                if (assessment != null)
                {
                    assessNameLbl.Text = assessment.assessName;
                    alertPlaceholder.Visible = true;
                }
                else
                {
                    Session.Add("assessType", assessType.SelectedItem.Value);
                    Session.Add("publicity", assessPublicity.SelectedItem.Value);
                    Session.Add("subject", subject.SelectedItem.Value);
                    Session.Add("quesNum", quesNum.Text);
                    Session.Add("newAssessName", assessName.Text);
                    Response.Redirect("/lecturer/assessment/create");
                }
            }
        }
    }
}