<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResource.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.EditResource" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="page-title">Edit Resource</h4>
    <a href="ManageResources.aspx" class="btn btn-secondary">
        ← Back to Resources
    </a>
</div>

<asp:HiddenField ID="hfResourceId" runat="server" />

<div class="card shadow-sm">
    <div class="card-body">

        <div class="row g-3">

            <!-- Board -->
            <div class="col-md-6">
                <label class="form-label">Board</label>
                <asp:DropDownList ID="ddlBoard" runat="server"
                    CssClass="form-select" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <!-- Class -->
            <div class="col-md-6">
                <label class="form-label">Class</label>
                <asp:DropDownList ID="ddlClass" runat="server"
                    CssClass="form-select" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <!-- Subject -->
            <div class="col-md-6">
                <label class="form-label">Subject</label>
                <asp:DropDownList ID="ddlSubject" runat="server"
                    CssClass="form-select">
                </asp:DropDownList>
            </div>

            <!-- Resource Type -->
            <div class="col-md-6">
                <label class="form-label">Resource Type</label>
                <asp:DropDownList ID="ddlType" runat="server"
                    CssClass="form-select">
                </asp:DropDownList>
            </div>

            <!-- Title -->
            <div class="col-md-12">
                <label class="form-label">Title</label>
                <asp:TextBox ID="txtTitle" runat="server"
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <!-- Description -->
            <div class="col-md-12">
                <label class="form-label">Description</label>
                <asp:TextBox ID="txtDescription" runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine" Rows="4">
                </asp:TextBox>
            </div>

            <!-- Current File -->
            <div class="col-md-12">
                <label class="form-label">Current File</label>
                <asp:HyperLink ID="lnkCurrentFile" runat="server"
                    CssClass="text-decoration-none"
                    Target="_blank">
                </asp:HyperLink>
            </div>

            <!-- Replace File -->
            <div class="col-md-12">
                <label class="form-label">Replace File (Optional)</label>
                <asp:FileUpload ID="fuFile" runat="server"
                    CssClass="form-control" />
            </div>

            <!-- Premium -->
            <div class="col-md-6">
                <div class="form-check mt-3">
                    <asp:CheckBox ID="chkPremium" runat="server"
                        CssClass="form-check-input" />
                    <label class="form-check-label">
                        Premium Resource
                    </label>
                </div>
            </div>

            <!-- Active -->
            <div class="col-md-6">
                <div class="form-check mt-3">
                    <asp:CheckBox ID="chkActive" runat="server"
                        CssClass="form-check-input" />
                    <label class="form-check-label">
                        Active
                    </label>
                </div>
            </div>

            <!-- Save -->
            <div class="col-12 text-end">
                <asp:Button ID="btnUpdate" runat="server"
                    Text="Update Resource"
                    CssClass="btn btn-primary"
                    OnClick="btnUpdate_Click" />
            </div>

        </div>
    </div>
</div>
</asp:Content>
