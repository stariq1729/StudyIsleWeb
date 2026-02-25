<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubjects.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.ManageSubjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="admin-header">
        <div>
            <h4 class="page-title">Manage Subjects</h4>
            <p class="page-subtitle">Manage subjects board and class wise</p>
        </div>

        <div>
            <a href="AddSubject.aspx" class="btn btn-primary btn-add">
                + Add Subject
            </a>
        </div>
    </div>

    <!-- Filters -->
    <div class="card admin-card p-3 mb-3">
        <div class="row">

            <div class="col-md-4">
                <label>Filter by Board</label>
                <asp:DropDownList ID="ddlBoardFilter" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlBoardFilter_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <div class="col-md-4">
                <label>Filter by Class</label>
                <asp:DropDownList ID="ddlClassFilter" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlClassFilter_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

        </div>
    </div>

    <!-- Grid -->
    <div class="card admin-card">

        <asp:GridView ID="gvSubjects" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-hover admin-table"
            OnRowCommand="gvSubjects_RowCommand"
            DataKeyNames="SubjectId">

            <Columns>

                <asp:BoundField DataField="SubjectId" HeaderText="ID" />

                <asp:BoundField DataField="BoardName" HeaderText="Board" />

                <asp:BoundField DataField="ClassName" HeaderText="Class" />

                <asp:BoundField DataField="SubjectName" HeaderText="Subject" />

                <asp:BoundField DataField="Slug" HeaderText="Slug" />

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnToggle" runat="server"
                            CommandName="ToggleActive"
                            CommandArgument='<%# Eval("SubjectId") %>'
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
                        <a href='EditSubject.aspx?id=<%# Eval("SubjectId") %>'
                            class="btn btn-sm btn-warning">
                            Edit
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</asp:Content>