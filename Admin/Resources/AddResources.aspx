<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddResources.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.AddResources" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-3">Add Resource</h4>

<asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

<div class="card p-4 shadow-sm">

<%--     Board -->--%>
    <div class="mb-3">
        <label>Board</label>
        <asp:DropDownList ID="ddlBoard" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" />
    </div>

     <%--Resource Type -->--%>
    <div class="mb-3">
        <label>Resource Type</label>
        <asp:DropDownList ID="ddlResourceType" runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlResourceType_SelectedIndexChanged" />
    </div>

    <%-- Class -->--%>
    <asp:Panel ID="pnlClass" runat="server" Visible="false">
        <div class="mb-3">
            <label>Class</label>
            <asp:DropDownList ID="ddlClass" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" />
        </div>
    </asp:Panel>

    <%--Subject -->--%>
    <asp:Panel ID="pnlSubject" runat="server" Visible="false">
        <div class="mb-3">
            <label>Subject</label>
            <asp:DropDownList ID="ddlSubject" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged" />
        </div>
    </asp:Panel>

    <%--!-- Chapter -->--%>
    <asp:Panel ID="pnlChapter" runat="server" Visible="false">
        <div class="mb-3">
            <label>Chapter</label>
            <asp:DropDownList ID="ddlChapter" runat="server"
                CssClass="form-control" />
        </div>
    </asp:Panel>

  <%--  <-- Year -->--%>
    <asp:Panel ID="pnlYear" runat="server" Visible="false">
        <div class="mb-3">
            <label>Year</label>
            <asp:DropDownList ID="ddlYear" runat="server"
                CssClass="form-control" />

            <asp:TextBox ID="txtNewYear" runat="server"
                CssClass="form-control mt-2"
                Placeholder="Add new year" />

            <asp:Button ID="btnAddYear" runat="server"
                Text="Add Year"
                CssClass="btn btn-sm btn-secondary mt-2"
                OnClick="btnAddYear_Click" />
        </div>
    </asp:Panel>

<%--    <!- SubCategory -->--%>
    <asp:Panel ID="pnlSubCategory" runat="server" Visible="false">
        <div class="mb-3">
            <label>SubCategory</label>
            <asp:DropDownList ID="ddlSubCategory" runat="server"
                CssClass="form-control" />

            <asp:TextBox ID="txtNewSubCategory" runat="server"
                CssClass="form-control mt-2"
                Placeholder="Add new subcategory" />

            <asp:Button ID="btnAddSubCategory" runat="server"
                Text="Add SubCategory"
                CssClass="btn btn-sm btn-secondary mt-2"
                OnClick="btnAddSubCategory_Click" />
        </div>
    </asp:Panel>

  <%--  <!- Title -->--%>
    <div class="mb-3">
        <label>Title</label>
        <asp:TextBox ID="txtTitle" runat="server"
            CssClass="form-control" />
    </div>

   <%-- <-- Description -->--%>
    <div class="mb-3">
        <label>Description</label>
        <asp:TextBox ID="txtDescription" runat="server"
            CssClass="form-control"
            TextMode="MultiLine"
            Rows="4" />
    </div>

    <%--!-- File -->--%>
    <div class="mb-3">
        <label>Upload File</label>
        <asp:FileUpload ID="fuFile" runat="server"
            CssClass="form-control" />
    </div>
<%-- !-- Pre
   mium -->--%>
    <div class="form-check mb-3">
        <asp:CheckBox ID="chkIsPremium"
            runat="server"
            CssClass="form-check-input" />
        <label class="form-check-label">Is Premium</label>
    </div>

    <asp:Button ID="btnSave" runat="server"
        Text="Save Resource"
        CssClass="btn btn-success"
        OnClick="btnSave_Click" />

</div>

</asp:Content>