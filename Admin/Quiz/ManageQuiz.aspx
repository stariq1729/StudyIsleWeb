<%@ Page Title="Manage Quiz" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageQuiz.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Quiz.ManageQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Manage Quizzes</h1>

        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
                <div>
                    <i class="fas fa-question-circle me-1"></i>
                    <strong>Quiz Management</strong>
                </div>
                <asp:HyperLink ID="lnkAddQuiz" runat="server"
                    NavigateUrl="~/Admin/Quiz/AddQuiz.aspx"
                    CssClass="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Quiz
                </asp:HyperLink>
            </div>

            <div class="card-body">

                <!-- Filters -->
                <div class="row g-3 mb-3">
                    <div class="col-md-3">
                        <label class="form-label">Board</label>
                        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Resource Type</label>
                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlFilterChanged" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Class</label>
                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlFilterChanged" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Subject</label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlFilterChanged" />
                    </div>
                </div>

                <!-- Quiz Grid -->
                <div class="table-responsive">
                    <asp:GridView ID="gvQuiz" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-bordered table-striped"
                        DataKeyNames="QuizId" EmptyDataText="No quizzes found."
                        OnRowCommand="gvQuiz_RowCommand">

                        <Columns>
                            <asp:BoundField DataField="QuizId" HeaderText="ID" />

                            <asp:BoundField DataField="BoardName" HeaderText="Board" />
                            <asp:BoundField DataField="TypeName" HeaderText="Resource Type" />
                            <asp:BoundField DataField="ClassName" HeaderText="Class" />
                            <asp:BoundField DataField="SubjectName" HeaderText="Subject" />
                            <asp:BoundField DataField="ChapterName" HeaderText="Chapter" />

                            <asp:BoundField DataField="QuizLabel" HeaderText="Quiz Label" />
                            <asp:BoundField DataField="TotalQuestions" HeaderText="Questions" />
                            <asp:BoundField DataField="TimeLimitMinutes" HeaderText="Time (Min)" />
                            <asp:BoundField DataField="Difficulty" HeaderText="Difficulty" />

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge <%# Convert.ToBoolean(Eval("IsActive")) ? "bg-success" : "bg-danger" %>'>
                                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkAddQuestion" runat="server"
                                        NavigateUrl='<%# "~/Admin/Quiz/AddQuestion.aspx?quizId=" + Eval("QuizId") %>'
                                        CssClass="btn btn-success btn-sm me-1">
                                        Add Questions
                                    </asp:HyperLink>

                                    <asp:HyperLink ID="lnkEdit" runat="server"
                                        NavigateUrl='<%# "~/Admin/Quiz/EditQuiz.aspx?quizId=" + Eval("QuizId") %>'
                                        CssClass="btn btn-primary btn-sm">
                                        Edit
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>