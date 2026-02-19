<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubjects.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.ManageSubjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="page-title">Manage Subjects</h4>
        <a href="AddSubject.aspx" class="btn btn-primary">+ Add Subject</a>
    </div>

    <asp:GridView ID="gvSubjects" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-bordered table-striped"
        HeaderStyle-CssClass="table-dark"
        OnRowCommand="gvSubjects_RowCommand">

        <Columns>

            <asp:BoundField DataField="SubjectId" HeaderText="ID" />

            <asp:BoundField DataField="BoardName" HeaderText="Board" />

            <asp:BoundField DataField="ClassName" HeaderText="Class" />

            <asp:BoundField DataField="SubjectName" HeaderText="Subject" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:LinkButton ID="btnToggle" runat="server"
                        CommandName="ToggleActive"
                        CommandArgument='<%# Eval("SubjectId") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success text-white p-2" : "badge bg-danger text-white p-2" %>'>
                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>
</asp:Content>
