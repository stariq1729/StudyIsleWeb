<%@ Page Title="Subject Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectDetails.aspx.cs" Inherits="StudyIsleWeb.SubjectDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root { --si-primary: #4f46e5; --si-bg: #f8fafc; --si-text: #1e293b; }
        body { background-color: var(--si-bg); }
        
        /* Sidebar Subject Card */
        .main-subject-card { border: none; border-radius: 24px; overflow: hidden; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
        .main-subject-card img { width: 100%; height: 380px; object-fit: cover; }
        .subject-badge-overlay { position: absolute; bottom: 0; left: 0; right: 0; padding: 20px; background: linear-gradient(transparent, #000); color: white; }

        /* Chapter Rows */
        .chapter-row { background: white; border: 1px solid #e2e8f0; border-radius: 16px; padding: 18px; margin-bottom: 12px; transition: all 0.3s ease; display: flex; align-items: center; }
        .chapter-row:hover { transform: translateX(5px); border-color: var(--si-primary); box-shadow: 0 4px 12px rgba(79, 70, 229, 0.1); }
        .chapter-num { width: 45px; height: 45px; background: #f1f5f9; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; color: #64748b; margin-right: 20px; }
        .chapter-row:hover .chapter-num { background: var(--si-primary); color: white; }

        /* Year Grid Cards */
        .year-card { background: white; border: 1px solid #e2e8f0; border-radius: 20px; padding: 30px; transition: 0.3s; text-align: center; height: 100%; }
        .year-card:hover { border-color: var(--si-primary); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .year-card h2 { font-size: 2.2rem; font-weight: 800; color: var(--si-text); margin: 0; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                <li class="breadcrumb-item"><asp:HyperLink ID="hlBoardClassContext" runat="server" /></li>
                <li class="breadcrumb-item active"><asp:Literal ID="litSubjectBreadcrumb" runat="server" /></li>
            </ol>
        </nav>

        <header class="mb-5">
            <h1 class="fw-bold"><asp:Literal ID="litPageTitle" runat="server" /></h1>
            <p class="text-muted">Access official study material and verified resources.</p>
        </header>

        <asp:PlaceHolder ID="phYearPath" runat="server" Visible="false">
            <div class="row g-4">
                <asp:Repeater ID="rptYears" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-6">
                            <a href='<%# "ViewResources.aspx?sid=" + Request.QueryString["sid"] + "&yid=" + Eval("YearId") %>' class="text-decoration-none">
                                <div class="year-card">
                                    <h2><%# Eval("YearName") %></h2>
                                    <span class="badge bg-primary-subtle text-primary rounded-pill mt-2">Solved Papers</span>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phChapterPath" runat="server" Visible="false">
            <div class="row g-5">
                <div class="col-lg-4">
                    <div class="main-subject-card position-relative">
                        <img src='/Uploads/SubjectIcons/<%= ViewState["SubIcon"] %>' alt="Subject" />
                        <div class="subject-badge-overlay">
                            <h3 class="mb-0 fw-bold"><%= ViewState["SubName"] %></h3>
                            <small class="opacity-75">Official Study Edition</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="fw-bold mb-0">Book Chapters</h3>
                        <span class="badge bg-white text-dark border px-3 py-2 rounded-pill shadow-sm">
                            <asp:Literal ID="litChapterCount" runat="server" /> Chapters Total
                        </span>
                    </div>
                    <asp:Repeater ID="rptChapters" runat="server">
                        <ItemTemplate>
                            <div class="chapter-row">
                                <div class="chapter-num"><%# Eval("DisplayOrder", "{0:00}") %></div>
                                <div class="flex-grow-1">
                                    <h5 class="mb-0 fw-bold text-dark"><%# Eval("ChapterName") %></h5>
                                    <small class="text-muted text-uppercase fw-bold" style="font-size: 10px;">Chapter <%# Eval("DisplayOrder") %></small>
                                </div>
                                <a href='<%# "ViewPDF.aspx?chapter=" + Eval("Slug") %>' class="btn btn-sm btn-outline-primary rounded-pill px-4 fw-bold">READ PDF</a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>