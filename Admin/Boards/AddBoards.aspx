<%@ Page Title="Add Board" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddBoards.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.AddBoards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Add New Board</h4>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold">Board Name</label>
                        <asp:TextBox ID="txtBoardName" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtBoardName_TextChanged" placeholder="e.g., CBSE or JEE"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold">Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                        <small class="text-muted">Auto-generated from name</small>
                    </div>
                </div>

                <hr />
                <h5 class="text-primary">Logic & Flow Settings</h5>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <asp:CheckBox ID="chkIsCompetitive" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label font-weight-bold">Is Competitive Board?</label>
                            <div class="small text-muted">Check this for JEE, NEET, etc. to change the content flow.</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <asp:CheckBox ID="chkHasClassLayer" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label font-weight-bold">Has Class Layer</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label font-weight-bold">Is Active</label>
                        </div>
                    </div>
                </div>

                <hr />
                <h5 class="text-primary">Hero Section (SEO)</h5>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Hero Title</label>
                    <asp:TextBox ID="txtHeroTitle" runat="server" CssClass="form-control" placeholder="e.g. Best Resources for CBSE Class 10"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label font-weight-bold">Hero Subtitle</label>
                    <asp:TextBox ID="txtHeroSubtitle" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Brief description..."></asp:TextBox>
                </div>

                <div class="mt-4">
                    <asp:Button ID="btnSave" runat="server" Text="Save Board" CssClass="btn btn-primary px-4" OnClick="btnSave_Click" />
                    <a href="ManageBoards.aspx" class="btn btn-outline-secondary ms-2">Cancel</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>