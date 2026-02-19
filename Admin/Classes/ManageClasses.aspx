<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageClasses.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.ManageClasses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="page-title">Manage Classes</h4>
        <a href="AddClass.aspx" class="btn btn-primary">+ Add Class</a>
    </div>

    <asp:GridView ID="gvClasses" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-bordered table-striped"
        HeaderStyle-CssClass="table-dark"
        OnRowCommand="gvClasses_RowCommand">

        <Columns>

            <asp:BoundField DataField="ClassId" HeaderText="ID" />

            <asp:BoundField DataField="BoardName" HeaderText="Board" />

            <asp:BoundField DataField="ClassName" HeaderText="Class Name" />

            <asp:BoundField DataField="DisplayOrder" HeaderText="Order" />
            <asp:TemplateField HeaderText="Action">
    <ItemTemplate>
        <a href='EditClass.aspx?id=<%# Eval("ClassId") %>' 
           class="btn btn-sm btn-warning">
           Edit
        </a>
    </ItemTemplate>
</asp:TemplateField>


            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:LinkButton ID="btnToggle" runat="server"
                        CommandName="ToggleActive"
                        CommandArgument='<%# Eval("ClassId") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success text-white p-2" : "badge bg-danger text-white p-2" %>'>
                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>
</asp:Content>
