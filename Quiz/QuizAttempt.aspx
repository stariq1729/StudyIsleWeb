<%@ Page Title="Quiz Attempt" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs" Inherits="StudyIsleWeb.Quiz.QuizAttempt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body { background-color: #f8f9fa; }
        .quiz-container { max-width: 1300px; margin: 20px auto; }
        
        /* Card Styles */
        .quiz-card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            padding: 25px; min-height: 500px;
        }
        .status-card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            padding: 20px;
        }

        /* Question UI */
        .q-badge {
            background: #eef2ff; color: #4f46e5;
            padding: 5px 15px; border-radius: 20px;
            font-size: 0.9rem; font-weight: 600; display: inline-block;
        }
        .question-text { font-size: 1.25rem; font-weight: 500; margin-top: 15px; color: #1e293b; }
        .question-img { max-width: 100%; height: auto; border-radius: 8px; margin: 20px 0; border: 1px solid #eee; }

        /* Custom Radio Options */
        .options-list { list-style: none; padding: 0; margin-top: 20px; }
        .option-item {
            border: 1px solid #e2e8f0; border-radius: 10px;
            margin-bottom: 12px; transition: all 0.2s; cursor: pointer;
            display: flex; align-items: center; padding: 12px 20px;
        }
        .option-item:hover { background-color: #f8fafc; border-color: #cbd5e1; }
        .option-item input[type="radio"] { width: 18px; height: 18px; margin-right: 15px; cursor: pointer; }
        .option-content { flex-grow: 1; font-size: 1rem; color: #334155; }
        .option-img { max-height: 100px; display: block; margin-top: 5px; border-radius: 4px; }

        /* Palette Grid */
        .palette { display: grid; grid-template-columns: repeat(5, 1fr); gap: 8px; margin-top: 15px; }
        .palette-btn {
            width: 100%; aspect-ratio: 1/1; border-radius: 8px;
            border: 1px solid #e2e8f0; font-weight: 600; font-size: 0.85rem;
            transition: transform 0.1s; cursor: pointer;
        }
        .palette-btn:hover { transform: scale(1.05); }
        
        .notvisited { background: #f1f5f9; color: #64748b; }
        .answered { background: #10b981 !important; color: white !important; border-color: #10b981; }
        .notanswered { background: #ef4444 !important; color: white !important; border-color: #ef4444; }
        .marked { background: #8b5cf6 !important; color: white !important; border-color: #8b5cf6; }
        .current { border: 2px solid #4f46e5 !important; color: #4f46e5; box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.2); }

        /* Status Legend */
        .legend-item { display: flex; align-items: center; font-size: 0.8rem; margin-bottom: 6px; color: #64748b; }
        .dot { width: 10px; height: 10px; border-radius: 3px; margin-right: 8px; }

        /* Custom Modal */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center; z-index: 1000;
        }
        .submit-modal {
            background: white; border-radius: 16px; padding: 30px;
            width: 350px; text-align: center; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
        }
        .success-icon {
            width: 60px; height: 60px; background: #ecfdf5; color: #10b981;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px; font-size: 30px; border: 2px solid #d1fae5;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="quiz-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="mb-0"><asp:Label ID="lblQuizTitle" runat="server" /></h4>
                <%--<small class="text-muted">NCERT CLASS 10 • SCIENCE</small>--%>
            </div>
            <div class="d-flex align-items-center">
                <div class="me-3 p-2 bg-white rounded border px-3">
                    <span class="text-muted small">Time Left:</span>
                    <span id="timerDisplay" class="fw-bold text-dark ms-1">00:00</span>
                    <asp:Label ID="lblTimer" runat="server" style="display:none;" />
                </div>
                <button type="button" class="btn btn-success px-4" onclick="showSubmitModal()">Submit Test</button>
                <asp:Button ID="btnSubmitTest" runat="server" style="display:none;" OnClick="btnSubmitTest_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col-lg-9">
                <div class="quiz-card">
                    <div class="q-badge">Question <asp:Label ID="lblQuestionNumber" runat="server" /></div>
                    
                    <div class="question-text">
                        <asp:Label ID="lblQuestionText" runat="server" />
                    </div>

                    <asp:Image ID="imgQuestion" runat="server" CssClass="question-img" Visible="false" />

                    <div class="options-list">
                        <asp:Repeater ID="rptOptions" runat="server">
                            <ItemTemplate>
                                <label class="option-item">
                                    <input type="radio" name="quizOption" value='<%# Eval("Key") %>' 
                                        <%# IsChecked(Eval("Key").ToString()) %> />
                                    <div class="option-content">
                                        <strong><%# Eval("Key") %>.</strong> <%# Eval("Text") %>
                                        <asp:Image runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Image").ToString()) %>' 
                                            ImageUrl='<%# Eval("Image") %>' CssClass="option-img" />
                                    </div>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>
                       <asp:HiddenField ID="hfSelectedOption" runat="server" ClientIDMode="Static" />
                    </div>

                    <asp:HiddenField ID="hfCurrentQuestion" runat="server" />

                    <div class="d-flex justify-content-between mt-5 border-top pt-4">
                        <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn btn-outline-secondary px-4" OnClick="btnPrevious_Click" />
                        <div>
                            <asp:Button ID="btnMarkReview" runat="server" Text="Mark for Review" CssClass="btn btn-warning text-white px-4 me-2" OnClick="btnMarkReview_Click" />
                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-primary px-5" OnClick="btnNext_Click" OnClientClick="syncSelectedOption();" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="status-card">
                    <h6 class="fw-bold mb-3">Question Status</h6>
                    <small class="text-muted">Click on a number to jump</small>
                    
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
                    <div class="legend-box">
                        <div class="legend-item"><span class="dot answered"></span> Answered: <b class="ms-auto"><asp:Literal ID="litAnsweredCount" runat="server" /></b></div>
                        <div class="legend-item"><span class="dot notanswered"></span> Not Answered: <b class="ms-auto"><asp:Literal ID="litNotAnsweredCount" runat="server" /></b></div>
                        <div class="legend-item"><span class="dot marked"></span> Marked: <b class="ms-auto"><asp:Literal ID="litMarkedCount" runat="server" /></b></div>
                        <div class="legend-item"><span class="dot notvisited"></span> Not Visited: <b class="ms-auto"><asp:Literal ID="litNotVisitedCount" runat="server" /></b></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="submitModal" class="modal-overlay">
        <div class="submit-modal">
            <div class="success-icon">✓</div>
            <h4 class="fw-bold">Submit Your Test?</h4>
            <p class="text-muted small">You have answered <asp:Literal ID="litSummaryCount" runat="server" /> out of <asp:Literal ID="litTotalCount" runat="server" /> questions.</p>
            <div class="d-grid gap-2 mt-4">
                <asp:Button ID="btnFinalSubmit" runat="server" Text="Yes, Submit" CssClass="btn btn-success py-2" OnClick="btnSubmitTest_Click" />
                <button type="button" class="btn btn-outline-secondary py-2" onclick="closeSubmitModal()">Resume Test</button>
            </div>
        </div>
    </div>

    <script>
        // Sync JS Radio to HiddenField before Postback
        function syncSelectedOption() {
            var selected = document.querySelector('input[name="quizOption"]:checked');
            document.getElementById('hfSelectedOption').value = selected ? selected.value : "";
        }

        function showSubmitModal() {
            syncSelectedOption();
            document.getElementById('submitModal').style.display = 'flex';
        }
        function closeSubmitModal() { document.getElementById('submitModal').style.display = 'none'; }

        // Timer Logic
        var remainingSeconds = <%= RemainingSeconds %>;
        function updateTimer() {
            var minutes = Math.floor(remainingSeconds / 60);
            var seconds = remainingSeconds % 60;
            document.getElementById('timerDisplay').innerText = 
                (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
            
            if (remainingSeconds <= 0) {
                document.getElementById('<%= btnSubmitTest.ClientID %>').click();
            } else {
                remainingSeconds--;
                setTimeout(updateTimer, 1000);
            }
        }
        window.onload = updateTimer;
    </script>
</asp:Content>