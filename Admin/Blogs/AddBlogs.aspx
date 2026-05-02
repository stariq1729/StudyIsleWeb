<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddBlogs.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.AddBlogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <h3>Add New Blog</h3>

    <div class="card p-4 mt-3">

       

       <%-- author--%>
        <div class="mb-3">
    <label>Author Name</label>
    <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control" />
</div>
        <div class="mb-3">
    <label>Author Image</label>
    <asp:FileUpload ID="fileAuthorImage" runat="server" CssClass="form-control" />
</div>
        <!-- Category -->
        <div class="mb-3">
            <label>Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>
         <!-- Readtime -->
       <div class="mb-3">
    <label>Read Time (in minutes)</label>
    <asp:TextBox ID="txtReadTime" runat="server" CssClass="form-control" />
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