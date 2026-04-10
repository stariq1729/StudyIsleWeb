<%@ Page Title="Add Question" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="AddQuestion.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Quiz.AddQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .preview-img {
            max-height: 80px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 3px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add MCQ Question</h1>

        <div class="card shadow-sm mb-4">
            <div class="card-header bg-light">
                <strong>Question Details</strong>
            </div>

            <div class="card-body">
                <div class="row g-3">

                    <!-- Question Text -->
                    <div class="col-12">
                        <label class="form-label fw-bold">Question Text</label>
                        <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control"
                            TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <!-- Question Image -->
                    <div class="col-12">
                        <label class="form-label">Question Image (Optional)</label>
                        <asp:FileUpload ID="fuQuestionImage" runat="server" CssClass="form-control" />
                    </div>

                    <!-- OPTION A -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Option A</label>
                        <asp:TextBox ID="txtA" runat="server" CssClass="form-control" />
                        <asp:FileUpload ID="fuAImage" runat="server" CssClass="form-control mt-1" />
                    </div>

                    <!-- OPTION B -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Option B</label>
                        <asp:TextBox ID="txtB" runat="server" CssClass="form-control" />
                        <asp:FileUpload ID="fuBImage" runat="server" CssClass="form-control mt-1" />
                    </div>

                    <!-- OPTION C -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Option C</label>
                        <asp:TextBox ID="txtC" runat="server" CssClass="form-control" />
                        <asp:FileUpload ID="fuCImage" runat="server" CssClass="form-control mt-1" />
                    </div>

                    <!-- OPTION D -->
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Option D</label>
                        <asp:TextBox ID="txtD" runat="server" CssClass="form-control" />
                        <asp:FileUpload ID="fuDImage" runat="server" CssClass="form-control mt-1" />
                    </div>

                    <!-- Correct Answer -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Correct Answer</label>
                        <asp:DropDownList ID="ddlCorrect" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Select Correct Option" Value="" />
                            <asp:ListItem Text="Option A" Value="A" />
                            <asp:ListItem Text="Option B" Value="B" />
                            <asp:ListItem Text="Option C" Value="C" />
                            <asp:ListItem Text="Option D" Value="D" />
                        </asp:DropDownList>
                    </div>

                    <!-- Marks -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Marks</label>
                        <asp:TextBox ID="txtMarks" runat="server" CssClass="form-control"
                            Text="1" TextMode="Number"></asp:TextBox>
                    </div>

                    <!-- Question Order -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Question Order</label>
                        <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control"
                            TextMode="Number"></asp:TextBox>
                    </div>

                    <!-- Explanation -->
                    <div class="col-12">
                        <label class="form-label fw-bold">Explanation (Optional)</label>
                        <asp:TextBox ID="txtExplanation" runat="server" CssClass="form-control"
                            TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <!-- Buttons -->
                    <div class="col-12 mt-4 border-top pt-3">
                        <asp:Button ID="btnSave" runat="server" Text="Save Question"
                            CssClass="btn btn-success px-4" OnClick="btnSave_Click" />

                        <asp:Button ID="btnFinish" runat="server" Text="Finish"
                            CssClass="btn btn-primary ms-2"
                            PostBackUrl="~/Admin/Quiz/AddQuiz.aspx" />

                        <asp:Label ID="lblMessage" runat="server" CssClass="ms-3"></asp:Label>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>