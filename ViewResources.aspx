<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ViewResources.aspx.cs"
    Inherits="StudyIsleWeb.ViewResources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Panzoom Library -->
    <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>

    <style>
                .resource-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 18px 20px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: 0.3s;
            cursor: pointer;
        }

.resource-card:hover {
    border-color: #6366f1;
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(0,0,0,0.06);
}

        .icon-box {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-right: 20px;
        }

        .bg-pdf { background: #fee2e2; color: #dc2626; }
        .bg-image { background: #fef9c3; color: #854d0e; }
        .bg-default { background: #f3f4f6; color: #374151; }
        .resource-number {
    width: 48px;
    height: 48px;
    min-width: 48px;
    border-radius: 12px;
    background: #eef2ff;
    color: #4f46e5;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 1rem;
    margin-right: 18px;
}

.resource-right-icon {
    width: 42px;
    height: 42px;
    min-width: 42px;
    border-radius: 10px;
    background: #f8fafc;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    color: #475569;
    border: 1px solid #e2e8f0;
}

.resource-card-inner {
    display: flex;
    align-items: center;
    width: 100%;
    justify-content: space-between;
}

.resource-left {
    display: flex;
    align-items: center;
    min-width: 0;
}

.res-info h5 {
    margin: 0;
    font-weight: 700;
    color: #1e293b;
    font-size: 1rem;
}

.res-info p {
    margin: 4px 0 0;
    font-size: 0.87rem;
    color: #64748b;
}
        .res-info h5 { margin: 0; font-weight: 700; color: #111827; }
        .res-info p { margin: 0; font-size: 0.9rem; color: #6b7280; }

        /* Viewer Styles */
        


        @media (max-width: 768px) {
            .viewer-frame,
            .zoom-container {
                height: 70vh;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <h2 class="fw-bold mb-4">Study Materials</h2>

               <asp:Repeater ID="rptResources" runat="server" OnItemCommand="rptResources_ItemCommand">
                    <ItemTemplate>

<div class="resource-card"
     onclick="window.location='ResourceViewer.aspx?id=<%# Eval("ResourceId") %>';">


    <div class="resource-card-inner">

        <!-- LEFT -->
        <div class="resource-left">

            <!-- NUMBER -->
            <div class="resource-number">
                <%# Container.ItemIndex + 1 %>
            </div>

            <!-- CONTENT -->
            <div class="res-info">

                <h5><%# Eval("Title") %></h5>

                <p><%# Eval("Description") %></p>

            </div>

        </div>

        <!-- RIGHT ICON -->
        <div class="resource-right-icon">

            <i class='<%# GetIcon(Eval("ContentType").ToString()) %>'></i>

        </div>

    </div>

</div>

</ItemTemplate>
                </asp:Repeater>

                <!-- Viewer -->
                <%--<div id="resourceViewer" class="viewer-container">
                    <div class="viewer-header">
                        <h5 id="viewerTitle">Resource Viewer</h5>
                        <div>
                            <button type="button" class="btn btn-success btn-sm" onclick="toggleFullscreen()">
    Fullscreen
</button>

<button type="button" class="btn btn-danger btn-sm" onclick="closeViewer()">
    Close
</button>
                        </div>
                    </div>

                    <iframe id="pdfViewer" class="viewer-frame" style="display:none;"></iframe>

                    <div id="imageViewer" class="zoom-container" style="display:none;">
                        <img id="zoomImage" src="" alt="Resource Viewer" />
                    </div>
                </div>--%>

                <asp:PlaceHolder ID="phNoData" runat="server" Visible="false">
                    <div class="text-center py-5">
                        <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">No resources uploaded yet for this section.</h4>
                    </div>
                </asp:PlaceHolder>

            </div>
        </div>
    </div>
</asp:Content>