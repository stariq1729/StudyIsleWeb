<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizResult.aspx.cs"
    Inherits="StudyIsleWeb.Quiz.QuizResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .result-container {
            max-width: 1100px;
            margin: 40px auto;
        }

        .stat-card {
            background: #f4f6ff;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .stat-card h3 {
            color: #4f46e5;
            font-weight: bold;
        }

        .chart-container {
            width: 280px;
            margin: auto;
        }

        .legend-box span {
            display: block;
            font-size: 15px;
            margin-bottom: 8px;
        }

        .badge-correct { color: #28a745; font-weight: bold; }
        .badge-wrong { color: #dc3545; font-weight: bold; }
        .badge-unattempted { color: #6c757d; font-weight: bold; }

        .correct-answer {
            background: #e6f9f0;
            border: 1px solid #28a745;
        }

        .wrong-answer {
            background: #fdecea;
            border: 1px solid #dc3545;
        }

        .question-detail {
            display: none;
        }

        .revision-box {
            background: #fff3cd;
            border: 1px solid #ffc107;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .question-img, .option-img {
            max-width: 150px;
            margin-top: 10px;
            border-radius: 6px;
        }
    </style>

    <script>
        function showQuestion(index) {
            var items = document.getElementsByClassName("question-detail");
            for (var i = 0; i < items.length; i++) {
                items[i].style.display = "none";
            }
            items[index].style.display = "block";
            window.scrollTo({ top: items[index].offsetTop - 100, behavior: 'smooth' });
        }

        function renderChart(correct, wrong, unattempted) {
            const ctx = document.getElementById('resultChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Correct', 'Wrong', 'Unattempted'],
                    datasets: [{
                        data: [correct, wrong, unattempted],
                        backgroundColor: ['#28a745', '#dc3545', '#6c757d']
                    }]
                },
                options: {
                    responsive: true,
                    cutout: '70%',
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }

        // Disable Back Button
        window.onload = function () {
            history.pushState(null, null, location.href);
            window.onpopstate = function () {
                history.go(1);
            };
        };
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container result-container">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Test Performance Report</h3>
        <asp:Button ID="btnRetake" runat="server" Text="Retake Test"
            CssClass="btn btn-primary" OnClick="btnRetake_Click" />
    </div>

    <!-- Summary Cards -->
    <div class="row text-center mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <p>FINAL SCORE</p>
                <h3><asp:Label ID="lblScore" runat="server" /></h3>
                <small><asp:Label ID="lblScoreDetails" runat="server" /></small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <p>ACCURACY</p>
                <h3><asp:Label ID="lblAccuracy" runat="server" /></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <p>ATTEMPTED</p>
                <h3><asp:Label ID="lblAttempted" runat="server" /></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <p>TIME DURATION</p>
                <h3><asp:Label ID="lblTime" runat="server" /></h3>
            </div>
        </div>
    </div>

    <!-- Chart Section -->
    <div class="row align-items-center mb-4">
        <div class="col-md-6 text-center">
            <div class="chart-container">
                <canvas id="resultChart"></canvas>
            </div>
        </div>
        <div class="col-md-6 legend-box">
            <span class="badge-correct">● Correct: <asp:Label ID="lblCorrect" runat="server" /></span>
            <span class="badge-wrong">● Wrong: <asp:Label ID="lblWrong" runat="server" /></span>
            <span class="badge-unattempted">● Unattempted: <asp:Label ID="lblUnattempted" runat="server" /></span>
        </div>
    </div>

    <!-- Question Review -->
    <div class="card p-4 mb-4">
        <h4>Question Review</h4>
        <asp:GridView ID="gvQuestions" runat="server" AutoGenerateColumns="False"
            CssClass="table table-bordered table-hover">
            <Columns>
                <asp:BoundField DataField="QuestionNumber" HeaderText="#" />
                <asp:BoundField DataField="QuestionText" HeaderText="Question" />
                <asp:BoundField DataField="UserAnswer" HeaderText="Your Ans" />
                <asp:BoundField DataField="CorrectAnswer" HeaderText="Correct Ans" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:TemplateField HeaderText="View">
                    <ItemTemplate>
                        <button type="button" class="btn btn-sm btn-info"
                            onclick="showQuestion(<%# Container.DataItemIndex %>)">
                            View
                        </button>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <!-- Question Details -->
    <asp:Repeater ID="rptQuestionDetails" runat="server">
        <ItemTemplate>
            <div class="card p-4 mb-3 question-detail">
                <h5>Question <%# Eval("QuestionNumber") %></h5>
                <p><%# Eval("QuestionText") %></p>

                <asp:Image runat="server"
                    ImageUrl='<%# ResolveUrl(Eval("QuestionImage").ToString()) %>'
                    Visible='<%# !string.IsNullOrEmpty(Eval("QuestionImage").ToString()) %>'
                    CssClass="question-img" />

                <ul class="list-group mt-3">
                    <li class='list-group-item <%# GetOptionClass(Eval("CorrectAnswer"), Eval("UserAnswer"), "A") %>'>
                        A. <%# Eval("OptionA") %>
                    </li>
                    <li class='list-group-item <%# GetOptionClass(Eval("CorrectAnswer"), Eval("UserAnswer"), "B") %>'>
                        B. <%# Eval("OptionB") %>
                    </li>
                    <li class='list-group-item <%# GetOptionClass(Eval("CorrectAnswer"), Eval("UserAnswer"), "C") %>'>
                        C. <%# Eval("OptionC") %>
                    </li>
                    <li class='list-group-item <%# GetOptionClass(Eval("CorrectAnswer"), Eval("UserAnswer"), "D") %>'>
                        D. <%# Eval("OptionD") %>
                    </li>
                </ul>

                <div class="mt-3 p-3 bg-light rounded">
                    <strong>Explanation:</strong>
                    <%# Eval("Explanation") %>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <!-- Recommended Revision -->
    <asp:Panel ID="pnlRevision" runat="server" Visible="false" CssClass="revision-box">
        <h5>⚠ Recommended Revision</h5>
        <p>
            Your accuracy in this chapter is
            <strong><asp:Label ID="lblRevisionAccuracy" runat="server" /></strong>.
            We recommend revising the core concepts before retaking the test.
        </p>
        <asp:Button ID="btnCourses" runat="server" Text="Find More Topics"
            CssClass="btn btn-warning" OnClick="btnCourses_Click" />
    </asp:Panel>

</div>
</asp:Content>