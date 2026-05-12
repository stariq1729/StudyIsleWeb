<%@ Page Title="Manage Sets" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageSets.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Sets.ManageSets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .badge-active {
            background: #dcfce7;
            color: #15803d;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-inactive {
            background: #fee2e2;
            color: #b91c1c;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .filter-card {
            border: 1px solid #eef2f7;
            border-radius: 12px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container-fluid py-4">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1">Manage Sets</h3>
                <p class="text-muted mb-0">
                    Manage set hierarchy and mappings
                </p>
            </div>

            <a href="AddSets.aspx"
                class="btn btn-primary">
                + Add New Set
            </a>
        </div>

        <!-- FILTERS -->

        <div class="card filter-card shadow-sm mb-4">
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
                            OnSelectedIndexChanged="FilterChanged">
                        </asp:DropDownList>
                    </div>

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

                    <div class="col-md-3 d-flex align-items-end">
                        <asp:Label ID="lblCount"
                            runat="server"
                            CssClass="fw-bold text-primary">
                        </asp:Label>
                    </div>

                </div>

            </div>
        </div>

        <!-- GRID -->

        <div class="card shadow-sm border-0">

            <div class="table-responsive">

                <asp:GridView ID="gvSets"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle mb-0"
                    GridLines="None"
                    DataKeyNames="SetId"
                    OnRowCommand="gvSets_RowCommand">

                    <Columns>

                        <asp:BoundField DataField="SetId"
                            HeaderText="ID" />

                        <asp:BoundField DataField="SetName"
                            HeaderText="Set Name" />

                        <asp:BoundField DataField="BoardName"
                            HeaderText="Board" />

                        <asp:BoundField DataField="TypeName"
                            HeaderText="Resource Type" />

                        <asp:TemplateField HeaderText="Hierarchy">
                            <ItemTemplate>

                                <div class="d-flex flex-column">

                                    <small>
                                        <%# Eval("ClassName") %>
                                    </small>

                                    <small>
                                        <%# Eval("SubjectName") %>
                                    </small>

                                    <small>
                                        <%# Eval("SubCategoryName") %>
                                    </small>

                                    <small>
                                        <%# Eval("ChapterName") %>
                                    </small>

                                </div>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="YearName"
                            HeaderText="Year" />

                        <asp:BoundField DataField="DisplayOrder"
                            HeaderText="Order" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>

                                <%# Convert.ToBoolean(Eval("IsActive"))
                                    ? "<span class='badge-active'>Active</span>"
                                    : "<span class='badge-inactive'>Inactive</span>" %>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">

                            <ItemTemplate>

                                <div class="btn-group">

                                    <a href='AddSets.aspx?id=<%# Eval("SetId") %>'
                                        class="btn btn-sm btn-outline-primary">
                                        Edit
                                    </a>

                                    <asp:LinkButton ID="btnToggle"
                                        runat="server"
                                        CssClass="btn btn-sm btn-outline-warning"
                                        CommandName="ToggleActive"
                                        CommandArgument='<%# Eval("SetId") %>'>
                                        Toggle
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnDelete"
                                        runat="server"
                                        CssClass="btn btn-sm btn-outline-danger"
                                        CommandName="DeleteMe"
                                        CommandArgument='<%# Eval("SetId") %>'
                                        OnClientClick="return confirm('Delete this set?');">
                                        Delete
                                    </asp:LinkButton>

                                </div>

                            </ItemTemplate>

                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>

        </div>

    </div>

</asp:Content>