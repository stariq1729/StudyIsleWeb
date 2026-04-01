<%@ Page Title="Exam Sets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sets.aspx.cs" Inherits="StudyIsleWeb.Sets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sets-header { background: #f8fafc; padding: 40px 0; border-bottom: 1px solid #e2e8f0; margin-bottom: 30px; }
        .set-card { 
            background: white; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; 
            display: flex; align-items: center; justify-content: space-between;
            transition: all 0.2s ease; text-decoration: none !important; height: 100%;
        }
        .set-card:hover { border-color: #f43f5e; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transform: translateY(-2px); }
        .set-info { display: flex; align-items: center; }
        .set-icon { color: #f43f5e; font-size: 1.5rem; margin-right: 15px; }
        .set-name { color: #1e293b; font-weight: 600; font-size: 1rem; }
        .external-icon { color: #cbd5e1; font-size: 0.9rem; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sets-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                    <li class="breadcrumb-item active"><asp:Literal ID="litBreadcrumb" runat="server" /></li>
                </ol>
            </nav>
            <h2 class="fw-bold text-slate-800">
                <asp:Literal ID="litHeaderTitle" runat="server" />
            </h2>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4">
            <asp:Repeater ID="rptSets" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-6">
                        <a href='<%# GetResourceUrl(Eval("Slug")) %>' class="set-card">
                            <div class="set-info">
                                <div class="set-icon"><i class="far fa-file-pdf"></i></div>
                                <div class="set-name"><%# Eval("SetName") %></div>
                            </div>
                            <div class="external-icon">
                                <i class="fas fa-external-link-alt"></i>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>