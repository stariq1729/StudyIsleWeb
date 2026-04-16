<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ViewResources.aspx.cs"
    Inherits="StudyIsleWeb.ViewResources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Panzoom Library -->
    <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>

    <style>
        .resource-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .resource-card:hover {
            border-color: #6366f1;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
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

        .res-info h5 { margin: 0; font-weight: 700; color: #111827; }
        .res-info p { margin: 0; font-size: 0.9rem; color: #6b7280; }

        /* Viewer Styles */
        .viewer-container {
            display: none;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
        }

        .viewer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .viewer-frame {
            width: 100%;
            height: 600px;
            border: none;
            border-radius: 8px;
            background: #f1f5f9;
        }

        .zoom-container {
            width: 100%;
            height: 600px;
            overflow: hidden;
            background: #000;
            position: relative;
            touch-action: none;
        }

        .zoom-container img {
            position: absolute;
            top: 0;
            left: 0;
            max-width: none;
            max-height: none;
            transform-origin: 0 0;
            user-select: none;
            -webkit-user-drag: none;
            cursor: grab;
        }

        .zoom-container img:active {
            cursor: grabbing;
        }
        .viewer-container:fullscreen {
    width: 100vw;
    height: 100vh;
    background: #000;
    padding: 20px;
    box-sizing: border-box;
}

.viewer-container:fullscreen .viewer-frame,
.viewer-container:fullscreen .zoom-container {
    width: 100%;
    height: 92vh;
}


        @media (max-width: 768px) {
            .viewer-frame,
            .zoom-container {
                height: 70vh;
            }
        }
    </style>

    <script>
        let panzoomInstance = null;

        function getCleanFileName(path) {
            let file = path.split('/').pop();
            return file.substring(0, file.lastIndexOf('.')) || file;
        }

        function openResource(filePath, contentType) {
            const viewer = document.getElementById("resourceViewer");
            const pdfViewer = document.getElementById("pdfViewer");
            const imageViewer = document.getElementById("imageViewer");
            const zoomImage = document.getElementById("zoomImage");
            const viewerTitle = document.getElementById("viewerTitle");

            viewer.style.display = "block";
            pdfViewer.style.display = "none";
            imageViewer.style.display = "none";

            pdfViewer.src = "";
            zoomImage.src = "";

            if (panzoomInstance) {
                panzoomInstance.destroy();
                panzoomInstance = null;
            }

            const type = contentType.toLowerCase();
            viewerTitle.innerText = getCleanFileName(filePath);

            if (type.includes("pdf")) {
                pdfViewer.style.display = "block";
                pdfViewer.src = filePath + "#toolbar=1&navpanes=0&scrollbar=1";
            }
            else if (type.includes("image") || type.includes("mindmap")) {
                imageViewer.style.display = "block";
                zoomImage.src = filePath;

                zoomImage.onload = function () {
                    panzoomInstance = Panzoom(zoomImage, {
                        maxScale: 8,
                        minScale: 0.3,
                        contain: "outside",
                        cursor: "grab"
                    });

                    imageViewer.addEventListener(
                        "wheel",
                        panzoomInstance.zoomWithWheel,
                        { passive: false }
                    );
                };
            }
            else {
                pdfViewer.style.display = "block";
                pdfViewer.src = filePath;
            }

            viewer.scrollIntoView({ behavior: "smooth" });
            return false;
        }

        function closeViewer() {
            document.getElementById("resourceViewer").style.display = "none";
            document.getElementById("pdfViewer").src = "";
            document.getElementById("zoomImage").src = "";

            if (panzoomInstance) {
                panzoomInstance.destroy();
                panzoomInstance = null;
            }
        }

        function toggleFullscreen() {
            const viewer = document.getElementById("resourceViewer");

            if (!document.fullscreenElement) {
                if (viewer.requestFullscreen) {
                    viewer.requestFullscreen();
                } else if (viewer.webkitRequestFullscreen) { // Safari
                    viewer.webkitRequestFullscreen();
                } else if (viewer.msRequestFullscreen) { // IE/Edge
                    viewer.msRequestFullscreen();
                }
            } else {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.webkitExitFullscreen) {
                    document.webkitExitFullscreen();
                } else if (document.msExitFullscreen) {
                    document.msExitFullscreen();
                }
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <h2 class="fw-bold mb-4">Study Materials</h2>

                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="resource-card">
                            <div class="d-flex align-items-center">
                                <div class='<%# "icon-box " + GetStatusClass(Eval("ContentType").ToString()) %>'>
                                    <i class='<%# GetIcon(Eval("ContentType").ToString()) %>'></i>
                                </div>
                                <div class="res-info">
                                    <h5><%# Eval("Title") %></h5>
                                    <p><%# Eval("Description") %></p>
                                    <small class="text-muted">
                                        <%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %>
                                    </small>
                                </div>
                            </div>
                            <div>
                                <a href="#"
                                   class="btn btn-primary rounded-pill px-4"
                                   onclick="return openResource('<%# ResolveUrl(Eval("FilePath").ToString()).Replace("'", "\\'") %>',
                                   '<%# Eval("ContentType").ToString().Replace("'", "\\'") %>');">
                                    <i class="fas fa-eye me-2"></i>Open
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Viewer -->
                <div id="resourceViewer" class="viewer-container">
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
                </div>

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