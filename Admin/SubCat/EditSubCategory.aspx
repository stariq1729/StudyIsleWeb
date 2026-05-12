<%@ Page Title="Edit SubCategory" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="EditSubCategory.aspx.cs"
    Inherits="StudyIsleWeb.Admin.SubCat.EditSubCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-9">

                <div class="card shadow-sm border-0">

                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h4 class="fw-bold mb-0 text-dark">Edit Sub-Category</h4>

                        <asp:Label ID="lblId" runat="server"
                            CssClass="badge bg-dark"></asp:Label>
                    </div>

                    <div class="card-body p-4">

                        <asp:HiddenField ID="hfSubCatId" runat="server" />

                        <asp:Label ID="lblMessage" runat="server"
                            CssClass="d-block mb-3"></asp:Label>

                        <div class="row g-3">

                            <!-- FLOW -->
                            <div class="col-12">
                                <div class="p-3 rounded bg-light border-start border-4 border-warning">
                                    <div class="form-check form-switch">

                                        <asp:CheckBox ID="chkIsCompetitive"
                                            runat="server"
                                            CssClass="form-check-input" />

                                        <label class="form-check-label fw-bold"
                                            for="<%= chkIsCompetitive.ClientID %>">
                                            Competitive Exam Flow
                                        </label>

                                    </div>

                                    <small class="text-muted">
                                        Enable this to skip class layer in frontend journey.
                                    </small>
                                </div>
                            </div>

                            <!-- BOARD -->
                            <div class="col-md-6">

                                <label class="form-label fw-bold">
                                    Target Board
                                </label>

                                <asp:DropDownList ID="ddlBoards"
                                    runat="server"
                                    CssClass="form-select"
                                    DataTextField="BoardName"
                                    DataValueField="BoardId"
                                    AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlBoards_SelectedIndexChanged">
                                </asp:DropDownList>

                            </div>

                            <!-- RESOURCE -->
                            <div class="col-md-6">

                                <label class="form-label fw-bold">
                                    Resource Type
                                </label>

                                <asp:DropDownList ID="ddlResourceTypes"
                                    runat="server"
                                    CssClass="form-select"
                                    DataTextField="TypeName"
                                    DataValueField="ResourceTypeId">
                                </asp:DropDownList>

                            </div>

                            <!-- NAME -->
                            <div class="col-md-6">

                                <label class="form-label fw-bold">
                                    Sub-Category Name
                                </label>

                                <asp:TextBox ID="txtName"
                                    runat="server"
                                    CssClass="form-control"
                                    AutoPostBack="true"
                                    OnTextChanged="txtName_TextChanged">
                                </asp:TextBox>

                            </div>

                            <!-- SLUG -->
                            <div class="col-md-6">

                                <label class="form-label fw-bold">
                                    URL Slug
                                </label>

                                <asp:TextBox ID="txtSlug"
                                    runat="server"
                                    CssClass="form-control bg-light"
                                    ReadOnly="true">
                                </asp:TextBox>

                            </div>

                            <!-- IMAGE -->
                            <div class="col-12">

                                <label class="form-label fw-bold">
                                    Icon Image
                                </label>

                                <div class="d-flex align-items-center gap-3">

                                    <asp:Image ID="imgPreview"
                                        runat="server"
                                        Width="60"
                                        Height="60"
                                        CssClass="rounded border shadow-sm" />

                                    <asp:FileUpload ID="fuIcon"
                                        runat="server"
                                        CssClass="form-control" />

                                </div>

                                <small class="text-muted">
                                    Upload only if you want to replace existing icon.
                                </small>

                            </div>

                            <!-- DESCRIPTION -->
                            <div class="col-12">

                                <label class="form-label fw-bold">
                                    Description
                                </label>

                                <asp:TextBox ID="txtDescription"
                                    runat="server"
                                    CssClass="form-control"
                                    TextMode="MultiLine"
                                    Rows="4">
                                </asp:TextBox>

                            </div>

                            <!-- BUTTON -->
                            <div class="col-12 pt-3">

                                <asp:Button ID="btnUpdate"
                                    runat="server"
                                    Text="Update Sub-Category"
                                    CssClass="btn btn-primary px-5 py-2 fw-bold"
                                    OnClick="btnUpdate_Click" />

                                <a href="ManageSubCat.aspx"
                                    class="btn btn-light border px-4 py-2 ms-2">
                                    Back
                                </a>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>

</asp:Content>