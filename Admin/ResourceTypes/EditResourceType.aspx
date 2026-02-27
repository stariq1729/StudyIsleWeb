<%@ Page Title="Edit Resource Type" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.EditResourceType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-card p-4 shadow-sm">
        <h4 class="form-title text-warning">Edit Resource Type</h4>
        <p class="text-muted">Update icon, naming, and associated boards.</p>
        <hr />

        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

        <div class="row">
            <div class="col-md-7">
                <div class="card admin-card p-3 mb-3 border-0 bg-light">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Type Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtName_TextChanged"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Display Order</label>
                        <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <div class="row bg-white p-3 rounded border mx-0">
                        <div class="col-md-4 text-center border-end">
                            <label class="form-label d-block fw-bold small">Current Icon</label>
                            <asp:Image ID="imgCurrent" runat="server" CssClass="img-thumbnail" style="width: 70px; height: 70px; object-fit: contain;" />
                            <asp:HiddenField ID="hfCurrentImg" runat="server" />
                        </div>
                        <div class="col-md-8">
                            <label class="form-label fw-bold">Change Icon Image</label>
                            <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control mb-1" />
                            <small class="text-muted small">Leave empty to keep current image.</small>
                        </div>
                    </div>

                    <div class="d-flex gap-4 mt-3">
                        <div class="form-check">
                            <asp:CheckBox ID="chkIsPremium" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Is Premium</label>
                        </div>
                        <div class="form-check">
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Is Active</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card admin-card p-3 mb-3 border-warning">
                    <h6 class="mb-3 border-bottom pb-2 text-warning fw-bold"><i class="fas fa-link me-2"></i>Mapped Boards</h6>
                    <p class="small text-muted mb-2">Check the boards where this resource should appear:</p>
                    <div style="max-height: 250px; overflow-y: auto; border: 1px solid #ddd; padding: 10px; border-radius: 5px; background: #fff;">
                        <asp:CheckBoxList ID="cblBoards" runat="server" CssClass="form-check custom-cbl" 
                            DataTextField="BoardName" DataValueField="BoardId" RepeatLayout="Flow">
                        </asp:CheckBoxList>
                    </div>
                </div>

                <div class="card admin-card p-3 mb-3">
                    <h6 class="mb-3 border-bottom pb-2 text-info"><i class="fas fa-sitemap me-2"></i>Hierarchy Flow</h6>
                    <asp:CheckBox ID="chkHasClass" runat="server" CssClass="d-block mb-2" Text="&nbsp;Has Class Layer" />
                    <asp:CheckBox ID="chkHasSubject" runat="server" CssClass="d-block mb-2" Text="&nbsp;Has Subject Layer" />
                    <asp:CheckBox ID="chkHasChapter" runat="server" CssClass="d-block mb-2" Text="&nbsp;Has Chapter Layer" />
                    <asp:CheckBox ID="chkHasYear" runat="server" CssClass="d-block mb-2" Text="&nbsp;Has Year Layer" />
                    <asp:CheckBox ID="chkHasSubCategory" runat="server" CssClass="d-block mb-2" Text="&nbsp;Has SubCategory Layer" />
                </div>
            </div>
        </div>

        <div class="mt-4 pt-3 border-top">
            <asp:Button ID="btnUpdate" runat="server" Text="Update Resource Type" CssClass="btn btn-warning px-5 fw-bold" OnClick="btnUpdate_Click" />
            <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2 px-4">Back to List</a>
        </div>
    </div>
</asp:Content>