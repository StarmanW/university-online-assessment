<%@ Page Title="View List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LecturerViewList.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.ViewList" %>

<asp:Content ID="LecturerViewListContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        // JS scripts for remembering previously active tab
        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "nav-assessments";
            $('#nav-tab a[href="#' + tabId + '"]').tab('show');
            $("#nav-tab a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });
    </script>

    <section id="lecturerViewListSection">
        <div class="container bg-light" style="min-height: 100vh">
            <nav class="pt-5">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link" id="nav-assessments-tab" data-toggle="tab" href="#nav-assessments" role="tab" aria-controls="nav-assessments" aria-selected="false">Assessments</a>
                    <a class="nav-item nav-link active" id="nav-students-tab" data-toggle="tab" href="#nav-students" role="tab" aria-controls="nav-students" aria-selected="true">Students</a>
                </div>
            </nav>

            <div class="tab-content table-responsive" id="nav-tabContent">
                <%--Assessments Tab--%>
                <div class="tab-pane fade show active" id="nav-assessments" role="tabpanel" aria-labelledby="nav-assessments-tab">
                    <h2 class="text-center pt-4">Assessments List</h2>
                    <hr />


                    <%--Search Bar for assessments--%>
                    <div class="form-inline mt-2">
                        <label for="assessSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="assessSearchBox" class="form-control" />
                    </div>


                    <%--Table for assessments list--%>
                    <asp:GridView runat="server"
                        ID="displayLectAssessGrid"
                        EmptyDataText="No assessment found."
                        GridLines="None"
                        CssClass="table mt-4"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Lecturer_Assessment"
                        DataKeyNames="Id"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayLectAssessGrid_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="getLecturerAssessments">
                        <Columns>
                            <asp:TemplateField HeaderText="Assessment Name" HeaderStyle-ForeColor="White" SortExpression="assessName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Assessment.assessName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject Name" HeaderStyle-ForeColor="White" SortExpression="subjectName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Assessment.Subject1.subjectName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assessment Type" HeaderStyle-ForeColor="White" SortExpression="type">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{(Item.Assessment.type == 0 ? "MCQ" : "Written")}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View/Mark" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <a href="#" class="btn btn-outline-primary">Edit</a>
                                    <a href="/lecturer/list/assessment/<%# Item.assessmentId %>" class="btn btn-outline-success">Mark</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <%--Student Tab--%>
                <div class="tab-pane fade" id="nav-students" role="tabpanel" aria-labelledby="nav-students-tab">
                    <h2 class="text-center pt-4">Student List</h2>
                    <hr />

                    <%--Search Bar for student--%>
                    <div class="form-inline mt-2">
                        <label for="studSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="studSearchBox" class="form-control" />
                    </div>

                    <%--Table for student list--%>
                    <asp:GridView runat="server"
                        ID="displayStudentList"
                        EmptyDataText="No students found."
                        GridLines="None"
                        CssClass="table mt-4"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Enrollment"
                        DataKeyNames="Id"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayStudentList_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="displayStudentList_GetData">
                        <Columns>
                            <asp:TemplateField HeaderText="Student ID" HeaderStyle-ForeColor="White" SortExpression="UserName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.aspnet_Users.UserName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.aspnet_Users.Student_Profile.firstName} {Item.aspnet_Users.Student_Profile.lastName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Programme" HeaderStyle-ForeColor="White" SortExpression="progName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Programme.progName.Substring(Item.Programme.progName.IndexOf("(R"))}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View Assessments" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" NavigateUrl="/lecturer/list/student/assessment" Text="View" CssClass="btn btn-outline-primary" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </section>

    <%--Hidden field for remembering previous/current active tab--%>
    <asp:HiddenField ID="hfTab" runat="server" />

    <script>
        // IIFE (Immediately Invoked Function Expression)
        (function () {
            // Select the search input box for each of the table list
            const assessSearchBox = document.querySelector('input#assessSearchBox'),
                studSearchBox = document.querySelector('input#studSearchBox'),
                ID = [
                    'displayLectAssessGrid',
                    'displayStudentList'
                ];

            // Filter programme list function
            function filterAssessment(e) {
                const progTable = document.querySelector(`[id*="${ID[0]}"]`).firstElementChild.children;

                Array.from(progTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(assessSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Filter lecturer list function
            function filterStudents(e) {
                const lectTable = document.querySelector(`[id*="${ID[1]}"]`).firstElementChild.children;

                Array.from(lectTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(studSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Add event listeners to each search box
            assessSearchBox.addEventListener('input', filterAssessment);
            studSearchBox.addEventListener('input', filterStudents);
        })();
    </script>
</asp:Content>
