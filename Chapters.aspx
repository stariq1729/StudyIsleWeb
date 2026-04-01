<%@ Page Title="Chapters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Chapters.aspx.cs" Inherits="StudyIsleWeb.Chapters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .resource-header { background: #1e293b; color: white; padding: 40px 0; margin-bottom: 30px; }
        .chapter-list { max-width: 800px; margin: 0 auto; }
        .chapter-item { 
            background: white; border: 1px solid #e2e8f0; border-radius: 12px; 
            padding: 20px 25px; margin-bottom: 15px; display: flex; 
            align-items: center; justify-content: space-between;
            transition: all 0.2s ease; text-decoration: none !important;
        }
        .chapter-item:hover { border-color: #6366f1; transform: translateX(5px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .chapter-info { display: flex; align-items: center; }
        .chapter-number { 
            background: #f1f5f9; color: #64748b; font-weight: 700; 
            width: 40px; height: 40px; border-radius: 8px; 
            display: flex; align-items: center; justify-content: center; margin-right: 20px;
        }
        .chapter-name { color: #1e293b; font-weight: 600; font-size: 1.1rem; }
        .view-btn { color: #6366f1; opacity: 0.5; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="resource-header">
        <div class="container">
            <h5 class="text-uppercase mb-1" style="letter-spacing: 1px; opacity: 0.8;">
                <asp:Literal ID="litSubjectName" runat="server" />
            </h5>
            <h2 class="fw-bold mb-0">Select Chapter</h2>
        </div>
    </div>

    <div class="container pb-5">
        <div class="chapter-list">
            <asp:Repeater ID="rptChapters" runat="server">
                <ItemTemplate>
                    <%-- The link is determined by the SetCount helper --%>
                    <a href='<%# GetFinalUrl(Eval("Slug"), Eval("HasSets")) %>' class="chapter-item">
                        <div class="chapter-info">
                            <div class="chapter-number"><%# Container.ItemIndex + 1 %></div>
                            <div>
                                <div class="chapter-name"><%# Eval("ChapterName") %></div>
                                <div class="small text-muted">CHAPTER <%# Container.ItemIndex + 1 %></div>
                            </div>
                        </div>
                        <div class="view-btn"><i class="fas fa-arrow-right"></i></div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>