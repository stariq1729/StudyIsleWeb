<%@ Page Title="Add Resource" Language="C#" MasterPageFile="~/Admin/Admin.Master"
AutoEventWireup="true" CodeBehind="AddResources.aspx.cs"
Inherits="StudyIsleWeb.Admin.Resources.AddResources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card shadow-sm p-4">

<h4 class="mb-4 text-primary">Add Resource</h4>

<asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

<!-- Board -->

<div class="mb-3">
<label class="form-label">Board</label>
<asp:DropDownList ID="ddlBoard" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
</asp:DropDownList>
</div>

<!-- Resource Type -->

<div class="mb-3">
<label class="form-label">Resource Type</label>
<asp:DropDownList ID="ddlResourceType" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlResourceType_SelectedIndexChanged">
</asp:DropDownList>
</div>

<!-- SubCategory -->

<asp:Panel ID="pnlSubCategory" runat="server" Visible="false">

<div class="mb-3">
<label class="form-label">SubCategory</label>

<asp:DropDownList ID="ddlSubCategory" runat="server"
CssClass="form-control">
</asp:DropDownList>

<div class="mt-2 d-flex gap-2">

<asp:TextBox ID="txtNewSubCategory"
runat="server"
CssClass="form-control"
Placeholder="Add new subcategory">
</asp:TextBox>

<asp:Button ID="btnAddSubCategory"
runat="server"
Text="Add"
CssClass="btn btn-outline-secondary"
OnClick="btnAddSubCategory_Click">
</asp:Button>

</div>

</div>

</asp:Panel>

<!-- Class -->

<asp:Panel ID="pnlClass" runat="server" Visible="false">

<div class="mb-3">
<label class="form-label">Class</label>

<asp:DropDownList ID="ddlClass" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
</asp:DropDownList>

</div>

</asp:Panel>

<!-- Subject -->

<asp:Panel ID="pnlSubject" runat="server" Visible="false">

<div class="mb-3">
<label class="form-label">Subject</label>

<asp:DropDownList ID="ddlSubject" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged">
</asp:DropDownList>

</div>

</asp:Panel>

<!-- Chapter -->

<asp:Panel ID="pnlChapter" runat="server" Visible="false">

<div class="mb-3">
<label class="form-label">Chapter</label>

<asp:DropDownList ID="ddlChapter" runat="server"
CssClass="form-control">
</asp:DropDownList>

</div>

</asp:Panel>

    <!-- SET -->
<asp:Panel ID="pnlSet" runat="server" Visible="false">

    <div class="mb-3">
        <label class="form-label">Set</label>

        <asp:DropDownList ID="ddlSet"
            runat="server"
            CssClass="form-control"
            AutoPostBack="true">
        </asp:DropDownList>

    </div>

</asp:Panel>
<!-- Year -->

<asp:Panel ID="pnlYear" runat="server" Visible="false">

<div class="mb-3">
<label class="form-label">Year</label>

<asp:DropDownList ID="ddlYear" runat="server"
CssClass="form-control">
</asp:DropDownList>

<div class="mt-2 d-flex gap-2">

<asp:TextBox ID="txtNewYear"
runat="server"
CssClass="form-control"
Placeholder="Add new year">
</asp:TextBox>

<asp:Button ID="btnAddYear"
runat="server"
Text="Add"
CssClass="btn btn-outline-secondary"
OnClick="btnAddYear_Click">
</asp:Button>

</div>

</div>

</asp:Panel>

<!-- Title -->

<div class="mb-3">

<label class="form-label">Title</label>

<asp:TextBox ID="txtTitle" runat="server"
CssClass="form-control">
</asp:TextBox>

</div>

<!-- Description -->

<div class="mb-3">

<label class="form-label">Description</label>

<asp:TextBox ID="txtDescription" runat="server"
CssClass="form-control"
TextMode="MultiLine"
Rows="4">
</asp:TextBox>

</div>

<!-- File Upload -->

<div class="mb-3">

<label class="form-label">Upload File</label>

<asp:FileUpload ID="fuFile" runat="server"
CssClass="form-control">
</asp:FileUpload>

</div>

<!-- Premium -->

<div class="form-check mb-3">

<asp:CheckBox ID="chkIsPremium"
runat="server"
CssClass="form-check-input">
</asp:CheckBox>

<label class="form-check-label">Premium Resource</label>

</div>

<!-- Save Button -->

<asp:Button ID="btnSave"
runat="server"
Text="Save Resource"
CssClass="btn btn-success"
OnClick="btnSave_Click">
</asp:Button>

</div>

</asp:Content>