<%@ Page Title="Quiz Attempt" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs" Inherits="StudyIsleWeb.Quiz.QuizAttempt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body { background-color: #f8f9fa; }
        .quiz-container { max-width: 1300px; margin: 20px auto; padding: 0 15px; }
        .quiz-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.05); padding: 30px; min-height: 550px; }
        .status-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.03); padding: 20px; position: sticky; top: 20px; }
        .q-badge { background: #eef2ff; color: #4f46e5; padding: 6px 16px; border-radius: 20px; font-size: 0.85rem; font-weight: 700; display: inline-block; margin-bottom: 15px; }
        .question-text { font-size: 1.3rem; font-weight: 500; color: #1e293b; line-height: 1.5; margin-bottom: 20px; }
        .question-img { max-width: 100%; height: auto; border-radius: 8px; margin: 10px 0 25px 0; border: 1px solid #f1f5f9; display: block; }
        .option-item { border: 1px solid #e2e8f0; border-radius: 10px; margin-bottom: 12px; transition: all 0.2s; cursor: pointer; display: flex; align-items: center; padding: 15px 20px; }
        .option-item:hover { background-color: #f8fafc; border-color: #cbd5e1; }
        .option-item input[type="radio"] { width: 20px; height: 20px; margin-right: 15px; cursor: pointer; flex-shrink: 0; }
        .option-content { flex-grow: 1; font-size: 1rem; color: #334155; }
        .option-img { max-height: 180px; display: block; margin-top: 10px; border-radius: 6px; border: 1px solid #eee; }
        .palette { display: grid; grid-template-columns: repeat(5, 1fr); gap: 10px; margin-top: 15px; }
        .palette-btn { width: 100%; aspect-ratio: 1/1; border-radius: 8px; border: 1px solid #e2e8f0; font-weight: 600; cursor: pointer; transition: 0.2s; }
        .notvisited { background: #f1f5f9; color: #64748b; }
        .answered { background: #10b981 !important; color: white !important; border: none; }
        .notanswered { background: #ef4444 !important; color: white !important; border: none; }
        .marked { background: #8b5cf6 !important; color: white !important; border: none; }
        .current { border: 2px solid #4f46e5 !important; color: #4f46e5; transform: scale(1.05); }
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); display: none; align-items: center; justify-content: center; z-index: 9999; }
        .submit-modal { background: white; border-radius: 20px; padding: 40px; width: 350px; text-align: center; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="quiz-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold text-dark"><asp:Label ID="lblQuizTitle" runat="server" /></h4>
            <div class="d-flex align-items-center">
                <div class="me-3 p-2 bg-white rounded border px-4 shadow-sm">
                    <span class="text-muted small uppercase">Time Left:</span>
                    <span id="timerDisplay" class="fw-bold text-danger ms-2">00:00</span>
                </div>
                <button type="button" class="btn btn-success fw-bold px-4 shadow-sm" onclick="showSubmitModal()">Submit Test</button>
                <asp:Button ID="btnSubmitTest" runat="server" style="display:none;" OnClick="btnSubmitTest_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col-lg-9">
                <div class="quiz-card">
                    <div class="q-badge">Question <asp:Label ID="lblQuestionNumber" runat="server" /></div>
                    <div class="question-text"><asp:Label ID="lblQuestionText" runat="server" /></div>
                    <asp:Image ID="imgQuestion" runat="server" CssClass="question-img" Visible="false" />

                    <div class="options-list">
                        <asp:Repeater ID="rptOptions" runat="server">
                            <ItemTemplate>
                                <label class="option-item">
                                    <input type="radio" name='<%# "q_group_" + hfCurrentQuestion.Value %>' 
                                           value='<%# Eval("Key") %>' 
                                           <%# IsChecked(Eval("Key").ToString()) %> />
                                    <div class="option-content">
                                        <strong><%# Eval("Key") %>.</strong> <%# Eval("Text") %>
                                        <asp:Image runat="server" 
                                            Visible='<%# !string.IsNullOrEmpty(Eval("Image").ToString()) %>' 
                                            ImageUrl='<%# Eval("Image") %>' CssClass="option-img" />
                                    </div>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:HiddenField ID="hfSelectedOption" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hfCurrentQuestion" runat="server" />
                    </div>

                    <div class="d-flex justify-content-between mt-5 border-top pt-4">
                        <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn btn-outline-secondary px-4 fw-bold" OnClick="btnPrevious_Click" OnClientClick="syncSelectedOption();" />
                        <div>
                            <asp:Button ID="btnMarkReview" runat="server" Text="Mark for Review" CssClass="btn btn-warning text-white px-4 me-2 fw-bold" OnClick="btnMarkReview_Click" OnClientClick="syncSelectedOption();" />
                            <asp:Button ID="btnNext" runat="server" Text="Next Question" CssClass="btn btn-primary px-5 fw-bold" OnClick="btnNext_Click" OnClientClick="syncSelectedOption();" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="status-card">
                    <h6 class="fw-bold mb-3 border-bottom pb-2">Question Status</h6>
                    <div class="palette">
                        <asp:Repeater ID="rptPalette" runat="server" OnItemDataBound="rptPalette_ItemDataBound">
                            <ItemTemplate>
                                <asp:Button ID="btnPalette" runat="server" 
                                    Text='<%# Container.ItemIndex + 1 %>' 
                                    CommandArgument='<%# Container.ItemIndex %>'
                                    OnCommand="btnPalette_Command" OnClientClick="syncSelectedOption();" />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <hr />
                    <div class="small text-muted mb-2">Summary:</div>
                    <div class="legend-item d-flex mb-1"><span class="dot answered me-2" style="width:12px;height:12px;border-radius:3px"></span> Answered: <b class="ms-auto"><asp:Literal ID="litAnsweredCount" runat="server" /></b></div>
                    <div class="legend-item d-flex mb-1"><span class="dot notanswered me-2" style="width:12px;height:12px;border-radius:3px"></span> Not Answered: <b class="ms-auto"><asp:Literal ID="litNotAnsweredCount" runat="server" /></b></div>
                    <div class="legend-item d-flex mb-1"><span class="dot marked me-2" style="width:12px;height:12px;border-radius:3px"></span> Marked: <b class="ms-auto"><asp:Literal ID="litMarkedCount" runat="server" /></b></div>
                    <div class="legend-item d-flex mb-1"><span class="dot notvisited me-2" style="width:12px;height:12px;border-radius:3px"></span> Not Visited: <b class="ms-auto"><asp:Literal ID="litNotVisitedCount" runat="server" /></b></div>
                    <div class="legend-item d-flex mt-2 fw-bold border-top pt-2">Total Questions: <b class="ms-auto"><asp:Literal ID="litTotalCount" runat="server" /></b></div>
                </div>
            </div>
        </div>
    </div>

    <div id="submitModal" class="modal-overlay">
        <div class="submit-modal shadow-lg">
            <div class="mb-3"><i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i></div>
            <h3 class="fw-bold">Ready to Finish?</h3>
            <p class="text-muted">You have answered <asp:Literal ID="litSummaryCount" runat="server" /> out of <asp:Literal ID="litTotalCountInModal" runat="server" /> questions.</p>
            <div class="d-grid gap-2 mt-4">
                <asp:Button ID="btnFinalSubmit" runat="server" Text="Yes, Submit My Test" CssClass="btn btn-success btn-lg fw-bold" OnClick="btnSubmitTest_Click" />
                <button type="button" class="btn btn-light btn-sm" onclick="closeSubmitModal()">Return to Quiz</button>
            </div>
        </div>
    </div>

    <script>
        function syncSelectedOption() {
            const currentIdx = document.getElementById('<%= hfCurrentQuestion.ClientID %>').value;
            const selected = document.querySelector('input[name="q_group_' + currentIdx + '"]:checked');
            document.getElementById('hfSelectedOption').value = selected ? selected.value : "";
        }
        function showSubmitModal() { syncSelectedOption(); document.getElementById('submitModal').style.display = 'flex'; }
        function closeSubmitModal() { document.getElementById('submitModal').style.display = 'none'; }
        
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
        window.onload = startTimer;
    </script>
</asp:Content>