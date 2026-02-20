<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResourceTypes.aspx.cs" Inherits="StudyIsleWeb.Admin.ResourceTypes.ManageResourceTypes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-header d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="admin-title mb-0">Manage Resources</h4>
        <small class="text-muted">All uploaded study materials</small>
    </div>

    <a href="AddResources.aspx" class="btn btn-primary">
        <i class="bi bi-plus-circle"></i> Add Resource
    </a>
</div>

<div class="card admin-card shadow-sm">
    <div class="card-body p-0">

        <div class="table-responsive">
            <asp:GridView ID="gvResources" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-hover align-middle mb-0"
                HeaderStyle-CssClass="table-light"
                OnRowCommand="gvResources_RowCommand">

                <Columns>

                    <asp:BoundField DataField="ResourceId" HeaderText="ID" />

                    <asp:BoundField DataField="BoardName" HeaderText="Board" />

                    <asp:BoundField DataField="ClassName" HeaderText="Class" />

                    <asp:BoundField DataField="SubjectName" HeaderText="Subject" />

                    <asp:BoundField DataField="TypeName" HeaderText="Type" />

                    <asp:BoundField DataField="Title" HeaderText="Title" />

                    <%-- Premium Badge -->--%>
                    <asp:TemplateField HeaderText="Premium">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("IsPremium")) 
                                ? "badge bg-warning text-dark"
                                : "badge bg-secondary" %>'>
                                <%# Convert.ToBoolean(Eval("IsPremium")) 
                                ? "Premium"
                                : "Free" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                   <%--  Status Toggle -->--%>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggle" runat="server"
                                CommandName="ToggleActive"
                                CommandArgument='<%# Eval("ResourceId") %>'
                                CssClass='<%# Convert.ToBoolean(Eval("IsActive")) 
                                    ? "badge bg-success text-white"
                                    : "badge bg-danger text-white" %>'>
                                <%# Convert.ToBoolean(Eval("IsActive")) 
                                    ? "Active"
                                    : "Inactive" %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- Downloads -->--%>
                    <asp:BoundField DataField="DownloadCount" HeaderText="Downloads" />

                   <%-- File Link -->--%>
                    <asp:TemplateField HeaderText="File">
                        <ItemTemplate>
                            <a href='<%# Eval("FilePath") %>' target="_blank"
                               class="btn btn-sm btn-outline-secondary">
                                View
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%--  Edit -->--%>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server"
                                CssClass="btn btn-sm btn-warning"
                                CommandName="EditResource"
                                CommandArgument='<%# Eval("ResourceId") %>'>
                                Edit
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>

    </div>
</div>

</asp:Content>
