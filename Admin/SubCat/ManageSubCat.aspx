<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubCat.aspx.cs" Inherits="StudyIsleWeb.Admin.SubCat.ManageSubCat" %>
<%--<%@ Page Title="Manage SubCategories" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubCategories.aspx.cs" Inherits="StudyIsleWeb.Admin.SubCat.ManageSubCategories" %>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <h4 class="fw-bold text-dark mb-0">Sub-Category Library</h4>
                <a href="AddSubCategory.aspx" class="btn btn-primary rounded-pill px-4 shadow-sm">+ Add New</a>
            </div>
            <div class="card-body">
                <div class="row g-3 mb-4 p-3 bg-light rounded border mx-0">
                    <div class="col-md-4">
                        <label class="form-label fw-bold small">Filter by Board</label>
                        <asp:DropDownList ID="ddlBoardFilter" runat="server" CssClass="form-select shadow-none" AutoPostBack="true" 
                            OnSelectedIndexChanged="FilterChanged" DataTextField="BoardName" DataValueField="BoardId">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold small">Filter by Resource Type</label>
                        <asp:DropDownList ID="ddlTypeFilter" runat="server" CssClass="form-select shadow-none" AutoPostBack="true" 
                            OnSelectedIndexChanged="FilterChanged" DataTextField="TypeName" DataValueField="ResourceTypeId">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4 d-flex align-items-end justify-content-end">
                         <asp:Label ID="lblCount" runat="server" CssClass="badge bg-secondary p-2"></asp:Label>
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvSubCats" runat="server" AutoGenerateColumns="False" CssClass="table table-hover border align-middle" 
                        DataKeyNames="SubCategoryId" OnRowDeleting="gvSubCats_RowDeleting">
                        <Columns>
                            <asp:TemplateField HeaderText="Icon" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <img src='<%# "/Uploads/SubCategoryIcons/" + Eval("IconImage") %>' 
                                         class="rounded shadow-sm border" style="width:50px; height:50px; object-fit:cover;" 
                                         onerror="this.src='/Uploads/SubCategoryIcons/default-sub.png';" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Sub-Category Details">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark"><%# Eval("SubCategoryName") %></div>
                                    <small class="text-muted d-block">Slug: <%# Eval("Slug") %></small>
                                    <div class="mt-1">
                                        <span class="badge bg-light text-dark border"><i class="fas fa-university me-1"></i><%# Eval("BoardName") %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mapping & Flow">
                                <ItemTemplate>
                                    <div class="mb-1">
                                        <%# Convert.ToBoolean(Eval("IsCompetitiveFlow")) ? 
                                            "<span class='badge bg-warning text-dark'><i class='fas fa-vial me-1'></i>Competitive Flow</span>" : 
                                            "<span class='badge bg-info text-dark'><i class='fas fa-book me-1'></i>Standard Flow</span>" %>
                                    </div>
                                    <small class="text-secondary">
                                        <%# Eval("TypeName") == DBNull.Value ? "<em>No Resource Mapping</em>" : "Linked: <strong>" + Eval("TypeName") + "</strong>" %>
                                    </small>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? 
                                        "<span class='text-success'><i class='fas fa-check-circle'></i> Active</span>" : 
                                        "<span class='text-danger'><i class='fas fa-times-circle'></i> Inactive</span>" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="160px">
                                <ItemTemplate>
                                    <div class="btn-group">
                                        <a href='EditSubCategory.aspx?id=<%# Eval("SubCategoryId") %>' class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" 
                                            OnClientClick="return confirm('Are you sure you want to delete this sub-category?');">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center py-5">
                                <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                                <h5 class="text-secondary">No sub-categories found for this filter.</h5>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>