<%@ Page Title="Add Resource Type" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.AddResourceType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-4">
        <h4 class="form-title text-primary mb-4">Phase 2: Add Resource Type</h4>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

        <div class="row">
            <div class="col-md-7">
                <div class="card shadow-sm p-3 mb-3">
                    <h6 class="mb-3 border-bottom pb-2">Basic Information</h6>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Type Name (e.g., Previous Year Paper, Notes)</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtName_TextChanged"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Icon Image</label>
                        <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control mb-1" />
                        <small class="text-muted">Upload PNG/SVG for the frontend UI.</small>
                    </div>
                    <div class="row">
                        <div class="col-6">
                             <label class="form-label fw-bold">Display Order</label>
                             <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                        </div>
                        <div class="col-6 d-flex align-items-end">
                            <div class="form-check me-3">
                                <asp:CheckBox ID="chkIsPremium" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label">Premium</label>
                            </div>
                            <div class="form-check">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label">Active</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm p-3 border-primary">
                    <h6 class="mb-3 border-bottom pb-2 text-primary">Hierarchy Flow Control (Skip Logic)</h6>
                    <p class="small text-muted">Toggle which layers this specific resource type requires:</p>
                    <div class="row">
                        <div class="col-6">
                            <asp:CheckBox ID="chkHasClass" runat="server" Text=" Has Class Layer" CssClass="d-block mb-2" />
                            <asp:CheckBox ID="chkHasSubject" runat="server" Text=" Has Subject Layer" CssClass="d-block mb-2" />
                            <asp:CheckBox ID="chkHasChapter" runat="server" Text=" Has Chapter Layer" CssClass="d-block mb-2" />
                        </div>
                        <div class="col-6">
                            <asp:CheckBox ID="chkHasSubCategory" runat="server" Text=" Has SubCategory Layer" CssClass="d-block mb-2" />
                            <asp:CheckBox ID="chkHasYear" runat="server" Text=" Has Year Layer" CssClass="d-block mb-2" />
                            <asp:CheckBox ID="chkHasSets" runat="server" Text=" Has Sets Layer" CssClass="d-block mb-2" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card shadow-sm p-3 border-info">
                    <h6 class="mb-3 border-bottom pb-2 text-info">Assign to Boards</h6>
                    <p class="small text-muted"><strong>Standard Flow:</strong> Board → ResourceType<br />
                       <strong>Competitive Flow:</strong> Board → SubCategory (Resource Type appears later)</p>
                    
                    <div class="board-selector-box">
                        <asp:CheckBoxList ID="cblBoards" runat="server" CssClass="custom-cbl" DataTextField="BoardName" DataValueField="BoardId">
                        </asp:CheckBoxList>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-4">
            <asp:Button ID="btnSave" runat="server" Text="Save Resource & Mapping" CssClass="btn btn-success px-5" OnClick="btnSave_Click" />
            <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2">Cancel</a>
        </div>
    </div>

    <style>
        .board-selector-box { max-height: 400px; overflow-y: auto; border: 1px solid #ddd; padding: 15px; border-radius: 5px; background: #f9f9f9; }
        .custom-cbl label { margin-left: 10px; font-weight: 500; cursor: pointer; }
        .custom-cbl input { cursor: pointer; transform: scale(1.2); }
        .custom-cbl td { padding-bottom: 8px; }
    </style>
</asp:Content>