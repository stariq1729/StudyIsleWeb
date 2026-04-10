<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddQuiz.aspx.cs" Inherits="StudyIsleWeb.Admin.Quiz.AddQuiz" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add Quiz</h1>

        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-light">
                <strong>Quiz Configuration</strong>
            </div>

            <div class="card-body">
                <div class="row g-3">

                    <!-- Board -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">1. Select Board</label>
                        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" />
                    </div>

                    <!-- Resource Type -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">2. Resource Type</label>
                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select" />
                    </div>

                    <!-- Class -->
                    <asp:PlaceHolder ID="phClass" runat="server" Visible="false">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">3. Select Class</label>
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" />
                        </div>
                    </asp:PlaceHolder>

                    <!-- SubCategory -->
                    <asp:PlaceHolder ID="phSubCategory" runat="server" Visible="false">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">3. Select Sub-Category</label>
                            <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-select"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged" />
                        </div>
                    </asp:PlaceHolder>

                    <!-- Subject -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">4. Select Subject</label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged" />
                    </div>

                    <!-- Chapter -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">5. Select Chapter</label>
                        <asp:DropDownList ID="ddlChapter" runat="server" CssClass="form-select" />
                    </div>

                    <!-- Quiz Label -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Quiz Label</label>
                        <asp:TextBox ID="txtQuizLabel" runat="server" CssClass="form-control"
                            placeholder="e.g. Mock Test 1"></asp:TextBox>
                    </div>

                    <!-- Total Questions -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Total Questions</label>
                        <asp:TextBox ID="txtTotalQuestions" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <!-- Time Limit -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Time Limit (Minutes)</label>
                        <asp:TextBox ID="txtTimeLimit" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <!-- Total Marks -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Total Marks</label>
                        <asp:TextBox ID="txtTotalMarks" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <!-- Difficulty -->
                    <div class="col-md-3">
                        <label class="form-label fw-bold">Difficulty</label>
                        <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Easy" Value="Easy" />
                            <asp:ListItem Text="Medium" Value="Medium" />
                            <asp:ListItem Text="Hard" Value="Hard" />
                        </asp:DropDownList>
                    </div>

                    <!-- Negative Marking -->
                    

                    <!-- Buttons -->
                    <div class="col-12 mt-4 border-top pt-3">
                        <asp:Button ID="btnSaveQuiz" runat="server" Text="Create Quiz"
                            CssClass="btn btn-primary px-5" OnClick="btnSaveQuiz_Click" />

                        <asp:Button ID="btnBack" runat="server" Text="Back"
                            CssClass="btn btn-secondary ms-2" PostBackUrl="~/Admin/Dashboard.aspx" />

                        <asp:Label ID="lblMessage" runat="server" CssClass="ms-3"></asp:Label>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>