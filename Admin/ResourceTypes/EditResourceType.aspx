<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.EditResourceType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card">

        <h4 class="form-title">Edit Resource Type</h4>

        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

        <!-- Basic Information -->
        <div class="card admin-card p-3 mb-3">

            <h6 class="mb-3">Basic Information</h6>

            <div class="mb-3">
                <label>Type Name</label>
                <asp:TextBox ID="txtName" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtName_TextChanged">
                </asp:TextBox>
            </div>

            <div class="mb-3">
                <label>Slug</label>
                <asp:TextBox ID="txtSlug" runat="server"
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <div class="mb-3">
                <label>Display Order</label>
                <asp:TextBox ID="txtDisplayOrder" runat="server"
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <div class="form-check mb-2">
                <asp:CheckBox ID="chkIsPremium" runat="server"
                    CssClass="form-check-input" />
                <label class="form-check-label">Is Premium</label>
            </div>

            <div class="form-check mb-2">
                <asp:CheckBox ID="chkIsActive" runat="server"
                    CssClass="form-check-input" />
                <label class="form-check-label">Is Active</label>
            </div>

        </div>

        <!-- Flow Control -->
        <div class="card admin-card p-3 mb-3">

            <h6 class="mb-3">Hierarchy Flow Control</h6>

            <div class="form-check">
                <asp:CheckBox ID="chkHasClass" runat="server" CssClass="form-check-input" />
                <label class="form-check-label">Has Class Layer</label>
            </div>

            <div class="form-check">
                <asp:CheckBox ID="chkHasSubject" runat="server" CssClass="form-check-input" />
                <label class="form-check-label">Has Subject Layer</label>
            </div>

            <div class="form-check">
                <asp:CheckBox ID="chkHasChapter" runat="server" CssClass="form-check-input" />
                <label class="form-check-label">Has Chapter Layer</label>
            </div>

            <div class="form-check">
                <asp:CheckBox ID="chkHasYear" runat="server" CssClass="form-check-input" />
                <label class="form-check-label">Has Year Layer</label>
            </div>

            <div class="form-check">
                <asp:CheckBox ID="chkHasSubCategory" runat="server" CssClass="form-check-input" />
                <label class="form-check-label">Has SubCategory Layer</label>
            </div>

        </div>

        <!-- Buttons -->
        <asp:Button ID="btnUpdate" runat="server"
            Text="Update Resource Type"
            CssClass="btn btn-success"
            OnClick="btnUpdate_Click" />

        <a href="ManageResourceTypes.aspx"
            class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>