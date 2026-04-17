<%@ Page Title="Resources" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ViewResource.aspx.cs"
    Inherits="StudyIsleWeb.ViewResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Mobile Optimization -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Panzoom Library (Reliable CDN) -->
    <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>

    <style>
        .res-container {
            background: #f8fafc;
            padding: 40px 0;
            min-height: 85vh;
        }

        .resource-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: 0.3s;
        }

        .resource-card:hover {
            border-color: #6366f1;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
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
        .bg-img { background: #fef9c3; color: #854d0e; }
        .bg-vid { background: #dbeafe; color: #2563eb; }
        .bg-gen { background: #f1f5f9; color: #475569; }

        .res-info h5 { margin: 0; font-weight: 700; color: #1e293b; }
        .res-info p { margin: 3px 0 0; font-size: 0.85rem; color: #64748b; }

        /* Viewer Container */
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
            flex-wrap: wrap;
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

/* Fullscreen */
.viewer-container:fullscreen .zoom-container {
    height: 92vh;
}

@media (max-width: 768px) {
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

            // PDF Viewer
            if (type.includes("pdf")) {
                pdfViewer.style.display = "block";
                pdfViewer.src = filePath + "#toolbar=0&navpanes=0&scrollbar=0";
            }
            // Image/Mindmap Viewer
            else if (type.includes("image") || type.includes("mindmap")) {
                imageViewer.style.display = "block";
                zoomImage.src = filePath;

                zoomImage.onload = function () {
                    if (typeof Panzoom === "undefined") {
                        console.error("Panzoom library failed to load.");
                        return;
                    }

                    // Destroy previous instance
                    if (panzoomInstance) {
                        panzoomInstance.destroy();
                        panzoomInstance = null;
                    }

                    // Initialize Panzoom
                    panzoomInstance = Panzoom(zoomImage, {
                        maxScale: 8,
                        minScale: 0.2,
                        contain: "outside",
                        startScale: 1,
                        cursor: "grab"
                    });

                    // Enable mouse wheel zoom
                    imageViewer.onwheel = (e) => {
                        e.preventDefault();
                        panzoomInstance.zoomWithWheel(e);
                    };

                    // Fit image within container initially
                    const containerWidth = imageViewer.clientWidth;
                    const containerHeight = imageViewer.clientHeight;
                    const imgWidth = zoomImage.naturalWidth;
                    const imgHeight = zoomImage.naturalHeight;

                    const scaleX = containerWidth / imgWidth;
                    const scaleY = containerHeight / imgHeight;
                    const scale = Math.min(scaleX, scaleY, 1);

                    panzoomInstance.zoom(scale, { animate: false });
                    panzoomInstance.pan(0, 0, { animate: false });
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
                viewer.requestFullscreen();
            } else {
                document.exitFullscreen();
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="res-container">
        <div class="container">
            <div class="col-lg-10 mx-auto">
                <h3 class="fw-bold mb-4">Study Materials</h3>

                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="resource-card">
                            <div class="d-flex align-items-center">
                                <div class='<%# "icon-box " + GetTheme(Eval("ContentType").ToString()) %>'>
                                    <i class='<%# GetIcon(Eval("ContentType").ToString()) %>'></i>
                                </div>
                                <div class="res-info">
                                    <h5><%# Eval("Title") %></h5>
                                    <p><%# Eval("Description") %></p>
                                </div>
                            </div>
                            <a href="#"
                               class="btn btn-primary rounded-pill px-4"
                               onclick="return openResource('<%# ResolveUrl(Eval("FilePath").ToString()).Replace("'", "\\'") %>',
                               '<%# Eval("ContentType").ToString().Replace("'", "\\'") %>');">
                                Open
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Resource Viewer -->
                <div id="resourceViewer" class="viewer-container">
                    <div class="viewer-header">
                        <h5 id="viewerTitle">Resource Viewer</h5>
                        <div>
                            <button type="button" class="btn btn-success btn-sm" onclick="toggleFullscreen()">Fullscreen</button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="closeViewer()">Close</button>
                        </div>
                    </div>

                    <!-- PDF Viewer -->
                    <iframe id="pdfViewer" class="viewer-frame" style="display:none;"></iframe>

                    <!-- Image/Mindmap Viewer -->
                    <div id="imageViewer" class="zoom-container" style="display:none;">
                        <img id="zoomImage" src="" alt="Resource Viewer" />
                    </div>
                </div>

                <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                    <div class="text-center py-5 border rounded-3 bg-white">
                        <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No resources found for this selection.</h5>
                    </div>
                </asp:PlaceHolder>

            </div>
        </div>
    </div>
</asp:Content>