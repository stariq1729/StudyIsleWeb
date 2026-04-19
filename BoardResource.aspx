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
/* The single white bar containing all buttons */
.class-tabs-container { 
    background: #ffffff; 
    padding: 16px; 
    border-radius: 12px; 
    display: inline-flex;
    align-items: center;
    gap: 22px;
    /* This shadow creates the 'lifted' effect from your reference */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); 
    border: 1px solid #f1f5f9;
    margin-bottom: 50px;
}

/* Individual Buttons inside the bar */
.class-btn { 
    padding: 10px 24px; 
    border-radius: 8px; 
    text-decoration: none !important; 
    color: #64748b; /* Slate grey for inactive */
    font-weight: 700; 
    font-size: 0.95rem;
    transition: all 0.3s ease;
    border: none;
    display: inline-block;
}

/* Hover effect for inactive items */
.class-btn:hover:not(.active) {
    color: #1e293b;
    background: #f8fafc;
}

/* The Active 'Floating' Button (Dark Navy) */
.class-btn.active { 
    background: #1e293b !important; 
    color: #ffffff !important; 
    /* This shadow makes the active button pop out slightly */
    box-shadow: 0 4px 12px rgba(30, 41, 59, 0.2); 
}
    /* Subject Card - Edition Dynamic Style */
   .edition-info { 
    color: #10b981 !important; /* Vibrant green from your reference image */
    font-size: 0.95rem; /* Increased for better readability */
    font-weight: 600; 
    margin-bottom: 15px; 
    display: flex;
    align-items: center;
    gap: 6px;
}
   .edition-info i {
    font-size: 0.85rem;
}
        /* Subject Section Headers */
        .subject-section-title { 
            display: flex; 
            font-size: 1.8rem;
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

        /* Container for the content inside the card */
.card-content { 
    flex-grow: 1; 
    display: flex; 
    flex-direction: column; 
    justify-content: center; 
    padding-right: 10px;
}

/* 1. Subject Label (Top small text) */
.cat-tag { 
    font-size: 0.8rem !important; 
    text-transform: uppercase; 
    font-weight: 500; 
    color: #94a3b8; 
    display: flex; 
    align-items: center; 
    gap: 5px; 
    margin-bottom: 4px;
}

/* 2. Main Title (Larger than everything else) */
.sub-name { 
    font-weight: 700; 
    color: #000000 !important; 
    font-size: 1.2rem !important; /* Increased size for Title */
    margin-bottom: 4px; 
    display: block; 
    line-height: 1.1;
}

/* 3. Edition (Same size as Subject Label, but Green) */
.edition-info { 
    color: #10b981; 
    font-size: 0.8rem !important; /* Similar to Subject size */
    font-weight: 500; 
    margin-bottom: 12px; 
    display: flex; 
    align-items: center; 
    gap: 6px;
}

/* 4. Button (Full width, rounded, with matching shadow) */
.btn-read-online { 
    background: #5850ec; 
    color: white !important; 
    padding: 8px 0; 
    border-radius: 8px; 
    text-decoration: none !important; 
    text-align: center; 
    font-weight: 700; 
    font-size: 1rem; 
    display: block; 
    width: 100%;
    transition: transform 0.2s;
    box-shadow: 0 4px 12px rgba(88, 80, 236, 0.2);
}

.btn-read-online:hover {
    background: #4338ca;
    transform: translateY(-1px);
}
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

<div class="text-center">
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
             class="subject-img" alt="Subject Image" />
    </div>
    <div class="card-content">
        <span class="cat-tag">
            <i class="fas fa-calculator" style="font-size: 0.75rem;"></i> 
            <%# Eval("SubjectName") %>
        </span>
        
        <span class="sub-name">
            <%# Eval("PageTitle") != DBNull.Value && !string.IsNullOrEmpty(Eval("PageTitle").ToString()) ? Eval("PageTitle") : Eval("SubjectName") + " (NCERT)" %>
        </span>

        <span class="edition-info">
            <i class="fas fa-check-circle"></i> 
            <%# Eval("Edition") != DBNull.Value ? Eval("Edition") : "2024-25 Latest Edition" %>
        </span>

        <a href='<%# "SubjectDetails.aspx?sid=" + Eval("SubjectId") + "&res=" + (Request.QueryString["res"] ?? "books") %>' class="btn-read-online">
            Explore <i class="fas fa-external-link-alt ms-1" style="font-size: 0.85rem;"></i>
        </a>
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