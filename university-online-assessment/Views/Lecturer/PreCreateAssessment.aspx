<%@ Page Title="Create Assessment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PreCreateAssessment.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.PreCreateQuestion" %>

<asp:Content ID="PreCreateAssessmentSectionContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="preCreateAssessmentSection" style="min-height: 100vh">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-8 mx-auto pt-5">
                    <h1 class="text-center">Create new Assessment</h1>

                    <%--Assessment Type--%>
                    <div class="form-group">
                        <label>Assessment Type:</label>
                        <asp:RadioButtonList runat="server" ID="assessType" CssClass="form-check form-check-inline" RepeatLayout="Flow">
                            <asp:ListItem Value="0" Text="Multiple Choice Question (MCQ)" Selected="True" class="form-check-input"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Written Question" class="form-check-input"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" ErrorMessage="Please select a assessment type." Display="Dynamic" ForeColor="Red" ControlToValidate="assessType"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" SetFocusOnError="true" ErrorMessage="Please select the correct assessment type." Display="Dynamic" ForeColor="Red" ControlToValidate="assessType" ValidationExpression="^[0-1]$"></asp:RegularExpressionValidator>
                    </div>

                    <%--Subject--%>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <asp:DropDownList runat="server" ID="subject" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="subject" Display="Dynamic" ErrorMessage="Please ensure the subject is selected."></asp:RequiredFieldValidator>
                    </div>
                    
                    <%--No. of Question--%>
                    <div class="form-group">
                        <label>No. of Questions:</label>
                        <asp:TextBox runat="server" ID="quesNum" CssClass="form-control" min="1" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" ErrorMessage="Please ensure the number of question field is not blank." Display="Dynamic" ForeColor="Red" ControlToValidate="quesNum"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" SetFocusOnError="true" ErrorMessage="Please only enter positive range for number of question." Display="Dynamic" ForeColor="Red" ControlToValidate="quesNum" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form-group">
                        <asp:Button runat="server" ID="createAssessBtn" OnClick="createAssessBtn_Click" CssClass="btn btn-block btn-outline-success" Text="Create Assessment" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        document.querySelectorAll('input[type="radio"]').forEach((elem) => {
            elem.classList.add('form-check-input');
        });
    </script>
</asp:Content>
