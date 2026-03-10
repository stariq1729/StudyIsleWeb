<%@ Page Title="Edit Resource Type" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditResourceType.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.EditResourceType" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-4">
        <h4 class="form-title text-primary mb-4">Edit Resource Type</h4>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mb-3"></asp:Label>
        <asp:HiddenField ID="hfRTID" runat="server" />

        <div class="row">
            <div class="col-md-7">
                <div class="card shadow-sm p-3 mb-3">
                    <h6 class="mb-3 border-bottom pb-2 font-weight-bold">Update Details</h6>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Type Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Current Icon</label>
                        <div class="d-flex align-items-center gap-3 bg-light p-2 rounded border">
                            <asp:Image ID="imgCurrentIcon" runat="server" Width="50px" Height="50px" CssClass="img-thumbnail" />
                            <asp:FileUpload ID="fuIcon" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm p-3 border-primary">
                    <h6 class="mb-3 border-bottom pb-2 text-primary">Hierarchy Flow Settings</h6>
                    <div class="row">
                        <div class="col-6">
                            <asp:CheckBox ID="chkHasClass" runat="server" Text=" Has Class" CssClass="d-block mb-1" />
                            <asp:CheckBox ID="chkHasSubject" runat="server" Text=" Has Subject" CssClass="d-block mb-1" />
                            <asp:CheckBox ID="chkHasChapter" runat="server" Text=" Has Chapter" CssClass="d-block mb-1" />
                        </div>
                        <div class="col-6">
                            <asp:CheckBox ID="chkHasSubCategory" runat="server" Text=" Has SubCategory" CssClass="d-block mb-1" />
                            <asp:CheckBox ID="chkHasYear" runat="server" Text=" Has Year" CssClass="d-block mb-1" />
                            <asp:CheckBox ID="chkHasSets" runat="server" Text=" Has Sets" CssClass="d-block mb-1" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card shadow-sm p-3 border-info">
                    <h6 class="mb-3 border-bottom pb-2 text-info">Associated Boards</h6>
                    <div style="max-height: 450px; overflow-y: auto;" class="p-2 border rounded bg-light">
                        <asp:CheckBoxList ID="cblBoards" runat="server" CssClass="custom-cbl" DataTextField="BoardName" DataValueField="BoardId">
                        </asp:CheckBoxList>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-4">
            <asp:Button ID="btnUpdate" runat="server" Text="Update Changes" CssClass="btn btn-primary px-5" OnClick="btnUpdate_Click" />
            <a href="ManageResourceTypes.aspx" class="btn btn-secondary ms-2">Cancel</a>
        </div>
    </div>
</asp:Content>