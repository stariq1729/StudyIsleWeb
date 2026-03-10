<%@ Page Title="Add Subject" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSubject.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.AddSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .form-title { font-weight: 700; color: #334155; margin-bottom: 1.5rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 10px; }
        .section-header { font-size: 0.8rem; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; margin: 20px 0 10px; }
        .upload-info { font-size: 0.75rem; color: #64748b; margin-top: 5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="form-card shadow-sm">
                    <h4 class="form-title">Add New Subject</h4>

                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <div class="row">
                        <div class="section-header">Subject Mapping (Hierarchy)</div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold small text-secondary">1. Select Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select shadow-none"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold small text-secondary">2. Select Class (Optional)</label>
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select shadow-none">
                            </asp:DropDownList>
                            <small class="text-muted">Skip for Competitive/General subjects.</small>
                        </div>

                        <div class="section-header">Basic Subject Details</div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold small text-secondary">Subject Name</label>
                            <asp:TextBox ID="txtSubjectName" runat="server" CssClass="form-control shadow-none" placeholder="e.g. Mathematics"
                                AutoPostBack="true" OnTextChanged="txtSubjectName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold small text-secondary">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control shadow-none bg-light" placeholder="auto-generated-slug"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold small text-secondary">Subject Icon (Image)</label>
                            <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control shadow-none" />
                            <div class="upload-info"><i class="fas fa-info-circle me-1"></i> Use transparent PNG or SVG for best UI results.</div>
                        </div>

                        <div class="section-header">SEO & Landing Page Content</div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold small text-secondary">SEO Page Title (H1)</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control shadow-none" placeholder="e.g. Free Study Material for Class 10 Maths"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold small text-secondary">Short Subtitle</label>
                            <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control shadow-none" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold small text-secondary">Full Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control shadow-none" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>

                        <div class="col-12 mb-4">
                            <div class="form-check form-switch p-2 bg-light rounded border">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label ms-2 fw-bold text-dark">Enable this Subject</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-3 border-top">
                        <asp:Button ID="btnSave" runat="server" Text="Save Subject" CssClass="btn btn-primary px-5 py-2 fw-bold shadow-sm" OnClick="btnSave_Click" />
                        <a href="ManageSubjects.aspx" class="btn btn-light ms-2 border px-4 py-2">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>