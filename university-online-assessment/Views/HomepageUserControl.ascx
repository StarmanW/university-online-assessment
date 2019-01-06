<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomepageUserControl.ascx.cs" Inherits="university_online_assessment.Views.WebUserControl1" %>

<%--Login View for dynamic homepage--%>
<asp:LoginView runat="server" ID="loginView">
    <RoleGroups>
        <%--Student homepage--%>
        <asp:RoleGroup Roles="Student">
            <ContentTemplate>
                <div class="card text-center">
                    <div class="card-header">
                        Assessments List
                    </div>
                    <div class="card-body">
                        <p class="card-text">View all your current and past assessments.</p>
                    </div>
                    <div class="card-footer text-muted">
                        <a href="/student/list" class="btn btn-block btn-outline-primary">View Assessments</a>
                    </div>
                </div>
            </ContentTemplate>
        </asp:RoleGroup>

        <%--Lecturer homepage--%>
        <asp:RoleGroup Roles="Lecturer">
            <ContentTemplate>
                <div class="row">
                    <div class="col-md-6">
                        <div class="card text-center">
                            <div class="card-header">
                                Create Assessment
                            </div>
                            <div class="card-body">
                                <p class="card-text">Create a new assessment.<br />
                                    <br />
                                </p>
                            </div>
                            <div class="card-footer text-muted">
                                <a href="/lecturer/assessment/pre_create" class="btn btn-block btn-outline-primary">Create Assessments</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card text-center">
                            <div class="card-header">
                                View List
                            </div>
                            <div class="card-body">
                                <p class="card-text">View all assessment created by you and student assessment result.</p>
                            </div>
                            <div class="card-footer text-muted">
                                <a href="/lecturer/list" class="btn btn-block btn-outline-primary">View List</a>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:RoleGroup>

        <%--Admin homepage--%>
        <asp:RoleGroup Roles="Admin">
            <ContentTemplate>
                <div class="card text-center">
                    <div class="card-header">
                        View List
                    </div>
                    <div class="card-body">
                        <p class="card-text">View the list of students, lecturers and programmes.</p>
                    </div>
                    <div class="card-footer text-muted">
                        <a href="/admin/list" class="btn btn-block btn-outline-primary">View List</a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <div class="card text-center mt-5">
                            <div class="card-header">
                                Register New Student
                            </div>
                            <div class="card-body">
                                <p class="card-text">Register a new student.</p>
                            </div>
                            <div class="card-footer text-muted">
                                <a href="/admin/register/student" class="btn btn-block btn-outline-primary">Register new student</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center mt-5">
                            <div class="card-header">
                                Register New Lecturer
                            </div>
                            <div class="card-body">
                                <p class="card-text">Register a new lecturer.</p>
                            </div>
                            <div class="card-footer text-muted">
                                <a href="/admin/register/lecturer" class="btn btn-block btn-outline-primary">Register new lecturer</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center mt-5">
                            <div class="card-header">
                                Register New Subject
                            </div>
                            <div class="card-body">
                                <p class="card-text">Register a new subject.</p>
                            </div>
                            <div class="card-footer text-muted">
                                <a href="/admin/register/subject" class="btn btn-block btn-outline-primary">Register new subject</a>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:RoleGroup>
    </RoleGroups>

    <%--Template for non-login user--%>
    <AnonymousTemplate>
        <div class="card text-center">
            <div class="card-header">
                LOGIN
            </div>
            <div class="card-body">
                <p class="card-text">Login to your account.</p>
            </div>
            <div class="card-footer text-muted">
                <a href="/login" class="btn btn-block btn-outline-primary">Login</a>
            </div>
        </div>
    </AnonymousTemplate>
</asp:LoginView>
