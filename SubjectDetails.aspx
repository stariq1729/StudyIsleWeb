<%@ Page Title="Subject Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectDetails.aspx.cs" Inherits="StudyIsleWeb.SubjectDetails" %>


<%--this page comes after selection of class and subject shows chaper set or year wise material--%>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .path-card { background: white; border: 1px solid #e2e8f0; border-radius: 16px; padding: 25px; transition: 0.3s; text-align: center; height: 100%; display: block; text-decoration: none; color: inherit; }
        .path-card:hover { border-color: #4f46e5; transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .chapter-item { background: white; border: 1px solid #e2e8f0; border-radius: 12px; padding: 15px; margin-bottom: 10px; display: flex; align-items: center; justify-content: space-between; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <header class="mb-5">
            <h1 class="fw-bold"><asp:Literal ID="litSubjectName" runat="server" /></h1>
            <p class="text-muted">Select the category of material you wish to access.</p>
        </header>

        <asp:PlaceHolder ID="phYearPath" runat="server" Visible="false">
            <div class="row g-4">
                <asp:Repeater ID="rptYears" runat="server">
                    <ItemTemplate>
                        <div class="col-md-3 col-6">
                            <a href='<%# "SetSelection.aspx?sid=" + Request.QueryString["sid"] + "&res=" + Request.QueryString["res"] + "&yid=" + Eval("YearId") %>' class="path-card">
                                <h2 class="mb-0 fw-bold"><%# Eval("YearName") %></h2>
                                <small class="text-primary">View Sets</small>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:PlaceHolder>

<asp:PlaceHolder ID="phChapterPath" runat="server" Visible="false">
    <div class="row">
        <asp:Repeater ID="rptChapters" runat="server">
            <ItemTemplate>
                <div class="col-12">
                    <div class="chapter-item">
                        <h5 class="mb-0 fw-bold"><%# Eval("ChapterName") %></h5>
                        <a href='<%# ResolveUrl(GetChapterRedirectUrl(
                                Eval("ChapterId"),
                                Eval("IsQuizEnabled"),
                                Eval("IsFlashcardEnabled"))) %>'
                           class="btn btn-primary btn-sm rounded-pill px-4">
                            View Material
                        </a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:PlaceHolder>
    </div>
</asp:Content>