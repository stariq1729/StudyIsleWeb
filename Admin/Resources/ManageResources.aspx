<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResources.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.ManageResources" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- Header -->--%>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="page-title">Manage Resources</h4>
        <a href="AddResource.aspx" class="btn btn-primary">
            + Add Resource
        </a>
    </div>

   <%-- Table -->--%>
    <asp:GridView ID="gvResources" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-bordered table-striped"
        HeaderStyle-CssClass="table-dark"
        OnRowCommand="gvResources_RowCommand">

        <Columns>

            <asp:BoundField DataField="ResourceId" HeaderText="ID" />

            <asp:BoundField DataField="BoardName" HeaderText="Board" />

            <asp:BoundField DataField="ClassName" HeaderText="Class" />

            <asp:BoundField DataField="SubjectName" HeaderText="Subject" />

            <asp:BoundField DataField="TypeName" HeaderText="Type" />

            <asp:BoundField DataField="Title" HeaderText="Title" />

     <%--  Premium -->--%>
    <%--        <asp:TemplateField HeaderText="Premium">
                <ItemTemplate>
                    <span class='<%# Convert.ToBoolean(Eval("IsPremium")) 
                        ? "badge bg-warning text-dark p-2" 
                        : "badge bg-secondary text-white p-2" %>'>
                        <%# Convert.ToBoolean(Eval("IsPremium")) 
                        ? "Premium" 
                        : "Free" %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>--%>

           <%-- Status -->--%>
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:LinkButton ID="btnToggle" runat="server"
                        CommandName="ToggleActive"
                        CommandArgument='<%# Eval("ResourceId") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) 
                            ? "badge bg-success text-white p-2" 
                            : "badge bg-danger text-white p-2" %>'>

                        <%# Convert.ToBoolean(Eval("IsActive")) 
                            ? "Active" 
                            : "Inactive" %>

                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

          <%--  Edit -->--%>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <a href='EditResource.aspx?id=<%# Eval("ResourceId") %>'
                       class="btn btn-sm btn-warning">
                        Edit
                    </a>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>
</asp:Content>
