<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.EditResourceType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-card">

        <h4 class="form-title">Edit Resource Type</h4>

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
                Text=" Is Active" />
        </div>

        <!-- Buttons -->
        <asp:Button ID="btnUpdate" runat="server"
            Text="Update Resource Type"
            CssClass="btn btn-success"
            OnClick="btnUpdate_Click" />

        <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>
