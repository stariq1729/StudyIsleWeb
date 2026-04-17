<%@ Page Title="Quiz Attempt" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs" Inherits="StudyIsleWeb.Quiz.QuizAttempt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body { background-color: #f8fafd; font-family: 'Segoe UI', sans-serif; }
        
        /* Centering the Quiz Layout */
        .centered-wrapper { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 18px;
        }

        .row.g-0 { margin-right: 0; margin-left: 0; }
        
        /* Main Cards */
        .quiz-card { background: #fff; border: 1px solid #eef2f7; border-radius: 15px 0 0 15px; padding: 30px; min-height: 600px; box-shadow: none; }
        .status-card { background: #fff; border: 1px solid #eef2f7; border-left: none; border-radius: 0 15px 15px 0; padding: 25px; box-shadow: none; height: 100%; }

        /* Progress Bar - Reduced Width */
        .progress-wrapper { margin-bottom: 20px; max-width: 300px; }
        .progress-text { font-size: 11px; font-weight: 700; color: #94a3b8; text-transform: uppercase; margin-bottom: 5px; }
        .progress { height: 6px; background-color: #eef2f7; border-radius: 10px; overflow: hidden; }
        .progress-bar { background: linear-gradient(90deg, #6366f1, #8b5cf6); transition: width 0.4s ease; }

        /* Question Section */
        .q-badge { background: #eef2ff; color: #6366f1; padding: 5px 15px; border-radius: 8px; font-weight: 700; font-size: 13px; margin-bottom: 10px; display: inline-block; }
        .question-text { font-size: 1.3rem; font-weight: 600; color: #1e293b; margin-top: 15px; margin-bottom: 20px; line-height: 1.5; }
        .question-img { max-width: 100%; border-radius: 10px; margin-bottom: 20px; border: 1px solid #f1f5f9; }

        /* Dividers */
        hr { border-top: 1px solid #eef2f7; opacity: 1.4; margin: 12px 0; }

        /* Options Indicators */
        .option-item { border: 1px solid #f1f5f9; border-radius: 12px; margin-bottom: 12px; padding: 15px 20px; display: flex; align-items: center; cursor: pointer; transition: 0.2s; }
        .option-item:hover { background-color: #f8fafc; border-color: #e2e8f0; }
        .option-item input[type="radio"] { display: none; }
        .indicator { width: 34px; height: 34px; border: 2px solid #e2e8f0; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 15px; font-weight: 700; color: #64748b; flex-shrink: 0; }
        
        /* Selected State */
        .option-item input[type="radio"]:checked + .indicator { border-color: #6366f1; background-color: #6366f1; color: white; }
        .selected-card { border-color: #6366f1 !important; background-color: #f5f3ff !important; }

        /* Buttons */
        .quiz-btn { height: 44px; min-width: 130px; font-weight: 600; border-radius: 10px; display: inline-flex; align-items: center; justify-content: center; transition: 0.2s; font-size: 14px; }
        
        /* Palette Logic Fixes */
        .palette { display: grid; grid-template-columns: repeat(5, 1fr); gap: 10px; margin-top: 15px; }
        .palette-btn { 
            aspect-ratio: 1/1; border-radius: 8px; border: 1px solid #e2e8f0; 
            background: #fff; font-weight: 600; font-size: 13px; color: #64748b; 
            transition: 0.3s; padding: 0; cursor: pointer;
        }

        /* Status colors using !important to ensure backend classes override default btn styles */
        .palette-btn.answered { background-color: #10b981 !important; color: white !important; border-color: #10b981 !important; }
        .palette-btn.notanswered { background-color: #ef4444 !important; color: white !important; border-color: #ef4444 !important; }
        .palette-btn.marked { background-color: #8b5cf6 !important; color: white !important; border-color: #8b5cf6 !important; }
        .palette-btn.notvisited { background-color: #f1f5f9 !important; color: #64748b !important; }
        
        /* Border highlight for the current question */
        .palette-btn.current-q { border: 3px solid #6366f1 !important; }

        /* Summary */
        .summary-box { border: 1px solid #f1f5f9; border-radius: 12px; padding: 15px; background: #fafcff; }
        .status-dot { width: 10px; height: 10px; border-radius: 50%; display: inline-block; margin-right: 10px; }
        .dot-answered { background: #10b981; }
        .dot-notanswered { background: #ef4444; }
        .dot-marked { background: #8b5cf6; }
        .dot-notvisited { background: #e2e8f0; }

        /* Header UI */
        .timer-display { font-family: 'Courier New', monospace; font-size: 1.2rem; font-weight: 700; color: #ef4444; background: #fff1f2; padding: 5px 15px; border-radius: 8px; border: 1px solid #fee2e2; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="centered-wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-0 text-dark"><asp:Label ID="lblQuizTitle" runat="server" /></h4>
                <div class="text-muted small fw-bold">PRACTICE MODE • STUDY ISLE</div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div id="timerDisplay" class="timer-display">00:00</div>
                <button type="button" class="btn btn-success quiz-btn" onclick="showSubmitModal()">Submit Test</button>
                <asp:Button ID="btnSubmitTest" runat="server" style="display:none;" OnClick="btnSubmitTest_Click" />
            </div>
        </div>

        <div class="row g-0">
            <div class="col-lg-9">
                <div class="quiz-card">
                    <div class="progress-wrapper">
                        <div class="progress-text">Progress: <asp:Literal ID="litAnsweredCountDisplay" runat="server" /> / <asp:Literal ID="litTotalCountDisplay" runat="server" /></div>
                        <div class="progress">
                            <div id="progressBar" class="progress-bar" role="progressbar" style="width: 0%"></div>
                        </div>
                    </div>
                    <hr />

                    <div class="q-badge">Question <asp:Label ID="lblQuestionNumber" runat="server" /></div>
                    <hr />
                    <div class="question-text"><asp:Label ID="lblQuestionText" runat="server" /></div>
                    
                    
                    <asp:Image ID="imgQuestion" runat="server" CssClass="question-img" Visible="false" />

                    <div class="options-list">
                        <asp:Repeater ID="rptOptions" runat="server">
                            <ItemTemplate>
                                <label class="option-item" onclick="highlightOption(this)">
                                    <input type="radio" name='<%# "q_group_" + hfCurrentQuestion.Value %>' 
                                           value='<%# Eval("Key") %>' 
                                           <%# IsChecked(Eval("Key").ToString()) %> />
                                    <div class="indicator"><%# Eval("Key") %></div>
                                    <div class="option-content">
                                        <%# Eval("Text") %>
                                        <asp:Image runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Image").ToString()) %>' 
                                                   ImageUrl='<%# Eval("Image") %>' CssClass="d-block mt-2" style="max-height:100px;"/>
                                    </div>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:HiddenField ID="hfSelectedOption" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hfCurrentQuestion" runat="server" />
                    </div>

                    <div class="d-flex justify-content-between mt-5 border-top pt-4">
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnMarkReview" runat="server" Text="Mark for Review" CssClass="btn btn-outline-warning quiz-btn" OnClick="btnMarkReview_Click" OnClientClick="syncSelectedOption();" />
                            <button type="button" class="btn btn-outline-danger quiz-btn" onclick="clearSelection()">Clear</button>
                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn btn-light border quiz-btn" OnClick="btnPrevious_Click" OnClientClick="syncSelectedOption();" />
                            <asp:Button ID="btnNext" runat="server" Text="Next Question" CssClass="btn btn-primary quiz-btn" OnClick="btnNext_Click" OnClientClick="syncSelectedOption();" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="status-card">
                    <h6 class="fw-bold text-dark mb-1">Question Status</h6>
                    <p class="text-muted small mb-3">Click on a number to jump</p>
                    
                    <div class="palette">
                        <asp:Repeater ID="rptPalette" runat="server" OnItemDataBound="rptPalette_ItemDataBound">
                            <ItemTemplate>
                                <asp:Button ID="btnPalette" runat="server" 
                                            CssClass="palette-btn"
                                            Text='<%# Container.ItemIndex + 1 %>' 
                                            CommandArgument='<%# Container.ItemIndex %>'
                                            OnCommand="btnPalette_Command" OnClientClick="syncSelectedOption();" />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="summary-box mt-4">
                        <div class="small fw-bold mb-3 text-muted">SUMMARY</div>
                        <div class="d-flex align-items-center mb-2 small fw-bold">
                            <span class="status-dot dot-answered"></span> Answered: <span class="ms-auto"><asp:Literal ID="litAnsweredCount" runat="server" /></span>
                        </div>
                        <div class="d-flex align-items-center mb-2 small fw-bold">
                            <span class="status-dot dot-notanswered"></span> Not Answered: <span class="ms-auto"><asp:Literal ID="litNotAnsweredCount" runat="server" /></span>
                        </div>
                        <div class="d-flex align-items-center mb-2 small fw-bold">
                            <span class="status-dot dot-marked"></span> Marked: <span class="ms-auto"><asp:Literal ID="litMarkedCount" runat="server" /></span>
                        </div>
                        <div class="d-flex align-items-center small fw-bold">
                            <span class="status-dot dot-notvisited"></span> Not Visited: <span class="ms-auto"><asp:Literal ID="litNotVisitedCount" runat="server" /></span>
                        </div>
                        <hr class="my-3" />
                        <div class="d-flex justify-content-between fw-bold text-dark">
                            <span>Total Questions:</span>
                            <span><asp:Literal ID="litTotalCount" runat="server" /></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="submitModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:9999; align-items:center; justify-content:center;">
        <div style="background:#fff; padding:30px; border-radius:15px; width:400px; text-align:center;">
            <h4 class="fw-bold mb-3">Finish Test?</h4>
            <p class="text-muted">You have answered <asp:Literal ID="litSummaryCount" runat="server" /> out of <asp:Literal ID="litTotalCountInModal" runat="server" /> questions.</p>
            <div class="d-flex gap-2 mt-4">
                <button type="button" class="btn btn-light w-50 quiz-btn" onclick="closeSubmitModal()">Cancel</button>
                <asp:Button ID="btnFinalSubmit" runat="server" Text="Submit Now" CssClass="btn btn-success w-50 quiz-btn" OnClick="btnSubmitTest_Click" />
            </div>
        </div>
    </div>

    <script>
        function syncSelectedOption() {
            const currentIdx = document.getElementById('<%= hfCurrentQuestion.ClientID %>').value;
            const selected = document.querySelector('input[name="q_group_' + currentIdx + '"]:checked');
            document.getElementById('hfSelectedOption').value = selected ? selected.value : "";
        }

        function highlightOption(element) {
            document.querySelectorAll('.option-item').forEach(el => el.classList.remove('selected-card'));
            element.classList.add('selected-card');
            const radio = element.querySelector('input[type="radio"]');
            if (radio) radio.checked = true;
        }

        function clearSelection() {
            const currentIdx = document.getElementById('<%= hfCurrentQuestion.ClientID %>').value;
            document.querySelectorAll('input[name="q_group_' + currentIdx + '"]').forEach(r => r.checked = false);
            document.querySelectorAll('.option-item').forEach(el => el.classList.remove('selected-card'));
            document.getElementById('hfSelectedOption').value = "";
        }

        function updateProgressBar() {
            const total = parseInt('<%= litTotalCount.Text %>') || 1;
            const answered = parseInt('<%= litAnsweredCount.Text %>') || 0;
            const percent = (answered / total) * 100;
            document.getElementById('progressBar').style.width = percent + "%";
        }

        let timeLeft = <%= RemainingSeconds %>; 
        function startTimer() {
            const display = document.getElementById('timerDisplay');
            const timer = setInterval(() => {
                let m = Math.floor(timeLeft / 60);
                let s = timeLeft % 60;
                display.innerText = (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    document.getElementById('<%= btnSubmitTest.ClientID %>').click();
                }
                timeLeft--;
            }, 1000);
        }

        function showSubmitModal() { document.getElementById('submitModal').style.display = 'flex'; }
        function closeSubmitModal() { document.getElementById('submitModal').style.display = 'none'; }

        window.onload = function () {
            startTimer();
            updateProgressBar();
            const checkedInput = document.querySelector('.option-item input[type="radio"]:checked');
            if (checkedInput) highlightOption(checkedInput.closest('.option-item'));
        };
    </script>
</asp:Content>