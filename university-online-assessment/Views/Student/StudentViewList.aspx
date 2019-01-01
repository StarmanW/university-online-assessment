<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentViewList.aspx.cs" Inherits="university_online_assessment.Views.Student.StudentViewList" %>

<asp:Content ID="studentViewListContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        // JS scripts for remembering previously active tab
        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "nav-current-assessments";
            $('#nav-tab a[href="#' + tabId + '"]').tab('show');
            $("#nav-tab a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });
    </script>

    <section id="displayAsmntSection" style="min-height: 100vh">
        <div class="container bg-light">
            <nav class="pt-5">

                <%--Assessment Completion Alert--%>
                <asp:PlaceHolder runat="server" ID="alertPlaceholder" Visible="false">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        You have successfully completed the
                        <asp:Label runat="server" ID="assessName" />
                        assessment! Thank you for your time!<br />
                        Click on "Past Assessments" tabs to view your score.
                    </div>
                </asp:PlaceHolder>

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
                        <label for="currentAsmntSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="currentAsmntSearchBox" class="form-control" />
                    </div>

                    <%--Table for current assessments list--%>
                    <asp:GridView runat="server"
                        ID="displayCurrentAssessmentList"
                        EmptyDataText="No assessment found."
                        GridLines="None"
                        CssClass="table mt-4"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Assessment"
                        DataKeyNames="Id"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayCurrentAssessmentList_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="displayCurrentAssessmentList_GetData">
                        <Columns>
                            <asp:TemplateField HeaderText="Assessment Name" HeaderStyle-ForeColor="White" SortExpression="assessName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.assessName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject" HeaderStyle-ForeColor="White" SortExpression="subjectName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Subject1.subjectName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type" HeaderStyle-ForeColor="White" SortExpression="type">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{(Item.type == 0 ? "MCQ" : "Written")}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View" HeaderStyle-ForeColor="White">
                                <ItemTemplate>
                                    <a href="/student/assessment/<%# Item.Id %>" class="btn btn-outline-primary">View</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <%--Past Assessment Tab--%>
                <div class="tab-pane fade show" id="nav-past-assessments" role="tabpanel" aria-labelledby="nav-students-tab">
                    <h2 class="text-center pt-4">Past Assessment List</h2>
                    <hr />

                    <%--Search Bar for past assessments--%>
                    <div class="form-inline mt-2">
                        <label for="pastAsmntSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="pastAsmntSearchBox" class="form-control" />
                    </div>

                    <%--Table for assessments list--%>
                    <asp:GridView runat="server"
                        ID="displayPastAssessmentList"
                        EmptyDataText="No assessment found."
                        GridLines="None"
                        CssClass="table mt-4"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Student_Assessment"
                        DataKeyNames="Id"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayPastAssessmentList_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="displayPastAssessmentList_GetData">
                        <Columns>
                            <asp:TemplateField HeaderText="Assessment Name" HeaderStyle-ForeColor="White" SortExpression="assessName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Assessment.assessName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject" HeaderStyle-ForeColor="White" SortExpression="subjectName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Assessment.Subject1.subjectName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type" HeaderStyle-ForeColor="White" SortExpression="type">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{(Item.Assessment.type == 0 ? "MCQ" : "Written")}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date Completed" HeaderStyle-ForeColor="White" SortExpression="dateFinished">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.dateFinished}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Grade" HeaderStyle-ForeColor="White" SortExpression="score">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.score}" %>' runat="server"></asp:Label>
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
            const currentAsmntSearchBox = document.querySelector('input#currentAsmntSearchBox'),
                pastAsmntSearchBox = document.querySelector('input#pastAsmntSearchBox'),
                ID = [
                    'displayCurrentAssessmentList',
                    'displayPastAssessmentList'
                ];

            // Filter current asssessment list function
            function filterCurrentAssessment(e) {
                const progTable = document.querySelector(`[id*="${ID[0]}"]`).firstElementChild.children;

                Array.from(progTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(currentAsmntSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Filter pass assessment list function
            function filterPastAssessment(e) {
                const lectTable = document.querySelector(`[id*="${ID[1]}"]`).firstElementChild.children;

                Array.from(lectTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(pastAsmntSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Add event listeners to each search box
            currentAsmntSearchBox.addEventListener('input', filterCurrentAssessment);
            pastAsmntSearchBox.addEventListener('input', filterPastAssessment);
        })();
    </script>
</asp:Content>
