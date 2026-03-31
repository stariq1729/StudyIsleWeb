<%@ Page Title="Add Chapter" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddChapter.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.AddChapter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add New Chapter</h1>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-book-open me-1"></i> Chapter Details
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Select Board</label>
                        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select" 
                            AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" CausesValidation="false">
                        </asp:DropDownList>
                    </div>

                    <asp:PlaceHolder ID="phClass" runat="server" Visible="false">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Select Class</label>
                            <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select" 
                                AutoPostBack="true" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged" CausesValidation="false">
                            </asp:DropDownList>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="phSubject" runat="server" Visible="false">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Select Subject</label>
                            <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                    </asp:PlaceHolder>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Chapter Name</label>
                        <asp:TextBox ID="txtChapterName" runat="server" CssClass="form-control" 
                            placeholder="Enter chapter name" AutoPostBack="true" 
                            OnTextChanged="txtChapterName_TextChanged"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">URL Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" ReadOnly="true" BackColor="#eeeeee"></asp:TextBox>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label fw-bold">Display Order</label>
                        <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control" Text="0" TextMode="Number"></asp:TextBox>
                    </div>

                    <div class="col-md-3 d-flex align-items-end">
                        <div class="form-check mb-2">
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label">Is Active</label>
                        </div>
                    </div>

                    <div class="col-12 mt-4">
                        <asp:Button ID="btnSave" runat="server" Text="Save Chapter" CssClass="btn btn-primary px-5" OnClick="btnSave_Click" />
                        <br /><br />
                        <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>