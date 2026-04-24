<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddBlogs.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.AddBlogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <h3>Add New Blog</h3>

    <div class="card p-4 mt-3">

        <!-- Title -->
        <div class="mb-3">
            <label>Blog Title</label>
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtTitle_TextChanged" />
        </div>

        <!-- Slug -->
        <div class="mb-3">
            <label>Slug (URL)</label>
            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" />
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label>Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <!-- Cover Image -->
        <div class="mb-3">
            <label>Cover Image</label>
            <asp:FileUpload ID="fileCoverImage" runat="server" CssClass="form-control" />
        </div>

        <!-- Short Description -->
        <div class="mb-3">
            <label>Short Description</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
        </div>

        <!-- Publish -->
        <div class="mb-3">
            <asp:CheckBox ID="chkPublish" runat="server" Text="Publish Now" />
        </div>

        <!-- Save Button -->
        <asp:Button ID="btnSave" runat="server" Text="Save Blog" CssClass="btn btn-primary" OnClick="btnSave_Click" />

    </div>

</div>

</asp:Content>