<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageBlogContent.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Blogs.ManageBlogContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Manage Blog Content</h3>
    </div>

    <!-- Grid -->
    <asp:GridView ID="gvContent" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-bordered table-hover"
        OnRowCommand="gvContent_RowCommand">

        <Columns>

            <asp:BoundField DataField="BlogId" HeaderText="ID" />

            <asp:BoundField DataField="Title" HeaderText="Title" />

            <asp:BoundField DataField="CategoryName" HeaderText="Category" />

            <asp:BoundField DataField="AuthorName" HeaderText="Author" />

           <%-- Content Status -->--%>
            <asp:TemplateField HeaderText="Content">
                <ItemTemplate>
                    <%# Convert.ToInt32(Eval("BlockCount")) > 0 ? "Available" : "Empty" %>
                </ItemTemplate>
            </asp:TemplateField>

<%--             Total Blocks -->--%>
            <asp:BoundField DataField="BlockCount" HeaderText="Blocks" />

             <%--Active Status -->--%>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                </ItemTemplate>
            </asp:TemplateField>

            <%--!-- Actions -->--%>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>

                   <%-- -- Edit Full Content -->--%>
                    <a href='EditBlogContent.aspx?BlogId=<%# Eval("BlogId") %>'
                        class="btn btn-sm btn-primary me-2">
                        Edit
                    </a>

                    <%---- Toggle Active -->--%>
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