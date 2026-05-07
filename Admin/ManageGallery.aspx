<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageGallery.aspx.cs"
    Inherits="StudyIsleWeb.Admin.ManageGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        /* =========================================
           MANAGE GALLERY PAGE
        ========================================= */

        .manage-gallery-page {
            padding: 35px;
            background: #f4f7fb;
            min-height: 100vh;
        }

        /* HEADER */

        .manage-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .manage-title {
            font-size: 34px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 8px;
        }

        .manage-subtitle {
            font-size: 15px;
            color: #64748b;
        }

        .add-gallery-btn {
            background: #7367ff;
            color: #ffffff;
            padding: 14px 26px;
            border-radius: 14px;
            font-size: 15px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .add-gallery-btn:hover {
            background: #5b4eff;
            color: #ffffff;
        }

        /* GRID */

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
        }

        /* CARD */

        .gallery-card {
            background: #ffffff;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            transition: 0.3s;
        }

        .gallery-card:hover {
            transform: translateY(-4px);
        }

        /* IMAGE */

        .gallery-image-wrap {
            position: relative;
            height: 240px;
            overflow: hidden;
        }

        .gallery-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* STATUS */

        .status-badge {
            position: absolute;
            top: 16px;
            left: 16px;
            padding: 8px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .status-active {
            background: #22c55e;
        }

        .status-inactive {
            background: #ef4444;
        }

        /* BODY */

        .gallery-card-body {
            padding: 24px;
        }

        .gallery-title-card {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .gallery-description {
            font-size: 15px;
            line-height: 1.7;
            color: #64748b;
            margin-bottom: 22px;

            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .gallery-date {
            font-size: 13px;
            font-weight: 600;
            color: #94a3b8;
            margin-bottom: 24px;
        }

        /* ACTIONS */

        .gallery-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .action-btn {
            flex: 1;
            border: none;
            border-radius: 12px;
            padding: 12px 18px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .edit-btn {
            background: #7367ff;
            color: #ffffff;
        }

        .edit-btn:hover {
            background: #5b4eff;
        }

        .toggle-btn {
            background: #f1f5f9;
            color: #334155;
        }

        .toggle-btn:hover {
            background: #e2e8f0;
        }

        .delete-btn {
            background: #ef4444;
            color: #ffffff;
        }

        .delete-btn:hover {
            background: #dc2626;
        }

        /* EMPTY */

        .empty-state {
            background: #ffffff;
            border-radius: 24px;
            padding: 80px 30px;
            text-align: center;
        }

        .empty-title {
            font-size: 28px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 14px;
        }

        .empty-subtitle {
            color: #64748b;
            font-size: 16px;
        }

        /* RESPONSIVE */

        @media(max-width:1100px) {

            .gallery-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media(max-width:768px) {

            .manage-gallery-page {
                padding: 20px;
            }

            .gallery-grid {
                grid-template-columns: 1fr;
            }

            .manage-title {
                font-size: 28px;
            }

            .gallery-title-card {
                font-size: 22px;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="manage-gallery-page">

        <!-- HEADER -->

        <div class="manage-header">

            <div>

                <div class="manage-title">
                    Manage Gallery
                </div>

                <div class="manage-subtitle">
                    Manage all uploaded gallery images and content.
                </div>

            </div>

            <a href="AddGallery.aspx" class="add-gallery-btn">
                + Add Gallery
            </a>

        </div>

        <!-- GRID -->

        <asp:Repeater ID="rptGallery" runat="server"
            OnItemCommand="rptGallery_ItemCommand">

            <HeaderTemplate>

                <div class="gallery-grid">

            </HeaderTemplate>

            <ItemTemplate>

                <div class="gallery-card">

                    <!-- IMAGE -->

                    <div class="gallery-image-wrap">

                        <img src='<%# Eval("ImagePath") %>'
                            class="gallery-image" />

                        <div class='status-badge <%# Convert.ToBoolean(Eval("IsActive")) ? "status-active" : "status-inactive" %>'>

                            <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>

                        </div>

                    </div>

                    <!-- BODY -->

                    <div class="gallery-card-body">

                        <div class="gallery-title-card">
                            <%# Eval("Title") %>
                        </div>

                        <div class="gallery-description">
                            <%# Eval("Description") %>
                        </div>

                        <div class="gallery-date">
                            <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                        </div>

                        <!-- ACTIONS -->

                        <div class="gallery-actions">

                            <!-- EDIT -->

                            <asp:Button ID="btnEdit"
                                runat="server"
                                Text="Edit"
                                CssClass="action-btn edit-btn"
                                CommandName="EditGallery"
                                CommandArgument='<%# Eval("GalleryId") %>' />

                            <!-- TOGGLE -->

                            <asp:Button ID="btnToggle"
                                runat="server"
                                Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Disable" : "Activate" %>'
                                CssClass="action-btn toggle-btn"
                                CommandName="ToggleStatus"
                                CommandArgument='<%# Eval("GalleryId") %>' />

                            <!-- DELETE -->

                            <asp:Button ID="btnDelete"
                                runat="server"
                                Text="Delete"
                                CssClass="action-btn delete-btn"
                                CommandName="DeleteGallery"
                                CommandArgument='<%# Eval("GalleryId") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this gallery item?');" />

                        </div>

                    </div>

                </div>

            </ItemTemplate>

            <FooterTemplate>

                </div>

            </FooterTemplate>

        </asp:Repeater>

        <!-- EMPTY STATE -->

        <asp:Panel ID="pnlEmpty"
            runat="server"
            Visible="false">

            <div class="empty-state">

                <div class="empty-title">
                    No Gallery Items Found
                </div>

                <div class="empty-subtitle">
                    Start by adding your first gallery image.
                </div>

            </div>

        </asp:Panel>

    </div>

</asp:Content>