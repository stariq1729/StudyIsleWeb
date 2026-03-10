<%@ Page Title="Edit Class" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditClass.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.EditClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .edit-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #e2e8f0; }
        .section-label { font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; margin-bottom: 15px; display: block; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="edit-card shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold text-dark mb-0">Edit Class Details</h4>
                        <asp:Label ID="lblClassID" runat="server" CssClass="badge bg-dark px-3"></asp:Label>
                    </div>

                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>
                    <asp:HiddenField ID="hfClassID" runat="server" />

                    <div class="row g-3">
                        <span class="section-label">Hierarchy & Basic Info</span>
                        
                        <div class="col-md-12">
                            <label class="form-label fw-bold small">Parent Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Class Name</label>
                            <asp:TextBox ID="txtClassName" runat="server" CssClass="form-control shadow-none" 
                                AutoPostBack="true" OnTextChanged="txtClassName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold small">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light shadow-none"></asp:TextBox>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold small">Display Order</label>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control shadow-none" TextMode="Number"></asp:TextBox>
                        </div>

                        <span class="section-label border-top pt-3">SEO & Landing Page Content</span>

                        <div class="col-12">
                            <label class="form-label fw-bold small">Page Title (H1 Tag)</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control shadow-none" placeholder="SEO optimized title"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold small">Page Description</label>
                            <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control shadow-none" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>

                        <div class="col-12 py-2">
                            <div class="form-check form-switch p-3 bg-light rounded border">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label ms-2 fw-bold">Keep this class active and visible</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-4 mt-3 border-top d-flex gap-2">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Class" CssClass="btn btn-success px-5 py-2 fw-bold shadow-sm" OnClick="btnUpdate_Click" />
                        <a href="ManageClasses.aspx" class="btn btn-outline-secondary px-4 py-2">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>