<%@ Page Title="Assessment by Student" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentAssessmentsList.aspx.cs" Inherits="university_online_assessment.Views.Lecturer.StudentAssessmentsList" %>

<asp:Content ID="studAssessListContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="studAssessListSection" style="min-height: 100vh">
        <div class="container bg-light">
            <h2 class="text-center pt-4">Assessments List for
                <br />
                <asp:Label runat="server" ID="studInfoHeader"></asp:Label></h2>
            <hr />

            <%--Back to View List link--%>
            <asp:HyperLink runat="server" CssClass="btn btn-block btn-outline-primary" NavigateUrl="/lecturer/list" Text="Back to View List" />

            <%--Search Bar for assessments--%>
            <div class="form-inline mt-2">
                <label for="studAssessmentList" class="mr-2">Search:</label>
                <input type="text" id="studAssessmentListSearchBox" class="form-control" />
            </div>

            <%--Table of assessments list for a specific student--%>
            <asp:GridView runat="server"
                ID="displayStudAssessList"
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
                SelectMethod="displayStudAssessList_GetData">
                <Columns>
                    <asp:TemplateField HeaderText="Assessment Name" HeaderStyle-ForeColor="White" SortExpression="Assessment.assessName">
                        <ItemTemplate>
                            <asp:Label Text='<%# $"{Item.Assessment.assessName}" %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Subject Name" HeaderStyle-ForeColor="White" SortExpression="Assessment.Subject1.subjectName">
                        <ItemTemplate>
                            <asp:Label Text='<%# $"{Item.Assessment.Subject1.subjectName}" %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assessment Type" HeaderStyle-ForeColor="White" SortExpression="Assessment.type">
                        <ItemTemplate>
                            <asp:Label Text='<%# $"{(Item.Assessment.type == 0 ? "MCQ" : "Written")}" %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Grade" HeaderStyle-ForeColor="White" SortExpression="score">
                        <ItemTemplate>
                            <asp:Label Text='<%# Item.getGrade() %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>

    <script>
        // IIFE (Immediately Invoked Function Expression)
        (function () {
            // Select the search input box for each of the table list
            const studAssessmentListSearchBox = document.querySelector('input#studAssessmentListSearchBox'),
                ID = [
                    'displayStudAssessList',
                ];

            // Filter assessment list function
            function filterAssessment(e) {
                const progTable = document.querySelector(`[id*="${ID[0]}"]`).firstElementChild.children;

                Array.from(progTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(studAssessmentListSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Add event listeners to each search box
            studAssessmentListSearchBox.addEventListener('input', filterAssessment);
        })();
    </script>
</asp:Content>
