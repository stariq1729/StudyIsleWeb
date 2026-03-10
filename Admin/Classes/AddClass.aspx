<%@ Page Title="Add Class" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddClass.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.AddClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .form-title { font-weight: 700; color: #0f172a; margin-bottom: 1.5rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 10px; }
        .section-divider { font-size: 0.75rem; font-weight: 800; color: #94a3b8; text-transform: uppercase; margin: 25px 0 15px; letter-spacing: 1.2px; display: flex; align-items: center; }
        .section-divider::after { content: ""; flex: 1; height: 1px; background: #e2e8f0; margin-left: 10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h4 class="form-title mb-0">Add New Class</h4>
                        <span class="badge bg-light text-secondary border">Layer 2 (Optional)</span>
                    </div>
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <div class="row g-3">
                        <div class="section-divider">Hierarchy Mapping</div>
                        
                        <div class="col-md-12 mb-2">
                            <label class="form-label fw-bold text-dark">Assign to Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select shadow-none border-primary-subtle"></asp:DropDownList>
                            <small class="text-muted">Classes are specific to a board (e.g., CBSE Class 10).</small>
                        </div>

                        <div class="section-divider">Class Details</div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold text-dark">Class Name</label>
                            <asp:TextBox ID="txtClassName" runat="server" CssClass="form-control shadow-none" placeholder="e.g. Class 12"
                                AutoPostBack="true" OnTextChanged="txtClassName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold text-dark">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light shadow-none" placeholder="auto-generated"></asp:TextBox>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold text-dark">Display Order</label>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control shadow-none" Text="0" TextMode="Number"></asp:TextBox>
                        </div>

                        <div class="section-divider">SEO & UI Content</div>

                        <div class="col-12">
                            <label class="form-label fw-bold text-dark">Page Heading (H1)</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control shadow-none" placeholder="e.g. NCERT Solutions for Class 12"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold text-dark">Page Description</label>
                            <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control shadow-none" TextMode="MultiLine" Rows="2" 
                                placeholder="Briefly describe the content available for this class..."></asp:TextBox>
                        </div>

                        <div class="col-12 py-2">
                            <div class="form-check form-switch p-3 bg-light rounded border">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label ms-2 fw-bold text-primary">Enable this Class in navigation</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-4 mt-3 border-top d-flex gap-2">
                        <asp:Button ID="btnSave" runat="server" Text="Create Class" CssClass="btn btn-primary px-5 shadow-sm py-2 fw-bold" OnClick="btnSave_Click" />
                        <a href="ManageClasses.aspx" class="btn btn-outline-secondary px-4 py-2">Back to List</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>