<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ResourceViewer.aspx.cs"
    Inherits="StudyIsleWeb.ResourceViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Panzoom -->
    <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>

    <style>

        body {
            background: #f8fafc;

        }

        .resource-page {
            padding: 22px 0 40px;
            min-height: 100vh;
            width: 100%;
        }

        /* =========================
           BREADCRUMB
        ==========================*/

        .resource-breadcrumb {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            font-size: 0.85rem;
            color: #64748b;
            margin-bottom: 18px;
        }

        .resource-breadcrumb span {
            color: #cbd5e1;
        }

        .resource-breadcrumb a {
            color: #64748b;
            text-decoration: none;
        }

        .resource-breadcrumb a:hover {
            color: #0f172a;
        }

        /* =========================
           HEADER
        ==========================*/

        .resource-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 22px;
            flex-wrap: wrap;
        }

        .resource-header-left {
            display: flex;
            gap: 16px;
            align-items: flex-start;
        }

        .back-btn {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #334155;
            text-decoration: none;
            transition: 0.2s;
        }

        .back-btn:hover {
            background: #f1f5f9;
            color: #0f172a;
        }

        .resource-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 2px;
        }

        .resource-subtitle {
            color: #64748b;
            font-size: 0.92rem;
        }

        /* =========================
           ACTIONS
        ==========================*/

        .viewer-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .action-btn {
            border: 1px solid #e2e8f0;
            background: #fff;
            border-radius: 10px;
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #334155;
            cursor: pointer;
            transition: 0.2s;
        }

        .action-btn:hover {
            background: #f1f5f9;
        }

        /* =========================
           VIEWER
        ==========================*/

        .viewer-wrapper {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
            position: relative;
        }

        .viewer-area {
            width: 100%;
            height: 85vh;
            background: #f1f5f9;
            position: relative;

        }

        /* PDF */

        .pdf-frame {
            width: 100%;
            height: 100%;
            border: none;
        }

        /* IMAGE / MINDMAP */

        .zoom-container {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: #e2e8f0;
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

        /* VIDEO */

        .video-player {
            width: 100%;
            height: 100%;
            background: #000;
        }

        /* FULLSCREEN */

        .viewer-wrapper:fullscreen {
            background: #fff;
        }

        .viewer-wrapper:fullscreen .viewer-area {
            height: 100vh;
        }

        /* MOBILE */

        @media (max-width: 768px) {

            .resource-title {
                font-size: 1.2rem;
            }

            .viewer-area {
                height: 72vh;
            }

            .resource-header {
                align-items: stretch;
            }

            .viewer-actions {
                width: 100%;
                justify-content: flex-end;
            }
        }

    </style>

    <script>

        let panzoomInstance = null;

        // =========================
        // FULLSCREEN
        // =========================

        function toggleFullscreen() {

            const viewer = document.getElementById("viewerWrapper");

            if (!document.fullscreenElement) {
                viewer.requestFullscreen();
            }
            else {
                document.exitFullscreen();
            }
        }

        // =========================
        // PANZOOM
        // =========================

        function initPanzoom() {

            const imageViewer = document.getElementById("imageViewer");
            const zoomImage = document.getElementById("zoomImage");

            if (!imageViewer || !zoomImage)
                return;

            zoomImage.onload = function () {

                if (typeof Panzoom === "undefined") {
                    console.error("Panzoom failed.");
                    return;
                }

                if (panzoomInstance) {
                    panzoomInstance.destroy();
                    panzoomInstance = null;
                }

                panzoomInstance = Panzoom(zoomImage, {
                    maxScale: 8,
                    minScale: 0.2,
                    contain: "outside",
                    startScale: 1,
                    cursor: "grab"
                });

                imageViewer.onwheel = function (e) {
                    e.preventDefault();
                    panzoomInstance.zoomWithWheel(e);
                };

                // Auto fit image

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

        window.onload = function () {
            initPanzoom();
        };

    </script>

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="resource-page">

        <div class="container">

            <!-- =========================
                 BREADCRUMB
            ==========================-->

            <div class="resource-breadcrumb">

                <a href="Default.aspx">
                    Home
                </a>

                <span>/</span>

                <asp:Literal ID="litResourceType" runat="server"></asp:Literal>

                <span>/</span>

                <asp:Literal ID="litSubject" runat="server"></asp:Literal>

                <span>/</span>

                <asp:Literal ID="litCategory" runat="server"></asp:Literal>

            </div>

            <!-- =========================
                 HEADER
            ==========================-->

            <div class="resource-header">

                <div class="resource-header-left">

                    <!-- BACK -->

                    <a href="javascript:history.back()"
                        class="back-btn">

                        <i class="fas fa-arrow-left"></i>

                    </a>

                    <!-- TITLE -->

                    <div>

                        <h1 class="resource-title">
                            <asp:Literal ID="litTitle" runat="server"></asp:Literal>
                        </h1>

                        <div class="resource-subtitle">
                            <asp:Literal ID="litViewerType" runat="server"></asp:Literal>
                        </div>

                    </div>

                </div>

                <!-- ACTIONS -->

                <div class="viewer-actions">

                    <!-- FULLSCREEN ONLY -->

                    <button type="button"
                        class="action-btn"
                        onclick="toggleFullscreen()">

                        <i class="fas fa-expand"></i>

                    </button>

                </div>

            </div>

            <!-- =========================
                 VIEWER
            ==========================-->

            <div class="viewer-wrapper"
                id="viewerWrapper">

                <div class="viewer-area">

                    <!-- PDF -->

                    <asp:PlaceHolder ID="phPdf"
                        runat="server"
                        Visible="false">

                        <iframe id="pdfViewer"
                            runat="server"
                            class="pdf-frame">
                        </iframe>

                    </asp:PlaceHolder>

                    <!-- IMAGE / MINDMAP -->

                    <asp:PlaceHolder ID="phImage"
                        runat="server"
                        Visible="false">

                        <div id="imageViewer"
                            class="zoom-container">

                            <img id="zoomImage"
                                runat="server"
                                src=""
                                alt="Viewer" />

                        </div>

                    </asp:PlaceHolder>

                    <!-- VIDEO -->

                    <asp:PlaceHolder ID="phVideo"
                        runat="server"
                        Visible="false">

                        <video id="videoPlayer"
                            runat="server"
                            class="video-player"
                            controls
                            controlsList="nodownload noplaybackrate">
                        </video>

                    </asp:PlaceHolder>

                </div>

            </div>

        </div>

    </div>

</asp:Content>