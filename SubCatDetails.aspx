<%@ Page Title="Sub Categories" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubCatDetails.aspx.cs" Inherits="StudyIsleWeb.SubCatDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root { --si-indigo: #4f46e5; --si-slate: #1e293b; }
        .subcat-header { text-align: center; padding: 60px 0 40px; background: #f8fafc; margin-bottom: 40px; border-bottom: 1px solid #e2e8f0; }
        .subcat-card { 
            background: white; 
            border: 1px solid #e2e8f0; 
            border-radius: 16px; 
            padding: 30px; 
            transition: all 0.3s ease; 
            text-align: center;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .subcat-card:hover { transform: translateY(-8px); box-shadow: 0 15px 30px rgba(0,0,0,0.08); border-color: var(--si-indigo); }
        .subcat-icon { width: 64px; height: 64px; margin-bottom: 20px; object-fit: contain; }
        .subcat-name { font-weight: 700; font-size: 1.2rem; color: var(--si-slate); margin-bottom: 8px; }
        .subcat-desc { font-size: 0.9rem; color: #64748b; }
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
                    <div class="col-md-4 col-sm-6">
                        <%-- Dynamic URL Logic based on Board Type --%>
                        <a href='<%# GetDynamicUrl(Eval("Slug"), Eval("IsCompetitive")) %>' class="text-decoration-none">
                            <div class="subcat-card">
                                <img src='<%# "/Uploads/SubCatIcons/" + (Eval("IconImage") == DBNull.Value ? "default-cat.png" : Eval("IconImage")) %>' class="subcat-icon" alt="Icon" />
                                <div class="subcat-name"><%# Eval("SubCategoryName") %></div>
                                <div class="subcat-desc"><%# Eval("Description") %></div>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>