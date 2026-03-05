<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardResource.aspx.cs" Inherits="StudyIsleWeb.BoardResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root { --si-purple: #4f46e5; --si-text-dark: #1e293b; --si-border: #e2e8f0; }
        .page-header { text-align: center; margin-bottom: 3rem; }
        .class-tabs { display: flex; gap: 10px; justify-content: center; margin-bottom: 40px; }
        .class-btn { padding: 8px 22px; border-radius: 8px; border: 1px solid var(--si-border); text-decoration: none; color: #64748b; font-weight: 600; }
        .class-btn.active { background: #1e293b; color: white; border-color: #1e293b; }
        .subject-group { margin-bottom: 50px; }
        .subject-header { border-left: 5px solid var(--si-purple); padding-left: 15px; font-weight: 700; font-size: 1.3rem; margin-bottom: 25px; }
        .resource-card { background: white; border: 1px solid var(--si-border); border-radius: 12px; padding: 20px; display: flex; gap: 15px; height: 100%; transition: 0.3s; }
        .resource-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .resource-img { width: 70px; height: 90px; object-fit: contain; }
        .btn-read { background: var(--si-purple); color: white; padding: 8px; border-radius: 6px; text-decoration: none; text-align: center; font-size: 0.85rem; font-weight: 700; display: block; margin-top: 10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="page-header">
            <h1><asp:Literal ID="litPageTitle" runat="server"></asp:Literal></h1>
            <p><asp:Literal ID="litPageSubtitle" runat="server"></asp:Literal></p>
        </div>

<div class="class-tabs">
    <asp:Repeater ID="rptClasses" runat="server">
        <ItemTemplate>
            <a href='<%# "BoardResource.aspx?board=" + Request.QueryString["board"] + "&res=" + (Request.QueryString["res"] ?? "books") + "&class=" + Eval("Slug") %>' 
               class='<%# Eval("Slug").ToString() == Request.QueryString["class"] || (string.IsNullOrEmpty(Request.QueryString["class"]) && Eval("Slug").ToString() == "class-12") ? "class-btn active" : "class-btn" %>'>
                <%# Eval("ClassName") %>
            </a>
        </ItemTemplate>
    </asp:Repeater>
</div>

<asp:Repeater ID="rptSubjectGroups" runat="server">
    <HeaderTemplate><div class="row g-4"></HeaderTemplate>
    <ItemTemplate>
        <div class="col-lg-3 col-md-4 col-6">
            <a href='<%# "SubjectDetails.aspx?sid=" + Eval("SubjectId") + "&res=" + (Request.QueryString["res"] ?? "books") %>' class="text-decoration-none">
                <div class="resource-card text-center d-flex flex-column align-items-center">
                    <img src='<%# "/Uploads/SubjectIcons/" + (Eval("IconImage") == DBNull.Value || string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "default.png" : Eval("IconImage")) %>' 
                         class="resource-img mb-2" alt="Icon" />
                    <span class="res-title d-block"><%# Eval("SubjectName") %></span>
                    <small class="text-muted">Explore Material</small>
                </div>
            </a>
        </div>
    </ItemTemplate>
    <FooterTemplate></div></FooterTemplate>
</asp:Repeater>
    </div>
</asp:Content>