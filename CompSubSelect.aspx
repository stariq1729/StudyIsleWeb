<%@ Page Title="Select Subject/Year" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompSubSelect.aspx.cs" Inherits="StudyIsleWeb.CompSubSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header { background: #f8fafc; padding: 40px 0; border-bottom: 1px solid #e2e8f0; margin-bottom: 40px; }
        
        .subject-card { 
            background: white; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; 
            transition: all 0.3s ease; height: 100%;
            display: flex;
            flex-direction: row; 
            align-items: center; 
            justify-content: space-between; /* Pushes content to edges */
            text-align: left;
        }
        
        .subject-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: #6366f1; }
        
        /* Left Section Wrapper (Icon + Text) */
        .card-main-content {
            display: flex;
            align-items: center;
            flex-grow: 1;
        }

        .sub-icon { 
            width: 70px; 
            height: 90px; 
            object-fit: contain; 
            margin-right: 20px; 
            flex-shrink: 0;
        }
        
        .sub-name { font-weight: 700; color: #1e293b; font-size: 1.15rem; margin-bottom: 2px; }
        .sub-title { font-size: 0.85rem; color: #64748b; margin-top: 0; line-height: 1.4; }

        /* Explore Button Styling */
        .btn-explore {
            background-color: #6366f1;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: background 0.2s;
            white-space: nowrap;
            margin-left: 5px;
        }
        .subject-card:hover .btn-explore {
            background-color: #4f46e5;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb" class="mb-2">
                <ol class="breadcrumb mb-0" style="font-size: 0.9rem;">
                    <li class="breadcrumb-item"><asp:Literal ID="litBoardName" runat="server" /></li>
                    <li class="breadcrumb-item active"><asp:Literal ID="litSubCatName" runat="server" /></li>
                </ol>
            </nav>
            <h2 class="fw-bold"><asp:Literal ID="litViewType" runat="server" /></h2>
            <p class="text-muted"><asp:Literal ID="litSubCatDesc" runat="server" /></p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4">
         <asp:Repeater ID="rptData" runat="server">
    <ItemTemplate>
        <div class="col-lg-6 col-md-12">
            <a href='<%# GetNavigationUrl(Eval("Id")) %>' class="text-decoration-none">
                <div class="subject-card">
                    <div class="card-main-content">
                        <img src='<%# GetIcon(Eval("IconImage")) %>' class="sub-icon" alt="Icon" />
                        <div class="sub-info">
                            <div class="sub-name"><%# Eval("DisplayName") %></div>
                            <div class="sub-title"><%# Eval("PageTitle") %></div>
                        </div>
                    </div>

                    <div class="btn-explore">
                        Explore <i class="bi bi-arrow-right ms-1"></i>
                    </div>
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