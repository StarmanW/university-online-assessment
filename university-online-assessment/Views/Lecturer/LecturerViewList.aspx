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
        <div class="container" style="min-height: 100vh">
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
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>Assessment No.</th>
                                <th>Name</th>
                                <th>Subject</th>
                                <th>Type</th>
                                <th>View/Mark</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Chapter 1 Intro to ASP.NET</td>
                                <td>BAIT2113 Web Application Development</td>
                                <td>MCQ</td>
                                <td>
                                    <asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" />
                                    <asp:HyperLink runat="server" NavigateUrl="/lecturer/list/assessment/mark" Text="Mark" CssClass="btn btn-outline-success" /></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Chapter 2 Agile methods</td>
                                <td>BAIT3343 Agile Software Development</td>
                                <td>Written</td>
                                <td>
                                    <asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" />
                                    <asp:Button runat="server" Text="Mark" CssClass="btn btn-outline-success" /></td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Chapter 3 Switch Security</td>
                                <td>BAIT2164 Computer Networks</td>
                                <td>Written</td>
                                <td>
                                    <asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" />
                                    <asp:Button runat="server" Text="Mark" CssClass="btn btn-outline-success" /></td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Chapter 4 Agile</td>
                                <td>BAIT3343 Agile Software Development</td>
                                <td>MCQ</td>
                                <td>
                                    <asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" />
                                    <asp:Button runat="server" Text="Mark" CssClass="btn btn-outline-success" /></td>
                            </tr>
                        </tbody>
                    </table>
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
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Programme</th>
                                <th>View Assessments</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>18WMR12048</td>
                                <td>Samuel Wong Kim Foong</td>
                                <td>RSD</td>
                                <td>
                                    <asp:HyperLink runat="server" NavigateUrl="/lecturer/list/student/assessment" Text="View" CssClass="btn btn-outline-primary" /></td>
                            </tr>
                            <tr>
                                <td>18WMR12658</td>
                                <td>Chong Jia Herng</td>
                                <td>RSD</td>
                                <td>
                                    <asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" /></td>
                            </tr>
                            <tr>
                                <td>18WBU32687</td>
                                <td>Thiban Kumar</td>
                                <td>RIT</td>
                                <td>
                                    <asp:Button runat="server" Text="View" CssClass="btn btn-outline-primary" /></td>
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
