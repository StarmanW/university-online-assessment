using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views
{
    public partial class RegisterStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DropDownList programme = registerStudentForm.FindControl("programme") as DropDownList;

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                List<Programme> progs = db.Programme.ToList();
                foreach (var prog in progs)
                {
                    programme.Items.Add(new ListItem(prog.progName, prog.progId.ToString()));
                }
            }
        }

        public void addNewStudent()
        {
            if (Page.IsValid)
            {
                try
                {
                    // Retrieve controls
                    TextBox studId = registerStudentForm.FindControl("studId") as TextBox;
                    TextBox password = registerStudentForm.FindControl("password_confirmation") as TextBox;
                    TextBox email = registerStudentForm.FindControl("email") as TextBox;

                    // First create the user membership
                    MembershipUser newStudent = Membership.CreateUser(studId.Text, password.Text, email.Text);
                    Roles.AddUserToRole(studId.Text, "Student");

                    // Create the student profile
                    Student_Profile student = new Student_Profile();
                    student.Id = (Guid)newStudent.ProviderUserKey;
                    TryUpdateModel(student);

                    if (ModelState.IsValid)
                    {
                        // Connect to database to add new staff profile
                        using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
                        {
                            Enrollment newEnrollment = new Enrollment();
                            newEnrollment.Id = Guid.NewGuid();
                            newEnrollment.studId = student.Id;
                            newEnrollment.progId = student.programme;
                            newEnrollment.enrollmentDateTime = DateTime.Now;

                            // Add the new staff and save it
                            db.Enrollment.Add(newEnrollment);
                            db.Student_Profile.Add(student);
                            db.SaveChanges();

                            // Set the text to new staff ID
                            newStudID.Text = studId.Text;

                            // Show success label & hide failure label
                            alertSuccess.Visible = true;
                            alertFailure.Visible = false;
                        }
                    }
                }
                catch (MembershipCreateUserException ex)
                {
                    // Match exception code with status code from MembershipCreateStatus class
                    switch (ex.StatusCode)
                    {
                        case MembershipCreateStatus.DuplicateUserName:
                            alertFailureMsg.Text = "There already exists a user with this username.";
                            break;
                        case MembershipCreateStatus.DuplicateEmail:
                            alertFailureMsg.Text = "There already exists a user with this email address.";
                            break;
                        case MembershipCreateStatus.InvalidEmail:
                            alertFailureMsg.Text = "There email address you provided in invalid.";
                            break;
                        case MembershipCreateStatus.InvalidPassword:
                            alertFailureMsg.Text = "The password you provided is invalid. It must be seven characters long and have at least one non-alphanumeric character.";
                            break;
                        default:
                            alertFailureMsg.Text = "There was an unknown error; the user account was NOT created.";
                            break;
                    }

                    // Show failure message
                    alertSuccess.Visible = false;
                    alertFailure.Visible = true;
                }
                catch (Exception ex)
                {
                    // Show failure message
                    alertFailureMsg.Text = "Oops! There was a problem occurred when registering the new student.";
                    alertSuccess.Visible = false;
                    alertFailure.Visible = true;
                }
            }
        }
    }
}