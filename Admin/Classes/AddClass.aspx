<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddClass.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.AddClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .form-title { font-weight: 700; color: #334155; margin-bottom: 1.5rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 10px; }
        .section-divider { font-size: 0.85rem; font-weight: 700; color: #64748b; text-transform: uppercase; margin: 20px 0 10px; letter-spacing: 1px; }
        /* Fix for checkbox alignment in Bootstrap 5 */
        .form-check-input { cursor: pointer; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card shadow-sm">
                    <h4 class="form-title">Add New Class</h4>

                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

                    <div class="row">
                        <div class="section-divider">Basic Configuration</div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold text-secondary">Select Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold text-secondary">Class Name</label>
                            <asp:TextBox ID="txtClassName" runat="server" CssClass="form-control" placeholder="e.g. Class 10"
                                AutoPostBack="true" OnTextChanged="txtClassName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold text-secondary">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" placeholder="auto-generated-slug"></asp:TextBox>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold text-secondary">Display Order</label>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                        </div>

                        <div class="section-divider">Page Content (UI)</div>

                        <div class="col-12 mb-3">
                            <label class="form-label fw-bold text-secondary">Page Header Title</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control" placeholder="e.g. CBSE Books for Class 10 - Free Access"></asp:TextBox>
                        </div>

                        <div class="col-12 mb-3">
                            <label class="form-label fw-bold text-secondary">Page Subtitle Description</label>
                            <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" 
                                placeholder="Full digital textbooks for all subjects and classes..."></asp:TextBox>
                        </div>

                        <div class="col-12 mb-4">
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label ms-2 fw-bold">Publish this Class</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-3 border-top">
                        <asp:Button ID="btnSave" runat="server" Text="Save Class" CssClass="btn btn-primary px-4 shadow-sm" OnClick="btnSave_Click" />
                        <a href="ManageClasses.aspx" class="btn btn-light ms-2 border">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>