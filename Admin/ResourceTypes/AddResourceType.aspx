<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.AddResourceType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card p-4 shadow-sm">
        <h4 class="form-title text-primary">Add Resource Type</h4>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

        <div class="row">
            <div class="col-md-7">
                <div class="card admin-card p-3 mb-3">
                    <h6 class="mb-3 border-bottom pb-2">Basic Information</h6>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold">Type Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtName_TextChanged"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold">Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3 bg-light p-3 rounded border">
                        <label class="form-label font-weight-bold">Resource Icon Image</label>
                        <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control mb-2" />
                        <small class="text-muted d-block">Recommended: 128x128px PNG/SVG (Max 200KB).</small>
                        <small class="text-info">If left blank, a default icon will be assigned.</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold">Display Order</label>
                        <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                    </div>

                    <div class="d-flex gap-4">
                        <div class="form-check">
                            <asp:CheckBox ID="chkIsPremium" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Is Premium</label>
                        </div>
                        <div class="form-check">
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label">Is Active</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card admin-card p-3 mb-3">
                    <h6 class="mb-3 border-bottom pb-2">Hierarchy Flow Control</h6>
                    <div class="form-check mb-2">
                        <asp:CheckBox ID="chkHasClass" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Has Class Layer</label>
                    </div>
                    <div class="form-check mb-2">
                        <asp:CheckBox ID="chkHasSubject" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Has Subject Layer</label>
                    </div>
                    <div class="form-check mb-2">
                        <asp:CheckBox ID="chkHasChapter" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Has Chapter Layer</label>
                    </div>
                    <div class="form-check mb-2">
                        <asp:CheckBox ID="chkHasYear" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Has Year Layer</label>
                    </div>
                    <div class="form-check mb-2">
                        <asp:CheckBox ID="chkHasSubCategory" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Has SubCategory Layer</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <asp:Button ID="btnSave" runat="server" Text="Save Resource Type" CssClass="btn btn-success px-4" OnClick="btnSave_Click" />
            <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2">Cancel</a>
        </div>
    </div>

</asp:Content>