<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddBoards.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.AddBoards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card shadow-sm">

        <h4 class="form-title">Add New Board</h4>

        <asp:Label ID="lblMessage" runat="server" 
            CssClass="text-danger d-block mb-3"></asp:Label>

        <!-- Board Name -->
        <div class="mb-3">
            <label class="form-label">Board Name</label>
            <asp:TextBox ID="txtBoardName" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnTextChanged="txtBoardName_TextChanged">
            </asp:TextBox>
        </div>

        <!-- Slug -->
        <div class="mb-3">
            <label class="form-label">Slug</label>
            <asp:TextBox ID="txtSlug" runat="server"
                CssClass="form-control">
            </asp:TextBox>
            <small class="text-muted">
                URL-friendly version (auto generated)
            </small>
        </div>

        <!-- Has Class Layer -->
        <div class="form-check mb-2">
            <asp:CheckBox ID="chkHasClassLayer"
                runat="server"
                CssClass="form-check-input"
                Checked="true" />
            <label class="form-check-label">
                Has Class Layer
            </label>
        </div>

        <!-- Is Active -->
        <div class="form-check mb-3">
            <asp:CheckBox ID="chkIsActive"
                runat="server"
                CssClass="form-check-input"
                Checked="true" />
            <label class="form-check-label">
                Is Active
            </label>
        </div>

        <!-- Buttons -->
        <asp:Button ID="btnSave" runat="server"
            Text="Save Board"
            CssClass="btn btn-primary"
            OnClick="btnSave_Click" />

        <a href="ManageBoards.aspx"
            class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>