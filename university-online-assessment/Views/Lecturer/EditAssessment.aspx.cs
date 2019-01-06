using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using university_online_assessment.Models;

namespace university_online_assessment.Views.Lecturer
{
    public partial class EditAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid assessID = Guid.Empty;
            try
            {
                assessID = Guid.Parse(Page.RouteData.Values["id"].ToString());
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Assessment assessment = db.Assessment.Find(assessID);

                if (assessment == null)
                {
                    Response.Redirect("/lecturer/list");
                }

                Page.Title = $"Edit {assessment.assessName}";

                // Get the subject dropdown list
                DropDownList subjectDrpDwnList = subject;

                // Get the current logged-in lecturer user ID
                Guid userId = Guid.Parse(Membership.GetUser().ProviderUserKey.ToString());

                // Get the current logged-in lecturer
                Lecturer_Profile lecturer = db.Lecturer_Profile.Where(l => l.Id == userId).FirstOrDefault();

                if (subjectDrpDwnList.Items.Count == 0)
                {
                    // Get only the subjects for the faculty that the lecturer is in
                    List<Subject> subjects = db.Subject.Where(s => s.Programme.faculty == lecturer.faculty).ToList();

                    int counter = 0, index = 0;

                    // Populate the dropdown list
                    foreach (var subject in subjects)
                    {
                        if (subject.subjectName.Equals(assessment.Subject1.subjectName))
                        {
                            index = counter;
                        }
                        subjectDrpDwnList.Items.Add(new ListItem(subject.subjectName, subject.Id.ToString()));
                        counter++;
                    }
                    subjectDrpDwnList.SelectedIndex = index;
                }

                if (!Page.IsPostBack)
                {
                    // Set assessment publicity
                    assessPublicity.SelectedIndex = assessment.publicity;
                    assessName.Text = assessment.assessName;
                }

                // Set header name
                subjectLbl.Text = assessment.Subject1.subjectName;

                List<Question> questions = assessment.Question.ToList();

                // 0 = MCQ, 1 = Written
                if (assessment.type == 0)
                {
                    // Iterate and display questions
                    for (int i = 0; i < questions.Count; i++)
                    {
                        if (questions[i].imgPath != null)
                        {
                            questionPlaceHolder.Controls.Add(new LiteralControl($"<img src=\"/Image_Storage/{questions[i].imgPath}\" class=\"img-fluid\" />"));
                        }

                        Label quesNoLbl = new Label();
                        quesNoLbl.Text = $"Question No.{i + 1}";

                        TextBox ques = new TextBox();
                        ques.ID = $"ques_{i + 1}";
                        ques.Text = questions[i].question1;
                        ques.CssClass = "form-control";

                        RequiredFieldValidator requiredFieldValidator = new RequiredFieldValidator();
                        requiredFieldValidator.SetFocusOnError = true;
                        requiredFieldValidator.ErrorMessage = "Please ensure the question field is not left blank";
                        requiredFieldValidator.Display = ValidatorDisplay.Dynamic;
                        requiredFieldValidator.ForeColor = System.Drawing.Color.Red;
                        requiredFieldValidator.ControlToValidate = ques.ID;

                        questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"form-group\">"));
                        questionPlaceHolder.Controls.Add(quesNoLbl);
                        questionPlaceHolder.Controls.Add(ques);
                        questionPlaceHolder.Controls.Add(requiredFieldValidator);
                        questionPlaceHolder.Controls.Add(new LiteralControl("<br />"));

                        List<Answer> answers = questions[i].Answer.ToList();

                        // Display 4 MCQ answer
                        for (int j = 0; j < answers.Count; j++)
                        {
                            questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"row\"><div class=\"col-md-10\">"));

                            TextBox answer = new TextBox();
                            answer.ID = $"ans_{i + 1}_{j + 1}";
                            answer.Text = answers[j].answer1;
                            answer.CssClass = "form-control";

                            CheckBox chkBox = new CheckBox();
                            chkBox.ID = $"isAns_{i + 1}_{j + 1}";
                            if (answers[j].isCorrectAnswer)
                            {
                                chkBox.Checked = true;
                            }

                            RequiredFieldValidator requiredFieldValidator1 = new RequiredFieldValidator();
                            requiredFieldValidator1.SetFocusOnError = true;
                            requiredFieldValidator1.ErrorMessage = "Please ensure the answer field is not left blank";
                            requiredFieldValidator1.Display = ValidatorDisplay.Dynamic;
                            requiredFieldValidator1.ForeColor = System.Drawing.Color.Red;

                            requiredFieldValidator1.ControlToValidate = answer.ID;
                            questionPlaceHolder.Controls.Add(answer);
                            questionPlaceHolder.Controls.Add(requiredFieldValidator1);
                            questionPlaceHolder.Controls.Add(new LiteralControl("</div><div class=\"col-md-2\">"));
                            questionPlaceHolder.Controls.Add(chkBox);
                            questionPlaceHolder.Controls.Add(new LiteralControl("</div></div>"));
                        }

                        questionPlaceHolder.Controls.Add(new LiteralControl("<br />"));
                        FileUpload quesImg = new FileUpload();
                        quesImg.ID = $"quesImg_{i + 1}";
                        quesImg.CssClass = "form-group";

                        questionPlaceHolder.Controls.Add(quesImg);
                        questionPlaceHolder.Controls.Add(new LiteralControl("</div>")); ;
                    }
                }
                else if (assessment.type == 1)
                {
                    // Generate nth of questions
                    for (int i = 0; i < questions.Count; i++)
                    {
                        Label quesNoLbl = new Label();
                        quesNoLbl.Text = $"Question No.{i + 1}";

                        TextBox ques = new TextBox();
                        ques.ID = $"ques_{i + 1}";
                        ques.Text = questions[i].question1;
                        ques.CssClass = "form-control";

                        RequiredFieldValidator requiredFieldValidator = new RequiredFieldValidator();
                        requiredFieldValidator.SetFocusOnError = true;
                        requiredFieldValidator.ErrorMessage = "Please ensure the question field is not left blank<br/>";
                        requiredFieldValidator.Display = ValidatorDisplay.Dynamic;
                        requiredFieldValidator.ForeColor = System.Drawing.Color.Red;
                        requiredFieldValidator.ControlToValidate = ques.ID;

                        questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"form-group\">"));
                        questionPlaceHolder.Controls.Add(quesNoLbl);
                        questionPlaceHolder.Controls.Add(ques);
                        questionPlaceHolder.Controls.Add(requiredFieldValidator);
                        questionPlaceHolder.Controls.Add(new LiteralControl("<br/>"));

                        if (questions[i].imgPath != null)
                        {
                            questionPlaceHolder.Controls.Add(new LiteralControl($"<img src=\"/Image_Storage/{questions[i].imgPath}\" class=\"img-fluid\" />"));

                            questionPlaceHolder.Controls.Add(new LiteralControl("<br/>"));
                            FileUpload quesImg = new FileUpload();
                            quesImg.ID = $"quesImg_{i + 1}";
                            quesImg.CssClass = "form-group";
                            questionPlaceHolder.Controls.Add(quesImg);
                        }

                        questionPlaceHolder.Controls.Add(new LiteralControl("</div>"));
                    }
                }
            }
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            Guid assessID = Guid.Empty;
            try
            {
                assessID = Guid.Parse(Page.RouteData.Values["id"].ToString());
            }
            catch (Exception)
            {
                Response.Redirect("/lecturer/list");
            }

            using (OnlineAssessmentDBEntities db = new OnlineAssessmentDBEntities())
            {
                Assessment assessment = db.Assessment.Find(assessID);

                if (assessment == null)
                {
                    Response.Redirect("/lecturer/list");
                }

                List<Question> questions = assessment.Question.ToList();

                assessment.subject = Guid.Parse(subject.SelectedItem.Value);
                assessment.assessName = assessName.Text;
                assessment.publicity = Convert.ToInt16(assessPublicity.SelectedItem.Value);
                db.SaveChanges();
                subjectLbl.Text = assessment.Subject1.subjectName;

                // 0 = MCQ, 1 = Written
                if (assessment.type == 0)
                {
                    for (int i = 0; i < questions.Count; i++)
                    {
                        questions[i].question1 = (questionPlaceHolder.FindControl($"ques_{i + 1}") as TextBox).Text;

                        FileUpload quesImg = questionPlaceHolder.FindControl($"quesImg_{i + 1}") as FileUpload;
                        // If there is an image
                        if (quesImg.HasFile)
                        {
                            Regex fileExtRegex = new Regex(@"^\.(jpg|png|jpeg|gif)$", RegexOptions.IgnoreCase);
                            string imageStoragePath = "~/Image_Storage/",
                                fileName = Path.GetFileName(quesImg.PostedFile.FileName),
                                fileNameWithoutExt = Path.GetFileNameWithoutExtension(fileName),
                                fileExtension = Path.GetExtension(fileName);
                            if (fileExtRegex.IsMatch(fileExtension))
                            {
                                if (!Directory.Exists(Server.MapPath(imageStoragePath)))
                                {
                                    Directory.CreateDirectory(Server.MapPath(imageStoragePath));
                                }
                                String finalPath = $"{fileNameWithoutExt}_{DateTime.Now.Ticks.ToString()}{fileExtension}";
                                quesImg.PostedFile.SaveAs($"{Server.MapPath(imageStoragePath)}{finalPath}");
                                questions[i].imgPath = finalPath;
                            }
                        }

                        List<Answer> answers = questions[i].Answer.ToList();

                        for (int j = 0; j < answers.Count; j++)
                        {
                            answers[j].answer1 = (questionPlaceHolder.FindControl($"ans_{i + 1}_{j + 1}") as TextBox).Text;

                            CheckBox isAnsChkBox = questionPlaceHolder.FindControl($"isAns_{i + 1}_{j + 1}") as CheckBox;
                            answers[j].isCorrectAnswer = false;
                            if (isAnsChkBox.Checked)
                            {
                                answers[j].isCorrectAnswer = true;
                            }
                        }

                        db.SaveChanges();
                    }
                }
                else if (assessment.type == 1)
                {
                    // Generate nth of questions
                    for (int i = 0; i < questions.Count; i++)
                    {
                        questions[i].question1 = (questionPlaceHolder.FindControl($"ques_{i + 1}") as TextBox).Text;

                        FileUpload quesImg = questionPlaceHolder.FindControl($"quesImg_{i + 1}") as FileUpload;
                        // If there is an image
                        if (quesImg.HasFile)
                        {
                            Regex fileExtRegex = new Regex(@"^\.(jpg|png|jpeg|gif)$", RegexOptions.IgnoreCase);
                            string imageStoragePath = "~/Image_Storage/",
                                fileName = Path.GetFileName(quesImg.PostedFile.FileName),
                                fileNameWithoutExt = Path.GetFileNameWithoutExtension(fileName),
                                fileExtension = Path.GetExtension(fileName);
                            if (fileExtRegex.IsMatch(fileExtension))
                            {
                                if (!Directory.Exists(Server.MapPath(imageStoragePath)))
                                {
                                    Directory.CreateDirectory(Server.MapPath(imageStoragePath));
                                }
                                String finalPath = $"{fileNameWithoutExt}_{DateTime.Now.Ticks.ToString()}{fileExtension}";
                                quesImg.PostedFile.SaveAs($"{Server.MapPath(imageStoragePath)}{finalPath}");
                                questions[i].imgPath = finalPath;
                            }
                        }
                        // Save the changes
                        db.SaveChanges();
                    }
                }
                updateStatus.Visible = true;
            }
        }
    }
}