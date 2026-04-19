<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardResource.aspx.cs" Inherits="StudyIsleWeb.BoardResource" %>


<%--this page loads the class and subject--%>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root { 
            --si-primary: #4f46e5; 
            --si-text-main: #1e293b; 
            --si-text-muted: #64748b;
            --si-bg-light: #f8fafc;
            --si-border: #e2e8f0; 
        }

        /* Breadcrumb Style */
        .breadcrumb-nav { font-size: 0.85rem; color: var(--si-text-muted); margin-bottom: 1rem; }
        .breadcrumb-nav a { color: inherit; text-decoration: none; }

        /* Header & Title */
        .page-header h1 { font-weight: 800; color: var(--si-text-main); font-size: 2.2rem; }
        .page-header h1 span { color: var(--si-primary); }
        .page-header p { color: var(--si-text-muted); font-size: 1.1rem; }

        /* Class Tabs (Pill style) */
       /* Fixed Class Tabs - Pill Container Style */
    .class-tabs-wrapper {
        display: flex;
        justify-content: center;
        margin: 40px 0;
    }
    .class-tabs-container { 
        background: #ffffff; 
        padding: 8px; 
        border-radius: 50px; /* Fully rounded pill shape */
        display: inline-flex;
        gap: 5px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        border: 1px solid #f1f5f9;
    }
    .class-btn { 
        padding: 10px 28px; 
        border-radius: 40px; 
        text-decoration: none !important; 
        color: #64748b; 
        font-weight: 600; 
        font-size: 0.95rem;
        transition: all 0.3s ease;
    }
    .class-btn:hover { color: #4f46e5; }
    .class-btn.active { 
        background: #1e293b; 
        color: #ffffff !important; 
        box-shadow: 0 4px 12px rgba(30, 41, 59, 0.2);
    }

    /* Subject Card - Edition Dynamic Style */
    .edition-info { 
        color: #10b981; 
        font-size: 0.82rem; 
        font-weight: 600; 
        margin-bottom: 12px; 
        display: flex;
        align-items: center;
        gap: 5px;
    }

        /* Subject Section Headers */
        .subject-section-title { 
            display: flex; 
            align-items: center; 
            gap: 15px; 
            margin-bottom: 30px; 
            font-weight: 700; 
            color: #0f172a;
        }
        .subject-section-title::before {
            content: "";
            width: 4px;
            height: 24px;
            background: var(--si-primary);
            border-radius: 2px;
        }
        .subject-section-title::after {
            content: "";
            flex-grow: 1;
            height: 1px;
            background: var(--si-border);
        }

        /* New Subject Card */
        .subject-card { 
            background: white; 
            border: 1px solid var(--si-border); 
            border-radius: 16px; 
            padding: 15px; 
            display: flex; 
            gap: 20px; 
            max-width: 450px;
            transition: 0.3s ease;
        }
        .subject-card:hover { box-shadow: 0 10px 25px rgba(0,0,0,0.08); transform: translateY(-3px); }
        
        .img-container {
            width: 100px;
            height: 130px;
            background: #f1f5f9;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
        }
        .subject-img { width: 100%; height: 100%; object-fit: cover; }

        .card-content { flex-grow: 1; display: flex; flex-direction: column; justify-content: space-between; }
        .cat-tag { font-size: 0.7rem; text-transform: uppercase; font-weight: 700; color: var(--si-primary); letter-spacing: 0.5px; }
        .sub-name { font-weight: 700; color: #1e293b; font-size: 1.1rem; margin: 4px 0; display: block; }
        .edition-info { color: #10b981; font-size: 0.85rem; font-weight: 600; margin-bottom: 12px; display: block; }

        .btn-read-online { 
            background: #5850ec; 
            color: white; 
            padding: 10px; 
            border-radius: 8px; 
            text-decoration: none; 
            text-align: center; 
            font-weight: 700; 
            font-size: 0.9rem;
            display: block;
        }
        .btn-read-online:hover { background: #4338ca; color: white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <nav class="breadcrumb-nav">
            Home &nbsp;›&nbsp; <asp:Literal ID="litBoardName" runat="server"></asp:Literal> &nbsp;›&nbsp; 
            <span class="text-dark"><asp:Literal ID="litClassNameCrumb" runat="server"></asp:Literal></span>
        </nav>

        <div class="page-header mb-4">
            <h1><asp:Literal ID="litPageTitle" runat="server"></asp:Literal></h1>
            <p><asp:Literal ID="litPageSubtitle" runat="server"></asp:Literal></p>
        </div>

       <div class="class-tabs-wrapper">
    <div class="class-tabs-container">
        <asp:Repeater ID="rptClasses" runat="server">
            <ItemTemplate>
                <a href='<%# "BoardResource.aspx?board=" + Request.QueryString["board"] + "&res=" + (Request.QueryString["res"] ?? "books") + "&class=" + Eval("Slug") %>' 
                   class='<%# Eval("Slug").ToString() == (Request.QueryString["class"] ?? ViewState["DefaultClassSlug"].ToString()) ? "class-btn active" : "class-btn" %>'>
                    <%# Eval("ClassName") %>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

        <asp:Repeater ID="rptSubjectGroups" runat="server">
            <ItemTemplate>
                <div class="subject-section mb-5">
                    <h3 class="subject-section-title">
                        <%# Eval("SubjectName") %> <%# GetResourceName() %>
                    </h3>
                    
                    <div class="row">
                        <div class="col-md-6 col-lg-5">
                            <a href='<%# "SubjectDetails.aspx?sid=" + Eval("SubjectId") + "&res=" + (Request.QueryString["res"] ?? "books") %>' class="text-decoration-none">
                                <div class="subject-card">
                                    <div class="img-container">
                                        <img src='<%# "/Uploads/SubjectIcons/" + (Eval("IconImage") == DBNull.Value || string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "default.png" : Eval("IconImage")) %>' 
                                             class="subject-img" alt="Subject Cover" />
                                    </div>
                                    <div class="card-content">
                                        <div>
                                            <span class="cat-tag"><i class="fas fa-book-open me-1"></i> <%# Eval("SubjectName") %></span>
                                            <span class="sub-name"><%# Eval("PageTitle") != DBNull.Value ? Eval("PageTitle") : Eval("SubjectName") %></span>
                                            <span class="edition-info">
    <i class="fas fa-check-circle"></i> 
    <%# Eval("Edition") != DBNull.Value ? Eval("Edition") : "2024-25 Latest Edition" %>
</span>
                                        </div>
                                        <div class="btn-read-online">
                                            Read Online <i class="fas fa-external-link-alt ms-1" style="font-size: 0.8rem;"></i>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>