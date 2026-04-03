<%@ Page Title="Manage Year Mappings" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddYear.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.AddYear" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; border: 1px solid #eef0f2; }
        .section-header { font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 1px; margin: 20px 0 10px; border-bottom: 1px solid #f1f5f9; padding-bottom: 5px; }
        .badge-year { background: #e0e7ff; color: #4338ca; padding: 5px 12px; border-radius: 20px; font-weight: 600; font-size: 0.85rem; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row">
            <div class="col-lg-8">
                <div class="form-card shadow-sm">
                    <h4 class="fw-bold text-primary mb-4">Link Year to Course Flow</h4>
                    <asp:Label ID="lblMsg" runat="server" CssClass="d-block mb-3"></asp:Label>

                    <div class="row g-3">
                        <div class="section-header">Step 1: Select Year & Board</div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Pick Year (Master List)</label>
                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Select Board</label>
                            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select shadow-none" AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>
                        </div>

                        <div class="section-header">Step 2: Resource Type & Path</div>
                        <div class="col-md-12 mb-2">
                            <label class="form-label fw-bold small">Resource Type</label>
                            <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                        </div>

                        <%-- Path A: School (CBSE/ICSE) --%>
                        <asp:PlaceHolder ID="phSchoolPath" runat="server" Visible="false">
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Class</label>
                                <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select shadow-none" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Subject</label>
                                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                            </div>
                        </asp:PlaceHolder>

                        <%-- Path B: Competitive (JEE/NEET) - Updated with Subject Layer --%>
                        <asp:PlaceHolder ID="phCompPath" runat="server" Visible="false">
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Sub-Category (Competitive Level)</label>
                                <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select shadow-none" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Subject (Competitive)</label>
                                <asp:DropDownList ID="ddlCompSubject" runat="server" CssClass="form-select shadow-none"></asp:DropDownList>
                            </div>
                        </asp:PlaceHolder>
                    </div>

                    <div class="pt-4 mt-4 border-top">
                        <asp:Button ID="btnSaveMapping" runat="server" Text="Link Year" CssClass="btn btn-primary px-5 fw-bold" OnClick="btnSaveMapping_Click" />
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-card shadow-sm">
                    <h6 class="fw-bold mb-3">Available Master Years</h6>
                    <div class="d-flex flex-wrap gap-2">
                        <asp:Repeater ID="rptMasterYears" runat="server">
                            <ItemTemplate>
                                <span class="badge-year"><%# Eval("YearName") %></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <hr />
                    <small class="text-muted">Years are managed globally. Use the left panel to map them to subjects or levels.</small>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
