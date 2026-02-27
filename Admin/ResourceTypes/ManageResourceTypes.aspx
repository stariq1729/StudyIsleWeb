<%@ Page Title="Manage Resource Types" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResourceTypes.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.ManageResourceTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-table img { border-radius: 4px; background: #fff; }
        .badge-board { background-color: #e9ecef; color: #495057; border: 1px solid #dee2e6; margin-right: 2px; font-size: 0.75rem; }
        .flow-indicator { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-header d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="page-title text-primary fw-bold">Manage Resource Types</h4>
            <p class="page-subtitle text-muted">View and manage resource visibility across boards.</p>
        </div>
        <a href="AddResourceType.aspx" class="btn btn-primary shadow-sm px-4">
            <i class="fas fa-plus-circle me-2"></i>Add New Type
        </a>
    </div>

    <div class="card mb-4 shadow-sm border-0">
        <div class="card-body bg-light rounded">
            <div class="row g-3 align-items-end">
                <div class="col-md-5">
                    <label class="form-label fw-bold small text-uppercase text-secondary">Search Name or Slug</label>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Type here to search..." AutoPostBack="true" OnTextChanged="btnFilter_Click"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-uppercase text-secondary">Status Filter</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="btnFilter_Click">
                        <asp:ListItem Text="Show All Status" Value=""></asp:ListItem>
                        <asp:ListItem Text="Active Only" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Inactive Only" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:LinkButton ID="btnFilter" runat="server" CssClass="btn btn-dark w-100" OnClick="btnFilter_Click">
                        <i class="fas fa-search me-2"></i>Apply Filters
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="table-responsive">
            <asp:GridView ID="gvResourceTypes" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-hover admin-table mb-0 align-middle"
                OnRowCommand="gvResourceTypes_RowCommand"
                DataKeyNames="ResourceTypeId" GridLines="None">

                <Columns>
                    <asp:TemplateField HeaderText="Icon" ItemStyle-Width="70px">
                        <ItemTemplate>
                            <img src='<%# "/Uploads/ResourceIcons/" + (string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "default-icon.png" : Eval("IconImage")) %>' 
                                 alt="icon" style="width: 40px; height: 40px; object-fit: contain; padding: 2px; border: 1px solid #eee;" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Resource Details">
                        <ItemTemplate>
                            <div class="fw-bold text-dark"><%# Eval("TypeName") %></div>
                            <div class="text-primary small" style="font-size: 0.8rem;">slug: /<%# Eval("Slug") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Mapped Boards">
                        <ItemTemplate>
                            <div class="d-flex flex-wrap gap-1">
                                <%# GetBoardBadges(Eval("MappedBoards")) %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Access/Flow">
                        <ItemTemplate>
                            <div class="mb-1">
                                <%# Convert.ToBoolean(Eval("IsPremium")) 
                                    ? "<span class='badge bg-warning text-dark'><i class='fas fa-crown me-1'></i>Premium</span>" 
                                    : "<span class='badge bg-light text-muted border'>Free</span>" %>
                            </div>
                            <div class="flow-indicator text-muted">
                                <%# GetFlowSummary(Eval("HasClass"), Eval("HasSubject"), Eval("HasChapter")) %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="DisplayOrder" HeaderText="Order" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggle" runat="server"
                                CommandName="ToggleActive"
                                CommandArgument='<%# Eval("ResourceTypeId") %>'
                                CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success text-white" : "badge bg-danger text-white" %>'
                                style="text-decoration:none; padding: 6px 12px;">
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Hidden" %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <a href='EditResourceType.aspx?id=<%# Eval("ResourceTypeId") %>' class="btn btn-sm btn-outline-primary me-1">
                                <i class="fas fa-edit"></i>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-5">
                        <i class="fas fa-folder-open fa-3x text-light mb-3"></i>
                        <p class="text-muted">No resources match your filters.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>