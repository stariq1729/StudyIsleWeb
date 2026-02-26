<%@ Page Title="Resources" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardResourceTypes.aspx.cs" Inherits="StudyIsleWeb.BoardResourceTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Hero Section Styling */
        .hero-section {
            background: linear-gradient(135deg, #1e293b 0%, #4338ca 100%);
            padding: 80px 0;
            color: #ffffff;
            text-align: center;
        }
        .hero-common { font-size: 1.9rem; opacity: 0.9; text-transform: uppercase; letter-spacing: 1px; }
        .hero-title { font-size: 3.1rem; font-weight: 800; margin: 10px 0; }
        .hero-subtitle { font-size: 1.1rem; max-width: 700px; margin: 0 auto; opacity: 0.8; line-height: 1.6; }

        /* Card Grid Styling */
        .resource-container { margin-top: -50px; padding-bottom: 80px; }
        .resource-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 26px;
            text-align: left;
            transition: all 0.3s ease;
            height: 100%;
            border: 1px solid rgba(0,0,0,0.05);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-decoration: none !important;
            display: block;
        }
        .resource-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        .icon-box {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            font-size: 1.5rem;
            color: white;
        }
        .card-name { font-size: 1.25rem; font-weight: 700; color: #1e293b; margin-bottom: 10px; }
        .card-desc { font-size: 0.9rem; color: #64748b; line-height: 1.5; margin-bottom: 20px; }
        .explore-link { font-weight: 600; color: #4338ca; font-size: 0.9rem; }
        
        /* Dynamic Colors for Icons (EduBooks style) */
        .bg-purple { background-color: #8b5cf6; }
        .bg-blue { background-color: #3b82f6; }
        .bg-green { background-color: #10b981; }
        .bg-orange { background-color: #f59e0b; }
        .bg-red { background-color: #ef4444; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        :root {
            --brand-primary: #6366f1;
            --brand-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            --card-bg: #ffffff;
            --text-title: #1e293b;
            --text-body: #64748b;
        }

        /* Hero Section */
        .hero-wrapper {
            background: var(--brand-gradient);
            padding: 80px 0;
            color: #ffffff;
            text-align: center;
        }
        .hero-main-title { font-size: 3rem; font-weight: 800; margin-bottom: 12px; }
        .hero-desc { font-size: 0.95rem; max-width: 650px; margin: 0 auto 28px; opacity: 0.8; }
        .hero-btns { 
    display: flex; 
    justify-content: center; 
    gap: 15px; 
    margin-top: 20px; 
}
        /*.hero-btns { display: flex; justify-content: center; gap: 15px; }*/
        .pill-btn {
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.25);
            color: white;
            padding: 10px 24px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
        }

        /* Fixed Size Card Grid */
        .content-area { padding: 40px 0; background-color: #f8fafc; }
        
        .resource-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 22px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            text-decoration: none !important;
            display: flex;
            flex-direction: column;
            /* Fixes the overall card height so all cards match */
            height: 100%; 
            min-height: 270px; 
            transition: 0.3s ease;
        }

        .resource-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        
        /* Icon Styling - Ensuring visibility */
        .card-icon-wrap {
            width: 72px;
            height: 72px;
            border-radius: 12px;
            background-color: #f1f5f9; 
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }
        .card-icon-wrap img { 
            width: 32px; 
            height: 32px; 
            object-fit: contain; 
            display: block;
        }

        .card-title { 
            font-size: 1.25rem; 
            font-weight: 700; 
            color: var(--text-title); 
            margin-bottom: 10px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Truncate Description with Three Dots (...) */
        .card-body-text { 
            font-size: 0.88rem; 
            color: var(--text-body); 
            line-height: 1.5; 
            margin-bottom: 20px;
            flex-grow: 1;
            
            /* Logic for the 3 dots after 3 lines */
            display: -webkit-box;
            -webkit-line-clamp: 3; 
            -webkit-box-orient: vertical;  
            overflow: hidden;
            height: 3.9em; /* Ensures fixed spacing even for short text */
        }

        .card-footer-link { 
            font-size: 0.9rem; 
            font-weight: 700; 
            color: var(--brand-primary); 
            display: flex; 
            align-items: center; 
            gap: 6px; 
            margin-top: auto; /* Pushes footer to bottom */
        }
    </style>

    <div class="hero-wrapper">
        <div class="container">
            <p style="font-size: 0.85rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 12px; opacity: 0.9;">
                Empowering Your Journey
            </p>
            <h1 class="hero-main-title"><asp:Literal ID="litHeroTitle" runat="server" /></h1>
            <p class="hero-desc"><asp:Literal ID="litHeroSubtitle" runat="server" /></p>
            
            <div class="hero-btns">
                <a href="#" class="pill-btn"><i class="fas fa-layer-group me-2"></i> 2M+ Resources</a>
                <a href="#" class="pill-btn"><i class="fas fa-check-circle me-2"></i> Updated Curriculum</a>
            </div>
        </div>
    </div>

    <div class="content-area">
        <div class="container">
            <div class="row g-4 justify-content-center">
                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <a href='<%# GetNavigationUrl(Eval("Slug"), Eval("HasClass")) %>' class="resource-card">
                                <div class="card-icon-wrap">
                                    <img src='<%# "/Uploads/ResourceIcons/" + Eval("IconImage") %>' alt="Resource Icon" />
                                </div>
                                <h3 class="card-title"><%# Eval("TypeName") %></h3>
                                <p class="card-body-text"><%# Eval("Description") %></p>
                                <div class="card-footer-link">
                                    Explore <%# Eval("TypeName") %> <i class="fas fa-arrow-right"></i>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>