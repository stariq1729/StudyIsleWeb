<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BlogDetails.aspx.cs" Inherits="StudyIsleWeb.BlogDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.container-blog {
    max-width: 1200px;
    margin: auto;
}

/* HEADER */
.blog-header h1 {
    font-size: 36px;
    font-weight: 700;
}

.blog-meta {
    color: #777;
    font-size: 14px;
}

/* TOC */
.toc-box {
    position: sticky;
    top: 100px;
    font-size: 13px;
    color: #777;
}

.toc-box a {
    display: block;
    margin-bottom: 8px;
    text-decoration: none;
    color: #444;
}

/* CONTENT */
.blog-content {
    font-size: 16px;
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

<div class="container-blog mt-4">

    <!-- HEADER -->
    <div class="blog-header mb-4">
        <h1><asp:Literal ID="litTitle" runat="server" /></h1>
        <div class="blog-meta">
            By <asp:Literal ID="litAuthor" runat="server" /> • 
            <asp:Literal ID="litDate" runat="server" />
        </div>
    </div>

    <div class="row">

        <!-- TOC -->
        <div class="col-md-3">
            <div class="toc-box">
                <h6>TABLE OF CONTENTS</h6>
                <asp:Literal ID="litTOC" runat="server"></asp:Literal>
            </div>
        </div>

        <!-- CONTENT -->
        <div class="col-md-9 blog-content">
            <asp:Literal ID="litContent" runat="server"></asp:Literal>
        </div>

    </div>

</div>

</asp:Content>