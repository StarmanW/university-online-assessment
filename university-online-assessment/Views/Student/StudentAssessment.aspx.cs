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
    public partial class StudentAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String assessID = "";
            try
            {
                assessID = Page.RouteData.Values["id"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/student/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Assessment assessment = db.Assessment.Find(Guid.Parse(assessID));

                // Set header name
                subjectNameHeader.Text = assessment.Subject1.subjectName;
                assessNameHeader.Text = assessment.assessName;

                // 0 = MCQ, 1 = Written
                if (assessment.type == 0)
                {
                    List<Question> questions = assessment.Question.ToList();

                    // Iterate and display questions
                    for (int i = 0; i < questions.Count; i++)
                    {
                        String[] MCQ = {
                            "A",
                            "B",
                            "C",
                            "D"
                        };

                        Label quesNoLbl = new Label();
                        quesNoLbl.Text = $"Question No.{i + 1}";
                        questionPlaceHolder.Controls.Add(quesNoLbl);
                        questionPlaceHolder.Controls.Add(new LiteralControl("<br>"));

                        if (questions[i].imgPath != null)
                        {
                            questionPlaceHolder.Controls.Add(new LiteralControl($"<img src=\"/Image_Storage/{questions[i].imgPath}\" class=\"img-fluid\" />"));
                        }

                        questionPlaceHolder.Controls.Add(new LiteralControl($"<p>{questions[i].question1}</p>"));

                        List<Answer> answers = questions[i].Answer.ToList();

                        // Display 4 MCQ answer
                        for (int j = 0; j < answers.Count; j++)
                        {
                            questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"row\"><div class=\"col-md-10\">"));

                            Label ansLbl = new Label();
                            ansLbl.ID = $"ans_{i + 1}_{j + 1}";
                            ansLbl.Text = $"{MCQ[j]}. {answers[i].answer1}";

                            questionPlaceHolder.Controls.Add(ansLbl);
                            questionPlaceHolder.Controls.Add(new LiteralControl("<br>"));

                            CheckBox chkBox = new CheckBox();
                            chkBox.ID = $"mcqAns_{i + 1}_{j + 1}";

                            questionPlaceHolder.Controls.Add(new LiteralControl("</div><div class=\"col-md-2\">"));
                            questionPlaceHolder.Controls.Add(chkBox);
                            questionPlaceHolder.Controls.Add(new LiteralControl("</div></div>"));
                        }

                        questionPlaceHolder.Controls.Add(new LiteralControl("<hr>"));
                    }
                }
                else if (assessment.type == 1)
                {
                    List<Question> questions = assessment.Question.ToList();

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

                        questionPlaceHolder.Controls.Add(answerTxtBox);
                        questionPlaceHolder.Controls.Add(new LiteralControl("</div>"));
                    }
                }
            }
        }

        protected void submitAsmntBtn_Click(object sender, EventArgs e)
        {
            String assessID = "";
            try
            {
                assessID = Page.RouteData.Values["id"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("/student/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Assessment assessment = db.Assessment.Find(Guid.Parse(assessID));

                if (assessment.type == 0)
                {
                    List<Question> questions = assessment.Question.ToList();

                }
                else if (assessment.type == 1)
                {
                    List<Question> questions = assessment.Question.ToList();
                    for (int i = 0; i < questions.Count; i++)
                    {
                        Student_Answer student_Answer = new Student_Answer();
                        TextBox writtenAnswer = questionPlaceHolder.FindControl($"writtenAns_q{i + 1}") as TextBox;
                        student_Answer.questionId = questions[i].Id;
                        student_Answer.studentId = Guid.Parse(Membership.GetUser().ProviderUserKey.ToString());
                        student_Answer.studentAnswer = writtenAnswer.Text;
                        db.Student_Answer.Add(student_Answer);
                        db.SaveChanges();
                    }
                }
            }
        }
    }
}