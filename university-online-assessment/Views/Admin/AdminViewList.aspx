<%@ Page Title="View List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminViewList.aspx.cs" Inherits="university_online_assessment.Views.Admin.ViewLecturerList" %>

<asp:Content ID="AdminViewListContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        // JS scripts for remembering previously active tab
        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "nav-students";
            $('#nav-tab a[href="#' + tabId + '"]').tab('show');
            $("#nav-tab a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });
    </script>

    <section id="AdminListContent" style="min-height: 100vh">
        <div class="container">
            <nav class="pt-5">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-students-tab" data-toggle="tab" href="#nav-students" role="tab" aria-controls="nav-students" aria-selected="true">Students</a>
                    <a class="nav-item nav-link" id="nav-programmes-tab" data-toggle="tab" href="#nav-programmes" role="tab" aria-controls="nav-programmes" aria-selected="false">Programmes</a>
                    <a class="nav-item nav-link" id="nav-lecturers-tab" data-toggle="tab" href="#nav-lecturers" role="tab" aria-controls="nav-lecturers" aria-selected="false">Lecturers</a>
                </div>
            </nav>

            <div class="tab-content table-responsive" id="nav-tabContent">
                <%--Student Tab--%>
                <div class="tab-pane fade show active" id="nav-students" role="tabpanel" aria-labelledby="nav-students-tab">
                    <h2 class="text-center pt-4">Student List</h2>
                    <hr />

                    <%--Add new student link--%>
                    <asp:HyperLink runat="server" CssClass="btn btn-block btn-outline-primary" NavigateUrl="/admin/register/student" Text="Add New Student" />

                    <%--Search Bar for student--%>
                    <div class="form-inline mt-2">
                        <label for="studSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="studSearchBox" class="form-control" />
                    </div>

                    <%--Table for student list--%>
                    <asp:GridView runat="server"
                        ID="displayStudGrid"
                        EmptyDataText="No student found."
                        GridLines="None"
                        CssClass="table mt-4"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Student_Profile"
                        DataKeyNames="Id"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayStudGrid_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="getStudents">
                        <Columns>
                            <asp:TemplateField HeaderText="Student ID" HeaderStyle-ForeColor="White" SortExpression="aspnet_Users.UserName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.aspnet_Users.UserName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.firstName} {Item.lastName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="gender" HeaderText="Gender" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="birthDate" HeaderText="Birth date" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="icNum" HeaderText="IC Number" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="contactNo" HeaderText="Contact" HeaderStyle-ForeColor="White" />
                        </Columns>
                    </asp:GridView>
                </div>

                <%--Programme Tab--%>
                <div class="tab-pane fade" id="nav-programmes" role="tabpanel" aria-labelledby="nav-programmes-tab">
                    <h2 class="text-center pt-4">Programme List</h2>
                    <hr />

                    <%--Search Bar for programme--%>
                    <div class="form-inline mt-2">
                        <label for="progSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="progSearchBox" class="form-control" />
                    </div>

                    <%--Table for programme list--%>
                    <asp:GridView runat="server"
                        ID="displayProgGrid"
                        EmptyDataText="No programme found."
                        GridLines="None"
                        CssClass="table mt-2"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Programme"
                        DataKeyNames="progId"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayProgGrid_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="getProgrammes">
                        <Columns>
                            <asp:DynamicField DataField="progName" HeaderText="Programme Name" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="faculty" HeaderText="Faculty" HeaderStyle-ForeColor="White" />
                        </Columns>
                    </asp:GridView>
                </div>

                <%--Lecturers Tab--%>
                <div class="tab-pane fade" id="nav-lecturers" role="tabpanel" aria-labelledby="nav-lecturers-tab">
                    <h2 class="text-center pt-4">Lecturer List</h2>
                    <hr />

                    <%--Add new lecturer link--%>
                    <asp:HyperLink runat="server" CssClass="btn btn-block btn-outline-primary" NavigateUrl="/admin/register/lecturer" Text="Add New Lecturer" />

                    <%--Search Bar for lecturer--%>
                    <div class="form-inline mt-2">
                        <label for="lectSearchBox" class="mr-2">Search:</label>
                        <input type="text" id="lectSearchBox" class="form-control" />
                    </div>

                    <%--Table for lecturer list--%>
                    <asp:GridView runat="server"
                        ID="displayLectGrid"
                        EmptyDataText="No lecturers found."
                        GridLines="None"
                        CssClass="table mt-2"
                        HeaderStyle-CssClass="thead-dark"
                        PagerStyle-CssClass="pagination-ys"
                        ItemType="university_online_assessment.Models.Lecturer_Profile"
                        DataKeyNames="Id"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="10"
                        OnSorted="displayLectGrid_Sorted"
                        AutoGenerateColumns="false"
                        SelectMethod="getLecturers">
                        <Columns>
                            <asp:TemplateField HeaderText="Lecturer ID" HeaderStyle-ForeColor="White" SortExpression="aspnet_Users.UserName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.aspnet_Users.UserName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" HeaderStyle-ForeColor="White" SortExpression="firstName">
                                <ItemTemplate>
                                    <asp:Label Text='<%# $"{Item.firstName} {Item.lastName}" %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="gender" HeaderText="Gender" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="birthDate" HeaderText="Birth date" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="icNum" HeaderText="IC Number" HeaderStyle-ForeColor="White" />
                            <asp:DynamicField DataField="contactNo" HeaderText="Contact" HeaderStyle-ForeColor="White" />
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
            const studSearchBox = document.querySelector('input#studSearchBox'),
                progSearchBox = document.querySelector('input#progSearchBox'),
                lectSearchBox = document.querySelector('input#lectSearchBox'),
                ID = [
                    'displayStudGrid',
                    'displayProgGrid',
                    'displayLectGrid'
                ];

            // Filter student list function
            function filterStudentList(e) {
                // Query select all rows for student table
                const studTable = document.querySelector(`[id*="${ID[0]}"]`).firstElementChild.children;

                /**
                 * Loop through each row of the table and filter out
                 * the header and pagination. This is because
                 * WebForms sucks by combining both 'thead'
                 * and pagination inside 'tbody'. Would've
                 * been much easier if separated.
                 */
                Array.from(studTable).forEach((v, i) => {
                    // Filter out header/pagination row
                    if (v.className === '') {
                        // Perform search box matching, display='none' to those doesn't match
                        if (v.innerText.toLowerCase().indexOf(studSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Filter programme list function
            function filterProgrammeList(e) {
                const progTable = document.querySelector(`[id*="${ID[1]}"]`).firstElementChild.children;

                Array.from(progTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(progSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Filter lecturer list function
            function filterLecturerList(e) {
                const lectTable = document.querySelector(`[id*="${ID[2]}"]`).firstElementChild.children;

                Array.from(lectTable).forEach((v, i) => {
                    if (v.className === '') {
                        if (v.innerText.toLowerCase().indexOf(lectSearchBox.value.toLowerCase()) !== -1) {
                            v.style.removeProperty('display');
                        } else {
                            v.style.display = 'none';
                        }
                    }
                });
            }

            // Add event listeners to each search box
            studSearchBox.addEventListener('input', filterStudentList);
            progSearchBox.addEventListener('input', filterProgrammeList);
            lectSearchBox.addEventListener('input', filterLecturerList);
        })();
    </script>
</asp:Content>
