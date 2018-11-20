<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarkStudentAssessment.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.StudentAssessment" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="createAssessmentSection">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-10 mx-auto pt-3">
                    <h3 class="text-center">Assessment for
                        <asp:Label runat="server" ID="subjectLbl"></asp:Label></h3>

                    <div class="form-group">
                        <label>Assessment Name: Chapter 1 Intro to ASP.NET</label>
                    </div>

                    <asp:PlaceHolder runat="server" ID="questionPlaceHolder"></asp:PlaceHolder>

                    <div class="form-group">
                        <label>Question 1</label>
                        <textarea class="form-control">Some answers here...</textarea>
                    </div>

                    <div class="form-group">
                        <label>Question 2</label>
                        <textarea class="form-control">Some answers here...</textarea>
                    </div>

                    <div class="form-group">
                        <label>Question 3</label>
                        <textarea class="form-control">Some answers here...</textarea>
                    </div>

                    <div class="form-group">
                        <label>Final Mark</label>
                        <asp:TextBox runat="server" TextMode="Number" min="0" max="100" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Button runat="server" ID="submitBtn" Text="Mark Assessment" CssClass="btn btn-block btn-outline-success" />
                            </div>
                            <div class="col-md-6">
                                <a href="/assessment/pre_create" class="btn btn-block btn-outline-primary">Back</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
