<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentAssessment.aspx.cs" Inherits="university_online_assessment.Views.Student.StudentAssessment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlaceholder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="asmntSection" style="min-height: 100vh">
        <div class="container bg-light">
            <div class="row">
                <div class="col-md-8 mx-auto pt-5">
                    <h1 class="text-center">ADMK3262 Principles of Marketing</h1>
                    <h2 class="text-center">Chapter 3 Quiz</h2>

                    <div class="form-group">
                        <label>1. Del Monte’s Barbecue Ketchup that contained finely chopped onions and was aimed at the heavy ketchup-eating segment (kids). That segment –kids-- did not care for onions. What is likely the reason the reason for this product failure?</label>
                        <textarea id="txtAns" class="form-control" cols="20" rows="2"></textarea>
                    </div>

                    <div class="form-group">
                        <label>2. When deciding on the purchase of a new wireless pocket PC, Bob was among the very first. He is very highly educated, and makes purchase decisions based on information from Internet newsgroups, newspapers, and technical journals he subscribes to. Stan made his decision based on numerous informal social contacts, though he is not a leader in any social setting. He was among the first 50% of the population to buy the wireless pocket PC. Out of profiles of product adopters, Bob could best be described as ... </label>
                        <textarea id="txtAns1" class="form-control" cols="20" rows="2"></textarea>
                    </div>

                    <div class="form-group">
                        <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#exampleModal">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Modal -->
    <section>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Confirm Submission?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Button ID="Button1" CssClass="btn btn-primary btn-block" OnClick="submitAsmntBtn_Click" runat="server" Text="Confirm" />
                            </div>
                            <div class="col-md-6">
                                <asp:Button ID="Button4" CssClass="btn btn-danger btn-block" runat="server" Text="Cancel" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
