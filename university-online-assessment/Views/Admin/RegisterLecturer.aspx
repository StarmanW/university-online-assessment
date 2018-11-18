<%@ Page Title="Register New Lecturer" EnableViewState="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterLecturer.aspx.cs" Inherits="university_online_assessment.Views.Admin.RegisterLecturer" %>

<asp:Content ID="RegisterLecturerMainContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="registerLecturerSection" class="bg-dark">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-8 pb-4 mx-auto">
                    <h1 class="text-center pt-3">Register New Lecturer</h1>
                    <hr class="mb-1" />

                    <%-- Alert Section --%>
                    <div class="alert alert-success" role="alert" visible="false" runat="server" id="alertSuccess">
                        <p class="mb-0">New lecturer (<asp:Label runat="server" ID="newLecturerID"></asp:Label>) has been successfully registered!</p>
                    </div>
                    <div class="alert alert-danger" role="alert" visible="false" runat="server" id="alertFailure">
                        <p class="mb-0">
                            <asp:Label runat="server" ID="alertFailureMsg"></asp:Label>
                        </p>
                    </div>

                    <%--Register lecturer form--%>
                    <asp:FormView runat="server"
                        ID="registerLecturerForm"
                        DefaultMode="Insert"
                        InsertMethod="addNewLecturer"
                        ItemType="university_online_assessment.Models.Lecturer_Profile"
                        RenderOuterTable="false"
                        DataKeyNames="Id">
                        <InsertItemTemplate>
                            <asp:Label ID="requiredLabel" runat="server" ForeColor="Red" Text="All fields are required" />

                            <%--Lecturer ID--%>
                            <div class="form-group">
                                <label for="lectId">Lecturer ID</label>
                                <asp:TextBox runat="server" ID="lectId" CssClass="form-control" placeholder="Enter lecturer ID"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="lectId" Display="Dynamic" ErrorMessage="Please ensure the lecturer ID field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="lectId" Display="Dynamic" ErrorMessage="Please enter the correct lecturer ID format." ValidationExpression="^\d{5}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Lecturer Email--%>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Enter lecturer email"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="email" Display="Dynamic" ErrorMessage="Please ensure the email field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="email" Display="Dynamic" ErrorMessage="Please enter the correct email format." ValidationExpression="^([A-z0-9_\-\.]+)@([A-z0-9_\-\.]+)\.([A-z]{2,5})$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Lecturer Password--%>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <asp:TextBox runat="server" ID="password" CssClass="form-control" placeholder="Enter password" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="password" Display="Dynamic" ErrorMessage="Please ensure the password field is not left blank."></asp:RequiredFieldValidator>
                            </div>

                            <%--Lecturer Confirm Password--%>
                            <div class="form-group">
                                <label for="password_confirmation">Confirm Password</label>
                                <asp:TextBox runat="server" ID="password_confirmation" CssClass="form-control" placeholder="Enter password" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="password_confirmation" Display="Dynamic" ErrorMessage="Please ensure the confirm password field is not left blank."></asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" ID="passwordConfirmationValidator" ControlToCompare="password" ControlToValidate="password_confirmation" ErrorMessage="The confirm password does not match with the password." ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:CompareValidator>
                            </div>

                            <%--First name--%>
                            <div class="form-group">
                                <label for="firstName">First Name</label>
                                <asp:TextBox runat="server" ID="firstName" CssClass="form-control" placeholder="Enter first name" Text='<%# Bind("firstName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="firstName" Display="Dynamic" ErrorMessage="Please ensure the first name field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="firstName" Display="Dynamic" ErrorMessage="Please enter the correct first name format." ValidationExpression="^[A-z\s\@\-]{2,}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Last name--%>
                            <div class="form-group">
                                <label for="lastName">Last Name</label>
                                <asp:TextBox runat="server" ID="lastName" CssClass="form-control" placeholder="Enter last name" Text='<%# Bind("lastName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="lastName" Display="Dynamic" ErrorMessage="Please ensure the last name field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="lastName" Display="Dynamic" ErrorMessage="Please enter the correct last name format." ValidationExpression="^[A-z\s\@\-]{2,}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Gender--%>
                            <label for="gender">Gender</label><br />
                            <asp:RadioButtonList runat="server" ID="gender" CssClass="form-check form-check-inline" RepeatLayout="Flow" SelectedValue='<%# Bind("gender") %>'>
                                <asp:ListItem Value="M" Text="Male" Selected="True" class="form-check-input"></asp:ListItem>
                                <asp:ListItem Value="F" Text="Female" class="form-check-input"></asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" ErrorMessage="Please select a gender." Display="Dynamic" ForeColor="Red" ControlToValidate="gender"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" SetFocusOnError="true" ErrorMessage="Please select the correct gender." Display="Dynamic" ForeColor="Red" ControlToValidate="gender" ValidationExpression="^(M|F)$"></asp:RegularExpressionValidator>

                            <%--Birth date--%>
                            <div class="form-group">
                                <label for="birthDate">Birth Date</label>
                                <asp:TextBox runat="server" ID="birthDate" TextMode="Date" CssClass="form-control" placeholder="Enter birth date" Text='<%# Bind("birthDate") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="birthDate" Display="Dynamic" ErrorMessage="Please ensure the birth date field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="birthDate" Display="Dynamic" ErrorMessage="Please enter the correct birth date format." ValidationExpression="^\d{4}\-\d{2}\-\d{2}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--IC Number--%>
                            <div class="form-group">
                                <label for="icNum">IC Number</label>
                                <asp:TextBox runat="server" ID="icNum" CssClass="form-control" placeholder="Enter IC Number" Text='<%# Bind("icNum") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="icNum" Display="Dynamic" ErrorMessage="Please ensure the IC Number field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="icNum" Display="Dynamic" ErrorMessage="Please enter the correct IC Number format." ValidationExpression="^\d{12}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Contact Number--%>
                            <div class="form-group">
                                <label for="contactNo">Contact No.</label>
                                <asp:TextBox runat="server" ID="contactNo" CssClass="form-control" placeholder="Enter contact number" Text='<%# Bind("contactNo") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="contactNo" Display="Dynamic" ErrorMessage="Please ensure the contact number field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="contactNo" Display="Dynamic" ErrorMessage="Please enter the correct contact number format." ValidationExpression="^\d{9,15}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Faculty--%>
                            <div class="form-group">
                                <label for="faculty">Faculty</label>
                                <asp:DropDownList runat="server" ID="faculty" CssClass="form-control" SelectedValue='<%# Bind("faculty") %>'>
                                    <asp:ListItem Value="" Selected="True" Text="Select Programme" disabled="disabled" />
                                    <asp:ListItem Value="FOCS" Text="Faculty of Computing And Information Technology [FOCS]" />
                                    <asp:ListItem Value="FAFB" Text="Faculty of Accountancy, Finance And Business [FAFB]" />
                                    <asp:ListItem Value="FOAS" Text="Faculty of Applied Sciences [FOAS]" />
                                    <asp:ListItem Value="FOBE" Text="Faculty of Built Environment [FOBE]" />
                                    <asp:ListItem Value="FCCI" Text="Faculty of Communication And Creative Industries [FCCI]" />
                                    <asp:ListItem Value="FOET" Text="Faculty of Engineering And Technology [FOET]" />
                                    <asp:ListItem Value="FSSH" Text="Faculty of Social Science And Humanities [FSSH]" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="faculty" Display="Dynamic" ErrorMessage="Please ensure the faculty is selected."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="faculty" Display="Dynamic" ErrorMessage="Please select the correct faculty." ValidationExpression="^(FOCS|FAFB|FOAS|FOBE|FCCI|FOET|FSSH)$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Address--%>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <asp:TextBox runat="server" ID="address" Rows="5" TextMode="MultiLine" CssClass="form-control" placeholder="Enter address" Text='<%# Bind("address") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="address" Display="Dynamic" ErrorMessage="Please ensure the address field is not left blank."></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ForeColor="Red" SetFocusOnError="true" ControlToValidate="address" Display="Dynamic" ErrorMessage="Please enter the correct address format." ValidationExpression="^[\w\s\@\-\,\.]{2,}$"></asp:RegularExpressionValidator>
                            </div>

                            <%--Buttons--%>
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Button runat="server" CommandName="Insert" ID="submit" CssClass="btn btn-outline-success btn-block" Text="Submit" />
                                </div>
                                <div class="col-md-6 mt-2 mt-md-0">
                                    <input type="reset" id="reset" class="btn btn-outline-primary btn-block" value="Reset" />
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:FormView>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        document.querySelectorAll('input[type="radio"]').forEach((elem) => {
            elem.classList.add('form-check-input');
        });
    </script>
</asp:Content>
