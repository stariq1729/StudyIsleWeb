<%@ Page Title="Quiz List" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="QuizList.aspx.cs"
    Inherits="StudyIsleWeb.Quiz.QuizList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .quiz-container {
            max-width: 1000px;
            margin: auto;
            padding: 40px 0;
        }

        .quiz-header h2 {
            font-weight: 700;
            color: #2c3e50;
        }

        .quiz-header p {
            color: #6c757d;
            margin-bottom: 20px;
        }

        .quiz-count {
            background: #eef2ff;
            color: #4f46e5;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            float: right;
        }

        .quiz-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            border: 1px solid #e9ecef;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: 0.3s;
        }

        .quiz-card:hover {
            transform: translateY(-3px);
        }

        .quiz-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .quiz-number {
            width: 45px;
            height: 45px;
            background: #f1f5f9;
            border-radius: 10px;
            text-align: center;
            line-height: 45px;
            font-weight: bold;
            color: #6c757d;
        }

        .quiz-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
        }

        .quiz-meta {
            font-size: 13px;
            color: #6c757d;
        }

        .difficulty {
            padding: 3px 8px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            margin-left: 8px;
        }

        .easy {
            background: #e6f9f0;
            color: #28a745;
        }

        .medium {
            background: #fff4e5;
            color: #ff9800;
        }

        .hard {
            background: #fdecea;
            color: #dc3545;
        }

        .start-btn {
            background: linear-gradient(90deg, #4f46e5, #6366f1);
            border: none;
            color: #fff;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
        }

        .start-btn:hover {
            color: #fff;
            opacity: 0.9;
        }

        .no-data {
            text-align: center;
            padding: 30px;
            color: #6c757d;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="quiz-container">

        <!-- Header -->
        <div class="quiz-header">
            <h2>
                Science Quizzes
                <asp:Label ID="lblQuizCount" runat="server" CssClass="quiz-count"></asp:Label>
            </h2>
            <p>Master each quiz with dedicated MCQ practice tests.</p>
        </div>

        <!-- Quiz List -->
        <asp:Repeater ID="rptQuizzes" runat="server">
            <ItemTemplate>
                <div class="quiz-card">
                    <div class="quiz-left">
                        <div class="quiz-number">
                            <%# Container.ItemIndex + 1 %>
                        </div>
                        <div>
                            <div class="quiz-title">
                                <%# Eval("QuizLabel") %>
                                <span class='difficulty <%# GetDifficultyClass(Eval("Difficulty").ToString()) %>'>
                                    <%# Eval("Difficulty") %>
                                </span>
                            </div>
                            <div class="quiz-meta">
                                📘 <%# Eval("TotalQuestions") %> Questions |
                                ⏱ <%# Eval("TimeLimitMinutes") %> Minutes |
                                🏆 <%# Eval("TotalMarks") %> Marks
                            </div>
                        </div>
                    </div>

                    <a class="start-btn"
                       href='<%# ResolveUrl("~/Quiz/QuizStart.aspx?quizId=" + Eval("QuizId")) %>'>
                        ▶ Start Test
                    </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- No Data Panel -->
        <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="no-data">
            No quizzes available for this chapter.
        </asp:Panel>

    </div>
</asp:Content>