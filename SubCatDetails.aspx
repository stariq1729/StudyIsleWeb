<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubCatDetails.aspx.cs" Inherits="StudyIsleWeb.SubCatDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5 text-center">
        <h1 class="fw-bold mb-2">Choose Type</h1>
        <p class="text-muted mb-5">Select a specific category to view available resources.</p>

        <div class="row g-4 justify-content-center">
            <asp:Repeater ID="rptSubCategories" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-lg-3">
                        <a href='<%# "BoardResource.aspx?board=" + Request.QueryString["board"] + "&res=" + Request.QueryString["res"] + "&subcat=" + Eval("Slug") %>' class="text-decoration-none">
                            <div class="card h-100 border-0 shadow-sm p-4 rounded-4 transition-hover">
                                <img src='<%# "/Uploads/SubCategoryIcons/" + Eval("IconImage") %>' class="mx-auto mb-3" style="width:70px; height:70px; object-fit:contain;" />
                                <h4 class="text-dark fw-bold mb-1"><%# Eval("SubCategoryName") %></h4>
                                <p class="small text-muted mb-0"><%# Eval("Description") %></p>
                            </div>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>