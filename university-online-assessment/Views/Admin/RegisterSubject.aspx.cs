using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Admin
{
    public partial class RegisterSubject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DropDownList programme = registerSubjectForm.FindControl("programme") as DropDownList;

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                List<Programme> progs = db.Programme.ToList();
                foreach (var prog in progs)
                {
                    programme.Items.Add(new ListItem(prog.progName, prog.progId.ToString()));
                }
            }
        }

        public void addNewSubject()
        {
            if (Page.IsValid)
            {
                // Create the Subject
                Subject subject = new Subject();
                subject.Id = Guid.NewGuid();
                TryUpdateModel(subject);

                if (ModelState.IsValid)
                {
                    // Connect to database to add new subject
                    using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
                    {
                        // Add the new subject and save it
                        db.Subject.Add(subject);
                        db.SaveChanges();

                        // Set the text to new subject name
                        newSubjectName.Text = subject.subjectName;

                        // Show success label & hide failure label
                        alertSuccess.Visible = true;
                        alertFailure.Visible = false;
                    }
                }
                else
                {
                    // Set the error text
                    alertFailureMsg.Text = "Oops! Something went wrong when registering the new subject";

                    // Show success label & hide failure label
                    alertSuccess.Visible = false;
                    alertFailure.Visible = true;
                }
            }
        }
    }
}