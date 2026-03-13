<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="StudyIsleWeb.Books" %>

<%--this page is also not in used, it is previous pages
--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/Public/books.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<asp:Panel ID="pnlBoardLanding" runat="server">

    <!-- HERO -->
    <section class="board-hero">
        <h1>
            <asp:Literal ID="litBoardTitle" runat="server"></asp:Literal>
        </h1>
        <p>Access free textbooks, solutions, and study materials.</p>
    </section>

    <!-- RESOURCE CARDS -->
    <section class="resource-type-section">
        <div class="container-grid">
            <asp:Repeater ID="rptResourceTypes" runat="server">
                <ItemTemplate>
                    <div class="resource-card">
                        <h3><%# Eval("TypeName") %></h3>
                        <p>Explore <%# Eval("TypeName") %> resources</p>
                        <a class="explore-btn"
                           href='Books.aspx?board=<%# Eval("BoardSlug") %>&type=<%# Eval("Slug") %>'>
                            Explore →
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>
    <!-- ================= CLASS SECTION ================= -->

<asp:Panel ID="pnlClassSection" runat="server" Visible="false">

    <section class="class-section">
        <h2>Select Your Class</h2>

        <div class="class-container">
            <asp:Repeater ID="rptClasses" runat="server">
                <ItemTemplate>
                    <a class='class-pill <%# Eval("Slug").ToString() == Request.QueryString["class"] ? "active-class" : "" %>'
                       href='Books.aspx?board=<%# Eval("BoardSlug") %>&type=<%# Eval("TypeSlug") %>&class=<%# Eval("Slug") %>'>
                        <%# Eval("ClassName") %>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</asp:Panel>



<!-- ================= SUBJECT SECTION ================= -->

<asp:Panel ID="pnlSubjectSection" runat="server" Visible="false">

    <section class="subject-section">
        <div class="subject-container">
            <asp:Repeater ID="rptSubjects" runat="server">
                <ItemTemplate>
                    <div class="subject-card">
                        <h3><%# Eval("SubjectName") %></h3>
                        <a href="#">View Books →</a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</asp:Panel>
    <!-- ========================= -->
<!-- STATS SECTION -->
<!-- ========================= -->

<section class="board-stats">
    <div class="stats-container">
        <div class="stat-box">
            <h3>500+</h3>
            <p>Digital Books</p>
        </div>
        <div class="stat-box">
            <h3>10k+</h3>
            <p>Solved PDFs</p>
        </div>
        <div class="stat-box">
            <h3>24/7</h3>
            <p>Free Access</p>
        </div>
        <div class="stat-box">
            <h3>2M+</h3>
            <p>Happy Students</p>
        </div>
    </div>
</section>

<!-- ========================= -->
<!-- WHY SECTION -->
<!-- ========================= -->

<section class="board-why">
    <div class="why-container">
        <div class="why-left">
            <h2>Why <asp:Literal ID="litBoardWhy" runat="server"></asp:Literal> Books Matter?</h2>

            <div class="why-point">
                <h4>The Golden Standard of Education</h4>
                <p>Official textbooks provide structured understanding and build strong exam foundation.</p>
            </div>

            <div class="why-point">
                <h4>Class 6 to 12 Mastery</h4>
                <p>From fundamentals to advanced concepts, build strong academic base.</p>
            </div>
        </div>

        <div class="why-right">
            <h4>Key Benefits</h4>
            <ul>
                <li>Seamless Digital Reading</li>
                <li>One Click Downloads</li>
                <li>Organized Chapter Structure</li>
                <li>Free Forever Access</li>
            </ul>
        </div>
    </div>
</section>


<!-- ========================= -->
<!-- CTA SECTION -->
<!-- ========================= -->

<section class="board-cta">
    <div class="cta-box">
        <h3>Ready to Start Learning?</h3>
        <p>Explore high quality study resources now.</p>
        <a href="#" class="cta-btn">Explore Books Now</a>
    </div>
</section>
    </asp:Panel>
</asp:Content>
