<%@ Page Title="Flashcard Viewer" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="FlashcardViewer.aspx.cs"
    Inherits="StudyIsleWeb.Flashcards.FlashcardViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .viewer-container {
            max-width: 700px;
            margin: 40px auto;
            text-align: center;
        }

        /* Header Navigation */
        .viewer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 0 10px;
        }

        .viewer-header a {
            text-decoration: none;
            color: #94a3b8;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.2s;
        }

        .viewer-header a:hover {
            color: #4b4bd3;
        }

        .card-counter {
            color: #94a3b8;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        /* The Flashcard */
        .flashcard {
            perspective: 1000px;
            margin-bottom: 25px;
        }

        .flashcard-inner {
            position: relative;
            width: 100%;
            height: 380px;
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
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
            border-radius: 24px;
            backface-visibility: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 40px; /* Space for absolute labels */
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }

        .flashcard-front {
            background: #ffffff;
            border: 1px solid #edf2f7;
        }

        .flashcard-back {
            background: #4f46e5;
            color: #ffffff;
            transform: rotateY(180deg);
        }

        /* Absolute Positions for Labels & Hints */
        .card-label {
            position: absolute;
            top: 30px;
            font-size: 11px;
            letter-spacing: 2px;
            font-weight: 700;
            color: #cbd5e0;
        }

        .flashcard-back .card-label {
            color: rgba(255, 255, 255, 0.6);
        }

        .flip-hint {
            position: absolute;
            bottom: 30px;
            font-size: 11px;
            letter-spacing: 1px;
            font-weight: 600;
            color: #cbd5e0;
            text-transform: uppercase;
        }

        .flashcard-back .flip-hint {
            color: rgba(255, 255, 255, 0.6);
        }

        /* Fixed Image Handling */
        .image-container {
    width: 100%;
    max-height: 180px; /* Limits how much space the image can take */
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 15px;
    overflow: hidden;
}

.card-image {
    max-height: 180px;
    max-width: 100%;
    object-fit: contain; /* Keeps aspect ratio without squishing */
    display: block;
}

        .card-text {
            font-size: 22px;
            font-weight: 700;
            line-height: 1.4;
            color: #1e293b;
        }

        .flashcard-back .card-text {
            color: #ffffff;
        }

        /* Progress Bar */
        .progress-container {
            height: 6px;
            background-color: #e2e8f0;
            border-radius: 10px;
            margin: 22px 0;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            background: #4f46e5;
            transition: width 0.4s ease;
        }

        /* Navigation Buttons */
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            gap: 15px;
        }

        .btn-viewer {
            flex: 1;
            height: 55px;
            border-radius: 14px;
            font-weight: 700;
            font-size: 16px;
            border: none;
            transition: all 0.2s;
            cursor: pointer;
        }

        .btn-prev {
            background-color: #f1f5f9;
            color: #64748b;
            border: 1px solid black;
        }

        .btn-prev:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-next {
            background-color: #3b82f6;
            color: white;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .btn-next:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
        }

        /* Completion Panel */
        /* Completion Panel Styles */
.completion-panel {
    background: #ffffff;
    padding: 40px;
    border-radius: 18px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

/* The Icon Circle */
.completion-icon {
    font-size: 30px;
    width: 60px;
    height: 60px;
    background: #f0fdf4; /* Light green background */
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}

.completion-panel h3 {
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 10px;
}

.completion-panel p {
    color: #64748b;
    margin-bottom: 25px;
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
        <div class="viewer-header">
            <a href="javascript:history.back()">← Chapters</a>
            <asp:Label ID="lblCardCount" runat="server" CssClass="card-counter"></asp:Label>
        </div>

       <asp:Panel ID="pnlFlashcard" runat="server">
    <div id="flashcard" class="flashcard" onclick="flipCard()">
        <div class="flashcard-inner">

            <div class="flashcard-front">
                <div class="card-label">QUESTION</div>
                
                <div id="divQuestionImg" runat="server" class="image-container">
                    <asp:Image ID="imgQuestion" runat="server" CssClass="card-image" />
                </div>

                <asp:Label ID="lblQuestion" runat="server" CssClass="card-text"></asp:Label>
                <div class="flip-hint">TAP TO REVEAL</div>
            </div>

            <div class="flashcard-back">
                <div class="card-label">ANSWER</div>
                
                <div id="divAnswerImg" runat="server" class="image-container">
                    <asp:Image ID="imgAnswer" runat="server" CssClass="card-image" />
                </div>

                <asp:Label ID="lblAnswer" runat="server" CssClass="card-text"></asp:Label>
                <div class="flip-hint">TAP TO FLIP BACK</div>
            </div>

        </div>
    </div>

    <div class="progress-container">
        <div id="progressBar" runat="server" class="progress-bar-fill"></div>
    </div>

    <div class="nav-buttons">
        <asp:Button ID="btnPrevious" runat="server"
            Text="Previous"
            CssClass="btn-viewer btn-prev"
            OnClick="btnPrevious_Click" />

        <asp:Button ID="btnNext" runat="server"
            Text="Next Card"
            CssClass="btn-viewer btn-next"
            OnClick="btnNext_Click" />
    </div>
</asp:Panel>

       <asp:Panel ID="pnlCompletion" runat="server" Visible="false">
    <div class="completion-panel">
        <div class="completion-icon">🎉</div>
        <h3>Great Job!</h3>
        <p>You’ve completed all cards for this session.</p>
        
        <div style="display: flex; gap: 10px;">
            <asp:Button ID="btnNewTopic" runat="server"
                Text="New Topic"
                CssClass="btn-viewer btn-next" 
                OnClick="btnNewTopic_Click" />

            <asp:Button ID="btnReviewAgain" runat="server"
                Text="Review Again"
                CssClass="btn-viewer btn-prev" 
                OnClick="btnReviewAgain_Click" />
        </div>
    </div>
</asp:Panel>
    </div>
</asp:Content>