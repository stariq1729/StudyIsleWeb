<%@ Page Title="Quiz Attempt" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs"
    Inherits="StudyIsleWeb.Quiz.QuizAttempt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .quiz-container { max-width: 1200px; margin: 30px auto; }
        .quiz-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            padding: 20px;
        }
        .question-title { font-size: 18px; font-weight: 600; }
        .question-img {
            max-width: 220px;
            margin: 10px auto;
            display: block;
            border-radius: 8px;
        }
        .option-container {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 10px;
        }
        .option-container:hover { background: #f5f7ff; }

        .palette {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 10px;
        }
        .palette-btn {
            width: 45px;
            height: 45px;
            border-radius: 8px;
            border: none;
            font-weight: bold;
            color: #fff;
        }
        .notvisited { background: #e9ecef; color: #000; }
        .answered { background: #28a745; }
        .notanswered { background: #dc3545; }
        .marked { background: #6f42c1; }
        .current { background: #0d6efd; }

        .legend-box span {
            display: inline-block;
            margin-right: 10px;
            font-size: 14px;
        }
        .legend {
            width: 12px;
            height: 12px;
            display: inline-block;
            margin-right: 5px;
            border-radius: 3px;
        }

        .timer-box {
            font-weight: bold;
            color: #dc3545;
            font-size: 18px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container quiz-container">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4><asp:Label ID="lblQuizTitle" runat="server" /></h4>
        <div>
            Time Left:
            <span class="timer-box">
                <asp:Label ID="lblTimer" runat="server" />
            </span>
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
                    Question <asp:Label ID="lblQuestionNumber" runat="server" />
                </h5>

                <p><asp:Label ID="lblQuestionText" runat="server" /></p>

                <asp:Image ID="imgQuestion" runat="server"
                    CssClass="question-img" Visible="false" />

                <asp:RadioButtonList ID="rblOptions" runat="server"
                    RepeatLayout="Flow" CssClass="w-100" />

                <asp:HiddenField ID="hfCurrentQuestion" runat="server" />

                <!-- Navigation Buttons -->
                <div class="d-flex justify-content-between mt-3">
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
                <div class="palette">
                    <asp:Repeater ID="rptPalette" runat="server"
                        OnItemDataBound="rptPalette_ItemDataBound">
                        <ItemTemplate>
                            <asp:Button ID="btnPalette" runat="server"
                                Text='<%# Container.ItemIndex + 1 %>'
                                CommandArgument='<%# Container.ItemIndex %>'
                                CssClass="palette-btn"
                                OnCommand="btnPalette_Command" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- Legend -->
                <div class="legend-box mt-3">
                    <span><span class="legend" style="background:#28a745;"></span>Answered</span>
                    <span><span class="legend" style="background:#dc3545;"></span>Not Answered</span>
                    <span><span class="legend" style="background:#6f42c1;"></span>Marked</span>
                    <span><span class="legend" style="background:#e9ecef;"></span>Not Visited</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Timer Script -->
<script>
    var remainingSeconds = <%= RemainingSeconds %>;

    function startTimer(duration) {
        var timer = duration;
        var display = document.getElementById('<%= lblTimer.ClientID %>');

        var interval = setInterval(function () {
            var minutes = Math.floor(timer / 60);
            var seconds = timer % 60;

            display.textContent = minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

            if (--timer < 0) {
                clearInterval(interval);
                alert("Time is up! Submitting quiz.");
                document.getElementById('<%= btnSubmitTest.ClientID %>').click();
            }
        }, 1000);
    }

    window.onload = function () {
        startTimer(remainingSeconds);
    };
</script>
</asp:Content>