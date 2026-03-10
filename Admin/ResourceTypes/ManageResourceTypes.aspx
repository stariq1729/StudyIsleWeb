<%@ Page Title="Manage Resource Types" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResourceTypes.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.ManageResourceTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid mt-4">
        <div class="card shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">Resource Type Library</h4>
                <a href="AddResourceType.aspx" class="btn btn-success">+ Add New Type</a>
            </div>

            <div class="card-body">
                <div class="row mb-4 bg-light p-3 rounded border mx-0">
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Filter by Board</label>
                        <asp:DropDownList ID="ddlBoardFilter" runat="server" CssClass="form-select" AutoPostBack="true" 
                            OnSelectedIndexChanged="ddlBoardFilter_SelectedIndexChanged" DataTextField="BoardName" DataValueField="BoardId">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-8 d-flex align-items-end justify-content-end">
                        <asp:Label ID="lblCount" runat="server" CssClass="badge bg-secondary p-2"></asp:Label>
                    </div>
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="text-success d-block mb-2"></asp:Label>

                <div class="table-responsive">
                    <asp:GridView ID="gvResourceTypes" runat="server" AutoGenerateColumns="False" DataKeyNames="ResourceTypeId"
                        CssClass="table table-hover align-middle border" OnRowDeleting="gvResourceTypes_RowDeleting">
                        <Columns>
                            <asp:TemplateField HeaderText="Icon" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <img src='<%# "/Uploads/Icons/" + Eval("IconImage") %>' alt="icon" style="width:40px; height:40px; object-fit:contain;" 
                                         onerror="this.src='/Uploads/Icons/default-resource.png';" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Resource Info">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark"><%# Eval("TypeName") %></div>
                                    <small class="text-muted"><%# Eval("Slug") %></small>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Linked Boards">
                                <ItemTemplate>
                                    <span class="small text-wrap">
                                        <%# Eval("MappedBoards") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Hierarchy Layers (Enabled)">
                                <ItemTemplate>
                                    <div class="d-flex flex-wrap gap-1">
                                        <%# Convert.ToBoolean(Eval("HasClass")) ? "<span class='badge bg-light text-dark border'>Class</span>" : "" %>
                                        <%# Convert.ToBoolean(Eval("HasSubject")) ? "<span class='badge bg-light text-dark border'>Subject</span>" : "" %>
                                        <%# Convert.ToBoolean(Eval("HasSubCategory")) ? "<span class='badge bg-light text-dark border'>SubCat</span>" : "" %>
                                        <%# Convert.ToBoolean(Eval("HasChapter")) ? "<span class='badge bg-light text-dark border'>Chapter</span>" : "" %>
                                        <%# Convert.ToBoolean(Eval("HasYear")) ? "<span class='badge bg-light text-dark border'>Year</span>" : "" %>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsPremium")) ? "<span class='badge bg-warning text-dark'>Premium</span>" : "<span class='badge bg-success'>Free</span>" %>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "<span class='badge bg-info'>Active</span>" : "<span class='badge bg-danger'>Inactive</span>" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <a href='EditResourceType.aspx?id=<%# Eval("ResourceTypeId") %>' class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i> Edit</a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger"
                                        OnClientClick="return confirm('Deleting this will remove it from all mapped boards. Proceed?');">Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center py-5">
                                <h5>No resource types found for this filter.</h5>
                                <a href="AddResourceType.aspx" class="btn btn-primary btn-sm">Create First Type</a>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>