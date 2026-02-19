<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResourceTypes.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.ManageResourceTypes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <%--Header -->--%>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="page-title">Manage Resource Types</h4>
        <a href="AddResourceType.aspx" class="btn btn-primary">
            + Add Resource Type
        </a>
    </div>

   <%-- Table -->--%>
    <asp:GridView ID="gvResourceTypes" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-bordered table-striped"
        HeaderStyle-CssClass="table-dark"
        OnRowCommand="gvResourceTypes_RowCommand">

        <Columns>

            <asp:BoundField DataField="ResourceTypeId" HeaderText="ID" />

           <asp:BoundField DataField="TypeName" HeaderText="Type Name" />


            <asp:BoundField DataField="Slug" HeaderText="Slug" />

            <%--Edit Button -->--%>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <a href='EditResourceType.aspx?id=<%# Eval("ResourceTypeId") %>'
                       class="btn btn-sm btn-warning">
                        Edit
                    </a>
                </ItemTemplate>
            </asp:TemplateField>

          <%--  Status Toggle --%>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:LinkButton ID="btnToggle" runat="server"
                        CommandName="ToggleStatus"
                        CommandArgument='<%# Eval("ResourceTypeId") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) 
                            ? "badge bg-success text-white p-2" 
                            : "badge bg-danger text-white p-2" %>'>

                        <%# Convert.ToBoolean(Eval("IsActive")) 
                            ? "Active" 
                            : "Inactive" %>

                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</asp:Content>
