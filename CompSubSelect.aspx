<%@ Page Title="Select Subject/Year" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompSubSelect.aspx.cs" Inherits="StudyIsleWeb.CompSubSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       .page-header { background: #f8fafc; padding: 40px 0; border-bottom: 1px solid #e2e8f0; margin-bottom: 40px; }
    
    .subject-card { 
        background: white; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; 
        transition: all 0.3s ease; height: 100%;
        display: flex; flex-direction: row; align-items: center; 
        text-align: left;
    }
    
    .subject-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: #6366f1; }
    
    .card-main-content { display: flex; align-items: center; flex-grow: 1; }

    .sub-icon { width: 80px; height: 80px; object-fit: contain; margin-right: 20px; flex-shrink: 0; }
    
    /* Text and Button Container */
    .sub-info { 
        display: flex; 
        flex-direction: column; /* Stacks children vertically */
        align-items: flex-start; 
    }
    
    .sub-name { font-weight: 700; color: #1e293b; font-size: 1.15rem; margin-bottom: 2px; }
    .sub-title { font-size: 0.85rem; color: #64748b; margin-bottom: 12px; line-height: 1.4; }

    /* Updated Button Style for positioning below text */
    .btn-explore {
        background-color: #6366f1; color: white; padding: 6px 18px; border-radius: 6px;
        font-weight: 600; font-size: 0.85rem; transition: all 0.2s; white-space: nowrap;
    }
    .subject-card:hover .btn-explore { background-color: #4f46e5; }
        /* Year-Specific Card Styling */
.year-card {
    background: white;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: center;
    min-height: 150px;
}

.year-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.05);
    border-color: #6366f1;
}

.year-number {
    font-size: 2.2rem; /* Large bold year */
    font-weight: 800;
    color: #1e293b;
    margin-bottom: 5px;
}

.view-sets-link {
    color: #3b82f6; /* Blue "View Sets" text */
    font-weight: 500;
    font-size: 1rem;
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
            <%-- Hero description Literal --%>
            <p class="text-muted"><asp:Literal ID="litSubCatDesc" runat="server" /></p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4">
<asp:Repeater ID="rptData" runat="server">
    <ItemTemplate>
        <div class="col-lg-4 col-md-6 col-sm-12">
            <a href='<%# GetNavigationUrl(Eval("Id")) %>' class="text-decoration-none">
                
                <%-- DESIGN 1: SUBJECT VIEW (Icon Left, Text & Button Stacked Right) --%>
                <asp:PlaceHolder runat="server" Visible='<%# ViewMode == "Subject" %>'>
                    <div class="subject-card">
                        <div class="card-main-content">
                            <img src='<%# GetIcon(Eval("IconImage")) %>' class="sub-icon" alt="Icon" />
                            <div class="sub-info">
                                <div class="sub-name"><%# Eval("DisplayName") %></div>
                                
                                <%-- Render PageTitle if it exists --%>
                                <%# !string.IsNullOrEmpty(Convert.ToString(Eval("PageTitle"))) ? 
                                    "<div class='sub-title'>" + Eval("PageTitle") + "</div>" : "" %>
                                
                                <%-- Explore Button moved inside sub-info --%>
                                <div class="btn-explore">Explore</div>
                            </div>
                        </div>
                    </div>
                </asp:PlaceHolder>

                <%-- DESIGN 2: YEAR VIEW (Centered Square Box) --%>
                <asp:PlaceHolder runat="server" Visible='<%# ViewMode == "Year" %>'>
                    <div class="year-card">
                        <div class="year-number"><%# Eval("DisplayName") %></div>
                        <div class="view-sets-link">View Sets</div>
                    </div>
                </asp:PlaceHolder>

            </a>
        </div>
    </ItemTemplate>
</asp:Repeater>
            
            <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="col-12 text-center py-5">
                <h5 class="text-muted">No resources found.</h5>
            </asp:Panel>
        </div>
    </div>
</asp:Content>