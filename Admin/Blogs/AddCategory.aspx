<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddCategory.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.AddCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">
    <h3>Add Blog Category</h3>

    <div class="card p-4 mt-3">

        <div class="mb-3">
            <label>Category Name</label>
            <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" />
        </div>

        <div class="mb-3">
            <label>Type</label>
            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                <asp:ListItem Text="General" Value="General" />
                <asp:ListItem Text="Specific" Value="Specific" />
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnSave" runat="server" Text="Save Category" 
            CssClass="btn btn-primary" OnClick="btnSave_Click" />

    </div>
</div>

</asp:Content>