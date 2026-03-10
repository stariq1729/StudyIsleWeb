<%@ Page Title="Manage Boards" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBoards.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.ManageBoards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <div class="card shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">Manage Boards</h4>
                <a href="AddBoards.aspx" class="btn btn-success btn-sm">+ Add New Board</a>
            </div>
            
            <div class="card-body">
                <div class="row mb-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Filter by Type:</label>
                        <asp:DropDownList ID="ddlFilterType" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterType_SelectedIndexChanged">
                            <asp:ListItem Text="All Boards" Value="All"></asp:ListItem>
                            <asp:ListItem Text="Standard (CBSE/ICSE)" Value="Standard"></asp:ListItem>
                            <asp:ListItem Text="Competitive (JEE/NEET)" Value="Competitive"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <asp:Label ID="lblStatus" runat="server" CssClass="text-success"></asp:Label>
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvBoards" runat="server" AutoGenerateColumns="False" DataKeyNames="BoardId" 
                        CssClass="table table-hover table-bordered" OnRowDeleting="gvBoards_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="BoardId" HeaderText="ID" ReadOnly="True" />
                            <asp:BoundField DataField="BoardName" HeaderText="Board Name" />
                            <asp:BoundField DataField="Slug" HeaderText="Slug" />
                            
                            <asp:TemplateField HeaderText="Type">
    <ItemTemplate>
        <%# (Eval("IsCompetitive") != DBNull.Value && Convert.ToBoolean(Eval("IsCompetitive"))) ? 
            "<span class='badge bg-warning text-dark'>Competitive</span>" : 
            "<span class='badge bg-info text-white'>Standard</span>" %>
    </ItemTemplate>
</asp:TemplateField>

                            <asp:TemplateField HeaderText="Active">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("IsActive") %>' Enabled="false" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <a href='EditBoard.aspx?id=<%# Eval("BoardId") %>' class="btn btn-sm btn-outline-primary">Edit</a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                        OnClientClick="return confirm('Are you sure you want to delete this board?');" 
                                        CssClass="btn btn-sm btn-outline-danger">Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center p-4">No boards found matching your criteria.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

</asp:Content>