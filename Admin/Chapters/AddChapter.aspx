<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddChapter.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.AddChapter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card shadow-sm">

        <h4 class="form-title">Add New Chapter</h4>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger d-block mb-3"></asp:Label>

        <!-- Board -->
        <div class="mb-3">
            <label>Select Board</label>
            <asp:DropDownList ID="ddlBoard" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <!-- Class -->
        <div class="mb-3">
            <label>Select Class (Optional)</label>
            <asp:DropDownList ID="ddlClass" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <!-- Subject -->
        <div class="mb-3">
            <label>Select Subject</label>
            <asp:DropDownList ID="ddlSubject" runat="server"
                CssClass="form-control">
            </asp:DropDownList>
        </div>

        <!-- Chapter Name -->
        <div class="mb-3">
            <label>Chapter Name</label>
            <asp:TextBox ID="txtChapterName" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnTextChanged="txtChapterName_TextChanged">
            </asp:TextBox>
        </div>

        <!-- Slug -->
        <div class="mb-3">
            <label>Slug</label>
            <asp:TextBox ID="txtSlug" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <!-- Display Order -->
        <div class="mb-3">
            <label>Display Order</label>
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
            Text="Save Chapter"
            CssClass="btn btn-primary"
            OnClick="btnSave_Click" />

        <a href="ManageChapters.aspx"
            class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>