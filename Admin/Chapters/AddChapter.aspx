<%@ Page Title="Add Chapter" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddChapter.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.AddChapter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add New Chapter</h1>
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-light">
                <i class="fas fa-book-open me-1"></i> <strong>Chapter Configuration</strong>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">1. Select Board</label>
                        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select" 
                            AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">2. Resource Type</label>
                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select">
                        </asp:DropDownList>
                    </div>

                    <%-- Path A: School Boards --%>
                    <asp:PlaceHolder ID="phClass" runat="server" Visible="false">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">3. Select Class</label>
                            <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select" 
                                AutoPostBack="true" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </asp:PlaceHolder>

                    <%-- Path B: Competitive Boards --%>
                    <asp:PlaceHolder ID="phSubCategory" runat="server" Visible="false">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">3. Select Sub-Category</label>
                            <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </asp:PlaceHolder>

                    <div class="col-md-6">
                        <label class="form-label fw-bold text-primary">4. Select Subject (Optional)</label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select">
                        </asp:DropDownList>
                        <small class="text-muted">Leave as "-- Select --" if no subject applies.</small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Chapter Name</label>
                        <asp:TextBox ID="txtChapterName" runat="server" CssClass="form-control" 
                            placeholder="e.g. Chemical Bonding" AutoPostBack="true" 
                            OnTextChanged="txtChapterName_TextChanged"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">URL Slug</label>
                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" ReadOnly="true" BackColor="#f8f9fa"></asp:TextBox>
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
                    <%--// adding a toggle for quiz and flashcards--%>
                    <div class="col-md-6">
    <label class="form-label fw-bold text-success">Content Type</label>
    
    <div class="form-check">
        <asp:CheckBox ID="chkIsQuizEnabled" runat="server" CssClass="form-check-input" />
        <label class="form-check-label">Enable Quiz</label>
    </div>

    <div class="form-check">
        <asp:CheckBox ID="chkIsFlashcardEnabled" runat="server" CssClass="form-check-input" />
        <label class="form-check-label">Enable Flashcards</label>
    </div>

    <small class="text-muted">Select only one. Leave both unchecked for normal resources.</small>
</div>

                    <div class="col-12 mt-4 border-top pt-3">
                        <asp:Button ID="btnSave" runat="server" Text="Create Chapter" CssClass="btn btn-success px-5" OnClick="btnSave_Click" />
                        <asp:Label ID="lblMessage" runat="server" CssClass="ms-3"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>