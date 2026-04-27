<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBlogType.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.ManageBlogType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <!-- Header + Add Button -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Manage Blogs</h3>

        <a href="AddBlogs.aspx" class="btn btn-success">
            + Add Blog
        </a>
    </div>

    <!-- Blog Table -->
    <asp:GridView ID="gvBlogs" runat="server" AutoGenerateColumns="False"
        CssClass="table table-bordered table-hover"
        OnRowCommand="gvBlogs_RowCommand">

        <Columns>

            <asp:BoundField DataField="BlogId" HeaderText="ID" />

            <asp:BoundField DataField="Title" HeaderText="Title" />

            <asp:BoundField DataField="CategoryName" HeaderText="Category" />

            <asp:BoundField DataField="AuthorName" HeaderText="Author" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>

                    <!-- Edit -->
                    <a href='AddBlogs.aspx?BlogId=<%# Eval("BlogId") %>'
                        class="btn btn-sm btn-primary me-2">
                        Edit
                    </a>

                    <!-- Toggle Active -->
                    <asp:Button ID="btnToggle" runat="server"
                        Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>'
                        CssClass="btn btn-sm btn-warning"
                        CommandName="ToggleActive"
                        CommandArgument='<%# Eval("BlogId") %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>

</asp:Content>