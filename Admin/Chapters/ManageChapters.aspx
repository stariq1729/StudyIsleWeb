<%@ Page Title="Manage Chapters" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageChapters.aspx.cs" Inherits="StudyIsleWeb.Admin.Chapters.ManageChapters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .admin-card { border: none; border-radius: 12px; transition: 0.3s; }
        .badge-active { background-color: #dcfce7; color: #15803d; padding: 5px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
        .badge-inactive { background-color: #fee2e2; color: #b91c1c; padding: 5px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
        .table thead { background-color: #f8fafc; color: #64748b; font-size: 0.8rem; text-transform: uppercase; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-0">Chapter & Resource Manager</h4>
                <p class="text-muted small">Path-based filtering for School and Competitive flows</p>
            </div>
            <div>
                <a href="AddYear.aspx" class="btn btn-outline-dark btn-sm me-1">Manage Years</a>
                <a href="AddSets.aspx" class="btn btn-outline-success btn-sm me-1">Add Set</a>
                <a href="AddChapter.aspx" class="btn btn-primary btn-sm">Add Chapter</a>
            </div>
        </div>

        <div class="card admin-card p-3 mb-4 shadow-sm bg-white border-0">
            <div class="row g-2">
                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Board</label>
                    <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Resource Type</label>
                    <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>

                <asp:PlaceHolder ID="phSchoolFilters" runat="server" Visible="false">
                    <div class="col-md-2">
                        <label class="small fw-bold text-secondary">Class</label>
                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label class="small fw-bold text-secondary">Subject</label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder ID="phCompFilters" runat="server" Visible="false">
                    <div class="col-md-4">
                        <label class="small fw-bold text-secondary">SubCategory</label>
                        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                    </div>
                </asp:PlaceHolder>

                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Year</label>
                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Set</label>
                    <asp:DropDownList ID="ddlSet" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="card admin-card shadow-sm border-0 bg-white">
            <asp:GridView ID="gvChapters" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" 
                DataKeyNames="ChapterId" OnRowCommand="gvChapters_RowCommand" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="ChapterId" HeaderText="ID" ItemStyle-Width="50px" />
                    
                    <asp:TemplateField HeaderText="Hierarchy">
                        <ItemTemplate>
                            <span class="badge bg-light text-dark border"><%# Eval("BoardName") %></span>
                            <span class="text-muted mx-1">/</span>
                            <span class="small text-primary fw-bold"><%# Eval("ContextName") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Resource Detail">
                        <ItemTemplate>
                            <div class="fw-bold"><%# Eval("ChapterName") %></div>
                            <div class="small text-muted">
                                📅 <%# Eval("YearName") %> | 📦 <%# Eval("SetName") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="DisplayOrder" HeaderText="Order" ItemStyle-HorizontalAlign="Center" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggle" runat="server" CommandName="ToggleActive" CommandArgument='<%# Eval("ChapterId") %>'
                                CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active text-decoration-none" : "badge-inactive text-decoration-none" %>'>
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <a href='EditChapter.aspx?id=<%# Eval("ChapterId") %>' class="btn btn-sm btn-light text-warning border"><i class="bi bi-pencil-square"></i></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="py-5 text-center text-muted">No data found matching these filters.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>