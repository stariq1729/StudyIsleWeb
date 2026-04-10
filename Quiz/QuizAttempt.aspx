<%@ Page Title="Quiz Attempt" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs"
    Inherits="StudyIsleWeb.Quiz.QuizAttempt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .quiz-container {
            max-width: 1200px;
            margin: 30px auto;
        }

        .quiz-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            padding: 20px;
        }

        .question-title {
            font-size: 18px;
            font-weight: 600;
        }

        .option-item {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: 0.2s;
        }

        .option-item:hover {
            background: #f5f7ff;
        }

        .palette {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 8px;
        }

        .palette-btn {
            width: 40px;
            height: 40px;
            border-radius: 6px;
            border: none;
            background: #e9ecef;
            font-weight: 600;
        }

        .palette-btn.answered { background: #28a745; color: #fff; }
        .palette-btn.marked { background: #6f42c1; color: #fff; }
        .palette-btn.current { background: #dc3545; color: #fff; }

        .timer-box {
            font-weight: bold;
            color: #dc3545;
        }

        .nav-buttons {
            margin-top: 15px;
        }

        .question-img {
        max-width: 220px;
        height: auto;
        display: block;
        margin: 10px auto;
        border-radius: 8px;
    }

    .option-container {
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 10px;
        margin-bottom: 10px;
        transition: 0.2s;
    }

    .option-container:hover {
        background-color: #f8f9ff;
    }

    .option-table {
        width: 100%;
    }

    .option-img {
        max-width: 80px;
        height: auto;
        border-radius: 6px;
        margin-left: 10px;
    }

    .quiz-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        padding: 20px;
    }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container quiz-container">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4>
                <asp:Label ID="lblQuizTitle" runat="server"></asp:Label>
            </h4>
            <div>
                Time Left:
                <span class="timer-box">
                    <asp:Label ID="lblTimer" runat="server"></asp:Label>
                </span>
                <asp:HiddenField ID="hfDuration" runat="server" />
            </div>
            <asp:Button ID="btnSubmitTest" runat="server"
                Text="Submit Test"
                CssClass="btn btn-success"
                OnClick="btnSubmitTest_Click" />
        </div>

        <div class="row">
            <!-- Question Section -->
            <div class="col-md-8">
                <div class="quiz-card">

                    <h5 class="question-title">
                        Question <asp:Label ID="lblQuestionNumber" runat="server"></asp:Label>
                    </h5>

                    <p>
                        <asp:Label ID="lblQuestionText" runat="server"></asp:Label>
                    </p>

                    <asp:Image ID="imgQuestion" runat="server"
                        CssClass="question-img" Visible="false" />

                    <asp:RadioButtonList ID="rblOptions" runat="server" RepeatLayout="Flow" CssClass="w-100">
</asp:RadioButtonList>

                    <asp:HiddenField ID="hfCurrentQuestion" runat="server" />

                    <!-- Navigation Buttons -->
                    <div class="nav-buttons d-flex justify-content-between">
                        <asp:Button ID="btnPrevious" runat="server"
                            Text="Previous"
                            CssClass="btn btn-secondary"
                            OnClick="btnPrevious_Click" />

                        <div>
                            <asp:Button ID="btnMarkReview" runat="server"
                                Text="Mark for Review"
                                CssClass="btn btn-warning"
                                OnClick="btnMarkReview_Click" />

                            <asp:Button ID="btnNext" runat="server"
                                Text="Next"
                                CssClass="btn btn-primary"
                                OnClick="btnNext_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Palette Section -->
            <div class="col-md-4">
                <div class="quiz-card">
                    <h5>Question Status</h5>
                    <asp:Repeater ID="rptPalette" runat="server">
                        <ItemTemplate>
                            <asp:Button ID="btnPalette" runat="server"
                                Text='<%# Container.ItemIndex + 1 %>'
                                CssClass="palette-btn"
                                CommandArgument='<%# Container.ItemIndex %>'
                                OnCommand="btnPalette_Command" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

    <!-- Timer Script -->
    <script>
        var duration = document.getElementById('<%= hfDuration.ClientID %>').value;

        if (duration) {
            var timer = duration * 60;
            var display = document.getElementById('<%= lblTimer.ClientID %>');

            setInterval(function () {
                var minutes = Math.floor(timer / 60);
                var seconds = timer % 60;
                display.textContent = minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
                timer--;

                if (timer < 0) {
                    document.getElementById('<%= btnSubmitTest.ClientID %>').click();
                }
            }, 1000);
        }
    </script>
</asp:Content>