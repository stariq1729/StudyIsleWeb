<%@ Page Title="Add Set" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSets.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.AddSets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .section-header { font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 1px; margin: 20px 0 10px; border-bottom: 1px solid #f1f5f9; padding-bottom: 5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="form-card shadow-sm">
                    <h4 class="fw-bold text-primary mb-4">Add New Set</h4>
                    <asp:Label ID="lblMsg" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <div class="row g-3">
                        <div class="section-header">Step 1: Hierarchy Selection</div>
                        
                        <div class="col-md-4">
                            <label class="form-label fw-bold small">Board (Optional)</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small">Class (Optional)</label>
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small">Year (Optional)</label>
                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="section-header">Step 2: Subject & Content Mapping</div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small">Subject</label>
                            <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged"></asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small">SubCategory (Optional)</label>
                            <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged"></asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small">Chapter (Optional)</label>
                            <asp:DropDownList ID="ddlChapter" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold small">Resource Type (Optional)</label>
                            <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="section-header">Step 3: Set Information</div>

                        <div class="col-md-8">
                            <label class="form-label fw-bold small">Set Name</label>
                            <asp:TextBox ID="txtSetName" runat="server" CssClass="form-control" placeholder="e.g. Set A, Practice Set 1, Mock Test"></asp:TextBox>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small">Display Order</label>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                        </div>

                        <div class="col-12 mt-3">
                            <div class="form-check form-switch p-2 bg-light rounded border">
                                <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label ms-2 fw-bold">Active Status</label>
                            </div>
                        </div>
                    </div>

                    <div class="pt-4 mt-4 border-top">
                        <asp:Button ID="btnSave" runat="server" Text="Save Set" CssClass="btn btn-success px-5 fw-bold" OnClick="btnSave_Click" />
                        <a href="ManageSets.aspx" class="btn btn-outline-secondary ms-2 px-4">Cancel</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>