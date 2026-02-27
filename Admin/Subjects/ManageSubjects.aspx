<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubjects.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.ManageSubjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .subject-icon-grid { width: 45px; height: 45px; object-fit: contain; background: #f8f9fa; border: 1px solid #e2e8f0; border-radius: 6px; padding: 4px; }
        .badge-active { background-color: #d1fae5; color: #065f46; padding: 0.4rem 0.8rem; border-radius: 50px; font-size: 0.75rem; font-weight: 600; text-decoration: none; }
        .badge-inactive { background-color: #fee2e2; color: #991b1b; padding: 0.4rem 0.8rem; border-radius: 50px; font-size: 0.75rem; font-weight: 600; text-decoration: none; }
        .filter-card { background: #fff; border-radius: 10px; border: 1px solid #eef0f2; margin-bottom: 20px; }
        .table-responsive { border-radius: 10px; overflow: hidden; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0">Manage Subjects</h4>
            <a href="AddSubject.aspx" class="btn btn-primary shadow-sm">+ Add New Subject</a>
        </div>

        <div class="filter-card shadow-sm p-3">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="small fw-bold text-secondary mb-1">Filter by Board</label>
                    <asp:DropDownList ID="ddlBoardFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnClear" runat="server" Text="Reset Filters" CssClass="btn btn-light border w-100" OnClick="btnClear_Click" />
                </div>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

        <div class="card border-0 shadow-sm">
            <div class="table-responsive">
<asp:GridView ID="gvSubjects" runat="server" AutoGenerateColumns="False" 
    CssClass="table table-hover align-middle mb-0" GridLines="None" 
    DataKeyNames="SubjectId" OnRowCommand="gvSubjects_RowCommand" OnRowDeleting="gvSubjects_RowDeleting">
    <Columns>
        <asp:TemplateField HeaderText="Icon" ItemStyle-Width="80px">
            <ItemTemplate>
                <img src='<%# "/Uploads/SubjectIcons/" + (string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "Default-icon.png" : Eval("IconImage")) %>' class="subject-icon-grid" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Subject Details">
            <ItemTemplate>
                <div class="fw-bold text-dark"><%# Eval("SubjectName") %></div>
                <div class="small text-muted"><%# Eval("Slug") %></div>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Association">
            <ItemTemplate>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1"><%# Eval("BoardName") %></span>
                <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1"><%# Eval("ClassName").ToString() == "" ? "General" : Eval("ClassName") %></span>
            </ItemTemplate>
        </asp:TemplateField>

        <%-- Corrected SEO Title Field --%>
        <asp:TemplateField HeaderText="SEO Title">
            <ItemTemplate>
                <div class="small text-truncate" style="max-width: 200px;" title='<%# Eval("PageTitle") %>'>
                    <%# Eval("PageTitle") %>
                </div>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <asp:LinkButton ID="btnToggle" runat="server" CommandName="ToggleActive" CommandArgument='<%# Eval("SubjectId") %>' 
                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active" : "badge-inactive" %>'>
                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                </asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <div class="btn-group">
                    <a href='EditSubject.aspx?id=<%# Eval("SubjectId") %>' class="btn btn-sm btn-outline-primary">
                        Edit
                    </a>
                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                        OnClientClick="return confirm('Are you sure? This will delete the subject permanently.');" 
                        CssClass="btn btn-sm btn-outline-danger ms-1">
                        Delete
                    </asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <HeaderStyle CssClass="bg-light text-secondary small text-uppercase fw-bold" />
</asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>