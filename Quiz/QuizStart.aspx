<%@ Page Title="Quiz Instructions" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizStart.aspx.cs"
    Inherits="StudyIsleWeb.Quiz.QuizStart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .quiz-wrapper {
            max-width: 750px;
            margin: 40px auto;
        }

        .quiz-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .quiz-header {
            background: linear-gradient(135deg, #4f46e5, #6d5dfc);
            color: #fff;
            padding: 25px;
        }

        .quiz-header h3 {
            margin: 0;
            font-weight: 600;
        }

        .quiz-header p {
            margin: 5px 0 0;
            font-size: 14px;
        }

        .quiz-body {
            padding: 25px;
        }

        .info-box {
            background: #f4f6fb;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
        }

        .info-title {
            font-size: 12px;
            color: #6c757d;
        }

        .info-value {
            font-size: 18px;
            font-weight: bold;
        }

        .instruction-list li {
            margin-bottom: 8px;
        }

        .start-btn {
            background: linear-gradient(135deg, #4f46e5, #6d5dfc);
            border: none;
            padding: 12px;
            width: 100%;
            color: #fff;
            font-weight: 600;
            border-radius: 8px;
        }

        .start-btn:hover {
            opacity: 0.95;
        }

        .back-link {
            margin-bottom: 15px;
            display: inline-block;
        }

        .difficulty-badge {
            padding: 5px 10px;
            border-radius: 8px;
            background: #e0e7ff;
            color: #4f46e5;
            font-weight: 600;
            font-size: 12px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container quiz-wrapper">

    <!-- Back Button -->
    <a href="javascript:history.back()" class="text-decoration-none back-link">
        ← Back to Chapters
    </a>

    <div class="quiz-card">

        <!-- Header -->
        <div class="quiz-header">
            <h3>
                <asp:Label ID="lblChapterName" runat="server"></asp:Label>
            </h3>
            <p>
                <asp:Label ID="lblQuizLabel" runat="server"></asp:Label>
            </p>
        </div>

        <!-- Body -->
        <div class="quiz-body">

            <!-- Quiz Info -->
            <div class="row text-center mb-4">
                <div class="col-md-3">
                    <div class="info-box">
                        <div class="info-title">QUESTIONS</div>
                        <div class="info-value">
                            <asp:Label ID="lblTotalQuestions" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="info-box">
                        <div class="info-title">TIME LIMIT</div>
                        <div class="info-value">
                            <asp:Label ID="lblTimeLimit" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="info-box">
                        <div class="info-title">TOTAL MARKS</div>
                        <div class="info-value">
                            <asp:Label ID="lblTotalMarks" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="info-box">
                        <div class="info-title">DIFFICULTY</div>
                        <div class="info-value">
                            <asp:Label ID="lblDifficulty" runat="server" CssClass="difficulty-badge"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Instructions -->
            <h5 class="mb-3">General Instructions</h5>
            <ul class="instruction-list">
                <li>The test contains <asp:Label ID="lblInstructionQuestions" runat="server"></asp:Label> multiple-choice questions.</li>
                <li>You have <asp:Label ID="lblInstructionTime" runat="server"></asp:Label> minutes to complete the test.</li>
                <li>Each question carries 1 mark.</li>
                <li>You can "Mark for Review" any question and return to it later.</li>
                <li>The test will auto-submit once the timer reaches zero.</li>
                <li>Click "Submit" only when you have finished all questions.</li>
            </ul>

            <!-- Test Settings -->
            <div class="card p-3 mb-4 bg-light">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="mb-1">Negative Marking</h6>
                        <small>-<asp:Label ID="lblNegativeMarks" runat="server"></asp:Label> marks for each incorrect answer</small>
                    </div>
                    <div class="form-check form-switch">
                        <asp:CheckBox ID="chkNegativeMarking" runat="server" CssClass="form-check-input" />
                    </div>
                </div>
            </div>

            <!-- Hidden Field -->
            <asp:HiddenField ID="hfQuizId" runat="server" />

            <!-- Begin Button -->
            <asp:Button ID="btnBeginTest" runat="server"
                Text="▶ Begin Test Now"
                CssClass="start-btn"
                OnClick="btnBeginTest_Click" />

        </div>
    </div>
</div>

</asp:Content>