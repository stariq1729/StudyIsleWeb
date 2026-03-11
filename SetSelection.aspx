<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SetSelection.aspx.cs" Inherits="StudyIsleWeb.SetSelection" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root { --si-indigo: #6366f1; --si-slate: #0f172a; }
        .set-grid-header { background: linear-gradient(135deg, #f8fafc 0%, #eff6ff 100%); padding: 60px 0; border-bottom: 1px solid #e2e8f0; margin-bottom: 40px; }
        .set-card-wrapper { text-decoration: none; color: inherit; display: block; height: 100%; }
        .set-card { 
            background: white; border: 1px solid #e2e8f0; border-radius: 20px; padding: 30px; 
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); position: relative; overflow: hidden;
            display: flex; flex-direction: column; align-items: center; justify-content: center;
        }
        .set-card:hover { 
            transform: translateY(-10px); border-color: var(--si-indigo); 
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .set-card::before { 
            content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; 
            background: var(--si-indigo); opacity: 0; transition: 0.3s; 
        }
        .set-card:hover::before { opacity: 1; }
        .set-icon { width: 50px; height: 50px; background: #eef2ff; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: var(--si-indigo); margin-bottom: 20px; font-size: 1.5rem; }
        .set-name { font-size: 1.4rem; font-weight: 800; color: var(--si-slate); margin-bottom: 5px; }
        .set-meta { font-size: 0.85rem; color: #64748b; text-transform: uppercase; letter-spacing: 1px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="set-grid-header">
        <div class="container text-center">
            <span class="badge bg-primary mb-3 px-3 py-2 rounded-pill">Set Selection</span>
            <h1 class="display-5 fw-bold text-dark"><asp:Literal ID="litSubjectYear" runat="server" /></h1>
            <p class="lead text-muted">Choose a specific set to access your study resources.</p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4 justify-content-center">
            <asp:Repeater ID="rptSets" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <a href='<%# "ViewResources.aspx?sid=" + Request.QueryString["sid"] + 
                                     "&res=" + Request.QueryString["res"] + 
                                     "&yid=" + Request.QueryString["yid"] + 
                                     "&setid=" + Eval("SetId") %>' class="set-card-wrapper">
                            <div class="set-card">
                                <div class="set-icon"><i class="fas fa-layer-group"></i></div>
                                <div class="set-name"><%# Eval("SetName") %></div>
                                <div class="set-meta">Available Papers</div>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>