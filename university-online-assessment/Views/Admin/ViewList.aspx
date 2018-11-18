<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewList.aspx.cs" Inherits="university_online_assessment.Views.Admin.ViewLecturerList" %>

<asp:Content ID="ViewListContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="displayProgSection" style="min-height: 100vh">
        <div class="container">
            <nav class="mt-5">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-students-tab" data-toggle="tab" href="#nav-students" role="tab" aria-controls="nav-students" aria-selected="true">Students</a>
                    <a class="nav-item nav-link" id="nav-programmes-tab" data-toggle="tab" href="#nav-programmes" role="tab" aria-controls="nav-programmes" aria-selected="false">Programmes</a>
                    <a class="nav-item nav-link" id="nav-enrollments-tab" data-toggle="tab" href="#nav-enrollments" role="tab" aria-controls="nav-enrollments" aria-selected="false">Enrollments</a>
                </div>
            </nav>
        </div>
    </section>


    <asp:HiddenField ID="hfTab" runat="server" />

</asp:Content>
