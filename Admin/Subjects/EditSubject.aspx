<%@ Page Title="Edit Subject" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditSubject.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.EditSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .edit-card { background: #fff; padding: 2.5rem; border-radius: 15px; border: 1px solid #e2e8f0; }
        .current-icon { width: 60px; height: 60px; object-fit: contain; padding: 5px; border: 1px solid #e2e8f0; border-radius: 8px; background: #f8fafc; }
        .section-header { font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 1.5px; margin: 30px 0 15px; display: flex; align-items: center; }
        .section-header::after { content: ""; flex: 1; height: 1px; background: #cbd5e1; margin-left: 15px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="edit-card shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold text-dark mb-0">Edit Subject</h4>
                        <asp:Label ID="lblSubjectID" runat="server" CssClass="badge bg-dark px-3 py-2"></asp:Label>
                    </div>

                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>
                    <asp:HiddenField ID="hfSubjectID" runat="server" />

                    <div class="row g-4">
                        <div class="section-header">Hierarchy & Identification</div>
                        
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select shadow-none" 
                                AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Class (Optional)</label>
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select shadow-none">
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Subject Name</label>
                            <asp:TextBox ID="txtSubjectName" runat="server" CssClass="form-control shadow-none" 
                                AutoPostBack="true" OnTextChanged="txtSubjectName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold small">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light shadow-none"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold small">Subject Icon</label>
                            <div class="d-flex align-items-center gap-3 p-3 border rounded bg-light">
                                <asp:Image ID="imgCurrentIcon" runat="server" CssClass="current-icon" />
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control form-control-sm" />
                                    <small class="text-muted">Leave empty to keep the current icon.</small>
                                </div>
                            </div>
                        </div>

                        <div class="section-header">SEO & Visibility</div>

                        <div class="col-12">
                            <label class="form-label fw-bold small">Page Title (H1)</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control shadow-none"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold small">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control shadow-none" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <div class="form-check form-switch p-2 bg-light rounded border">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label ms-2 fw-bold">Active Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-4 mt-4 border-top d-flex gap-2">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Subject" CssClass="btn btn-primary px-5 fw-bold" OnClick="btnUpdate_Click" />
                        <a href="ManageSubjects.aspx" class="btn btn-outline-secondary px-4">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>