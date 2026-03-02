<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubjectDetails.aspx.cs" Inherits="StudyIsleWeb.SubjectDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header { text-align: left; margin-bottom: 2rem; padding-top: 10px; border-bottom: 1px solid #e2e8f0; padding-bottom: 20px;}
        .breadcrumb { font-size: 0.85rem; color: #64748b; margin-bottom: 5px; }
        .breadcrumb a { color: #64748b; text-decoration: none; }
        .breadcrumb a:hover { color: #4f46e5; text-decoration: underline;}
        .breadcrumb span.current { color: #1e293b; font-weight: 600; }
        .breadcrumb span.separator { margin: 0 8px; }

        .page-header h1 { font-weight: 800; font-size: 2rem; color: #1e293b; margin-bottom: 5px; }
        .page-header h1 span { color: #4f46e5; }
        .page-header p { color: #64748b; font-size: 0.95rem; margin: 0; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        
        <div class="page-header">
            <div class="breadcrumb">
                <a href="Default.aspx">Home</a> <span class="separator">&gt;</span> 
                <asp:HyperLink ID="hlBoardClassContext" runat="server"></asp:HyperLink> <span class="separator">&gt;</span>
                <span class="current"><asp:Literal ID="litSubjectBreadcrumb" runat="server"></asp:Literal></span>
            </div>
            <h1>
                <asp:Literal ID="litPageTitle" runat="server"></asp:Literal>
            </h1>
            <p><asp:Literal ID="litPageSubtitle" runat="server"></asp:Literal></p>
        </div>

        <asp:PlaceHolder ID="phChapterPath" runat="server" Visible="false">
            <div class="alert alert-info">
                <strong>Logic Check:</strong> You are on the 'Books' path. In the next step, we will bind the chapter list from the `dbo.Chapters` table to look like your reference image.
            </div>
            </asp:PlaceHolder>

        <asp:PlaceHolder ID="phYearPath" runat="server" Visible="false">
            <div class="alert alert-info">
                <strong>Logic Check:</strong> You are on the 'PYQ' path. We will bind the list of years from the `dbo.Years` table in a separate step.
            </div>
            </asp:PlaceHolder>

    </div>
</asp:Content>