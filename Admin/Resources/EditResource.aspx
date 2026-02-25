<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResource.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.EditResource" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-3">Edit Resource</h4>

<asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

<div class="card p-4 shadow-sm">

    <asp:HiddenField ID="hfResourceId" runat="server" />

    <!-- Board -->
    <div class="mb-3">
        <label>Board</label>
        <asp:DropDownList ID="ddlBoard" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" />
    </div>

    <!-- Resource Type -->
    <div class="mb-3">
        <label>Resource Type</label>
        <asp:DropDownList ID="ddlResourceType" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlResourceType_SelectedIndexChanged" />
    </div>

    <!-- Class -->
    <asp:Panel ID="pnlClass" runat="server" Visible="false">
        <div class="mb-3">
            <label>Class</label>
            <asp:DropDownList ID="ddlClass" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" />
        </div>
    </asp:Panel>

    <!-- Subject -->
    <asp:Panel ID="pnlSubject" runat="server" Visible="false">
        <div class="mb-3">
            <label>Subject</label>
            <asp:DropDownList ID="ddlSubject" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged" />
        </div>
    </asp:Panel>

    <!-- Chapter -->
    <asp:Panel ID="pnlChapter" runat="server" Visible="false">
        <div class="mb-3">
            <label>Chapter</label>
            <asp:DropDownList ID="ddlChapter" runat="server"
                CssClass="form-control" />
        </div>
    </asp:Panel>

    <!-- Year -->
    <asp:Panel ID="pnlYear" runat="server" Visible="false">
        <div class="mb-3">
            <label>Year</label>
            <asp:DropDownList ID="ddlYear" runat="server"
                CssClass="form-control" />
        </div>
    </asp:Panel>

    <!-- SubCategory -->
    <asp:Panel ID="pnlSubCategory" runat="server" Visible="false">
        <div class="mb-3">
            <label>SubCategory</label>
            <asp:DropDownList ID="ddlSubCategory" runat="server"
                CssClass="form-control" />
        </div>
    </asp:Panel>

    <!-- Title -->
    <div class="mb-3">
        <label>Title</label>
        <asp:TextBox ID="txtTitle" runat="server"
            CssClass="form-control" />
    </div>

    <!-- Description -->
    <div class="mb-3">
        <label>Description</label>
        <asp:TextBox ID="txtDescription" runat="server"
            CssClass="form-control"
            TextMode="MultiLine"
            Rows="4" />
    </div>

    <!-- File -->
    <div class="mb-3">
        <label>Replace File (optional)</label>
        <asp:FileUpload ID="fuFile" runat="server"
            CssClass="form-control" />
    </div>

    <!-- Premium -->
    <div class="form-check mb-3">
        <asp:CheckBox ID="chkIsPremium"
            runat="server"
            CssClass="form-check-input" />
        <label class="form-check-label">Is Premium</label>
    </div>

    <asp:Button ID="btnUpdate" runat="server"
        Text="Update Resource"
        CssClass="btn btn-success"
        OnClick="btnUpdate_Click" />

</div>

</asp:Content>