<%@ Page Title="Edit Resource" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResource.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.EditResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3 border-bottom">
                <h4 class="mb-0 fw-bold text-success">Edit Resource</h4>
                <p class="text-muted small mb-0">Modify details for the existing resource. Optional fields can be left as "-- Optional --".</p>
            </div>
            
            <div class="card-body p-4">
                <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>
                <asp:HiddenField ID="hfResourceId" runat="server" />

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Board / Category <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-bold">Resource Type <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlResourceType_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label fw-bold">Sub-Category</label>
                        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Class</label>
                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small fw-bold">Subject</label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Year</label>
                        <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Chapter</label>
                        <asp:DropDownList ID="ddlChapter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlChapter_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Set / Paper</label>
                        <asp:DropDownList ID="ddlSet" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>

                    <div class="col-12 mt-4">
                        <label class="form-label fw-bold small">Resource Title <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter title"></asp:TextBox>
                    </div>

                    <div class="col-md-8">
                        <label class="form-label fw-bold small">Replace File (Optional)</label>
                        <asp:FileUpload ID="fuFile" runat="server" CssClass="form-control" />
                        <small class="text-muted">Leave empty to keep the existing file.</small>
                    </div>

                    <div class="col-md-4 d-flex align-items-end">
                        <div class="form-check form-switch mb-2">
                            <asp:CheckBox ID="chkIsPremium" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label ms-2 fw-bold small">Premium Content</label>
                        </div>
                    </div>

                    <div class="col-12 pt-3 border-top mt-4">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Resource" CssClass="btn btn-success px-5 fw-bold" OnClick="btnUpdate_Click" />
                        <a href="ManageResources.aspx" class="btn btn-light px-4 ms-2">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>