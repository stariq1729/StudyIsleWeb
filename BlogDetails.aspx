<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BlogDetails.aspx.cs" Inherits="StudyIsleWeb.BlogDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.container-blog {
    max-width: 1200px;
    margin: auto;
}

/* HEADER */
.blog-header h1 {
    font-size: 30px;
    font-weight: 600;
    margin: 25px 0;
}
.blog-header h2 {
    font-size: 20px;
    font-weight: 500;
    margin: 25px 0;
}
.blog-meta {
    color: #777;
    font-size: 10px;
}

/* TOC */
.toc-box {
    position: sticky;
    top: 100px;
    font-size: 10px;
    color: #777;
}

.toc-box a {
    display: block;
    margin-bottom: 10px;
    text-decoration: none;
    color: #444;
}

/* CONTENT */
.blog-content {
    font-size: 12px;
    line-height: 1.7;
}

/* IMAGE */
.blog-image {
    width: 100%;
    border-radius: 12px;
    margin: 20px 0;
}

/* SECTION */
.section-block {
    background: #f5f7fb;
    padding: 25px;
    border-radius: 12px;
    margin: 30px 0;
    color: #6b7280;
}

/* HTML BLOCK */
.html-block {
    display: flex;
    border-radius: 12px;
    overflow: hidden;
    margin: 25px 0;
    border: 1px solid #eee;
}

.html-code {
    width: 50%;
    background: #0f172a;
    color: #22c55e;
    padding: 20px;
    font-family: monospace;
    font-size: 13px;
}

.html-preview {
    width: 50%;
    padding: 20px;
    background: #fff;
}

/* TABLE */
.blog-table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
}

.blog-table th, .blog-table td {
    border: 1px solid #ddd;
    padding: 10px;
}

</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <div class="row">

        <!-- 🔷 LEFT SIDE (TOC) -->
        <div class="col-md-3">
            <div style="position:sticky; top:100px;">
                <h6 class="text-muted">TABLE OF CONTENTS</h6>

                <asp:Repeater ID="rptTOC" runat="server">
                    <ItemTemplate>
                        <div class="mb-2">
                            • <%# Eval("Text") %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>

        <!-- 🔷 RIGHT SIDE (MAIN CONTENT) -->
        <div class="col-md-9">

            <!-- 🔥 TITLE -->
            <h1 class="fw-bold mb-3">
                <asp:Literal ID="litTitle" runat="server"></asp:Literal>
            </h1>

            <!-- 🔥 AUTHOR -->
            <div class="d-flex align-items-center mb-4">

                <img src="/assets/user.png" 
                     style="width:40px; height:40px; border-radius:50%;" />

                <div class="ms-2">
                    <strong><asp:Literal ID="litAuthor" runat="server"></asp:Literal></strong><br />
                    <small class="text-muted">
                        <asp:Literal ID="litDate" runat="server"></asp:Literal>
                    </small>
                </div>

            </div>
            <br />
            <!-- 🔥 BLOG CONTENT -->
            <asp:PlaceHolder ID="phContent" runat="server"></asp:PlaceHolder>

        </div>

    </div>

</div>

</asp:Content>