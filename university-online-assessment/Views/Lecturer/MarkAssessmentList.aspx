<%@ Page Title="Mark Assessment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarkAssessmentList.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.MarkAssessmentList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="studAssessListSection" style="min-height: 100vh">
        <div class="container">
            <h2 class="text-center pt-4">Students List for
                <br />
                Asssessment "Chapter 1 Intro to ASP.NET"</h2>
            <hr />

            <%--Back to View List link--%>
            <asp:HyperLink runat="server" CssClass="btn btn-block btn-outline-primary" NavigateUrl="/lecturer/list" Text="Back to View List" />

            <%--Search Bar for assessments--%>
            <div class="form-inline mt-2">
                <label for="assessSearchBox" class="mr-2">Search:</label>
                <input type="text" id="assessSearchBox" class="form-control" />
            </div>

            <%--Table for assessments list--%>
            <asp:GridView runat="server"
                ID="displayStudentAssessmentList"
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
                AutoGenerateColumns="false"
                SelectMethod="displayStudentAssessmentList_GetData">
                <Columns>
                    <asp:TemplateField HeaderText="Assessment Name" HeaderStyle-ForeColor="White" SortExpression="assessName">
                        <ItemTemplate>
                            <asp:Label Text='<%# $"{Item.Assessment.assessName}" %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Student ID" HeaderStyle-ForeColor="White" SortExpression="subjectName">
                        <ItemTemplate>
                            <asp:Label Text='<%# $"{Item.aspnet_Users.UserName}" %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Grade" HeaderStyle-ForeColor="White" SortExpression="type">
                        <ItemTemplate>
                            <asp:Label Text='<%# $"{Item.getGrade()}" %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="View/Mark" HeaderStyle-ForeColor="White">
                        <ItemTemplate>
                            <a href="/lecturer/list/assessment/student/mark/<%# Item.assessmentId %>/<%# Item.studentId %>" class="btn btn-outline-primary">View</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Grade</th>
                        <th>View/Mark</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>18WMR12048</td>
                        <td>Samuel Wong Kim Foong</td>
                        <td>None</td>
                        <td>
                            <asp:HyperLink runat="server" ID="markBtn" NavigateUrl="/lecturer/list/assessment/student/mark" Text="Mark" CssClass="btn btn-outline-primary"></asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td>18WMR12658</td>
                        <td>Chong Jia Herng</td>
                        <td>A</td>
                        <td>
                            <asp:HyperLink runat="server" ID="HyperLink1" NavigateUrl="#" Text="Mark" CssClass="btn btn-outline-primary"></asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td>18WBU32687</td>
                        <td>Thiban Kumar</td>
                        <td>A</td>
                        <td>
                            <asp:HyperLink runat="server" ID="HyperLink2" NavigateUrl="#" Text="Mark" CssClass="btn btn-outline-primary"></asp:HyperLink></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
</asp:Content>
