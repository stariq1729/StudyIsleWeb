<%@ Page Title="Select Subject/Year" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompSubSelect.aspx.cs" Inherits="StudyIsleWeb.CompSubSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header { background: #f8fafc; padding: 40px 0; border-bottom: 1px solid #e2e8f0; margin-bottom: 40px; }
        .subject-card { 
            background: white; border: 1px solid #e2e8f0; border-radius: 12px; padding: 25px; 
            transition: all 0.3s ease; text-align: center; height: 100%;
        }
        .subject-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: #6366f1; }
        .sub-icon { width: 50px; height: 50px; margin-bottom: 15px; object-fit: contain; }
        .sub-name { font-weight: 700; color: #1e293b; margin-bottom: 5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb" class="mb-2">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><asp:Literal ID="litBoardName" runat="server" /></li>
                    <li class="breadcrumb-item active"><asp:Literal ID="litSubCatName" runat="server" /></li>
                </ol>
            </nav>
            <h2 class="fw-bold">
                <asp:Literal ID="litViewType" runat="server" />
            </h2>
            <p class="text-muted small">Select an option to continue browsing resources.</p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4">
            <asp:Repeater ID="rptData" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <a href='<%# GetNavigationUrl(Eval("Id")) %>' class="text-decoration-none">
                            <div class="subject-card">
                                <img src='<%# GetIcon(Eval("IconImage")) %>' class="sub-icon" alt="Icon" />
                                <div class="sub-name"><%# Eval("DisplayName") %></div>
                                <div class="small text-muted text-truncate"><%# Eval("Description") %></div>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="col-12 text-center py-5">
                <h5 class="text-muted">No resources found in this category.</h5>
            </asp:Panel>
        </div>
    </div>
</asp:Content>