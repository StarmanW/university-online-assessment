<%@ Page Title="Register New Subject" EnableViewState="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterSubject.aspx.cs" Inherits="university_online_assessment.Views.Admin.RegisterSubject" %>

<asp:Content ID="RegisterSubjectContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="registerSubjectSection" class="bg-dark">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-8 pb-4 mx-auto">
                    <h1 class="text-center pt-3">Register New Subject</h1>
                    <hr class="mb-1" />

                    <%-- Alert Section --%>
                    <div class="alert alert-success" role="alert" visible="false" runat="server" id="alertSuccess">
                        <p class="mb-0">New subject (<asp:Label runat="server" ID="newSubjectName"></asp:Label>) has been successfully registered!</p>
                    </div>
                    <div class="alert alert-danger" role="alert" visible="false" runat="server" id="alertFailure">
                        <p class="mb-0">
                            <asp:Label runat="server" ID="alertFailureMsg"></asp:Label>
                        </p>
                    </div>

                    <%--Register subject form--%>
                    <asp:FormView runat="server"
                        ID="registerSubjectForm"
                        DefaultMode="Insert"
                        InsertMethod="addNewSubject"
                        ItemType="university_online_assessment.Models.Subject"
                        RenderOuterTable="false"
                        DataKeyNames="Id">
                        <InsertItemTemplate>
                            <asp:Label ID="requiredLabel" runat="server" ForeColor="Red" Text="All fields are required" />

                            <%--Subject Name--%>
                            <div class="form-group">
                                <label for="subjectName">Subject Name</label>
                                <asp:TextBox runat="server" ID="subjectName" Text='<%# Bind("subjectName") %>' CssClass="form-control" placeholder="Enter subject name"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="subjectName" Display="Dynamic" ErrorMessage="Please ensure the subject name field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="subjectName" Display="Dynamic" ErrorMessage="Please enter the correct subject name format." ValidationExpression="^[A-z0-9 ]+$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Credit Hour--%>
                            <div class="form-group">
                                <label for="creditHour">Credit Hour</label>
                                <asp:TextBox runat="server" ID="creditHour" TextMode="Number" Text='<%# Bind("creditHours") %>' CssClass="form-control" placeholder="Enter credit hour"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="creditHour" Display="Dynamic" ErrorMessage="Please ensure the credit hour field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="creditHour" Display="Dynamic" ErrorMessage="Please enter the credit hour format." ValidationExpression="^[0-9]$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Programme--%>
                            <div class="form-group">
                                <label for="programme">Programme</label>
                                <asp:DropDownList runat="server" ID="programme" CssClass="form-control" SelectedValue='<%# Bind("progId") %>'>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="programme" Display="Dynamic" ErrorMessage="Please ensure the programme is selected."></asp:RequiredFieldValidator>
                            </div>
                            

                            <%--Buttons--%>
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Button runat="server" CommandName="Insert" ID="submit" CssClass="btn btn-outline-success btn-block" Text="Submit" />
                                </div>
                                <div class="col-md-6 mt-2 mt-md-0">
                                    <input type="reset" id="reset" class="btn btn-outline-primary btn-block" value="Reset" />
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:FormView>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
