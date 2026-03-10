<%@ Page Title="Manage Subjects" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubjects.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.ManageSubjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .subject-icon-grid { width: 40px; height: 40px; object-fit: contain; background: #fff; border-radius: 8px; padding: 5px; border: 1px solid #f1f5f9; }
        .badge-active { background-color: #d1fae5; color: #065f46; padding: 0.4rem 0.8rem; border-radius: 50px; font-size: 0.72rem; font-weight: 700; text-decoration: none; border: 1px solid #10b981; }
        .badge-inactive { background-color: #fee2e2; color: #991b1b; padding: 0.4rem 0.8rem; border-radius: 50px; font-size: 0.72rem; font-weight: 700; text-decoration: none; border: 1px solid #ef4444; }
        .filter-card { background: #fff; border-radius: 12px; border: 1px solid #e2e8f0; margin-bottom: 1.5rem; }
        .assoc-tag { font-size: 0.75rem; font-weight: 600; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold m-0">Subject Repository</h4>
                <p class="text-muted small mb-0">Manage teaching subjects across all boards and classes.</p>
            </div>
            <a href="AddSubject.aspx" class="btn btn-primary shadow-sm px-4 fw-bold">+ Add New Subject</a>
        </div>

        <div class="filter-card shadow-sm p-3">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="small fw-bold text-secondary mb-1"><i class="fas fa-filter me-1"></i> Filter by Board</label>
                    <asp:DropDownList ID="ddlBoardFilter" runat="server" CssClass="form-select shadow-none" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-light border w-100 fw-bold" OnClick="btnClear_Click" />
                </div>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

        <div class="card border-0 shadow-sm overflow-hidden">
            <div class="table-responsive">
                <asp:GridView ID="gvSubjects" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover align-middle mb-0" GridLines="None" 
                    DataKeyNames="SubjectId" OnRowCommand="gvSubjects_RowCommand" OnRowDeleting="gvSubjects_RowDeleting">
                    <Columns>
                        <asp:TemplateField HeaderText="Icon" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <img src='<%# "/Uploads/SubjectIcons/" + (string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "Default-icon.png" : Eval("IconImage")) %>' class="subject-icon-grid shadow-sm" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Subject Details">
                            <ItemTemplate>
                                <div class="fw-bold text-dark" style="font-size: 0.95rem;"><%# Eval("SubjectName") %></div>
                                <div class="text-primary small" style="font-size: 0.75rem;"><%# Eval("Slug") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Association (Board & Class)">
                            <ItemTemplate>
                                <div class="d-flex align-items-center gap-1">
                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle assoc-tag">
                                        <%# Eval("BoardName") %>
                                    </span>
                                    <i class="fas fa-chevron-right text-muted small mx-1" style="font-size: 10px;"></i>
                                    <span class='<%# Eval("ClassName").ToString() == "" ? "badge bg-warning-subtle text-warning border border-warning-subtle assoc-tag" : "badge bg-secondary-subtle text-secondary border border-secondary-subtle assoc-tag" %>'>
                                        <%# Eval("ClassName").ToString() == "" ? "General/Competitive" : Eval("ClassName") %>
                                    </span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SEO Title">
                            <ItemTemplate>
                                <div class="small text-muted text-truncate" style="max-width: 220px;" title='<%# Eval("PageTitle") %>'>
                                    <%# string.IsNullOrEmpty(Eval("PageTitle").ToString()) ? "<em class='text-danger'>Missing Title</em>" : Eval("PageTitle") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status" ItemStyle-Width="120px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnToggle" runat="server" CommandName="ToggleActive" CommandArgument='<%# Eval("SubjectId") %>' 
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active" : "badge-inactive" %>'>
                                    <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "fas fa-check-circle me-1" : "fas fa-times-circle me-1" %>'></i>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Hidden" %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <div class="d-flex gap-2">
                                    <a href='EditSubject.aspx?id=<%# Eval("SubjectId") %>' class="btn btn-sm btn-outline-primary px-3 shadow-sm">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                        OnClientClick="return confirm('Delete this subject and all its linked chapters?');" 
                                        CssClass="btn btn-sm btn-outline-danger shadow-sm">
                                        <i class="fas fa-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="bg-light text-secondary small text-uppercase fw-bolder border-bottom" />
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <img src="/Admin/Assets/no-data.png" style="width: 100px; opacity: 0.5;" />
                            <p class="text-muted mt-3">No subjects found for the selected criteria.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>