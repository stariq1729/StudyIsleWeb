<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BlogDetails.aspx.cs" Inherits="StudyIsleWeb.BlogDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>

.container-blog {
    max-width: 1150px;
    margin: auto;
    padding-left: 32px;
    padding-right: 32px;
}
/* =========================
   CONTENT WIDTH CONTROL
========================= */

.blog-content-wrapper {
    max-width: 860px;
}
/* =========================
   BLOG HEADER
========================= */

.blog-top-meta {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 16px;
}

.blog-category {
    background: #eef2ff;
    color: #4f46e5;
    padding: 6px 14px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 500;
    letter-spacing: 0.3px;
    text-transform: uppercase;
}

.meta-dot {
    width: 4px;
    height: 4px;
    border-radius: 50%;
    background: #9ca3af;
}

.blog-readtime {
    font-size: 12px;
    color: #6b7280;
    font-weight: 500;
}

/* TITLE */

.blog-main-title {
    font-size: 3rem;
    line-height: 1;
    font-weight: 900;
    letter-spacing: -2px;
    color: #0f172a;
    margin-bottom: 2rem;
    max-width: 920px;
}

/* AUTHOR SECTION */

.blog-author-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 20px;
    border-bottom: 1px solid #e5e7eb;
    margin-bottom: 1rem;
}

.author-left {
    display: flex;
    align-items: center;
}

.author-image {
    width: 56px;
    height: 56px;
    border-radius: 50%;
    object-fit: cover;
}

.author-info {
    margin-left: 14px;
}

.author-name {
    font-size: 18px;
    font-weight: 600;
    color: #111827;
}

.author-meta {
    margin-top: 4px;
    font-size: 12px;
    color: #6b7280;
}

.share-button {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    border: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: 0.25s ease;
    color: #6b7280;
}

.share-button:hover {
    background: #f8fafc;
    color: #111827;
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
.toc-header{
    font-size:20px;
    font-weight:300;
}
.toc-box {
    position: sticky;
    top: 100px;
                font-size: 0.975rem;
    line-height: 1.30rem;
font-weight:400;
    color: #777;
     margin: 8px;
}

.toc-box a {
    display: flex;
   
    text-decoration: none;
    color: #444;
            
}

/* CONTENT */
.blog-content {
    font-size: 12px;
    line-height: 1.7;
}

/* IMAGE */
/* =========================
   COVER IMAGE
========================= */

.blog-cover-wrapper {
    width: 100%;
    aspect-ratio: 16 / 9;
    overflow: hidden;
    border-radius: 24px;
    margin-bottom: 40px;
    background: #f3f4f6;
    position: relative;
}

.blog-cover-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

/* =========================
   CONTENT IMAGES
========================= */

.blog-content-image {
    max-width: 100%;
    height: auto;
    border-radius: 18px;
    margin: 30px 0;
    display: block;
    object-fit: contain;
}

/* SECTION */
.section-block {
    background: #4f46e5;
    padding: 25px;
    border-radius: 12px;
    margin: 30px 0;
    color: #fff;
}
/* Note Section */
.note-block {
    background: #f5efe4;
    padding: 20px;
    border-radius: 12px;
    margin: 25px 0;
    border-left: 4px solid #c89b3c;
}

.note-title {
    font-weight: 600;
    font-size: 14px;
    color: #a16207;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
}

.note-title::before {
    content: "●";
    color: #c89b3c;
    margin-right: 8px;
}

.note-desc {
    font-size: 13px;
    color: #444;
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
/* ===== FAQ ===== */
.faq-section {
    margin: 40px 0;
}

.faq-title-main {
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 20px;
}

.faq-item-ui {
    background: #f5f7fb;
    border-radius: 12px;
    padding: 18px;
    margin-bottom: 12px;
    cursor: pointer;
    transition: 0.3s;
}

.faq-item-ui:hover {
    background: #eef2ff;
}

.faq-question {
    display: flex;
    justify-content: space-between;
    font-weight: 600;
}

.faq-answer {
    margin-top: 10px;
    display: none;
    color: #555;
}

.faq-item-ui.active .faq-answer {
    display: block;
}

.faq-arrow {
    transition: transform 0.3s;
}

.faq-item-ui.active .faq-arrow {
    transform: rotate(180deg);
}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container-blog mt-5">

    <div class="row">

        <!-- 🔷 LEFT SIDE (TOC) -->
        <div class="col-md-3 toc">
            <div style="position:sticky; top:100px;">
                <h6 class="text-muted toc-header">TABLE OF CONTENTS</h6>

                <asp:Repeater ID="rptTOC" runat="server">
                    <ItemTemplate>
                        <div class="mb-2 toc-box">
                          • <a href="#<%# Eval("Id") %>" class="toc-link">
    <%# Eval("Text") %>
  </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>

        <!-- 🔷 RIGHT SIDE (MAIN CONTENT) -->
        <!-- 🔷 RIGHT SIDE (MAIN CONTENT) -->
<div class="col-md-9">

    <div class="blog-content-wrapper">
            <!-- 🔥 TOP META -->
<div class="blog-top-meta">

    <div class="blog-category">
        <asp:Literal ID="litCategory" runat="server"></asp:Literal>
    </div>

    <div class="meta-dot"></div>

    <div class="blog-readtime">
        <asp:Literal ID="litReadTime" runat="server"></asp:Literal> min read
    </div>

</div>
            <!-- 🔥 TITLE -->
            <h1 id="mainTitle" class="blog-main-title">
    <asp:Literal ID="litTitle" runat="server"></asp:Literal>
</h1>

            <!-- 🔥 AUTHOR -->
          <!-- 🔥 AUTHOR SECTION -->
<div class="blog-author-row">

    <!-- LEFT -->
    <div class="author-left">

        <!-- IMAGE -->
        <img id="imgAuthor" runat="server"
             class="author-image" />

        <!-- INFO -->
        <div class="author-info">

            <div class="author-name">
                <asp:Literal ID="litAuthor" runat="server"></asp:Literal>
            </div>

            <div class="author-meta">

                <asp:Literal ID="litDate" runat="server"></asp:Literal>

            </div>

        </div>

    </div>

    <!-- RIGHT SHARE -->
    <div class="share-button" onclick="shareBlog()">

        <svg xmlns="http://www.w3.org/2000/svg"
             width="20"
             height="20"
             fill="none"
             stroke="currentColor"
             stroke-width="2"
             viewBox="0 0 24 24">

            <circle cx="18" cy="5" r="3"></circle>
            <circle cx="6" cy="12" r="3"></circle>
            <circle cx="18" cy="19" r="3"></circle>

            <path d="M8.59 13.51L15.42 17.49"></path>
            <path d="M15.41 6.51L8.59 10.49"></path>

        </svg>

    </div>

</div>
            <asp:Literal ID="litAuthorImage" runat="server" Visible="false"></asp:Literal>

            <br />
            <!-- 🔥 BLOG CONTENT -->
            <asp:PlaceHolder ID="phContent" runat="server"></asp:PlaceHolder>

    </div>

</div>

    </div>

</div>
    <script>
        window.addEventListener("load", function () {

            document.querySelectorAll(".toc-link").forEach(link => {
                link.addEventListener("click", function (e) {
                    e.preventDefault();

                    const target = document.getElementById(this.getAttribute("href").substring(1));

                    if (target) {
                        window.scrollTo({
                            top: target.offsetTop - 80,
                            behavior: "smooth"
                        });
                    }
                });
            });

        });
        function toggleFaq(el) {

            // close others (optional, but matches modern UX)
            document.querySelectorAll(".faq-item-ui").forEach(item => {
                if (item !== el) item.classList.remove("active");
            });

            el.classList.toggle("active");
        }

        function shareBlog() {

            if (navigator.share) {

                navigator.share({
                    title: document.title,
                    url: window.location.href
                });

            } else {

                navigator.clipboard.writeText(window.location.href);
                alert("Blog link copied!");

            }
        }
    </script>
</asp:Content>