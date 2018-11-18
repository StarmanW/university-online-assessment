<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="university_online_assessment.Views.Login" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        // JS scripts for remembering previously active tab
        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "student";
            $(`#nav-tab a[href="#${tabId}"]`).tab('show');
            $("#nav-tab a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });
    </script>

    <section id="loginSection">
        <div class="container pt-5">

            <%--Nav tabs--%>
            <ul class="nav nav-tabs" id="nav-tab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="student-login-tab" data-toggle="tab" href="#student" role="tab" aria-controls="student" aria-selected="true">Student Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="lecturer-login-tab" data-toggle="tab" href="#lecturer" role="tab" aria-controls="lecturer" aria-selected="false">Lecturer Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="admin-login-tab" data-toggle="tab" href="#admin" role="tab" aria-controls="admin" aria-selected="false">Admin Login</a>
                </li>
            </ul>

            <%--Tab Content--%>
            <div class="tab-content" id="loginContent">
                <%--Student Login Tab--%>
                <div class="tab-pane fade show active" id="student" role="tabpanel" aria-labelledby="student-login-tab">
                    <div class="col-md-8 mx-auto pt-4">
                        <div class="row">
                            <div class="col-md-2 form-group">
                                <label for="studId">Student ID:</label>
                            </div>
                            <div class="col-md-10 form-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="studId"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="studIdRequired" runat="server" ControlToValidate="studId" ErrorMessage="Student ID is required." ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="StudentGroup" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-2 form-group">
                                <label for="studPassword">Password:</label>
                            </div>
                            <div class="col-md-10 form-group">
                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" ID="studPassword"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="studPasswordRequired" runat="server" ControlToValidate="studPassword" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="StudentGroup" />
                            </div>
                        </div>

                        <div class="form-group form-check">
                            <asp:CheckBox ID="studentRememberMe" runat="server" Text="Remember me." />
                            <br />
                            <asp:Label runat="server" ID="studentLoginInfo" CssClass="text-danger"></asp:Label>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Button ID="studentLoginBtn" OnClick="studentLoginBtn_Click" ValidationGroup="StudentGroup" runat="server" Text="Log In" CssClass="btn btn-block btn-outline-success" />
                                </div>
                                <div class="col-md-6">
                                    <asp:HyperLink ID="studRegisterBtn" NavigateUrl="/register/student" runat="server" Text="Register an Account" CssClass="btn btn-block btn-outline-primary" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--Lecturer Login Tab--%>
                <div class="tab-pane fade" id="lecturer" role="tabpanel" aria-labelledby="lecturer-login-tab">
                    <div class="col-md-8 mx-auto pt-4">
                        <div class="row">
                            <div class="col-md-2 form-group">
                                <label for="lecturerId">Lecturer ID:</label>
                            </div>
                            <div class="col-md-10 form-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="lecturerId"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="lecturerIdReuqired" runat="server" ControlToValidate="lecturerId" ErrorMessage="Lecturer ID is required." ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="LecturerGroup" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-2 form-group">
                                <label for="lecturerPassword">Password:</label>
                            </div>
                            <div class="col-md-10 form-group">
                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" ID="lecturerPassword"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="lecturerPasswordRequired" runat="server" ControlToValidate="lecturerPassword" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="LecturerGroup" />
                            </div>
                        </div>

                        <div class="form-group form-check">
                            <asp:CheckBox ID="lecturerRememberMe" runat="server" Text="Remember me." />
                            <br />
                            <asp:Label runat="server" ID="lecturerLoginInfo" CssClass="text-danger"></asp:Label>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="lecturerLoginBtn" OnClick="lecturerLoginBtn_Click" ValidationGroup="LecturerGroup" runat="server" Text="Log In" CssClass="btn btn-block btn-outline-success" />
                        </div>
                    </div>
                </div>

                <%--Admin Login Tab--%>
                <div class="tab-pane fade" id="admin" role="tabpanel" aria-labelledby="admin-login-tab">
                    <div class="col-md-8 mx-auto pt-4">
                        <div class="row">
                            <div class="col-md-2 form-group">
                                <label for="adminId">Admin ID:</label>
                            </div>
                            <div class="col-md-10 form-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="adminId"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="adminIdRequired" runat="server" ControlToValidate="adminId" ErrorMessage="Admin ID is required." ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="AdminGroup" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-2 form-group">
                                <label for="adminPassword">Password:</label>
                            </div>
                            <div class="col-md-10 form-group">
                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" ID="adminPassword"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="adminPasswordRequired" runat="server" ControlToValidate="adminPassword" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="AdminGroup" />
                            </div>
                        </div>

                        <div class="form-group form-check">
                            <asp:CheckBox ID="adminRememberMe" runat="server" Text="Remember me." />
                            <br />
                            <asp:Label runat="server" ID="adminLoginInfo" CssClass="text-danger"></asp:Label>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="adminLoginBtn" ValidationGroup="AdminGroup" runat="server" Text="Log In" OnClick="adminLoginBtn_Click" CssClass="btn btn-block btn-outline-success" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfTab" runat="server" />
    </section>

    <script type="text/javascript">
        document.querySelectorAll('input[type="checkbox"]').forEach((elem) => {
            elem.classList.add('form-check-input');
        });
    </script>
</asp:Content>
