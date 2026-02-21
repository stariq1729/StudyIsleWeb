<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NCERT.aspx.cs" Inherits="StudyIsleWeb.NCERT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HERO SECTION -->
    <section class="board-hero">
        <div class="container text-center">
            <h1>NCERT Resources</h1>
            <p>Access free textbooks, solutions, and study materials.</p>
        </div>
    </section>

    <!-- RESOURCE TYPE SECTION -->
    <section class="resource-section">
        <div class="container">
<div class="row g-4">

    <asp:Repeater ID="rptResourceTypes" runat="server">
        <ItemTemplate>
            <div class="col-md-4">
                <div class="resource-card">
                    <h5><%# Eval("TypeName") %></h5>
                    <p>Explore <%# Eval("TypeName") %> resources</p>
                    <a href="NcertBooks.aspx" class="btn-explore">Explore →</a>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>
        </div>
    </section>
        <!-- STATS SECTION -->
    <section class="board-stats">
        <div class="container text-center">
            <div class="row">

                <div class="col-md-3">
                    <h3>500+</h3>
                    <p>Digital Books</p>
                </div>

                <div class="col-md-3">
                    <h3>10k+</h3>
                    <p>Solved PDFs</p>
                </div>

                <div class="col-md-3">
                    <h3>24/7</h3>
                    <p>Free Access</p>
                </div>

                <div class="col-md-3">
                    <h3>2M+</h3>
                    <p>Happy Students</p>
                </div>

            </div>
        </div>
    </section>


    <!-- WHY SECTION -->
    <section class="why-section">
        <div class="container">
            <div class="row align-items-center">

                <div class="col-md-6">
                    <h2>Why NCERT Books Matter?</h2>

                    <h6 class="mt-4">The Golden Standard of Education</h6>
                    <p>
                        Official textbooks provide structured understanding and build strong exam foundation.
                    </p>

                    <h6 class="mt-4">Class 6 to 12 Mastery</h6>
                    <p>
                        From fundamentals to advanced concepts, build strong academic base.
                    </p>
                </div>

                <div class="col-md-6">
                    <div class="benefit-box">
                        <h5>Key Benefits</h5>
                        <ul>
                            <li>Seamless Digital Reading</li>
                            <li>One Click Downloads</li>
                            <li>Organized Chapter Structure</li>
                            <li>Free Forever Access</li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </section>


    <!-- CTA SECTION -->
    <section class="board-cta">
        <div class="container text-center">
            <h2>Ready to Start Learning?</h2>
            <p>Explore high quality study resources now.</p>
            <a href="#" class="cta-btn">Explore Books Now</a>
        </div>
    </section>
</asp:Content>
