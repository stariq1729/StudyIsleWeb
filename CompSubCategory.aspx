<%@ Page Title="Competitive Exams" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompSubCategory.aspx.cs" Inherits="StudyIsleWeb.CompSubCategory" %>
<%--this page is not in used for now because we changed the flow for jee now it's redirecting to resource types page only changes occured--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* matching your reference UI */
        .comp-hero-section {
            padding: 70px 0;
            text-align: center;
            background: #fff;
        }
        .comp-hero-title { font-size: 3.0rem; font-weight: 800; color: #1a1a1a; }
        .comp-hero-title span { color: #6366f1; }
        .comp-hero-subtitle { color: #666; max-width: 600px; margin: 20px auto; font-size: 1.1rem; line-height: 1.6; }

        .comp-card-grid { padding-bottom: 50px; }
        .comp-resource-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 28px;
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            text-decoration: none !important;
        }
        .comp-resource-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.06);
            border-color: #6366f1;
        }
        .icon-wrap {
            width: 64px; height: 64px;
            border-radius: 12px;
            background: #f1f5f9;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 18px;
        }
        .icon-wrap img { width: 30px; height: 30px; object-fit: contain; }
        
        .card-name { font-size: 1.2rem; font-weight: 700; color: #1e293b; text-transform: uppercase; margin-bottom: 12px; }
        .card-desc { font-size: 0.95rem; color: #64748b; line-height: 1.5; flex-grow: 1; margin-bottom: 20px; }
        .learn-more { color: #6366f1; font-weight: 600; font-size: 0.9rem; display: flex; align-items: center; gap: 8px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="comp-hero-section">
        <div class="container">
            <h1 class="comp-hero-title">
                Crack <asp:Literal ID="litBoardName" runat="server" /> with <span>Confidence</span>
            </h1>
            <p class="comp-hero-subtitle">
                <asp:Literal ID="litHeroSubtitle" runat="server" />
            </p>
        </div>
    </section>

    <div class="container comp-card-grid">
        <div class="row g-4">
            <asp:Repeater ID="rptSubCategories" runat="server">
                <ItemTemplate>
                    <div class="col-12 col-md-6 col-lg-4">
                        <asp:LinkButton ID="lnkSubCat" runat="server" CssClass="comp-resource-card" 
                            OnClick="lnkSubCat_Click" CommandArgument='<%# Eval("SubCategoryId") %>'>
                            <div class="icon-wrap">
                                <img src='<%# "/Uploads/SubCategoryIcons/" + Eval("IconImage") %>' 
                                     onerror="this.src='/Assets/img/default-icon.png';" />
                            </div>
                            <h3 class="card-name"><%# Eval("SubCategoryName") %></h3>
                            <p class="card-desc"><%# Eval("Description") %></p>
                            <div class="learn-more">
                                Learn More <i class="fas fa-chevron-right"></i>
                            </div>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>