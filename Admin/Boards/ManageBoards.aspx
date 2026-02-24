<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBoards.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.ManageBoards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="admin-header">
        <div>
            <h4 class="page-title">Manage Boards</h4>
            <p class="page-subtitle">Create and manage education boards</p>
        </div>

        <div>
            <a href="AddBoards.aspx" class="btn btn-primary btn-add">
                + Add Board
            </a>
        </div>
    </div>

    <div class="card admin-card">

        <asp:GridView ID="gvBoards" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-hover admin-table"
            OnRowCommand="gvBoards_RowCommand"
            DataKeyNames="BoardId">

            <Columns>

                <asp:BoundField DataField="BoardId" HeaderText="ID" />

                <asp:BoundField DataField="BoardName" HeaderText="Board Name" />

                <asp:BoundField DataField="Slug" HeaderText="Slug" />

                <asp:TemplateField HeaderText="Has Class">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("HasClassLayer")) 
                            ? "<span class='badge badge-info'>Yes</span>" 
                            : "<span class='badge badge-secondary'>No</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Created">
                    <ItemTemplate>
                        <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnToggle" runat="server"
                            CommandName="ToggleActive"
                            CommandArgument='<%# Eval("BoardId") %>'
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
                        <a href='EditBoard.aspx?id=<%# Eval("BoardId") %>'
                            class="btn btn-sm btn-warning me-2">
                            Edit
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</asp:Content>
