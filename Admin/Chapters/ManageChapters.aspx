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
                <h4 class="fw-bold mb-0">Manage Chapters</h4>
                <p class="text-muted small">Full hierarchy: Board > Year/Class > Subject > Set > Chapter</p>
            </div>
            <div>
                <a href="AddYear.aspx" class="btn btn-outline-dark btn-sm me-2"><i class="bi bi-calendar-plus me-1"></i>Year</a>
                <a href="AddSets.aspx" class="btn btn-outline-success btn-sm me-2"><i class="bi bi-collection me-1"></i>Set</a>
                <a href="AddChapter.aspx" class="btn btn-primary btn-sm"><i class="bi bi-plus-circle me-1"></i>Chapter</a>
            </div>
        </div>

        <div class="card admin-card p-3 mb-4 shadow-sm bg-white">
            <div class="row g-3">
                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Board</label>
                    <asp:DropDownList ID="ddlBoardFilter" runat="server" CssClass="form-select form-select-sm shadow-none" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Class (School)</label>
                    <asp:DropDownList ID="ddlClassFilter" runat="server" CssClass="form-select form-select-sm shadow-none" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold text-secondary">Year (Exam)</label>
                    <asp:DropDownList ID="ddlYearFilter" runat="server" CssClass="form-select form-select-sm shadow-none" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <label class="small fw-bold text-secondary">Subject</label>
                    <asp:DropDownList ID="ddlSubjectFilter" runat="server" CssClass="form-select form-select-sm shadow-none" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <label class="small fw-bold text-secondary">Set</label>
                    <asp:DropDownList ID="ddlSetFilter" runat="server" CssClass="form-select form-select-sm shadow-none" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged"></asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="card admin-card shadow-sm bg-white">
            <asp:GridView ID="gvChapters" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" 
                DataKeyNames="ChapterId" OnRowCommand="gvChapters_RowCommand" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="ChapterId" HeaderText="ID" ItemStyle-Width="50px" />
                    
                    <asp:TemplateField HeaderText="Context Hierarchy">
                        <ItemTemplate>
                            <div class="d-flex align-items-center">
                                <span class="badge bg-light text-dark border me-2"><%# Eval("BoardName") %></span>
                                <i class="bi bi-arrow-right text-muted small me-2"></i>
                                <span class="fw-bold text-primary"><%# Eval("LevelName") %></span>
                            </div>
                            <div class="small text-muted mt-1"><%# Eval("SubjectName") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Content Detail">
                        <ItemTemplate>
                            <div class="fw-bold"><%# Eval("ChapterName") %></div>
                            <div class="text-success small"><%# Eval("SetName") != DBNull.Value ? "📂 " + Eval("SetName") : "" %></div>
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
                            <a href='EditChapter.aspx?id=<%# Eval("ChapterId") %>' class="btn btn-sm btn-outline-warning"><i class="bi bi-pencil"></i></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="p-5 text-center">
                        <i class="bi bi-search display-4 text-muted"></i>
                        <p class="mt-3">No chapters found for these filters.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>