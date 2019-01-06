<%@ Page Title="TAR UC Online Assessment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="university_online_assessment.Views.WebForm1" %>

<%@ Register Src="~/Views/HomepageUserControl.ascx" TagPrefix="uc1" TagName="HomepageUserControl" %>

<asp:Content ID="HomepageMainContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="homepageSection">
        <div class="container bg-light">
            <h1 class="text-center pt-3">TAR UC Online Assessment Home page</h1>
            <hr />

            <%--Dynamic Homepage--%>
            <uc1:HomepageUserControl runat="server" id="HomepageUserControl" />
        </div>
    </section>
</asp:Content>
