<%@ Page Title="Add Class" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddClass.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.AddClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .section-divider { font-size: 0.75rem; font-weight: 800; color: #94a3b8; text-transform: uppercase; margin: 25px 0 15px; letter-spacing: 1.2px; display: flex; align-items: center; }
        .section-divider::after { content: ""; flex: 1; height: 1px; background: #e2e8f0; margin-left: 10px; }
        .border-highlight { border-left: 4px solid #6366f1 !important; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="form-card shadow-sm">
                    <h4 class="fw-bold text-dark mb-4">Create New Class</h4>
                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <asp:UpdatePanel ID="upHierarchy" runat="server">
                        <ContentTemplate>
                            <div class="row g-3">
                                <div class="section-divider text-primary">Step 1: Placement Hierarchy</div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold small">1. Select Board</label>
                                    <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select border-highlight shadow-none"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>

                                <asp:PlaceHolder ID="phResourceType" runat="server" Visible="false">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">2. Resource Type (Flow)</label>
                                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select shadow-none"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlResourceType_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </asp:PlaceHolder>

                                <asp:PlaceHolder ID="phSubCategory" runat="server" Visible="false">
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold small">3. Sub-Category (Optional)</label>
                                        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                                        <small class="text-muted">Only select if this class belongs to a specific sub-flow (e.g. PYQs).</small>
                                    </div>
                                </asp:PlaceHolder>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="row g-3 mt-2">
                        <div class="section-divider">Step 2: Class Details</div>
                        
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Class Name</label>
                            <asp:TextBox ID="txtClassName" runat="server" CssClass="form-control" placeholder="e.g. Class 10"
                                AutoPostBack="true" OnTextChanged="txtClassName_TextChanged"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold small">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold small">SEO Page Title (H1)</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control" placeholder="e.g. CBSE Class 10 Study Material"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
    <label class="form-label fw-bold small">Page Subtitle</label>
    <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control" 
        placeholder="e.g. Best study material for CBSE Class 10"></asp:TextBox>
</div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold small">Display Order</label>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control w-25" Text="0" TextMode="Number"></asp:TextBox>
                        </div>

                        <div class="col-12 mt-4">
                            <asp:Button ID="btnSave" runat="server" Text="Save Class" CssClass="btn btn-primary px-5 fw-bold" OnClick="btnSave_Click" />
                            <a href="ManageClasses.aspx" class="btn btn-light border ms-2">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>