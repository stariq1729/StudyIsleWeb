<%@ Page Title="Manage Chapters" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageChapters.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Chapters.ManageChapters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        .table thead {
            background: #f8fafc;
            text-transform: uppercase;
            font-size: 12px;
            color: #64748b;
        }

        .chapter-card {
            border: none;
            border-radius: 14px;
        }

        .badge-active {
            background: #dcfce7;
            color: #15803d;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-inactive {
            background: #fee2e2;
            color: #b91c1c;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container-fluid py-4">

        <!-- HEADER -->

        <div class="d-flex justify-content-between align-items-center mb-4">

            <div>
                <h3 class="fw-bold mb-1">Manage Chapters</h3>
                <p class="text-muted mb-0">
                    Manage all chapter resources from here
                </p>
            </div>

            <a href="AddChapter.aspx"
                class="btn btn-primary">

                <i class="bi bi-plus-lg me-1"></i>
                Add Chapter

            </a>

        </div>

        <%--<-- FILTERS -->--%>

        <div class="card shadow-sm chapter-card mb-4">

            <div class="card-body">

                <div class="row g-3">

                    

                    <div class="col-md-3">

                        <label class="form-label fw-bold small">
                            Board
                        </label>

                        <asp:DropDownList ID="ddlBoard"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                        </asp:DropDownList>

                    </div>

                   <%-- !-- RESOURCE TYPE ----%>

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

                    <%--<!- CLASS -->--%>

                    <asp:PlaceHolder ID="phSchool"
                        runat="server"
                        Visible="false">

                        <div class="col-md-3">

                            <label class="form-label fw-bold small">
                                Class
                            </label>

                            <asp:DropDownList ID="ddlClass"
                                runat="server"
                                CssClass="form-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                            </asp:DropDownList>

                        </div>

                        <div class="col-md-3">

                            <label class="form-label fw-bold small">
                                Subject
                            </label>

                            <asp:DropDownList ID="ddlSubject"
                                runat="server"
                                CssClass="form-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="FilterChanged">
                            </asp:DropDownList>

                        </div>

                    </asp:PlaceHolder>

                    <%--<!- SUBCATEGORY -->--%>

                    <asp:PlaceHolder ID="phCompetitive"
                        runat="server"
                        Visible="false">

                        <div class="col-md-3">

                            <label class="form-label fw-bold small">
                                Sub-Category
                            </label>

                            <asp:DropDownList ID="ddlSubCategory"
                                runat="server"
                                CssClass="form-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="FilterChanged">
                            </asp:DropDownList>

                        </div>

                    </asp:PlaceHolder>

                </div>

            </div>

        </div>

<%--        <!- GRID -->--%>

        <div class="card shadow-sm chapter-card">

            <div class="table-responsive">

                <asp:GridView ID="gvChapters"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle mb-0"
                    GridLines="None"
                    DataKeyNames="ChapterId"
                    OnRowCommand="gvChapters_RowCommand">

                    <Columns>

                        <%--<!-PATH -->--%>

                        <asp:TemplateField HeaderText="Hierarchy">

                            <ItemTemplate>

                                <div class="ps-2">

                                    <div class="fw-semibold text-primary">
                                        <%# Eval("BoardName") %>
                                    </div>

                                    <div class="small text-muted">
                                        <%# Eval("HierarchyPath") %>
                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                        <%--<-- CHAPTER -->--%>

                        <asp:TemplateField HeaderText="Chapter">

                            <ItemTemplate>

                                <div class="fw-bold text-dark">
                                    <%# Eval("ChapterName") %>
                                </div>

                                <div class="small text-muted">
                                    <%# Eval("TypeName") %>
                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                  <%--      !-- STATUS -->--%>

                        <asp:TemplateField HeaderText="Status"
                            ItemStyle-Width="130px">

                            <ItemTemplate>

                                <asp:LinkButton ID="lnkStatus"
                                    runat="server"
                                    CommandName="ToggleActive"
                                    CommandArgument='<%# Eval("ChapterId") %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active text-decoration-none" : "badge-inactive text-decoration-none" %>'>

                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>

                                </asp:LinkButton>

                            </ItemTemplate>

                        </asp:TemplateField>

                        <%--<!-- ACTIOS ->--%>

                        <asp:TemplateField HeaderText="Actions"
                            ItemStyle-Width="140px">

                            <ItemTemplate>

                                <div class="d-flex gap-2">

                                    <a href='AddChapter.aspx?id=<%# Eval("ChapterId") %>'
                                        class="btn btn-sm btn-light border">

                                        <i class="bi bi-pencil"></i>

                                    </a>

                                    <asp:LinkButton ID="btnDelete"
                                        runat="server"
                                        CommandName="DeleteMe"
                                        CommandArgument='<%# Eval("ChapterId") %>'
                                        CssClass="btn btn-sm btn-outline-danger"
                                        OnClientClick="return confirm('Delete this chapter permanently?');">

                                        <i class="bi bi-trash"></i>

                                    </asp:LinkButton>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                    </Columns>

                    <EmptyDataTemplate>

                        <div class="text-center p-5">

                            <h5 class="text-muted">
                                No Chapters Found
                            </h5>

                            <p class="small text-secondary">
                                Try changing filters or add new chapter.
                            </p>

                        </div>

                    </EmptyDataTemplate>

                </asp:GridView>

            </div>

        </div>

    </div>

</asp:Content>