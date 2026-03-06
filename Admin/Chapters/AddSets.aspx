<%@ Page Title="Add Set" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSets.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.AddSets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="form-card p-4 shadow-sm">

<h4 class="text-primary mb-4">Add Set</h4>

<asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>

<div class="row">

<div class="col-md-6">

<label>Board (Optional)</label>
<asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>

</div>

<div class="col-md-6">

<label>Resource Type (Optional)</label>
<asp:DropDownList ID="ddlResourceType" runat="server"
CssClass="form-control"></asp:DropDownList>

</div>

</div>


<div class="row mt-3">

<div class="col-md-6">

<label>Class (Optional)</label>
<asp:DropDownList ID="ddlClass" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>

</div>

<div class="col-md-6">

<label>Subject (Optional)</label>
<asp:DropDownList ID="ddlSubject" runat="server"
CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged"></asp:DropDownList>

</div>

</div>


<div class="row mt-3">

<div class="col-md-6">

<label>SubCategory (Optional)</label>
<asp:DropDownList ID="ddlSubCategory" runat="server"
CssClass="form-control"></asp:DropDownList>

</div>

<div class="col-md-6">

<label>Chapter (Optional)</label>
<asp:DropDownList ID="ddlChapter" runat="server"
CssClass="form-control"></asp:DropDownList>

</div>

</div>


<div class="row mt-3">

<div class="col-md-6">

<label>Year (Optional)</label>
<asp:DropDownList ID="ddlYear" runat="server"
CssClass="form-control"></asp:DropDownList>

</div>

</div>


<div class="mt-3">

<label>Set Name</label>
<asp:TextBox ID="txtSetName" runat="server"
CssClass="form-control"></asp:TextBox>

</div>


<div class="mt-3">

<label>Display Order</label>
<asp:TextBox ID="txtDisplayOrder" runat="server"
CssClass="form-control"
Text="0"></asp:TextBox>

</div>


<div class="form-check mt-3">

<asp:CheckBox ID="chkActive" runat="server" Checked="true"/>
<label>Is Active</label>

</div>

<br />

<asp:Button ID="btnSave" runat="server"
Text="Save Set"
CssClass="btn btn-success"
OnClick="btnSave_Click"/>

</div>

</asp:Content>