<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentViewList.aspx.cs" Inherits="university_online_assessment.Views.Student.StudentViewList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section id="displayAsmntSection" style="min-height: 100vh">
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

                    <%--Search Bar for current assessments--%>
                    <div class="form-inline mt-2">
                        <label for="studSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="currentAsmntSearchBox" class="form-control" />
                    </div>

                    <%--Table for assessments list--%>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>Assessment No.</th>
                                <th>Name</th>
                                <th>Subject</th>
                                <th>Type</th>
                                <th>View</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Chapter 3 Quiz</td>
                                <td>ADMK3262 Principles of Marketing</td>
                                <td>MCQ</td>
                                <td><asp:Button ID="btnViewAsmnt" runat="server" Text="View" OnClick="btnViewAsmnt_Click" CssClass="btn btn-outline-primary" /></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Chapter 2 Test</td>
                                <td>ADMK3262 Principles of Marketing</td>
                                <td>Written</td>
                                <td><asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" /></td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Chapter 4 - 5 Quiz</td>
                                <td>AACA3232 Principles of Finance</td>
                                <td>Written</td>
                                <td><asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" /></td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Mid Term Test Preparation</td>
                                <td>ADMK2563 Digital Marketing</td>
                                <td>MCQ</td>
                                <td><asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>


                <%--Past Assessment Tab--%>
                <div class="tab-pane fade show" id="nav-past-assessments" role="tabpanel" aria-labelledby="nav-students-tab">
                    <h2 class="text-center pt-4">Past Assessment List</h2>
                    <hr />

                    <%--Search Bar for past assessments--%>
                    <div class="form-inline mt-2">
                        <label for="studSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="pastAsmntSearchBox" class="form-control" />
                    </div>

                    <%--Table for assessments list--%>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>Assessment No.</th>
                                <th>Name</th>
                                <th>Subject</th>
                                <th>Date Completed</th>
                                <th>Grade</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Chapter 3 Quiz</td>
                                <td>ADMK3262 Principles of Marketing</td>
                                <td>12 December 2018</td>
                                <td>A</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Chapter 2 Test</td>
                                <td>ADMK3262 Principles of Marketing</td>
                                <td>12 December 2018</td>
                                <td>A</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Chapter 4 - 5 Quiz</td>
                                <td>AACA3232 Principles of Finance</td>
                                <td>12 December 2018</td>
                                <td>A</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Mid Term Test Preparation</td>
                                <td>ADMK2563 Digital Marketing</td>
                                <td>12 December 2018</td>
                                <td>A</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

    <%--Hidden field for remembering previous/current active tab--%>
    <asp:HiddenField ID="hfTab" runat="server" />
</asp:Content>
