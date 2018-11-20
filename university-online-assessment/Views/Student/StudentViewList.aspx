<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentViewList.aspx.cs" Inherits="university_online_assessment.Views.Student.StudentViewList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="displayProgSection" style="min-height: 100vh">
        <div class="container">
            <nav class="mt-5">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-current-assessments-tab" data-toggle="tab" href="#nav-current-assessments" role="tab" aria-controls="nav-current-assessments" aria-selected="true">Current Assessments</a>
                    <a class="nav-item nav-link" id="nav-past-assessments-tab" data-toggle="tab" href="#nav-past-assessments" role="tab" aria-controls="nav-past-assessments" aria-selected="false">Past Assessments</a>
                </div>
            </nav>

            <div class="tab-content table-responsive" id="nav-tabContent">
                <%--Current Assessment Tab--%>
                <div class="tab-pane fade show active" id="nav-current-assessments" role="tabpanel" aria-labelledby="nav-students-tab">
                    <h2 class="text-center pt-4">Current Assessment List</h2>
                    <hr />

                    <%--Add new student link--%>
                    <%--<asp:HyperLink runat="server" CssClass="btn btn-block btn-outline-primary" NavigateUrl="/register/student" Text="Add New Student" />--%>

                    <%--Search Bar for student--%>
                    <div class="form-inline mt-2">
                        <label for="studSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="currentAsmntSearchBox" class="form-control" />
                    </div>

                </div>
            </div>

            <div class="tab-content table-responsive" id="nav-tabContent">
                <%--Past Assessment Tab--%>
                <div class="tab-pane fade show active" id="nav-past-assessments" role="tabpanel" aria-labelledby="nav-students-tab">
                    <h2 class="text-center pt-4">Past Assessment List</h2>
                    <hr />

                    <%--Add new student link--%>
                    <%--<asp:HyperLink runat="server" CssClass="btn btn-block btn-outline-primary" NavigateUrl="/register/student" Text="Add New Student" />--%>

                    <%--Search Bar for student--%>
                    <div class="form-inline mt-2">
                        <label for="studSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="studSearchBox" class="form-control" />
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>
