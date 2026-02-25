<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageResources.aspx.cs" Inherits="StudyIsleWeb.Admin.Resources.ManageResources" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="d-flex justify-content-between align-items-center mb-3">
    <div>
        <h4>Manage Resources</h4>
        <small class="text-muted">All uploaded study materials</small>
    </div>

    <a href="AddResources.aspx" class="btn btn-primary">
        + Add Resource
    </a>
</div>

<div class="card shadow-sm">
    <div class="card-body p-0">

        <asp:GridView ID="gvResources" runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-bordered table-hover"
            AllowPaging="true"
            PageSize="20"
            OnPageIndexChanging="gvResources_PageIndexChanging"
            OnRowCommand="gvResources_RowCommand">

            <Columns>

                <asp:BoundField DataField="ResourceId" HeaderText="ID" />
                <asp:BoundField DataField="BoardName" HeaderText="Board" />
                <asp:BoundField DataField="ClassName" HeaderText="Class" />
                <asp:BoundField DataField="SubjectName" HeaderText="Subject" />
                <asp:BoundField DataField="ChapterName" HeaderText="Chapter" />
                <asp:BoundField DataField="YearName" HeaderText="Year" />
                <asp:BoundField DataField="SubCategoryName" HeaderText="SubCategory" />
                <asp:BoundField DataField="TypeName" HeaderText="Type" />
                <asp:BoundField DataField="Title" HeaderText="Title" />

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

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnToggle" runat="server"
                            CommandName="Toggle"
                            CommandArgument='<%# Eval("ResourceId") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive")) 
                                ? "badge bg-success"
                                : "badge bg-danger" %>'>
                            <%# Convert.ToBoolean(Eval("IsActive")) 
                                ? "Active"
                                : "Inactive" %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server"
                            CommandName="EditItem"
                            CommandArgument='<%# Eval("ResourceId") %>'
                            CssClass="btn btn-sm btn-warning">
                            Edit
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>
    </div>
</div>

</asp:Content>
