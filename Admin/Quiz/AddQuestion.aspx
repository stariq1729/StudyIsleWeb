<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddQuestion.aspx.cs" Inherits="StudyIsleWeb.Admin.Quiz.AddQuestion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-4">
        <h1 class="mt-4">Add Questions</h1>

        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-light">
                <strong>MCQ Entry</strong>
            </div>

            <div class="card-body">
                <div class="row g-3">

                    <!-- Question -->
                    <div class="col-12">
                        <label class="form-label fw-bold">Question</label>
                        <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control"
                            TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <!-- Options -->
                    <div class="col-md-6">
                        <label class="form-label">Option A</label>
                        <asp:TextBox ID="txtA" runat="server" CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Option B</label>
                        <asp:TextBox ID="txtB" runat="server" CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Option C</label>
                        <asp:TextBox ID="txtC" runat="server" CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Option D</label>
                        <asp:TextBox ID="txtD" runat="server" CssClass="form-control" />
                    </div>

                    <!-- Correct Answer -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Correct Answer</label>
                        <asp:DropDownList ID="ddlCorrect" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Select" Value="" />
                            <asp:ListItem Text="A" Value="A" />
                            <asp:ListItem Text="B" Value="B" />
                            <asp:ListItem Text="C" Value="C" />
                            <asp:ListItem Text="D" Value="D" />
                        </asp:DropDownList>
                    </div>

                    <!-- Marks -->
                    <div class="col-md-4">
                        <label class="form-label">Marks</label>
                        <asp:TextBox ID="txtMarks" runat="server" CssClass="form-control" Text="1" TextMode="Number" />
                    </div>

                    <!-- Order -->
                    <div class="col-md-4">
                        <label class="form-label">Question Order</label>
                        <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control" TextMode="Number" />
                    </div>

                    <!-- Explanation -->
                    <div class="col-12">
                        <label class="form-label">Explanation (Optional)</label>
                        <asp:TextBox ID="txtExplanation" runat="server" CssClass="form-control"
                            TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <!-- Buttons -->
                    <div class="col-12 mt-4 border-top pt-3">
                        <asp:Button ID="btnSave" runat="server" Text="Save Question"
                            CssClass="btn btn-success px-4" OnClick="btnSave_Click" />

                        <asp:Button ID="btnFinish" runat="server" Text="Finish"
                            CssClass="btn btn-primary ms-2" OnClick="btnFinish_Click" />

                        <asp:Label ID="lblMessage" runat="server" CssClass="ms-3"></asp:Label>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>