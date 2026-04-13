<%@ Page Title="Flashcards" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="FlashcardSetList.aspx.cs"
    Inherits="StudyIsleWeb.Flashcards.FlashcardSetList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .flashcard-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
        }

        .flashcard-card {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            padding: 40px;
            text-align: center;
            transition: transform 0.3s ease-in-out;
        }

        .flashcard-card:hover {
            transform: translateY(-5px);
        }

        .flashcard-icon {
            font-size: 50px;
            color: #4F46E5;
            margin-bottom: 15px;
        }

        .chapter-title {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        .flashcard-description {
            font-size: 16px;
            color: #555;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .flashcard-details {
            background: #f8f9fc;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 15px;
            color: #444;
        }

        .start-btn {
            background: linear-gradient(135deg, #4F46E5, #6366F1);
            color: #fff;
            border: none;
            padding: 12px 35px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .start-btn:hover {
            background: linear-gradient(135deg, #4338CA, #4F46E5);
            transform: scale(1.05);
        }

        .no-data {
            text-align: center;
            font-size: 18px;
            color: #dc3545;
            padding: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="flashcard-container">

        <asp:Panel ID="pnlFlashcard" runat="server" Visible="false">
            <div class="flashcard-card">
                
                <div class="flashcard-icon">
                    📚
                </div>

                <!-- Chapter Name -->
                <asp:Label ID="lblChapterName" runat="server"
                    CssClass="chapter-title"></asp:Label>

                <!-- Description -->
                <p class="flashcard-description">
                    Strengthen your understanding with interactive flashcards designed to help you
                    revise key concepts quickly and effectively. Each card presents a question on the
                    front and a clear explanation on the back, enhancing memory retention and conceptual clarity.
                </p>

                <!-- Flashcard Details -->
                <div class="flashcard-details">
                    <strong>Total Flashcards:</strong>
                    <asp:Label ID="lblTotalFlashcards" runat="server"></asp:Label>
                    <br />
                    Review all important concepts before attempting quizzes or exams.
                </div>

                <!-- Start Button -->
                <asp:Button ID="btnStartFlashcards" runat="server"
                    Text="▶ Start Flashcards"
                    CssClass="start-btn"
                    OnClick="btnStartFlashcards_Click" />

            </div>
        </asp:Panel>

        <!-- No Flashcards Panel -->
        <asp:Panel ID="pnlNoFlashcards" runat="server" Visible="false">
            <div class="flashcard-card">
                <p class="no-data">
                    ❌ No flashcards available for this chapter yet.
                </p>
            </div>
        </asp:Panel>

    </div>

</asp:Content>