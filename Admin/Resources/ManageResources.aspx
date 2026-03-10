<%@ Page Title="Manage Resources" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResources.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.ManageResources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h4 class="fw-bold text-primary">Manage Resources</h4>
            <small class="text-muted">Search, filter, and track resource downloads</small>
        </div>
        <a href="AddResources.aspx" class="btn btn-primary shadow-sm">+ Add Resource</a>
    </div>

    <div class="card shadow-sm mb-4 border-0">
        <div class="card-body bg-light">
            <div class="row g-2">
                <div class="col-md-2">
                    <label class="small fw-bold">Board</label>
                    <asp:DropDownList ID="ddlFilterBoard" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold">Type</label>
                    <asp:DropDownList ID="ddlFilterType" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold">Class</label>
                    <asp:DropDownList ID="ddlFilterClass" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="small fw-bold">Subject</label>
                    <asp:DropDownList ID="ddlFilterSubject" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-sm btn-outline-secondary w-100" OnClick="btnClear_Click">Reset Filters</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <asp:GridView ID="gvResources" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-hover mb-0"
                GridLines="None"
                AllowPaging="true"
                PageSize="15"
                OnPageIndexChanging="gvResources_PageIndexChanging"
                OnRowCommand="gvResources_RowCommand">
                
                <HeaderStyle CssClass="bg-white border-bottom text-secondary small text-uppercase" />
                <Columns>
                    <asp:BoundField DataField="ResourceId" HeaderText="ID" ItemStyle-CssClass="small text-muted" />
                    
                    <asp:TemplateField HeaderText="Resource / Mapping">
                        <ItemTemplate>
                            <div class="fw-bold">
                                <asp:HyperLink ID="hlFile" runat="server" NavigateUrl='<%# Eval("FilePath") %>' Target="_blank" Text='<%# Eval("Title") %>'></asp:HyperLink>
                            </div>
                            <div class="small text-muted">
                                <%# Eval("BoardName") %> • <%# Eval("TypeName") %> 
                                <%# Eval("ClassName") != DBNull.Value ? " • " + Eval("ClassName") : "" %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="SubjectName" HeaderText="Subject" NullDisplayText="-" />
                    <asp:BoundField DataField="ChapterName" HeaderText="Chapter" NullDisplayText="-" />
                    
                    <asp:TemplateField HeaderText="Access">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("IsPremium")) ? "badge rounded-pill bg-warning text-dark" : "badge rounded-pill bg-info text-white" %>'>
                                <%# Convert.ToBoolean(Eval("IsPremium")) ? "Premium" : "Free" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Stats">
                        <ItemTemplate>
                            <div class="small">
                                <i class="bi bi-download"></i> <%# Eval("DownloadCount") %> Downloads
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggle" runat="server"
                                CommandName="Toggle"
                                CommandArgument='<%# Eval("ResourceId") %>'
                                CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success text-decoration-none" : "badge bg-danger text-decoration-none" %>'>
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Hidden" %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditItem" CommandArgument='<%# Eval("ResourceId") %>' CssClass="btn btn-sm btn-light border text-primary"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pagination-container p-3 border-top bg-light" />
                <EmptyDataTemplate>
                    <div class="p-5 text-center text-muted">No resources found matching your filters.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>