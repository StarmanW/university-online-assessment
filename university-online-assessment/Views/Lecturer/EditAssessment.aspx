<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditAssessment.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.EditAssessment" %>

<asp:Content ID="editAssessmentContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="editAssessmentSection">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-10 mx-auto pt-3">
                    <%--Successful update alert--%>
                    <asp:PlaceHolder runat="server" ID="updateStatus" Visible="false">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                                <span class="sr-only">Close</span>
                            </button>
                            The assessment has been successfully updated!
                        </div>
                    </asp:PlaceHolder>

                    <h3 class="text-center">Assessment for
                        <asp:Label runat="server" ID="subjectLbl"></asp:Label></h3>

                    <%--Change Subject--%>
                    <div class="form-group">
                        <label for="subject">Change Subject</label>
                        <asp:DropDownList runat="server" ID="subject" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="subject" Display="Dynamic" ErrorMessage="Please ensure the subject is selected."></asp:RequiredFieldValidator>
                    </div>

                    <%--Assessment Publicity--%>
                    <div class="form-group">
                        <label>Publicity:</label>
                        <asp:RadioButtonList runat="server" ID="assessPublicity" CssClass="form-check form-check-inline" RepeatLayout="Flow">
                            <asp:ListItem Value="0" Text="Private" class="form-check-input"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Public" class="form-check-input"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" ErrorMessage="Please select a assessment publicity." Display="Dynamic" ForeColor="Red" ControlToValidate="assessPublicity"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" SetFocusOnError="true" ErrorMessage="Please select the correct assessment publicity." Display="Dynamic" ForeColor="Red" ControlToValidate="assessPublicity" ValidationExpression="^[0-1]$"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form-group">
                        <label>Assessment Name:</label>
                        <asp:TextBox runat="server" ID="assessName" CssClass="form-control"></asp:TextBox>
                    </div>

                    <asp:PlaceHolder runat="server" ID="questionPlaceHolder"></asp:PlaceHolder>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Button runat="server" ID="updateBtn" OnClick="updateBtn_Click" Text="Update Assessment" CssClass="btn btn-block btn-outline-success" />
                            </div>
                            <div class="col-md-6">
                                <a href="/lecturer/list" class="btn btn-block btn-outline-primary">Back</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
