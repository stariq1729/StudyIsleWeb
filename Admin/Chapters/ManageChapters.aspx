<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageChapters.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.ManageChapters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="admin-header">

    <div>
        <h4 class="page-title">Manage Chapters</h4>
        <p class="page-subtitle">Manage chapters subject wise</p>
    </div>

    <div>
        <a href="AddChapter.aspx" class="btn btn-primary btn-add">
            + Add Chapter
        </a>

        <a href="AddSets.aspx" class="btn btn-success btn-add ms-2">
            + Add Set
        </a>
    </div>

</div>

<!-- Filters -->

<div class="card admin-card p-3 mb-3">

<div class="row">

<div class="col-md-3">

<label>Filter by Board</label>

<asp:DropDownList ID="ddlBoardFilter" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlBoardFilter_SelectedIndexChanged">
</asp:DropDownList>

</div>

<div class="col-md-3">

<label>Filter by Class</label>

<asp:DropDownList ID="ddlClassFilter" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlClassFilter_SelectedIndexChanged">
</asp:DropDownList>

</div>

<div class="col-md-3">

<label>Filter by Subject</label>

<asp:DropDownList ID="ddlSubjectFilter" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlSubjectFilter_SelectedIndexChanged">
</asp:DropDownList>

</div>

<div class="col-md-3">

<label>Filter by Sets</label>

<asp:DropDownList ID="ddlSetFilter" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlSetFilter_SelectedIndexChanged">
</asp:DropDownList>

</div>

</div>

</div>

<!-- Grid -->

<div class="card admin-card">

<asp:GridView ID="gvChapters" runat="server"
AutoGenerateColumns="False"
CssClass="table table-hover admin-table"
OnRowCommand="gvChapters_RowCommand"
DataKeyNames="ChapterId">

<Columns>

<asp:BoundField DataField="ChapterId" HeaderText="ID" />

<asp:BoundField DataField="BoardName" HeaderText="Board" />

<asp:BoundField DataField="ClassName" HeaderText="Class" />

<asp:BoundField DataField="SubjectName" HeaderText="Subject" />

<asp:BoundField DataField="ChapterName" HeaderText="Chapter" />

<asp:BoundField DataField="SetName" HeaderText="Set" />

<asp:BoundField DataField="DisplayOrder" HeaderText="Order" />

<asp:TemplateField HeaderText="Status">

<ItemTemplate>

<asp:LinkButton ID="btnToggle" runat="server"
CommandName="ToggleActive"
CommandArgument='<%# Eval("ChapterId") %>'
CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge badge-active" : "badge badge-inactive" %>'>

<%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>

</asp:LinkButton>

</ItemTemplate>

</asp:TemplateField>

<asp:TemplateField HeaderText="Action">

<ItemTemplate>

<a href='EditChapter.aspx?id=<%# Eval("ChapterId") %>'
class="btn btn-sm btn-warning">
Edit
</a>

</ItemTemplate>

</asp:TemplateField>

</Columns>

</asp:GridView>

</div>

</asp:Content>