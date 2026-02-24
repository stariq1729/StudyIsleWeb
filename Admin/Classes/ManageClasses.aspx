<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageClasses.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.ManageClasses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="admin-header">
        <div>
            <h4 class="page-title">Manage Classes</h4>
            <p class="page-subtitle">Manage classes board-wise</p>
        </div>

        <div>
            <a href="AddClass.aspx" class="btn btn-primary btn-add">
                + Add Class
            </a>
        </div>
    </div>

    <!-- Board Filter -->
    <div class="card admin-card mb-3 p-3">
        <div class="row">
            <div class="col-md-4">
                <label>Select Board</label>
                <asp:DropDownList ID="ddlBoardFilter" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlBoardFilter_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
    </div>

    <!-- Grid -->
    <div class="card admin-card">

        <asp:GridView ID="gvClasses" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-hover admin-table"
            OnRowCommand="gvClasses_RowCommand"
            DataKeyNames="ClassId">

            <Columns>

                <asp:BoundField DataField="ClassId" HeaderText="ID" />

                <asp:BoundField DataField="BoardName" HeaderText="Board" />

                <asp:BoundField DataField="ClassName" HeaderText="Class Name" />

                <asp:BoundField DataField="Slug" HeaderText="Slug" />

                <asp:BoundField DataField="DisplayOrder" HeaderText="Order" />

                <asp:TemplateField HeaderText="Created">
                    <ItemTemplate>
                        <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnToggle" runat="server"
                            CommandName="ToggleActive"
                            CommandArgument='<%# Eval("ClassId") %>'
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
                        <a href='EditClass.aspx?id=<%# Eval("ClassId") %>'
                            class="btn btn-sm btn-warning">
                            Edit
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</asp:Content>