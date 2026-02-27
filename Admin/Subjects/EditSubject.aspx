<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditSubject.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.EditSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .form-title { font-weight: 700; color: #334155; margin-bottom: 1.5rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 10px; }
        .section-header { font-size: 0.8rem; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; margin: 20px 0 10px; }
        .current-icon-preview { width: 80px; height: 80px; object-fit: contain; border: 1px solid #dee2e6; padding: 5px; border-radius: 8px; background: #f8f9fa; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="form-card shadow-sm">
                    <h4 class="form-title">Edit Subject</h4>

                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>
                    <asp:HiddenField ID="hfOldImage" runat="server" />

                    <div class="row">
                        <div class="section-header">Subject Mapping</div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Select Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Select Class (Optional)</label>
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="section-header">Basic Details</div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Subject Name</label>
                            <asp:TextBox ID="txtSubjectName" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtSubjectName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold d-block">Subject Icon</label>
                            <div class="d-flex align-items-start border p-3 rounded bg-light">
                                <div class="me-3 text-center">
                                    <asp:Image ID="imgPreview" runat="server" CssClass="current-icon-preview" />
                                    <div class="small text-muted mt-1">Current Icon</div>
                                </div>
                                <div class="flex-grow-1">
                                    <label class="small text-secondary mb-1">Replace Icon (Optional)</label>
                                    <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control" />
                                    <small class="text-muted d-block mt-1">Leave empty to keep the current icon.</small>
                                </div>
                            </div>
                        </div>

                        <div class="section-header">Page Content (SEO)</div>
                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold">Page Header Title</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold">Page Subtitle</label>
                            <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold">General Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>

                        <div class="col-12 mb-4">
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label fw-bold">Is Active</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-3 border-top">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Subject" CssClass="btn btn-success px-4 shadow-sm" OnClick="btnUpdate_Click" />
                        <a href="ManageSubjects.aspx" class="btn btn-light ms-2 border">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>