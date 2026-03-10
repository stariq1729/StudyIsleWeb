<%@ Page Title="Manage Classes" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageClasses.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.ManageClasses" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
                <div>
                    <h4 class="fw-bold text-dark mb-0">Class Management</h4>
                    <p class="text-muted small mb-0">Layer 2: Assigned to specific Boards</p>
                </div>
                <a href="AddClass.aspx" class="btn btn-primary rounded-pill px-4 shadow-sm">+ Add New Class</a>
            </div>
            
            <div class="card-body">
                <div class="row mb-4 g-3 align-items-center p-3 bg-light rounded mx-0">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Filter by Board</label>
                        <asp:DropDownList ID="ddlBoardFilter" runat="server" CssClass="form-select shadow-none" 
                            AutoPostBack="true" OnSelectedIndexChanged="ddlBoardFilter_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-8 text-end">
                         <span class="text-muted small">Showing classes for the selected board hierarchy.</span>
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvClasses" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-hover align-middle border" DataKeyNames="ClassId" 
                        OnRowDeleting="gvClasses_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="DisplayOrder" HeaderText="Order" ItemStyle-Width="70px" />
                            
                            <asp:TemplateField HeaderText="Class Details">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark"><%# Eval("ClassName") %></div>
                                    <div class="small text-muted">Slug: <%# Eval("Slug") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Parent Board">
                                <ItemTemplate>
                                    <span class="badge bg-secondary-subtle text-secondary border px-3">
                                        <%# Eval("BoardName") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SEO Content">
                                <ItemTemplate>
                                    <div class="small text-truncate" style="max-width: 250px;" title='<%# Eval("PageTitle") %>'>
                                        <strong>Title:</strong> <%# Eval("PageTitle") %>
                                    </div>
                                    <div class="small text-muted text-truncate" style="max-width: 250px;">
                                        <%# Eval("PageSubtitle") %>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? 
                                        "<span class='badge bg-success-subtle text-success'><i class='fas fa-check me-1'></i>Active</span>" : 
                                        "<span class='badge bg-danger-subtle text-danger'><i class='fas fa-times me-1'></i>Hidden</span>" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="btn-group">
                                        <a href='EditClass.aspx?id=<%# Eval("ClassId") %>' class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" 
                                            CssClass="btn btn-sm btn-outline-danger" 
                                            OnClientClick="return confirm('Delete this class? This may affect linked subjects!');">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center py-5">
                                <h5 class="text-muted">No classes found for this board.</h5>
                                <p class="small">Click 'Add New Class' to begin building your hierarchy.</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>