<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBoards.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.ManageBoards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="page-title">Manage Boards</h4>
        <a href="AddBoard.aspx" class="btn btn-primary btn-add">+ Add Board</a>
    </div>

    <asp:GridView ID="gvBoards" runat="server" 
        AutoGenerateColumns="False" 
        CssClass="table table-bordered"
        OnRowCommand="gvBoards_RowCommand">

        <Columns>

            <asp:BoundField DataField="BoardId" HeaderText="ID" />

            <asp:BoundField DataField="BoardName" HeaderText="Board Name" />

            <asp:BoundField DataField="HasClassLayer" HeaderText="Has Class Layer" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:LinkButton ID="btnToggle" runat="server"
                        CommandName="ToggleActive"
                        CommandArgument='<%# Eval("BoardId") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge badge-active text-white p-2" : "badge badge-inactive text-white p-2" %>'>
                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>
</asp:Content>
