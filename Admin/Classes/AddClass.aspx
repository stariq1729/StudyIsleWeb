<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddClass.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.AddClass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card shadow-sm">

        <h4 class="form-title">Add New Class</h4>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger d-block mb-3"></asp:Label>

        <!-- Select Board -->
        <div class="mb-3">
            <label class="form-label">Select Board</label>
            <asp:DropDownList ID="ddlBoard" runat="server"
                CssClass="form-control">
            </asp:DropDownList>
        </div>

        <!-- Class Name -->
        <div class="mb-3">
            <label class="form-label">Class Name</label>
            <asp:TextBox ID="txtClassName" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnTextChanged="txtClassName_TextChanged">
            </asp:TextBox>
        </div>

        <!-- Slug -->
        <div class="mb-3">
            <label class="form-label">Slug</label>
            <asp:TextBox ID="txtSlug" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <!-- Display Order -->
        <div class="mb-3">
            <label class="form-label">Display Order</label>
            <asp:TextBox ID="txtDisplayOrder" runat="server"
                CssClass="form-control"
                Text="0">
            </asp:TextBox>
        </div>

        <!-- Active -->
        <div class="form-check mb-3">
            <asp:CheckBox ID="chkIsActive"
                runat="server"
                CssClass="form-check-input"
                Checked="true" />
            <label class="form-check-label">Is Active</label>
        </div>

        <asp:Button ID="btnSave" runat="server"
            Text="Save Class"
            CssClass="btn btn-primary"
            OnClick="btnSave_Click" />

        <a href="ManageClasses.aspx"
            class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>