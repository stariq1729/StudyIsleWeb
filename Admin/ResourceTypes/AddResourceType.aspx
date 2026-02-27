<%@ Page Title="Add Resource Type" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.AddResourceType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-card p-4 shadow-sm">
        <h4 class="form-title text-primary mb-4">Add Resource Type</h4>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

        <div class="row">
            <div class="col-md-7">
                <div class="card admin-card p-3 mb-3">
                    <h6 class="mb-3 border-bottom pb-2">Basic Information</h6>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Type Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtName_TextChanged"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="e.g., Full digital textbooks for all subjects."></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3 bg-light p-3 rounded border">
                        <label class="form-label fw-bold">Icon Image</label>
                        <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control mb-2" />
                        <small class="text-muted">Recommended: PNG/SVG (Max 200KB).</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Display Order</label>
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
                <div class="card admin-card p-3 mb-3 border-primary">
                    <h6 class="mb-3 border-bottom pb-2 text-primary">Assign to Boards</h6>
                    <p class="small text-muted mb-2">Select which boards will display this resource:</p>
                    <div style="max-height: 200px; overflow-y: auto; border: 1px solid #eee; padding: 10px; border-radius: 8px;">
                        <asp:CheckBoxList ID="cblBoards" runat="server" CssClass="form-check custom-cbl" 
                            DataTextField="BoardName" DataValueField="BoardId" RepeatLayout="UnorderedList">
                        </asp:CheckBoxList>
                    </div>
                </div>

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
                </div>
            </div>
        </div>

        <div class="mt-3">
            <asp:Button ID="btnSave" runat="server" Text="Save Resource & Mapping" CssClass="btn btn-success px-4" OnClick="btnSave_Click" />
            <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2">Cancel</a>
        </div>
    </div>

    <style>
        .custom-cbl ul { list-style: none; padding: 0; margin: 0; }
        .custom-cbl li { margin-bottom: 5px; }
        .custom-cbl input { margin-right: 10px; }
    </style>
</asp:Content>