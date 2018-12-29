<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBarUserControl.ascx.cs" Inherits="university_online_assessment.NavBarUserControl" %>


<%--Navigation Bar--%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="/">
        <img src="/Content/Images/tarc_logo.png" width="40" height="40" class="d-inline-block align-top" />
        TAR UC Online Assessment
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">


        <%--Login View for dynamic navigation bar--%>
        <asp:LoginView runat="server" ID="loginView">
            <RoleGroups>
                <%--Student Navbar--%>
                <asp:RoleGroup Roles="Student">
                    <ContentTemplate>
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="/">Home</a>
                            </li>
                            <li>
                                <a class="nav-link" href="/student/list">Assessment</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="studentDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asp:Label runat="server" ID="userName"></asp:Label>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="studentDropdown">
                                    <asp:LoginStatus CssClass="dropdown-item" runat="server" ID="logoutStatus" LogoutAction="Redirect" LogoutPageUrl="/" />
                                </div>
                            </li>
                        </ul>
                    </ContentTemplate>
                </asp:RoleGroup>

                <%--Lecturer Navbar--%>
                <asp:RoleGroup Roles="Lecturer">
                    <ContentTemplate>
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="/">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/assessment/pre_create">Create Assessment</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/lecturer/list">View List</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="lecturerDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asp:Label runat="server" ID="userName"></asp:Label>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="lecturerDropdown">
                                    <asp:LoginStatus CssClass="dropdown-item" runat="server" ID="logoutStatus" LogoutAction="Redirect" LogoutPageUrl="/" />
                                </div>
                            </li>
                        </ul>
                    </ContentTemplate>
                </asp:RoleGroup>

                <%--Admin Navbar--%>
                <asp:RoleGroup Roles="Admin">
                    <ContentTemplate>
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="/">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/list">View List</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="registerDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Register</a>
                                <div class="dropdown-menu" aria-labelledby="registerDropdown">
                                    <a class="dropdown-item" href="/register/lecturer">Register Lecturer</a>
                                    <a class="dropdown-item" href="/register/student">Register Student</a>
                                    <a class="dropdown-item" href="/register/subject">Register Subject</a>
                                </div>
                            </li>
                        </ul>
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asp:Label runat="server" ID="userName"></asp:Label>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="adminDropdown">
                                    <asp:LoginStatus CssClass="dropdown-item" runat="server" ID="logoutStatus" LogoutAction="Redirect" LogoutPageUrl="/" />
                                </div>
                            </li>
                        </ul>
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>

            <%--Template for non-login user--%>
            <AnonymousTemplate>
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Home</a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <asp:LoginStatus CssClass="nav-link" runat="server" ID="loginStatus" LoginText="Login" />
                    </li>
                </ul>
            </AnonymousTemplate>
        </asp:LoginView>
    </div>
</nav>
