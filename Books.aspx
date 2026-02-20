<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="StudyIsleWeb.Books" %>
<%--<%@ Page Title="Books" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Books.aspx.cs"
    Inherits="StudyIsleWeb.Books" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/Public/books.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HERO SECTION -->
    <section class="board-hero">
        <h1>
            <asp:Literal ID="litBoardTitle" runat="server"></asp:Literal>
        </h1>
        <p>Access free textbooks, solutions, and study materials.</p>
    </section>

    <!-- RESOURCE TYPE CARDS -->
    <section class="resource-type-section">
        <div class="container">
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


</asp:Content>