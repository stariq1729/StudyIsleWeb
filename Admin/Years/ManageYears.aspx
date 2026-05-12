<%@ Page Title="Manage Year Mappings" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageYears.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Years.ManageYears" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        .year-card {
            border: none;
            border-radius: 14px;
        }

        .table thead {
            background: #f8fafc;
            text-transform: uppercase;
            font-size: 12px;
            color: #64748b;
        }

        .badge-active {
            background: #dcfce7;
            color: #15803d;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .badge-inactive {
            background: #fee2e2;
            color: #b91c1c;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .path-badge {
            background: #eff6ff;
            color: #2563eb;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

    </style>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container-fluid py-4">

      <%--  <1!-- HEADER -->--%>

        <div class="d-flex justify-content-between align-items-center mb-4">

            <div>
                <h3 class="fw-bold mb-1">
                    Manage Year Mappings
                </h3>

                <p class="text-muted mb-0">
                    Manage all year-resource hierarchy mappings
                </p>
            </div>

            <a href="../Years/AddYear.aspx"
                class="btn btn-primary">

                <i class="bi bi-plus-lg me-1"></i>
                Add Mapping

            </a>

        </div>

      <%--  <!1-- FILTERS -->--%>

        <div class="card shadow-sm year-card mb-4">

            <div class="card-body">

                <div class="row g-3">

                   <%-- <1!-- BOARD -->--%>

                    <div class="col-md-3">

                        <label class="form-label fw-bold small">
                            Board
                        </label>

                        <asp:DropDownList ID="ddlBoard"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="FilterChanged">
                        </asp:DropDownList>

                    </div>

                    <%--<!-1- RESOURCE -->--%>

                    <div class="col-md-3">

                        <label class="form-label fw-bold small">
                            Resource Type
                        </label>

                        <asp:DropDownList ID="ddlResourceType"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="FilterChanged">
                        </asp:DropDownList>

                    </div>

                    <%--<!1-- YEAR -->--%>

                    <div class="col-md-3">

                        <label class="form-label fw-bold small">
                            Year
                        </label>

                        <asp:DropDownList ID="ddlYear"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="FilterChanged">
                        </asp:DropDownList>

                    </div>

                </div>

            </div>

        </div>

        <%--<1!-- GRID -->--%>

        <div class="card shadow-sm year-card">

            <div class="table-responsive">

                <asp:GridView ID="gvMappings"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle mb-0"
                    GridLines="None"
                    DataKeyNames="MappingId"
                    OnRowCommand="gvMappings_RowCommand">

                    <Columns>

                        <%--<!-1- YEAR -->--%>

                        <asp:TemplateField HeaderText="Year">

                            <ItemTemplate>

                                <div class="fw-bold text-primary">
                                    <%# Eval("YearName") %>
                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                        <%--<!1--1 BOARD -->--%>

                        <asp:TemplateField HeaderText="Board">

                            <ItemTemplate>

                                <div class="fw-semibold">
                                    <%# Eval("BoardName") %>
                                </div>

                                <div class="small text-muted">
                                    <%# Eval("TypeName") %>
                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                       <%-- <1!-- HIERARCHY -->--%>

                        <asp:TemplateField HeaderText="Hierarchy Path">

                            <ItemTemplate>

                                <div class="d-flex flex-wrap gap-2">

                                    <asp:PlaceHolder runat="server"
                                        Visible='<%# Eval("ClassName") != DBNull.Value %>'>

                                        <span class="path-badge">
                                            <%# Eval("ClassName") %>
                                        </span>

                                    </asp:PlaceHolder>

                                    <asp:PlaceHolder runat="server"
                                        Visible='<%# Eval("SubCategoryName") != DBNull.Value %>'>

                                        <span class="path-badge">
                                            <%# Eval("SubCategoryName") %>
                                        </span>

                                    </asp:PlaceHolder>

                                    <asp:PlaceHolder runat="server"
                                        Visible='<%# Eval("SubjectName") != DBNull.Value %>'>

                                        <span class="path-badge">
                                            <%# Eval("SubjectName") %>
                                        </span>

                                    </asp:PlaceHolder>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                       <%-- <!1-- STATUS -->--%>

                        <asp:TemplateField HeaderText="Status"
                            ItemStyle-Width="130px">

                            <ItemTemplate>

                                <asp:LinkButton ID="lnkStatus"
                                    runat="server"
                                    CommandName="ToggleActive"
                                    CommandArgument='<%# Eval("MappingId") %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active text-decoration-none" : "badge-inactive text-decoration-none" %>'>

                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>

                                </asp:LinkButton>

                            </ItemTemplate>

                        </asp:TemplateField>

                       <%-- <1!-- ACTIONS -->--%>

                        <asp:TemplateField HeaderText="Actions"
                            ItemStyle-Width="140px">

                            <ItemTemplate>

                                <div class="d-flex gap-2">

                                    <a href='../Years/AddYear.aspx?id=<%# Eval("MappingId") %>'
                                        class="btn btn-sm btn-light border">

                                        <i class="bi bi-pencil"></i>

                                    </a>

                                    <asp:LinkButton ID="btnDelete"
                                        runat="server"
                                        CommandName="DeleteMe"
                                        CommandArgument='<%# Eval("MappingId") %>'
                                        CssClass="btn btn-sm btn-outline-danger"
                                        OnClientClick="return confirm('Delete this mapping permanently?');">

                                        <i class="bi bi-trash"></i>

                                    </asp:LinkButton>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                    </Columns>

                    <EmptyDataTemplate>

                        <div class="text-center p-5">

                            <h5 class="text-muted">
                                No Year Mappings Found
                            </h5>

                            <p class="small text-secondary">
                                Create new year mappings from AddYear page.
                            </p>

                        </div>

                    </EmptyDataTemplate>

                </asp:GridView>

            </div>

        </div>

    </div>

</asp:Content>