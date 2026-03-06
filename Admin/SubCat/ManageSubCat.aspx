<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageSubCat.aspx.cs" Inherits="StudyIsleWeb.Admin.SubCat.ManageSubCat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Manage SubCategories</h2>
        <a href="AddSubCategory.aspx" class="btn btn-primary rounded-pill px-4">+ Add New</a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <asp:GridView ID="gvSubCategories" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover align-middle" GridLines="None" 
                DataKeyNames="SubCategoryId" OnRowDeleting="gvSubCategories_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="SubCategoryId" HeaderText="ID" />
                    
                    <asp:TemplateField HeaderText="Icon">
                        <ItemTemplate>
                            <img src='<%# "/Uploads/SubCategoryIcons/" + Eval("IconImage") %>' 
                                 style="width: 40px; height: 40px; object-fit: cover;" class="rounded shadow-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="SubCategoryName" HeaderText="Title" />
                    <asp:BoundField DataField="BoardName" HeaderText="Board" />
                    
                    <asp:TemplateField HeaderText="Flow Type">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("IsCompetitiveFlow")) ? "badge bg-info text-dark" : "badge bg-secondary" %>'>
                                <%# Convert.ToBoolean(Eval("IsCompetitiveFlow")) ? "Competitive" : "Board" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                OnClientClick="return confirm('Delete this subcategory?');" 
                                CssClass="text-danger ms-2"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-4 text-muted">No subcategories found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</div>
</asp:Content>
