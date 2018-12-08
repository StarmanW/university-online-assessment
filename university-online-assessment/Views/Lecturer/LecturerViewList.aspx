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
                            <asp:TemplateField HeaderText="Assessment Name" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Assessment.assessName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject Name" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.Assessment.Subject1.subjectName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assessment Type" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{(Item.Assessment.type == 0 ? "MCQ" : "Written")}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View/Mark" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:HyperLink runat="server" NavigateUrl="#" Text="View" CssClass="btn btn-outline-primary" />
                                    <asp:HyperLink runat="server" NavigateUrl="#" Text="Mark" CssClass="btn btn-outline-success" />
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
