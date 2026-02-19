<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditBoard.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.EditBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card shadow-sm">

        <h4 class="form-title">Edit Board</h4>

        <asp:HiddenField ID="hfBoardId" runat="server" />

        <div class="mb-3">
            <label class="form-label">Board Name</label>
            <asp:TextBox ID="txtBoardName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label">Slug</label>
            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-check mb-3">
            <asp:CheckBox ID="chkHasClassLayer" runat="server" CssClass="form-check-input" />
            <label class="form-check-label">Has Class Layer</label>
        </div>

        <div class="form-check mb-3">
            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
            <label class="form-check-label">Is Active</label>
        </div>

        <asp:Button ID="btnUpdate" runat="server"
            Text="Update Board"
            CssClass="btn btn-primary"
            OnClick="btnUpdate_Click" />

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger d-block mt-3"></asp:Label>

    </div>


</asp:Content>
