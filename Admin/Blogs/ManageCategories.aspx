<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCategories.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.ManageCategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">
    <h3>Manage Blog Categories</h3>

    <div class="card p-3 mt-3">

        <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" 
            CssClass="table table-bordered table-striped"
            OnRowCommand="gvCategories_RowCommand">

            <Columns>

                <asp:BoundField DataField="CategoryId" HeaderText="ID" />

                <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />

                <asp:BoundField DataField="Type" HeaderText="Type" />

                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" 
                    DataFormatString="{0:dd-MM-yyyy}" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                            CssClass="btn btn-danger btn-sm"
                            CommandName="DeleteCategory"
                            CommandArgument='<%# Eval("CategoryId") %>'
                            OnClientClick="return confirm('Are you sure you want to delete?');" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>
</div>

</asp:Content>