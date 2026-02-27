<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageClasses.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.ManageClasses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .badge-active { background-color: #d1fae5; color: #065f46; padding: 0.5rem 0.8rem; border-radius: 50px; text-decoration: none; font-size: 0.8rem; font-weight: 600; display: inline-block; }
        .badge-inactive { background-color: #fee2e2; color: #991b1b; padding: 0.5rem 0.8rem; border-radius: 50px; text-decoration: none; font-size: 0.8rem; font-weight: 600; display: inline-block; }
        .badge-active:hover, .badge-inactive:hover { opacity: 0.8; color: inherit; }
        .admin-header { border-bottom: 2px solid #f8f9fa; padding-bottom: 1rem; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="admin-header d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="page-title fw-bold">Manage Classes</h4>
                <p class="text-muted mb-0">Manage classes board-wise with UI metadata</p>
            </div>
            <div>
                <a href="AddClass.aspx" class="btn btn-primary px-4 shadow-sm">+ Add New Class</a>
            </div>
        </div>

        <div class="card border-0 shadow-sm mb-4 p-3 bg-white">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-uppercase text-secondary">Filter by Board</label>
                    <asp:DropDownList ID="ddlBoardFilter" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlBoardFilter_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm bg-white">
            <div class="table-responsive">
                <asp:GridView ID="gvClasses" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle mb-0"
                    OnRowCommand="gvClasses_RowCommand"
                    DataKeyNames="ClassId"
                    GridLines="None">

                    <Columns>
                        <asp:BoundField DataField="ClassId" HeaderText="ID" ItemStyle-CssClass="text-muted small fw-bold" />
                        
                        <asp:BoundField DataField="BoardName" HeaderText="Board" />
                        
                        <asp:BoundField DataField="ClassName" HeaderText="Class Name" ItemStyle-CssClass="fw-bold text-dark" />
                        
                        <asp:TemplateField HeaderText="Page Header Title">
                            <ItemTemplate>
                                <span class="small text-truncate d-inline-block" style="max-width: 180px;" title='<%# Eval("PageTitle") %>'>
                                    <%# Eval("PageTitle") != DBNull.Value && !string.IsNullOrEmpty(Eval("PageTitle").ToString()) ? Eval("PageTitle") : "<span class='text-muted italic'>Not Set</span>" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="DisplayOrder" HeaderText="Order" ItemStyle-HorizontalAlign="Center" />

                        <%-- Created Date Column --%>
                        <asp:TemplateField HeaderText="Created Date">
                            <ItemTemplate>
                                <div class="small text-secondary">
                                    <%# Eval("CreatedAt") != DBNull.Value ? Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy") : "---" %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnToggle" runat="server"
                                    CommandName="ToggleActive"
                                    CommandArgument='<%# Eval("ClassId") %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active" : "badge-inactive" %>'>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <a href='EditClass.aspx?id=<%# Eval("ClassId") %>' class="btn btn-sm btn-outline-primary px-3">
                                    Edit
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="bg-light text-secondary small text-uppercase" />
                    <EmptyDataTemplate>
                        <div class="p-5 text-center text-muted">No classes found for this board.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>