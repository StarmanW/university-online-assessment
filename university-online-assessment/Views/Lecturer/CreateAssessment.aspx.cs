using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
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
    public partial class CreateQuestion : System.Web.UI.Page
    {
        private OnlineAssessmentDBEntities db;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.db = new OnlineAssessmentDBEntities();

            String assessType = (String)Session["assessType"];
            String subject = (String)Session["subject"];
            int quesNum = Convert.ToInt32(Session["quesNum"]);

            if (assessType == null || subject == null)
            {
                Response.Redirect("/lecturer/assessment/pre_create");
            }

            subjectLbl.Text = db.Subject.Find(Guid.Parse(subject)).subjectName;

            if (assessType.Equals("0"))
            {
                // Generate nth of questions
                for (int i = 0; i < quesNum; i++)
                {
                    Label quesNoLbl = new Label();
                    quesNoLbl.Text = $"Question No.{i + 1}";

                    TextBox ques = new TextBox();
                    ques.ID = $"ques_{i + 1}";
                    ques.Attributes.Add("placeholder", $"Enter MCQ question no. {i + 1}");
                    ques.CssClass = "form-control";

                    questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"form-group\">"));
                    questionPlaceHolder.Controls.Add(quesNoLbl);
                    questionPlaceHolder.Controls.Add(ques);

                    RequiredFieldValidator requiredFieldValidator = new RequiredFieldValidator();
                    requiredFieldValidator.SetFocusOnError = true;
                    requiredFieldValidator.ErrorMessage = "Please ensure the question field is not left blank";
                    requiredFieldValidator.Display = ValidatorDisplay.Dynamic;
                    requiredFieldValidator.ForeColor = System.Drawing.Color.Red;
                    requiredFieldValidator.ControlToValidate = ques.ID;

                    questionPlaceHolder.Controls.Add(requiredFieldValidator);
                    questionPlaceHolder.Controls.Add(new LiteralControl("<br />"));

                    // Generate 4 MCQ answer
                    for (int j = 0; j < 4; j++)
                    {
                        questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"row\"><div class=\"col-md-10\">"));

                        TextBox answer = new TextBox();
                        answer.ID = $"ans_{i + 1}_{j + 1}";
                        answer.Attributes.Add("placeholder", $"Enter answer no.{j + 1} for question no.{i + 1}");
                        answer.CssClass = "form-control";

                        CheckBox chkBox = new CheckBox();
                        chkBox.ID = $"isAns_{i + 1}_{j + 1}";

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
                    questionPlaceHolder.Controls.Add(new LiteralControl("</div>"));
                }
            }
            else if (assessType.Equals("1"))
            {
                // Generate nth of questions
                for (int i = 0; i < quesNum; i++)
                {
                    Label quesNoLbl = new Label();
                    quesNoLbl.Text = $"Question No.{i + 1}";

                    TextBox ques = new TextBox();
                    ques.ID = $"ques_{i + 1}";
                    ques.Attributes.Add("placeholder", $"Enter written question no. {i + 1}");
                    ques.CssClass = "form-control";

                    RequiredFieldValidator requiredFieldValidator = new RequiredFieldValidator();
                    requiredFieldValidator.SetFocusOnError = true;
                    requiredFieldValidator.ErrorMessage = "Please ensure the question field is not left blank<br/>";
                    requiredFieldValidator.Display = ValidatorDisplay.Dynamic;
                    requiredFieldValidator.ForeColor = System.Drawing.Color.Red;
                    requiredFieldValidator.ControlToValidate = ques.ID;

                    FileUpload quesImg = new FileUpload();
                    quesImg.ID = $"quesImg_{i + 1}";
                    quesImg.CssClass = "form-group";

                    questionPlaceHolder.Controls.Add(new LiteralControl("<div class=\"form-group\">"));
                    questionPlaceHolder.Controls.Add(quesNoLbl);
                    questionPlaceHolder.Controls.Add(ques);
                    questionPlaceHolder.Controls.Add(requiredFieldValidator);
                    questionPlaceHolder.Controls.Add(quesImg);
                    questionPlaceHolder.Controls.Add(new LiteralControl("</div>"));
                }
            }
        }

        // Add the question
        protected void submitBtn_Click(object sender, EventArgs e)
        {
            try
            {
                // Create the new assessment record
                Assessment newAssess = new Assessment();
                newAssess.Id = Guid.NewGuid();
                newAssess.assessName = Session["newAssessName"].ToString();
                newAssess.subject = Guid.Parse(Session["subject"].ToString());
                newAssess.type = Convert.ToInt32(Session["assessType"]);
                newAssess.publicity = Convert.ToInt16(Session["publicity"]);
                this.db.Assessment.Add(newAssess);
                this.db.SaveChanges();

                // Create the new lecturer_assessment record
                Lecturer_Assessment newLectAssess = new Lecturer_Assessment();
                newLectAssess.Id = Guid.NewGuid();
                newLectAssess.lecturerId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                newLectAssess.assessmentId = newAssess.Id;
                this.db.Lecturer_Assessment.Add(newLectAssess);
                this.db.SaveChanges();

                if (Session["assessType"].ToString().Equals("0"))
                {
                    int mcqQuesCounter = 0;
                    Regex questionRegex = new Regex(@"^ques_\d+$", RegexOptions.IgnoreCase);

                    foreach (var ctrl in questionPlaceHolder.Controls)
                    {
                        if (ctrl is TextBox)
                        {
                            TextBox quesTxtBox = ctrl as TextBox;
                            if (questionRegex.IsMatch(quesTxtBox.ID))
                            {
                                // Increment MCQ question counter
                                mcqQuesCounter++;

                                // Create new question
                                Question newQues = new Question();
                                newQues.Id = Guid.NewGuid();
                                newQues.assessmentId = newAssess.Id;

                                // Get the question textbox
                                newQues.question1 = quesTxtBox.Text;

                                // Get the file upload control
                                FileUpload quesImg = questionPlaceHolder.FindControl($"quesImg_{quesTxtBox.ID.Substring(5)}") as FileUpload;

                                if (quesImg.HasFile)
                                {
                                    // Create regex for file extension
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
                                        newQues.imgPath = finalPath;
                                    }
                                }

                                // Add the new question
                                this.db.Question.Add(newQues);
                                this.db.SaveChanges();

                                // For loop to add the MCQ answer
                                for (int i = 0; i < 4; i++)
                                {
                                    TextBox ansTxtBox = questionPlaceHolder.FindControl($"ans_{mcqQuesCounter}_{i + 1}") as TextBox;
                                    CheckBox ansChkBox = questionPlaceHolder.FindControl($"isAns_{mcqQuesCounter}_{i + 1}") as CheckBox;

                                    Answer answer = new Answer();
                                    answer.Id = Guid.NewGuid();
                                    answer.questionId = newQues.Id;
                                    answer.answer1 = ansTxtBox.Text;
                                    answer.isCorrectAnswer = ansChkBox.Checked;

                                    // Add the new question
                                    this.db.Answer.Add(answer);
                                    this.db.SaveChanges();
                                }
                            }
                        }
                    }
                }
                else if (Session["assessType"].ToString().Equals("1"))
                {
                    foreach (var ctrl in questionPlaceHolder.Controls)
                    {
                        if (ctrl is TextBox)
                        {
                            // Create new question
                            Question newQues = new Question();
                            newQues.Id = Guid.NewGuid();
                            newQues.assessmentId = newAssess.Id;

                            // Get the question textbox
                            TextBox quesTxtBox = ctrl as TextBox;
                            newQues.question1 = quesTxtBox.Text;

                            // Get the file upload control
                            FileUpload quesImg = questionPlaceHolder.FindControl($"quesImg_{quesTxtBox.ID.Substring(5)}") as FileUpload;

                            // If there is an image
                            if (quesImg.HasFile)
                            {
                                // Create regex for file extension
                                Regex fileExtRegex = new Regex(@"^\.(jpg|png|jpeg|gif)$", RegexOptions.IgnoreCase);

                                // Declare file storage path
                                // Get complete file name using the help of "Path" class
                                // Get file name without extension
                                // Get file extension
                                string imageStoragePath = "~/Image_Storage/",
                                    fileName = Path.GetFileName(quesImg.PostedFile.FileName),
                                    fileNameWithoutExt = Path.GetFileNameWithoutExtension(fileName),
                                    fileExtension = Path.GetExtension(fileName);

                                // Check if extension is correct image extension
                                if (fileExtRegex.IsMatch(fileExtension))
                                {
                                    // Check if file storage directory exist
                                    // using th help of "Directory" class.
                                    if (!Directory.Exists(Server.MapPath(imageStoragePath)))
                                    {
                                        // Create file storage directory
                                        Directory.CreateDirectory(Server.MapPath(imageStoragePath));
                                    }

                                    String finalPath = $"{fileNameWithoutExt}_{DateTime.Now.Ticks.ToString()}{fileExtension}";

                                    // Take the image and save it as "/imageStoragePath/fileName_datetimeTicks.extension"
                                    // Use ticks from DateTime for uniqueness and prevent duplication of file names.
                                    quesImg.PostedFile.SaveAs($"{Server.MapPath(imageStoragePath)}{finalPath}");

                                    newQues.imgPath = finalPath;
                                }
                            }

                            // Add the new question
                            this.db.Question.Add(newQues);
                            this.db.SaveChanges();
                        }
                    }
                }
                Session["assessCreated"] = "1";
                Session["assessName"] = newAssess.assessName;
                Response.Redirect("/lecturer/list");
            }
            catch (DbEntityValidationException dbEx)
            {
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        System.Diagnostics.Debug.WriteLine("Property: {0} Error: {1}", validationError.PropertyName, validationError.ErrorMessage);
                    }
                }
            }
        }
    }
}