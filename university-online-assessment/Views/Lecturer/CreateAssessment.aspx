<%@ Page Title="Create Assessment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateAssessment.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.CreateQuestion" %>

<asp:Content ID="CreateAssessmentContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="createAssessmentSection">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-10 mx-auto pt-3">
                    <h3 class="text-center">Assessment for <asp:Label runat="server" ID="subjectLbl"></asp:Label></h3>
                    
                    <div class="form-group">
                        <label>Assessment Name:</label>
                        <asp:TextBox runat="server" ID="assessName" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                    <asp:PlaceHolder runat="server" ID="questionPlaceHolder">
                    </asp:PlaceHolder>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Button runat="server" ID="submitBtn" OnClick="submitBtn_Click" Text="Create Assessment" CssClass="btn btn-block btn-outline-success" />
                            </div>
                            <div class="col-md-6">
                                <a href="/assessment/pre_create" class="btn btn-block btn-outline-primary">Back</a>
                            </div>
                        </div>
                    </div>

                    <asp:Label runat="server" ID="testLbl"></asp:Label>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
