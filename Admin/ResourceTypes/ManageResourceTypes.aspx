<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResourceTypes.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.ManageResourceTypes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="admin-header">
        <div>
            <h4 class="page-title">Manage Resource Types</h4>
            <p class="page-subtitle">Controls system hierarchy flow</p>
        </div>

        <div>
            <a href="AddResourceType.aspx" class="btn btn-primary btn-add">
                + Add Resource Type
            </a>
        </div>
    </div>

    <div class="card admin-card">

        <asp:GridView ID="gvResourceTypes" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-hover admin-table"
            OnRowCommand="gvResourceTypes_RowCommand"
            DataKeyNames="ResourceTypeId">

            <Columns>

                <asp:BoundField DataField="ResourceTypeId" HeaderText="ID" />

                <asp:BoundField DataField="TypeName" HeaderText="Type Name" />

                <asp:BoundField DataField="Slug" HeaderText="Slug" />

                <asp:TemplateField HeaderText="Premium">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("IsPremium"))
                            ? "<span class='badge badge-warning'>Premium</span>"
                            : "<span class='badge badge-secondary'>Free</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="DisplayOrder" HeaderText="Order" />

                <asp:TemplateField HeaderText="Flow Flags">
                    <ItemTemplate>

                        <%# Convert.ToBoolean(Eval("HasClass"))
                            ? "<span class='flag-badge'>Class</span>" : "" %>

                        <%# Convert.ToBoolean(Eval("HasSubject"))
                            ? "<span class='flag-badge'>Subject</span>" : "" %>

                        <%# Convert.ToBoolean(Eval("HasChapter"))
                            ? "<span class='flag-badge'>Chapter</span>" : "" %>

                        <%# Convert.ToBoolean(Eval("HasYear"))
                            ? "<span class='flag-badge'>Year</span>" : "" %>

                        <%# Convert.ToBoolean(Eval("HasSubCategory"))
                            ? "<span class='flag-badge'>SubCategory</span>" : "" %>

                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnToggle" runat="server"
                            CommandName="ToggleActive"
                            CommandArgument='<%# Eval("ResourceTypeId") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive"))
                                ? "badge badge-active"
                                : "badge badge-inactive" %>'>
                            <%# Convert.ToBoolean(Eval("IsActive"))
                                ? "Active"
                                : "Inactive" %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <a href='EditResourceType.aspx?id=<%# Eval("ResourceTypeId") %>'
                            class="btn btn-sm btn-warning">
                            Edit
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</asp:Content>