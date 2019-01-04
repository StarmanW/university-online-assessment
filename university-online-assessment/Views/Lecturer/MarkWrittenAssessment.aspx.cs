using System;
using System.Collections.Generic;
using System.Linq;
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
            String assessID = "";
            String studID = "";

            try
            {
                assessID = Page.RouteData.Values["id"].ToString();
                studID = Page.RouteData.Values["studId"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            Guid assessIDGuid = Guid.Parse(assessID);
            Guid studIDGuid = Guid.Parse(studID);

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Student_Assessment studAssess = db.Student_Assessment.Where(sa => sa.studentId == studIDGuid && sa.assessmentId == assessIDGuid).FirstOrDefault();

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
    }
}