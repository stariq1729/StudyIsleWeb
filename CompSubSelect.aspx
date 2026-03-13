<%@ Page Title="Select Subject" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompSubSelect.aspx.cs" Inherits="StudyIsleWeb.CompSubSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header { background: #f8fafc; padding: 40px 0; border-bottom: 1px solid #e2e8f0; margin-bottom: 40px; }
        .breadcrumb-item a { color: #6366f1; text-decoration: none; font-weight: 500; }
        .subject-card { 
            background: white; border: 1px solid #e2e8f0; border-radius: 12px; padding: 25px; 
            transition: all 0.3s ease; text-align: center; height: 100%;
        }
        .subject-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: #6366f1; }
        .sub-icon { width: 50px; height: 50px; margin-bottom: 15px; }
        .sub-name { font-weight: 700; color: #1e293b; margin-bottom: 5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                    <li class="breadcrumb-item acyive"><asp:Literal ID="litBoardName" runat="server" /></li>

                    <%--this breadcrum is added but right now is not working it out later--%>

                    <li class="breadcrumb-item "><asp:Literal ID="LitResourcTypes" runat="server" /></li>
                </ol>
            </nav>
            <h2 class="fw-bold"><asp:Literal ID="litSubCatName" runat="server" /> - Subjects</h2>
            <p class="text-muted">Select a subject to view available resources.</p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row g-4">
            <asp:Label ID="lblNoData" runat="server" CssClass="alert alert-info d-block text-center" Visible="false"></asp:Label>
            
            <asp:Repeater ID="rptSubjects" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <a href='<%# GetNavigationUrl(Eval("Slug")) %>' class="text-decoration-none">
                            <div class="subject-card">
                                <img src='<%# "/Uploads/SubjectIcons/" + (Eval("IconImage") == DBNull.Value ? "default-sub.png" : Eval("IconImage")) %>' 
                                     class="sub-icon" alt="Subject Icon" />
                                <div class="sub-name"><%# Eval("SubjectName") %></div>
                                <div class="small text-muted text-truncate"><%# Eval("Description") %></div>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>