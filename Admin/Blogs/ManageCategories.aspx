<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCategories.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.ManageCategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <!-- Header + Add Button -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Manage Blog Categories</h3>

        <a href="AddCategory.aspx" class="btn btn-success">
            + Add Category
        </a>
    </div>

    <!-- Table -->
    <div class="card p-3">

        <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False"
            CssClass="table table-bordered table-hover"
            OnRowCommand="gvCategories_RowCommand"
            EmptyDataText="No categories found">

            <Columns>

                <asp:BoundField DataField="CategoryId" HeaderText="ID" />

                <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />

                <asp:BoundField DataField="Type" HeaderText="Type" />

                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date"
                    DataFormatString="{0:dd-MM-yyyy}" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server"
                            Text="Delete"
                            CssClass="btn btn-danger btn-sm"
                            CommandName="DeleteCategory"
                            CommandArgument='<%# Eval("CategoryId") %>'
                            OnClientClick="return confirm('Are you sure you want to deactivate this category?');" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</div>

</asp:Content>