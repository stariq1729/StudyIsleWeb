<%@ Page Title="Subject Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectDetails.aspx.cs" Inherits="StudyIsleWeb.SubjectDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body { background-color: #f8fafc; }
        .breadcrumb { background: transparent; padding: 0; margin-bottom: 20px; font-size: 0.9rem; }
        .breadcrumb-item a { color: #6366f1; text-decoration: none; }
        
        /* Sticky Book Sidebar */
        .book-sidebar { position: sticky; top: 20px; }
        .book-card {
            width: 100%; border-radius: 16px; overflow: hidden;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            background: #1e293b; aspect-ratio: 3/4; position: relative;
        }
        .book-card img { width: 100%; height: 100%; object-fit: cover; opacity: 0.6; }
        .book-overlay {
            position: absolute; bottom: 0; left: 0; right: 0;
            padding: 25px 20px; background: linear-gradient(transparent, rgba(0,0,0,0.9));
            color: white;
        }

        /* Enhanced Chapter Items */
        .chapter-badge { background: #e0e7ff; color: #4338ca; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .chapter-item { 
            background: white; border: 1px solid #f1f5f9; border-radius: 12px; 
            padding: 20px; margin-bottom: 12px; display: flex; 
            align-items: center; justify-content: space-between;
            transition: all 0.3s ease; text-decoration: none !important;
        }
        .chapter-item:hover { border-color: #6366f1; transform: translateX(5px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .chapter-idx { font-size: 1.1rem; font-weight: 700; color: #cbd5e1; margin-right: 20px; min-width: 30px; }
        .chapter-title { color: #1e293b; font-weight: 600; font-size: 1.05rem; display: block; }
        .chapter-meta { color: #94a3b8; font-size: 0.75rem; text-transform: uppercase; }

        /* Original Year Path Styling */
        .path-card { background: white; border: 1px solid #e2e8f0; border-radius: 16px; padding: 25px; transition: 0.3s; text-align: center; display: block; text-decoration: none; color: inherit; }
        .path-card:hover { border-color: #4f46e5; transform: translateY(-5px); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                <li class="breadcrumb-item active"><asp:Literal ID="litBreadcrumb" runat="server" /></li>
            </ol>
        </nav>

        <div class="row">
            <asp:PlaceHolder ID="phSidebar" runat="server" Visible="false">
                <div class="col-lg-4 mb-4">
                    <div class="book-sidebar">
                        <div class="book-card">
                            <asp:Image ID="imgSubject" runat="server" ImageUrl="~/Images/default-book.png" />
                            <div class="book-overlay">
                                <h3 class="fw-bold mb-0"><asp:Literal ID="litBookTitle" runat="server" /></h3>
                                <p class="small opacity-75 mb-0">Official Study Resources</p>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>

            <div class='<%= phChapterPath.Visible ? "col-lg-8" : "col-12" %>'>
                
                <asp:PlaceHolder ID="phChapterPath" runat="server" Visible="false">
                    <div class="d-flex justify-content-between align-items-end mb-4">
                        <div>
                            <h2 class="fw-bold mb-1">Chapters</h2>
                            <p class="text-muted mb-0">Select a chapter to access resources</p>
                        </div>
                        <div class="chapter-badge"><asp:Literal ID="litChapterCount" runat="server" /> Chapters</div>
                    </div>

                    <asp:Repeater ID="rptChapters" runat="server">
                        <ItemTemplate>
                            <a href='<%# ResolveUrl(GetChapterRedirectUrl(Eval("ChapterId"), Eval("IsQuizEnabled"), Eval("IsFlashcardEnabled"))) %>' class="chapter-item">
                                <div class="d-flex align-items-center">
                                    <div class="chapter-idx"><%# (Container.ItemIndex + 1).ToString("D2") %></div>
                                    <div>
                                        <span class="chapter-title"><%# Eval("ChapterName") %></span>
                                        <span class="chapter-meta">Chapter <%# Container.ItemIndex + 1 %></span>
                                    </div>
                                </div>
                                <i class="fas fa-chevron-right text-muted"></i>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="phYearPath" runat="server" Visible="false">
                    <h2 class="fw-bold mb-4">Previous Year Papers</h2>
                    <div class="row g-4">
                        <asp:Repeater ID="rptYears" runat="server">
                            <ItemTemplate>
                                <div class="col-md-3 col-6">
                                    <a href='<%# "SetSelection.aspx?sid=" + Request.QueryString["sid"] + "&res=" + Request.QueryString["res"] + "&yid=" + Eval("YearId") %>' class="path-card">
                                        <h2 class="mb-0 fw-bold"><%# Eval("YearName") %></h2>
                                        <small class="text-primary">View Materials</small>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>
</asp:Content>