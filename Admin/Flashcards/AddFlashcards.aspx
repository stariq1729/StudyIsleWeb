<%@ Page Title="Add Flashcards" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="AddFlashcards.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Flashcards.AddFlashcards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-box {
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        .section-title {
            font-weight: 600;
            margin-top: 20px;
            margin-bottom: 10px;
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container-fluid mt-4">
<div class="card-box">

<h2 class="mb-4">📚 Add Flashcards</h2>
<asp:Label ID="lblMessage" runat="server" CssClass="fw-bold"></asp:Label>

<!-- Academic Selection -->
<h5 class="section-title">Select Academic Details</h5>
<div class="row">

    <div class="col-md-4 mb-3">
        <label>Board</label>
        <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-control"
            AutoPostBack="true" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" />
    </div>

    <div class="col-md-4 mb-3">
        <label>Resource Type</label>
        <asp:DropDownList ID="ddlResourceType" runat="server"
            CssClass="form-control" />
    </div>

    <asp:PlaceHolder ID="phClass" runat="server" Visible="false">
        <div class="col-md-4 mb-3">
            <label>Class</label>
            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" />
        </div>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="phSubCategory" runat="server" Visible="false">
        <div class="col-md-4 mb-3">
            <label>Sub-Category</label>
            <asp:DropDownList ID="ddlSubCategory" runat="server"
                CssClass="form-control" AutoPostBack="true"
                OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged" />
        </div>
    </asp:PlaceHolder>

    <div class="col-md-4 mb-3">
        <label>Subject</label>
        <asp:DropDownList ID="ddlSubject" runat="server"
            CssClass="form-control" AutoPostBack="true"
            OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged" />
    </div>

    <div class="col-md-4 mb-3">
        <label>Chapter</label>
        <asp:DropDownList ID="ddlChapter" runat="server"
            CssClass="form-control" />
    </div>

</div>

<!-- Flashcard Input -->
<h5 class="section-title">Flashcard Details</h5>

<div class="mb-3">
    <label>Question Text</label>
    <asp:TextBox ID="txtQuestionText" runat="server"
        CssClass="form-control" TextMode="MultiLine" Rows="3" />
</div>

<div class="mb-3">
    <label>Question Image</label>
    <asp:FileUpload ID="fuQuestionImage" runat="server"
        CssClass="form-control" />
</div>

<div class="mb-3">
    <label>Answer Text</label>
    <asp:TextBox ID="txtAnswerText" runat="server"
        CssClass="form-control" TextMode="MultiLine" Rows="3" />
</div>

<div class="mb-3">
    <label>Answer Image</label>
    <asp:FileUpload ID="fuAnswerImage" runat="server"
        CssClass="form-control" />
</div>

<div class="row">
    <div class="col-md-3">
        <label>Display Order</label>
        <asp:TextBox ID="txtDisplayOrder" runat="server"
            CssClass="form-control" Text="1" />
    </div>
    <div class="col-md-3 mt-4">
        <asp:CheckBox ID="chkIsActive" runat="server" Checked="true"
            Text="Is Active" />
    </div>
</div>

<br />

<asp:Button ID="btnAddFlashcard" runat="server"
    Text="➕ Add Question"
    CssClass="btn btn-primary"
    OnClick="btnAddFlashcard_Click" />

<asp:Button ID="btnFinish" runat="server"
    Text="✔ Finish"
    CssClass="btn btn-success ms-2"
    OnClick="btnFinish_Click" />

<hr />

<!-- Preview Grid -->
<h5 class="section-title">Added Flashcards</h5>

<asp:GridView ID="gvFlashcards" runat="server"
    CssClass="table table-bordered table-striped"
    AutoGenerateColumns="False"
    DataKeyNames="FlashcardId"
    EmptyDataText="No flashcards added yet.">

    <Columns>
        <asp:BoundField DataField="DisplayOrder" HeaderText="Order" />
        <asp:BoundField DataField="QuestionText" HeaderText="Question" />
        <asp:BoundField DataField="AnswerText" HeaderText="Answer" />
    </Columns>
</asp:GridView>

</div>
</div>

</asp:Content>