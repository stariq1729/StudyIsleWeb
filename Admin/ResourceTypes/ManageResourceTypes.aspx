<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResourceTypes.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.ManageResourceTypes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="admin-header d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="page-title text-primary">Manage Resource Types</h4>
            <p class="page-subtitle text-muted">Control icons, premium status, and hierarchy flow</p>
        </div>
        <a href="AddResourceType.aspx" class="btn btn-primary shadow-sm">+ Add Resource Type</a>
    </div>

    <div class="card mb-4 shadow-sm border-0 bg-light">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-uppercase">Search Name/Slug</label>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..." AutoPostBack="true" OnTextChanged="btnFilter_Click"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-uppercase">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="btnFilter_Click">
                        <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                        <asp:ListItem Text="Active Only" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Inactive Only" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:LinkButton ID="btnFilter" runat="server" CssClass="btn btn-secondary w-100" OnClick="btnFilter_Click">
                        <i class="fas fa-filter"></i> Filter
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div class="card admin-card shadow-sm border-0">
        <asp:GridView ID="gvResourceTypes" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-hover admin-table mb-0 align-middle"
            OnRowCommand="gvResourceTypes_RowCommand"
            DataKeyNames="ResourceTypeId" GridLines="None">

            <Columns>
                <asp:BoundField DataField="ResourceTypeId" HeaderText="ID" ItemStyle-CssClass="text-muted small" />

                <%-- Image Preview Column --%>
                <asp:TemplateField HeaderText="Icon">
                    <ItemTemplate>
                        <div class="p-1 border rounded bg-white d-inline-block">
                            <img src='<%# "/Uploads/ResourceIcons/" + (string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "default-icon.png" : Eval("IconImage")) %>' 
                                 alt="icon" style="width: 35px; height: 35px; object-fit: contain;" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Resource Info">
                    <ItemTemplate>
                        <div class="fw-bold text-dark"><%# Eval("TypeName") %></div>
                        <div class="text-muted small">/<%# Eval("Slug") %></div>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Access">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("IsPremium"))
                            ? "<span class='badge bg-warning text-dark'><i class='fas fa-crown me-1'></i>Premium</span>"
                            : "<span class='badge bg-light text-muted border text-dark'>Free</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="DisplayOrder" HeaderText="Order" ItemStyle-CssClass="fw-bold text-center" />

                <asp:TemplateField HeaderText="Flow Structure">
                    <ItemTemplate>
                        <div class="d-flex flex-wrap gap-1">
                            <%# Convert.ToBoolean(Eval("HasClass")) ? "<span class='badge bg-info text-dark small'>Class</span>" : "" %>
                            <%# Convert.ToBoolean(Eval("HasSubject")) ? "<span class='badge bg-info text-dark small'>Subject</span>" : "" %>
                            <%# Convert.ToBoolean(Eval("HasChapter")) ? "<span class='badge bg-info text-dark small'>Chapter</span>" : "" %>
                            <%# Convert.ToBoolean(Eval("HasYear")) ? "<span class='badge bg-info text-dark small'>Year</span>" : "" %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnToggle" runat="server"
                            CommandName="ToggleActive"
                            CommandArgument='<%# Eval("ResourceTypeId") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success text-white" : "badge bg-danger text-white" %>'
                            style="text-decoration:none;">
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <a href='EditResourceType.aspx?id=<%# Eval("ResourceTypeId") %>' class="btn btn-sm btn-outline-warning">
                             Edit
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
            <EmptyDataTemplate>
                <div class="text-center p-5 text-muted">No resource types found.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

</asp:Content>