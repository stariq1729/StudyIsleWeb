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
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Content Repository</h3>
                <p class="text-muted mb-0">Manage the educational hierarchy for StudyIsle</p>
            </div>
            <div class="d-flex gap-2">
                <a href="AddYear.aspx" class="btn btn-outline-secondary btn-sm"><i class="bi bi-calendar-plus me-1"></i>Manage Years</a>
                <a href="AddSets.aspx" class="btn btn-success btn-sm"><i class="bi bi-collection-play me-1"></i>New Set</a>
                <a href="AddChapter.aspx" class="btn btn-primary btn-sm"><i class="bi bi-plus-lg me-1"></i>New Chapter</a>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label small fw-bold text-uppercase text-muted">Primary Board</label>
                        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select border-light-subtle" AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold text-uppercase text-muted">Material Type</label>
                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select border-light-subtle" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                    </div>
                    
                    <asp:PlaceHolder ID="phSchool" runat="server" Visible="false">
                        <div class="col-md-2">
                            <label class="form-label small fw-bold text-uppercase text-muted">Grade/Class</label>
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select border-light-subtle" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold text-uppercase text-muted">Subject</label>
                            <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select border-light-subtle" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="phCompetitive" runat="server" Visible="false">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-uppercase text-muted">Sub-Category</label>
                            <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select border-light-subtle" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                        </div>
                    </asp:PlaceHolder>

                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-uppercase text-muted">Academic Year</label>
                        <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select border-light-subtle" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4">
            <div class="table-responsive">
                <asp:GridView ID="gvChapters" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" 
                    DataKeyNames="ChapterId" OnRowCommand="gvChapters_RowCommand" GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Resource Map">
                            <ItemTemplate>
                                <div class="ps-3">
                                    <span class="badge rounded-pill bg-light text-dark border mb-1"><%# Eval("BoardName") %></span>
                                    <div class="small text-primary fw-semibold"><%# Eval("HierarchyPath") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Content Detail">
                            <ItemTemplate>
                                <div class="fw-bold text-dark"><%# Eval("ChapterName") %></div>
                                <div class="d-flex gap-3 small text-muted">
                                    <span><i class="bi bi-tag me-1"></i><%# Eval("SetName") %></span>
                                    <span><i class="bi bi-calendar3 me-1"></i><%# Eval("YearDisplay") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status" ItemStyle-Width="120px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkStatus" runat="server" CommandName="ToggleActive" CommandArgument='<%# Eval("ChapterId") %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success-subtle text-success text-decoration-none p-2 w-100" : "badge bg-danger-subtle text-danger text-decoration-none p-2 w-100" %>'>
                                    <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "bi bi-check-circle-fill me-1" : "bi bi-x-circle-fill me-1" %>'></i>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Disabled" %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Control" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <div class="d-flex gap-2">
                                    <a href='EditChapter.aspx?id=<%# Eval("ChapterId") %>' class="btn btn-sm btn-light border"><i class="bi bi-pencil"></i></a>
                                    <asp:LinkButton ID="btnDel" runat="server" CommandName="DeleteMe" CommandArgument='<%# Eval("ChapterId") %>' 
                                        OnClientClick="return confirm('Permanently delete this resource?');" CssClass="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-5 text-center">
                            <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="80" class="mb-3 opacity-25" />
                            <h5 class="text-muted">No Resources Found</h5>
                            <p class="small text-secondary">Try adjusting your filters or adding a new chapter.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>