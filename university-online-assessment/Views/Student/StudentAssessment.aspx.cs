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

                Page.Title = assessment.assessName;

                // Set header name
                subjectNameHeader.Text = assessment.Subject1.subjectName;
                assessNameHeader.Text = assessment.assessName;

                // 0 = MCQ, 1 = Written
                if (assessment.type == 0)
                {
                    List<Question> questions = assessment.Question.ToList();
                    String[] MCQ = {
                        "A",
                        "B",
                        "C",
                        "D"
                    };

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

                        List<Answer> answers = questions[i].Answer.ToList();

                        // Display 4 MCQ answer
                        for (int j = 0; j < answers.Count; j++)
                        {
                            questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"row\"><div class=\"col-md-10\">"));

                            Label ansLbl = new Label();
                            ansLbl.ID = $"ans_{i + 1}_{j + 1}";
                            ansLbl.Text = $"{MCQ[j]}. {answers[j].answer1}";

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
                    // Get the list of questions
                    List<Question> questions = assessment.Question.ToList();

                    // Loop through the list of questions
                    for (int i = 0; i < questions.Count; i++)
                    {
                        Student_Answer student_Answer = new Student_Answer();

                        // Declare an empty Guid and question ID
                        Guid studMCQAnswerID = Guid.Empty;
                        Guid questionID = questions[i].Id;

                        // Loop through the 4 MCQ choice to find the answer choice the student has chosen
                        for (int j = 0; j < 4; j++)
                        {
                            CheckBox ansChkBox = questionPlaceHolder.FindControl($"mcqAns_{i + 1}_{j + 1}") as CheckBox;

                            // If student picked this MCQ choice as the answer
                            if (ansChkBox.Checked)
                            {
                                // Get the MCQ answer text
                                String studSelectedAns = (questionPlaceHolder.FindControl($"ans_{i + 1}_{j + 1}") as Label).Text.Substring(3);

                                // Retrieve the answer and get the ID
                                Answer answer = db.Answer.Where(a => a.answer1.Equals(studSelectedAns) && a.questionId == questionID).FirstOrDefault();
                                if (answer != null)
                                {
                                    studMCQAnswerID = answer.Id;
                                }
                                break;
                            }
                        }

                        // Set student answer attributes and save it into database
                        student_Answer.questionId = questionID;
                        student_Answer.studentId = Guid.Parse(Membership.GetUser().ProviderUserKey.ToString());
                        student_Answer.studentAnswer = studMCQAnswerID.ToString();
                        db.Student_Answer.Add(student_Answer);
                        db.SaveChanges();
                    }

                    // Method to perform MCQ marks calculation
                    calculateMCQMarks(assessment, questions);

                    Response.Redirect("/student/list", false);
                }
                else if (assessment.type == 1)
                {
                    // Get the list of questions
                    List<Question> questions = assessment.Question.ToList();

                    // Create new student assessment record
                    Student_Assessment student_Assessment = new Student_Assessment();
                    student_Assessment.Id = Guid.NewGuid();
                    student_Assessment.studentId = Guid.Parse(Membership.GetUser().ProviderUserKey.ToString());
                    student_Assessment.assessmentId = assessment.Id;
                    student_Assessment.dateFinished = DateTime.Now;
                    student_Assessment.score = -1;

                    // Loop through the list of questions
                    for (int i = 0; i < questions.Count; i++)
                    {
                        // Get the written answer and save into database
                        Student_Answer student_Answer = new Student_Answer();
                        TextBox writtenAnswer = questionPlaceHolder.FindControl($"writtenAns_q{i + 1}") as TextBox;
                        student_Answer.questionId = questions[i].Id;
                        student_Answer.studentId = Guid.Parse(Membership.GetUser().ProviderUserKey.ToString());
                        student_Answer.studentAnswer = writtenAnswer.Text;
                        db.Student_Answer.Add(student_Answer);
                        db.SaveChanges();
                    }

                    db.Student_Assessment.Add(student_Assessment);
                    db.SaveChanges();
                }

                Session["assessCompleted"] = "1";
                Session["assessName"] = assessment.assessName;
                Response.Redirect("/student/list");
            }
        }

        // Private method to perform MCQ marks calculation
        private void calculateMCQMarks(Assessment assessment, List<Question> questions)
        {
            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                List<Student_Answer> studentAnswerList = db.Student_Answer.Where(sa => sa.Question.assessmentId == assessment.Id).ToList();
                int correctCounter = 0;
                double score = 0.0;

                for (int i = 0; i < studentAnswerList.Count; i++)
                {
                    if (db.Answer.Find(Guid.Parse(studentAnswerList[i].studentAnswer)).isCorrectAnswer)
                    {
                        correctCounter++;
                    }
                }

                score = Math.Round((Convert.ToDouble(correctCounter) / assessment.Question.Count) * 100.00);

                Student_Assessment studentAssessment = new Student_Assessment();
                studentAssessment.Id = Guid.NewGuid();
                studentAssessment.assessmentId = assessment.Id;
                studentAssessment.studentId = Guid.Parse(Membership.GetUser().ProviderUserKey.ToString());
                studentAssessment.score = Convert.ToInt32(score);
                studentAssessment.dateFinished = DateTime.Now;
                db.Student_Assessment.Add(studentAssessment);
                db.SaveChanges();
            }
        }
    }
}