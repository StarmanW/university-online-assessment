<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentAssessment.aspx.cs" Inherits="university_online_assessment.Views.Student.StudentAssessment" %>

<asp:Content ID="assessmentQuestionContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="asmntSection" style="min-height: 100vh">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-10 mx-auto pt-3">
                    <h1 class="text-center">
                        <asp:Label runat="server" ID="subjectNameHeader"></asp:Label></h1>
                    <h2 class="text-center">
                        <asp:Label runat="server" ID="assessNameHeader"></asp:Label></h2>

                    <asp:PlaceHolder runat="server" ID="questionPlaceHolder"></asp:PlaceHolder>

                    <div class="form-group pb-3">
                        <div class="row">
                            <div class="col-md-6">
                                <button type="button" class="btn btn-outline-success btn-block" data-toggle="modal" data-target="#exampleModal">Submit</button>
                            </div>
                            <div class="col-md-6">
                                <a href="/student/list" class="btn btn-block btn-outline-primary">Back</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Confirm Submission?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            Please ensure you have double checked your answer.
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-6">
                            <asp:Button runat="server" ID="submitBtn" OnClick="submitAsmntBtn_Click" Text="Confirm" CssClass="btn btn-block btn-outline-success" />
                        </div>
                        <div class="col-md-6">
                            <button type="button" class="btn btn-outline-danger btn-block" data-dismiss="modal" aria-label="Close">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
