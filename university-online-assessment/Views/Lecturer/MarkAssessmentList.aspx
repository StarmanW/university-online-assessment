<%@ Page Title="Mark Assessment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarkAssessmentList.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.MarkAssessmentList" %>

<asp:Content ID="markAssessmentList" ContentPlaceHolderID="MainContent" runat="server">
    <section id="markAssessmentListSection" style="min-height: 100vh">
        <div class="container bg-light">
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
                            <a href="/lecturer/list/assessment/<%# Item.assessmentId %>/<%# Item.studentId %>/mark" class="btn btn-outline-primary">View/Mark</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</asp:Content>
