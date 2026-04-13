<%@ Page Title="Flashcard Viewer" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="FlashcardViewer.aspx.cs"
    Inherits="StudyIsleWeb.Flashcards.FlashcardViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f5f7fb;
        }

        .viewer-container {
            max-width: 900px;
            margin: 30px auto;
            text-align: center;
        }

        /* Header */
        .viewer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            color: #6c757d;
            font-size: 14px;
        }

        .viewer-header a {
            text-decoration: none;
            color: #6c757d;
            font-weight: 600;
        }

        /* Flashcard */
        .flashcard {
            perspective: 1000px;
            margin-bottom: 20px;
        }

        .flashcard-inner {
            position: relative;
            width: 100%;
            height: 320px;
            transition: transform 0.6s;
            transform-style: preserve-3d;
            cursor: pointer;
        }

        .flashcard.flipped .flashcard-inner {
            transform: rotateY(180deg);
        }

        .flashcard-front,
        .flashcard-back {
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 18px;
            backface-visibility: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .flashcard-front {
            background: #ffffff;
        }

        .flashcard-back {
            background: linear-gradient(135deg, #5b5be0, #4b4bd3);
            color: #ffffff;
            transform: rotateY(180deg);
        }

        .card-label {
            font-size: 12px;
            letter-spacing: 1px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #6c757d;
        }

        .flashcard-back .card-label {
            color: #e0e0ff;
        }

        .card-text {
            font-size: 18px;
            font-weight: 600;
            line-height: 1.6;
        }

        .card-image {
            max-width: 150px;
            margin-bottom: 15px;
            border-radius: 10px;
        }

        .flip-hint {
            font-size: 12px;
            margin-top: 15px;
            color: #999;
        }

        .flashcard-back .flip-hint {
            color: #dcdcff;
        }

        /* Progress Bar */
        .progress {
            height: 6px;
            border-radius: 5px;
            margin: 20px 0;
            background-color: #e9ecef;
        }

        .progress-bar {
            background: #4b4bd3;
        }

        /* Navigation Buttons */
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .btn-custom {
            min-width: 140px;
            border-radius: 8px;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #4b4bd3;
            border: none;
        }

        .btn-primary:hover {
            background-color: #3d3dbb;
        }

        /* Completion Panel */
        .completion-panel {
            background: #ffffff;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .completion-panel h3 {
            margin-top: 15px;
            font-weight: 700;
        }

        .completion-icon {
            font-size: 40px;
        }
    </style>

    <script>
        function flipCard() {
            document.getElementById("flashcard").classList.toggle("flipped");
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="viewer-container">

        <!-- Header -->
        <div class="viewer-header">
            <a href="javascript:history.back()">← Chapters</a>
            <asp:Label ID="lblCardCount" runat="server" Text=""></asp:Label>
        </div>

        <!-- Flashcard Panel -->
        <asp:Panel ID="pnlFlashcard" runat="server">

            <div id="flashcard" class="flashcard" onclick="flipCard()">
                <div class="flashcard-inner">

                    <!-- Front Side -->
                    <div class="flashcard-front">
                        <div class="card-label">QUESTION</div>

                        <asp:Image ID="imgQuestion" runat="server"
                            CssClass="card-image" Visible="false" />

                        <asp:Label ID="lblQuestion" runat="server"
                            CssClass="card-text"></asp:Label>

                        <div class="flip-hint">TAP TO REVEAL</div>
                    </div>

                    <!-- Back Side -->
                    <div class="flashcard-back">
                        <div class="card-label">ANSWER</div>

                        <asp:Image ID="imgAnswer" runat="server"
                            CssClass="card-image" Visible="false" />

                        <asp:Label ID="lblAnswer" runat="server"
                            CssClass="card-text"></asp:Label>

                        <div class="flip-hint">TAP TO FLIP BACK</div>
                    </div>

                </div>
            </div>

            <!-- Progress Bar -->
            <div class="progress">
                <div id="progressBar" runat="server"
                    class="progress-bar" role="progressbar"></div>
            </div>

            <!-- Navigation Buttons -->
            <div class="nav-buttons">
                <asp:Button ID="btnPrevious" runat="server"
                    Text="Previous"
                    CssClass="btn btn-outline-secondary btn-custom"
                    OnClick="btnPrevious_Click" />

                <asp:Button ID="btnNext" runat="server"
                    Text="Next Card"
                    CssClass="btn btn-primary btn-custom"
                    OnClick="btnNext_Click" />
            </div>

        </asp:Panel>

        <!-- Completion Panel -->
        <asp:Panel ID="pnlCompletion" runat="server" Visible="false">
            <div class="completion-panel">
                <div class="completion-icon">🎉</div>
                <h3>Great Job!</h3>
                <p>You’ve completed all cards for this session.</p>

                <asp:Button ID="btnNewTopic" runat="server"
                    Text="New Topic"
                    CssClass="btn btn-primary me-2"
                    OnClick="btnNewTopic_Click" />

                <asp:Button ID="btnReviewAgain" runat="server"
                    Text="Review Again"
                    CssClass="btn btn-outline-secondary"
                    OnClick="btnReviewAgain_Click" />
            </div>
        </asp:Panel>

    </div>

</asp:Content>