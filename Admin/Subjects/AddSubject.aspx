<%@ Page Title="Add Subject" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSubject.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.AddSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .form-title { font-weight: 700; color: #334155; margin-bottom: 1.5rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 10px; }
        .section-header { font-size: 0.8rem; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; margin: 20px 0 10px; }
        .upload-info { font-size: 0.75rem; color: #64748b; margin-top: 5px; }
        .border-highlight { border-left: 4px solid #6366f1 !important; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="form-card shadow-sm bg-white p-4 rounded-3">
                    <h4 class="form-title mb-4">Post New Subject</h4>
                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <asp:UpdatePanel ID="upHierarchy" runat="server">
                        <ContentTemplate>
                            <div class="row g-3">
                                <div class="section-header text-primary">Step 1: Placement Hierarchy</div>
                                
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small">1. Target Board</label>
                                    <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select shadow-none border-highlight"
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
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">3. Sub-Category (Optional)</label>
                                        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                                    </div>
                                </asp:PlaceHolder>

                                <asp:PlaceHolder ID="phClass" runat="server" Visible="false">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">4. Target Class (Optional)</label>
                                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                                    </div>
                                </asp:PlaceHolder>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <hr class="my-4" />

                    <div class="row g-3">
                        <div class="section-header">Step 2: Subject Identity</div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Subject Name</label>
                            <asp:TextBox ID="txtSubjectName" runat="server" CssClass="form-control" placeholder="e.g. Organic Chemistry"
                                AutoPostBack="true" OnTextChanged="txtSubjectName_TextChanged"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small">Subject Icon</label>
                            <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control" />
                        </div>

                        <div class="section-header">Step 3: SEO Content</div>
                        <div class="col-12">
                            <label class="form-label fw-bold small">SEO Title (H1)</label>
                            <asp:TextBox ID="txtPageTitle" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-12">
    <label class="form-label fw-bold small">Page Subtitle</label>
    <asp:TextBox ID="txtPageSubtitle" runat="server" CssClass="form-control"
        placeholder="e.g. Complete Organic Chemistry Notes for Class 12"></asp:TextBox>
</div>
                        <div class="col-12">
    <label class="form-label fw-bold small">Edition</label>
    <asp:TextBox ID="txtEdition" runat="server" CssClass="form-control"
        placeholder="e.g. 2025 Edition / Revised Edition"></asp:TextBox>
</div>
                        <div class="col-12">
                            <label class="form-label fw-bold small">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-12 mt-4">
                            <asp:Button ID="btnSave" runat="server" Text="Publish Subject" CssClass="btn btn-primary px-5 fw-bold" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>