using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Lecturer
{
    public partial class StudentAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid assessID = Guid.Empty;
            string studID = "";

            try
            {
                assessID = Guid.Parse(Page.RouteData.Values["id"].ToString());
                studID = Page.RouteData.Values["studId"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Student_Assessment studAssess = db.Student_Assessment.Where(sa => sa.aspnet_Users.LoweredUserName.Equals(studID.ToLower()) && sa.assessmentId == assessID).FirstOrDefault();

                if (studAssess is null)
                {
                    Response.Redirect("/lecturer/list");
                }

                Page.Title = $"{ studAssess.aspnet_Users.Student_Profile.firstName } { studAssess.aspnet_Users.Student_Profile.lastName } { studAssess.Assessment.assessName }";

                // Set header name
                subjectLbl.Text = studAssess.Assessment.Subject1.subjectName;
                assessNameLbl.Text = studAssess.Assessment.assessName;

                List<Question> questions = studAssess.Assessment.Question.ToList();

                // Iterate and display questions
                for (int i = 0; i < questions.Count; i++)
                {
                    Label quesNoLbl = new Label();
                    quesNoLbl.Text = $"Question No.{i + 1}";
                    questionPlaceHolder.Controls.Add(quesNoLbl);
                    questionPlaceHolder.Controls.Add(new LiteralControl("<br>"));

                    if (questions[i].imgPath != null)
                    {
                        questionPlaceHolder.Controls.Add(new LiteralControl($"<img src=\"/Image_Storage/{questions[i].imgPath}\" class=\"img-fluid\" />"));
                    }

                    questionPlaceHolder.Controls.Add(new LiteralControl($"<p>{questions[i].question1}</p>"));
                    questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"form-group\">"));

                    TextBox answerTxtBox = new TextBox();
                    answerTxtBox.TextMode = TextBoxMode.MultiLine;
                    answerTxtBox.ID = $"writtenAns_q{i + 1}";
                    answerTxtBox.CssClass = "form-control";
                    answerTxtBox.Attributes.Add("cols", "20");
                    answerTxtBox.Attributes.Add("rows", "2");
                    answerTxtBox.Text = questions[i].Student_Answer.studentAnswer;

                    questionPlaceHolder.Controls.Add(answerTxtBox);
                    questionPlaceHolder.Controls.Add(new LiteralControl("</div>"));

                    questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"form-group\">"));

                    Label markLabel = new Label();
                    markLabel.Text = "Marks";

                    TextBox markTextBox = new TextBox();
                    markTextBox.TextMode = TextBoxMode.Number;
                    markTextBox.ID = $"writtenAns_qm{i + 1}";
                    markTextBox.CssClass = "form-control";
                    markTextBox.Attributes.Add("min", "0");
                    markTextBox.Attributes.Add("max", "100");

                    questionPlaceHolder.Controls.Add(markLabel);
                    questionPlaceHolder.Controls.Add(markTextBox);
                    questionPlaceHolder.Controls.Add(new LiteralControl("</div>"));
                }
            }
        }

        protected void submitBtn_Click(object sender, EventArgs e)
        {
            // Variables declaration
            double totalMark = 0.0;
            Guid assessID = Guid.Empty;
            string studID = "";


            try
            {
                assessID = Guid.Parse(Page.RouteData.Values["id"].ToString());
                studID = Page.RouteData.Values["studId"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Student_Assessment studAssess = db.Student_Assessment.Where(sa => sa.aspnet_Users.LoweredUserName.Equals(studID.ToLower()) && sa.assessmentId == assessID).FirstOrDefault();

                if (studAssess is null)
                {
                    Response.Redirect("/lecturer/list");
                }

                List<Question> questions = studAssess.Assessment.Question.ToList();

                // Iterate and display questions
                for (int i = 0; i < questions.Count; i++)
                {
                    TextBox markTxtBox = questionPlaceHolder.FindControl($"writtenAns_qm{i + 1}") as TextBox;
                    totalMark += Convert.ToDouble(markTxtBox.Text);
                }

                // Calculate final mark
                totalMark /= Convert.ToDouble(questions.Count);

                studAssess.score = Convert.ToInt16(totalMark);
                db.SaveChanges();

                // Display label
                totalMarkLbl.Text = $"{Convert.ToInt16(totalMark).ToString()} ({studAssess.getGrade()})";
                alertPlaceholder.Visible = true;

                // Send an email of the score to student
                sendEmailToStudent(studAssess);
            }
        }

        // Method to send email to student
        private void sendEmailToStudent(Student_Assessment studAssess)
        {
            // Create an SMTP client server object to connect to hotmail server
            SmtpClient smtpServer = new SmtpClient("smtp.live.com");
            smtpServer.Port = 587;
            smtpServer.UseDefaultCredentials = false;
            smtpServer.Credentials = new System.Net.NetworkCredential("tarconlineassessment@hotmail.com", "%TGB6yhn^YHN5tgb");
            smtpServer.EnableSsl = true;

            // Create new MailMessage object to send an email
            MailMessage mailMessage = new MailMessage();
            mailMessage.IsBodyHtml = true;
            mailMessage.Subject = $"Score for assessment {studAssess.Assessment.assessName}";
            mailMessage.From = new MailAddress("tarconlineassessment@hotmail.com");
            mailMessage.To.Add(studAssess.aspnet_Users.aspnet_Membership.Email);
            mailMessage.Body = $"Your assessment for \"{studAssess.Assessment.Subject1.subjectName} - {studAssess.Assessment.assessName}\" has just been graded!<br/>Your score is {studAssess.score} ({studAssess.getGrade()}).";

            // Send the email
            smtpServer.Send(mailMessage);
        }
    }
}