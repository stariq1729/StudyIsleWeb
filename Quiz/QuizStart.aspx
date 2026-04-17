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
/* 1. Target the input directly and strip all browser styling */
#chkNegativeMarking {
    appearance: none !important;
    -webkit-appearance: none !important;
    -moz-appearance: none !important;
    width: 45px !important;
    height: 24px !important;
    background-color: #dee2e6 !important; /* Off Color */
    border-radius: 50px !important;
    position: relative;
    cursor: pointer;
    transition: background-color 0.3s ease;
    border: none !important;
    /* This creates the white circle (the knob) */
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3e%3ccircle r='3' fill='%23fff'/%3e%3c/svg%3e") !important;
    background-position: left 2px center;
    background-repeat: no-repeat;
    background-size: 20px;
    outline: none !important;
    box-shadow: none !important;
    display: inline-block;
    vertical-align: middle;
}

/* 2. Style when the toggle is ON (Checked) */
#chkNegativeMarking:checked {
    background-color: #6d5dfc !important; /* Reference Purple */
    background-position: right 2px center !important; /* Slides the circle to the right */
}

/* 3. ASP.NET specific fix: Checkboxes often render inside a span that adds extra margins */
.form-check-input {
    margin-left: 0 !important;
    float: none !important;
}

/* 4. Fix for Bootstrap's default background-image showing up */
.form-check-input:checked {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3e%3ccircle r='3' fill='%23fff'/%3e%3c/svg%3e") !important;
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

<div class="card border-0 shadow-sm mb-4" style="background-color: #f8fafd; border-radius: 12px;">
    <div class="card-body p-4">
        <div class="d-flex align-items-center mb-3" style="color: #6c757d;">
            <span class="me-2" style="font-size: 1.1rem;">⚙️</span>
            <h6 class="mb-0 fw-bold">Test Settings</h6>
        </div>

        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h6 class="mb-1 fw-bold" style="color: #2d3436;">Negative Marking</h6>
                <small class="text-muted" style="font-size: 0.85rem;">
                    -<asp:Label ID="lblNegativeMarks" runat="server"></asp:Label> marks for every incorrect answer
                </small>
            </div>
            
            <div class="form-check form-switch p-0">
                <asp:CheckBox ID="chkNegativeMarking" runat="server" 
                    CssClass="form-check-input" 
                    ClientIDMode="Static" />
            </div>
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