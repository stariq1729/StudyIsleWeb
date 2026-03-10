<%@ Page Title="Edit Board" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditBoard.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.EditBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <div class="card shadow-sm">
            <div class="card-header bg-warning text-dark d-flex justify-content-between">
                <h4 class="mb-0">Edit Board Details</h4>
                <asp:Label ID="lblIdDisplay" runat="server" CssClass="badge bg-dark"></asp:Label>
            </div>
            <div class="card-body">
                <asp:HiddenField ID="hfBoardId" runat="server" />
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold">Board Name</label>
                        <asp:TextBox ID="txtBoardName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold">Slug (URL)</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <hr />
                <h5 class="text-primary">Logic & Flow Settings</h5>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <asp:CheckBox ID="chkIsCompetitive" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label font-weight-bold">Is Competitive?</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <asp:CheckBox ID="chkHasClassLayer" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label font-weight-bold">Has Class Layer</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label font-weight-bold">Is Active</label>
                        </div>
                    </div>
                </div>

                <hr />
                <h5 class="text-primary">Hero Section (SEO)</h5>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Hero Title</label>
                    <asp:TextBox ID="txtHeroTitle" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label font-weight-bold">Hero Subtitle</label>
                    <asp:TextBox ID="txtHeroSubtitle" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>

                <div class="mt-4">
                    <asp:Button ID="btnUpdate" runat="server" Text="Update Board" CssClass="btn btn-warning px-4" OnClick="btnUpdate_Click" />
                    <a href="ManageBoards.aspx" class="btn btn-outline-secondary ms-2">Cancel</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>