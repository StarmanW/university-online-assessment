<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarkWrittenAssessment.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.StudentAssessment" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="createAssessmentSection">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-10 mx-auto pt-3">

                    <%--Assessment Creation Successful Alert--%>
                    <asp:PlaceHolder runat="server" ID="alertPlaceholder" Visible="false">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                                <span class="sr-only">Close</span>
                            </button>
                            The assessment has been successfully graded!<br />
                            Total mark is <asp:Label runat="server" ID="totalMarkLbl" />
                        </div>
                    </asp:PlaceHolder>

                    <h3 class="text-center">Assessment For : 
                        <asp:Label runat="server" ID="subjectLbl"></asp:Label></h3>

                    <div class="form-group text-center">
                        <asp:Label runat="server" ID="assessNameLbl"></asp:Label>
                    </div>

                    <asp:PlaceHolder runat="server" ID="questionPlaceHolder"></asp:PlaceHolder>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Button runat="server" ID="submitBtn" OnClick="submitBtn_Click" Text="Mark Assessment" CssClass="btn btn-block btn-outline-success" />
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
