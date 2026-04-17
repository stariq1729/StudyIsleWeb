<%@ Page Title="Chapters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Chapters.aspx.cs" Inherits="StudyIsleWeb.Chapters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body { background-color: #f8fafc; }
        .main-wrapper { padding-top: 50px; }
        
        /* Left Side: Book Card */
        .book-sidebar { position: sticky; top: 20px; }
        .book-card {
            position: relative;
            width: 100%;
            max-width: 320px;
            aspect-ratio: 3/4;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            background: #1e293b;
        }
        .book-card img { width: 100%; height: 100%; object-fit: cover; opacity: 0.7; filter: blur(1px); }
        .book-overlay {
            position: absolute; bottom: 0; left: 0; right: 0;
            padding: 30px 20px;
            background: linear-gradient(transparent, rgba(0,0,0,0.9));
            color: white;
        }

        /* Right Side: Chapter List */
        .content-header { margin-bottom: 25px; }
        .chapter-badge {
            background: #e0e7ff; color: #4338ca;
            padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;
        }
        .chapter-item { 
            background: white; border: 1px solid #f1f5f9; border-radius: 12px; 
            padding: 20px; margin-bottom: 12px; display: flex; 
            align-items: center; justify-content: space-between;
            transition: all 0.3s ease; text-decoration: none !important;
        }
        .chapter-item:hover { 
            border-color: #6366f1; transform: translateY(-2px); 
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); 
        }
        .chapter-idx { font-size: 1.2rem; font-weight: 700; color: #cbd5e1; margin-right: 20px; min-width: 30px; }
        .chapter-main-text { flex-grow: 1; }
        .chapter-title { color: #1e293b; font-weight: 600; font-size: 1.05rem; display: block; }
        .chapter-meta { color: #94a3b8; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px; }
        .arrow-icon { color: #cbd5e1; font-size: 1.2rem; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container main-wrapper pb-5">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="book-sidebar">
                    <div class="book-card">
                        <asp:Image ID="imgSubject" runat="server" CssClass="book-img" ImageUrl="~/Images/default-book.png" />
                        <div class="book-overlay">
                            <h3 class="fw-bold mb-1"><asp:Literal ID="litBookTitle" runat="server" /></h3>
                            <p class="small mb-0 opacity-75"><asp:Literal ID="litBookSub" runat="server" /></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="content-header d-flex justify-content-between align-items-end">
                    <div>
                        <h2 class="fw-bold text-dark mb-1">Chapters</h2>
                        <p class="text-muted mb-0">Select a chapter to start learning</p>
                    </div>
                    <div class="chapter-badge">
                        <asp:Literal ID="litCount" runat="server" /> Chapters
                    </div>
                </div>

                <div class="chapter-container">
                    <asp:Repeater ID="rptChapters" runat="server">
                        <ItemTemplate>
                            <a href='<%# ResolveUrl(GetFinalUrl(Eval("ChapterId"), Eval("HasSets"))) %>' class="chapter-item">
                                <div class="chapter-idx"><%# (Container.ItemIndex + 1).ToString("D2") %></div>
                                <div class="chapter-main-text">
                                    <span class="chapter-title"><%# Eval("ChapterName") %></span>
                                    <span class="chapter-meta">Chapter <%# Container.ItemIndex + 1 %></span>
                                </div>
                                <div class="arrow-icon">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>