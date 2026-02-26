<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditBoard.aspx.cs" Inherits="StudyIsleWeb.Admin.Boards.EditBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card shadow-sm p-4">
        <h4 class="form-title text-primary">Edit Board Details</h4>
        <p class="text-muted">Modify board settings and hero section content.</p>
        <hr />

        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>

        <div class="mb-3">
            <label class="form-label font-weight-bold">Board Name</label>
            <asp:TextBox ID="txtBoardName" runat="server" CssClass="form-control"
                AutoPostBack="true" OnTextChanged="txtBoardName_TextChanged">
            </asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label font-weight-bold">Slug</label>
            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
            <small class="text-muted">URL-friendly version used for navigation.</small>
        </div>

        <div class="bg-light p-3 rounded mb-3 border">
            <h5 class="text-info">Hero Section (SEO Content)</h5>
            
            <div class="mb-3">
                <label class="form-label font-weight-bold">Hero Title</label>
                <asp:TextBox ID="txtHeroTitle" runat="server" CssClass="form-control" 
                    placeholder="e.g., Best CBSE Class 10 Resources"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label font-weight-bold">Hero Subtitle</label>
                <asp:TextBox ID="txtHeroSubtitle" runat="server" CssClass="form-control" 
                    TextMode="MultiLine" Rows="3" 
                    placeholder="Enter the description that appears under the main heading..."></asp:TextBox>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-check mb-2">
                    <asp:CheckBox ID="chkHasClassLayer" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label">Has Class Layer</label>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-check mb-3">
                    <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label">Is Active Status</label>
                </div>
            </div>
        </div>

        <hr />

        <div class="mt-4">
            <asp:Button ID="btnUpdate" runat="server" Text="Update Board Info"
                CssClass="btn btn-success px-4" OnClick="btnUpdate_Click" />

            <a href="ManageBoards.aspx" class="btn btn-secondary ms-2">Back to List</a>
        </div>
    </div>

</asp:Content>