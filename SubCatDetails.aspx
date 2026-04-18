<%@ Page Title="Sub Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubCatDetails.aspx.cs" Inherits="StudyIsleWeb.SubCatDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    :root { 
        --si-indigo: #4f46e5; 
        --si-slate: #1e293b; 
        --si-gray: #64748b;
    }

    /* Keep your existing header style as requested */
    .subcat-header { text-align: center; padding: 100px 0 80px; background: #703deb; margin-bottom: 40px; border-bottom: 1px solid #e2e8f0; color: white; }
    
    body { background: #f8f9fa; }

    /* The New Card Design */
    .subcat-card { 
        background: white; 
        border: 1px solid #eef2f6; 
        border-radius: 16px; 
        padding: 30px; 
        transition: all 0.3s ease; 
        text-align: left; /* Change to left */
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: flex-start; /* Align items to start */
        position: relative;
        overflow: hidden; /* For the background blob */
        box-shadow: 0 4px 6px rgba(0,0,0,0.02);
    }

    /* Decorative Circle in corner */
    .subcat-card::after {
        content: "";
        position: absolute;
        width: 120px;
        height: 120px;
        background: linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(147, 51, 234, 0.05) 100%);
        border-radius: 50%;
        top: -40px;
        right: -40px;
    }

    .subcat-card:hover { 
        transform: translateY(-8px); 
        box-shadow: 0 15px 30px rgba(0,0,0,0.08); 
        border-color: var(--si-indigo); 
    }

    /* Icon Box Wrapper */
    .icon-box {
        width: 48px;
        height: 48px;
        background: var(--si-indigo); /* You can change this color dynamically */
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
        z-index: 1;
    }

    .subcat-icon { 
        width: 24px; 
        height: 24px; 
        object-fit: contain; 
        filter: brightness(0) invert(1); /* Makes image icons white */
    }

    .subcat-name { 
        font-weight: 800; 
        font-size: 1.1rem; 
        color: var(--si-slate); 
        margin-bottom: 10px; 
        text-transform: uppercase; /* Match reference */
        z-index: 1;
    }

    .subcat-desc { 
        font-size: 0.9rem; 
        color: var(--si-gray); 
        line-height: 1.5;
        margin-bottom: 20px;
        z-index: 1;
    }

    /* Learn More Link */
    .learn-more-btn {
        color: var(--si-indigo);
        font-weight: 600;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        margin-top: auto;
        z-index: 1;
    }

    .learn-more-btn span { margin-right: 5px; }

    /* Default (Indigo/Blue) */
    .theme-1 .icon-box { background: #4f46e5; }
    .theme-1::after { background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, rgba(147, 51, 234, 0.05) 100%); }

    /* Theme 2 (Purple) */
    .theme-2 .icon-box { background: #7c3aed; }
    .theme-2::after { background: linear-gradient(135deg, rgba(124, 58, 237, 0.1) 0%, rgba(192, 38, 211, 0.05) 100%); }

    /* Theme 3 (Green) */
    .theme-3 .icon-box { background: #059669; }
    .theme-3::after { background: linear-gradient(135deg, rgba(5, 150, 105, 0.1) 0%, rgba(16, 185, 129, 0.05) 100%); }

    /* Theme 4 (Orange) */
    .theme-4 .icon-box { background: #ea580c; }
    .theme-4::after { background: linear-gradient(135deg, rgba(234, 88, 12, 0.1) 0%, rgba(251, 146, 60, 0.05) 100%); }

    /* Theme 5 (Red) */
    .theme-5 .icon-box { background: #dc2626; }
    .theme-5::after { background: linear-gradient(135deg, rgba(220, 38, 38, 0.1) 0%, rgba(248, 113, 113, 0.05) 100%); }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="subcat-header">
        <div class="container">
            <h1 class="fw-bold"><asp:Literal ID="litTitle" runat="server" /></h1>
            <p class="text-muted"><asp:Literal ID="litSubtitle" runat="server" /></p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4 justify-content-center">
           <asp:Repeater ID="rptSubCats" runat="server">
    <ItemTemplate>
        <div class="col-lg-4 col-md-6 col-sm-12">
            <a href='<%# GetDynamicUrl(Eval("SubCategoryId"), Eval("IsCompetitive")) %>' class="text-decoration-none">
                <div class='<%# "subcat-card theme-" + ((Container.ItemIndex % 5) + 1) %>'>
                    
                    <div class="icon-box">
                        <img src='<%# "/Uploads/SubCatIcons/" + (Eval("IconImage") == DBNull.Value ? "default-cat.png" : Eval("IconImage")) %>' 
                             class="subcat-icon" alt="Icon" />
                    </div>

                    <div class="subcat-name"><%# Eval("SubCategoryName") %></div>
                    
                        <div class="subcat-desc"><%# Eval("Description") %></div>
                    

                    <div class="learn-more-btn">
                        <span>Learn More</span>
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg>
                    </div>
                </div>
            </a>
        </div>
    </ItemTemplate>
</asp:Repeater>
        </div>
    </div>
</asp:Content>