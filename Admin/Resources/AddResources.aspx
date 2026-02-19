<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddResources.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.AddResources" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-card">

    <h4 class="form-title">Add Resource</h4>

    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

    <!-- Board -->
    <div class="mb-3">
        <label>Board</label>
        <asp:DropDownList ID="ddlBoard" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
        </asp:DropDownList>
    </div>

    <!-- Class -->
    <div class="mb-3">
        <label>Class</label>
        <asp:DropDownList ID="ddlClass" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
        </asp:DropDownList>
    </div>

    <!-- Subject -->
    <div class="mb-3">
        <label>Subject</label>
        <asp:DropDownList ID="ddlSubject" runat="server"
            CssClass="form-control">
        </asp:DropDownList>
    </div>

    <!-- Resource Type -->
    <div class="mb-3">
        <label>Resource Type</label>
        <asp:DropDownList ID="ddlResourceType" runat="server"
            CssClass="form-control">
        </asp:DropDownList>
    </div>

    <!-- Title -->
    <div class="mb-3">
        <label>Title</label>
        <asp:TextBox ID="txtTitle" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnTextChanged="txtTitle_TextChanged">
        </asp:TextBox>
    </div>

    <!-- Slug -->
    <div class="mb-3">
        <label>Slug</label>
        <asp:TextBox ID="txtSlug" runat="server"
            CssClass="form-control">
        </asp:TextBox>
    </div>

    <!-- File Upload -->
    <div class="mb-3">
        <label>Upload File</label>
        <asp:FileUpload ID="fileUpload" runat="server"
            CssClass="form-control" />
    </div>

    <!-- Is Active -->
    <div class="mb-3">
        <asp:CheckBox ID="chkIsActive" runat="server"
            Text=" Is Active"
            Checked="true" />
    </div>

    <asp:Button ID="btnSave" runat="server"
        Text="Save Resource"
        CssClass="btn btn-success"
        OnClick="btnSave_Click" />

    <a href="ManageResources.aspx" class="btn btn-secondary ms-2">
        Cancel
    </a>

</div>
</asp:Content>
