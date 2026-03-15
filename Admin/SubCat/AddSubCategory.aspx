<%@ Page Title="Add SubCategory" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSubCategory.aspx.cs" Inherits="StudyIsleWeb.Admin.SubCat.AddSubCategory" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h4 class="fw-bold mb-0 text-dark">Create New Sub-Category</h4>
                    </div>
                    <div class="card-body p-4">
                        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

                        <div class="row g-3">
                            <div class="col-12">
                                <div class="p-3 rounded bg-light border-start border-4 border-info">
                                    <div class="form-check form-switch">
                                        <asp:CheckBox ID="chkIsCompetitive" runat="server" CssClass="form-check-input" />
                                        <label class="form-check-label fw-bold" for="<%= chkIsCompetitive.ClientID %>">Competitive Exam Flow (JEE/NEET)</label>
                                    </div>
                                    <small class="text-muted">Enable this to skip the 'Class' selection in the user journey.</small>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold">Target Board</label>
                                <asp:DropDownList ID="ddlBoards" runat="server" CssClass="form-select" DataTextField="BoardName" DataValueField="BoardId">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Resource Type (Optional)</label>
                                <asp:DropDownList ID="ddlResourceTypes" runat="server" CssClass="form-select" DataTextField="TypeName" DataValueField="ResourceTypeId">
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold">Sub-Category Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Physics" AutoPostBack="true" OnTextChanged="txtName_TextChanged"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">URL Slug</label>
                                <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-bold">Icon Image</label>
                                <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control" />
                                <small class="text-muted">Supported: .png, .jpg, .webp</small>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-bold">Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </div>

                            <div class="col-12 pt-3">
                                <asp:Button ID="btnSave" runat="server" Text="Save Sub-Category" CssClass="btn btn-primary px-5 py-2 fw-bold" OnClick="btnSave_Click" />
                                <a href="ManageSubCat.aspx" class="btn btn-light px-4 py-2 border ms-2">Back to List</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>