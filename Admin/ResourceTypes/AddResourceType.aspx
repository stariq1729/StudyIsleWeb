<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.AddResourceType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-card">

        <h4 class="form-title">Add Resource Type</h4>

        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

        <!-- Name -->
        <div class="mb-3">
            <label>Name</label>
            <asp:TextBox ID="txtName" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnTextChanged="txtName_TextChanged">
            </asp:TextBox>
        </div>

        <!-- Slug -->
        <div class="mb-3">
            <label>Slug</label>
            <asp:TextBox ID="txtSlug" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <!-- Is Active -->
        <div class="mb-3">
            <asp:CheckBox ID="chkIsActive" runat="server"
                Text=" Is Active"
                Checked="true" />
        </div>

        <!-- Button -->
        <asp:Button ID="btnSave" runat="server"
            Text="Save Resource Type"
            CssClass="btn btn-success"
            OnClick="btnSave_Click" />

        <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>
