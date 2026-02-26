<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBoards.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.ManageBoards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="admin-header d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="page-title">Manage Boards</h4>
            <p class="page-subtitle text-muted">Create and manage education boards and their SEO content</p>
        </div>
        <a href="AddBoards.aspx" class="btn btn-primary">+ Add New Board</a>
    </div>

    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <div class="row align-items-end">
                <div class="col-md-4">
                    <label class="form-label font-weight-bold">Search Board</label>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Type board name..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-secondary w-100" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="card admin-card shadow-sm">
        <asp:GridView ID="gvBoards" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-hover admin-table mb-0"
            OnRowCommand="gvBoards_RowCommand"
            DataKeyNames="BoardId" 
            GridLines="None">

            <Columns>
                <asp:BoundField DataField="BoardId" HeaderText="ID" />
                <asp:BoundField DataField="BoardName" HeaderText="Board Name" />
                
                <%-- Added Hero Title for quick preview --%>
                <asp:TemplateField HeaderText="Hero Title">
                    <ItemTemplate>
                        <span class="text-truncate d-inline-block" style="max-width: 150px;" title='<%# Eval("HeroTitle") %>'>
                            <%# Eval("HeroTitle") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Slug" HeaderText="Slug" />

                <%-- Fixed Badge Visibility: Using Bootstrap contextual classes --%>
                <asp:TemplateField HeaderText="Has Class">
                    <ItemTemplate>
                        <span class='<%# Convert.ToBoolean(Eval("HasClassLayer")) ? "badge bg-info text-dark" : "badge bg-light text-muted border" %>'>
                            <%# Convert.ToBoolean(Eval("HasClassLayer")) ? "Yes" : "No" %>
                        </span>
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
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success text-white" : "badge bg-danger text-white" %>'
                            style="text-decoration:none;">
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <a href='EditBoard.aspx?id=<%# Eval("BoardId") %>' class="btn btn-sm btn-outline-warning">
                            <i class="fas fa-edit"></i> Edit Content
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div class="p-4 text-center text-muted">No boards found matching your search.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>