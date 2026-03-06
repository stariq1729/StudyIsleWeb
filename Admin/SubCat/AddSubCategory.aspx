<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSubCategory.aspx.cs" Inherits="StudyIsleWeb.Admin.SubCat.AddSubCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white border-0 pt-4">
                    <h2 class="fw-bold text-dark mb-1">Add New SubCategory</h2>
                    <p class="text-muted">Define the layer name, icon, and navigation flow.</p>
                </div>
                <div class="card-body p-4">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="p-3 rounded-3 border-start border-4 border-primary bg-light">
                                <asp:CheckBox ID="chkIsCompetitive" runat="server" Text="&nbsp; Competitive Exam Flow" CssClass="fw-bold h5 mb-1 d-block" />
                                <small class="text-muted d-block">
                                    Check this for <strong>JEE/NEET</strong> (Home > SubCategory > Resource). 
                                    Leave unchecked for <strong>CBSE</strong> (Home > Resource > SubCategory).
                                </small>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold">Target Board</label>
                            <asp:DropDownList ID="ddlBoards" runat="server" CssClass="form-select" DataTextField="BoardName" DataValueField="BoardId"></asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Resource Type (Optional)</label>
                            <asp:DropDownList ID="ddlResourceTypes" runat="server" CssClass="form-select" DataTextField="TypeName" DataValueField="ResourceTypeId"></asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">SubCategory Title</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. JEE Main" OnTextChanged="txtName_TextChanged" AutoPostBack="true"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Logo / Icon Image</label>
                            <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control" />
                            <small class="text-muted">Recommended: Square PNG/JPG (200x200px)</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Slug (Auto-Generated)</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold">Description / Subtitle</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Explain what this category contains..."></asp:TextBox>
                        </div>

                        <div class="col-12 pt-2">
                            <hr />
                            <asp:Button ID="btnSave" runat="server" Text="Create SubCategory" CssClass="btn btn-primary btn-lg px-5 rounded-pill" OnClick="btnSave_Click" />
                            <asp:Label ID="lblMessage" runat="server" CssClass="ms-3 fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
