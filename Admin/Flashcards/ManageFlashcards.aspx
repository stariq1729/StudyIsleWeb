<%@ Page Title="Manage Flashcards" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageFlashcards.aspx.cs"
    Inherits="StudyIsleWeb.Admin.Flashcards.ManageFlashcards" %>

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
            margin-bottom: 15px;
        }
        .top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .grid-img {
            width: 60px;
            height: auto;
            border-radius: 5px;
        }
        .badge-active {
            background-color: #28a745;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .badge-inactive {
            background-color: #dc3545;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container-fluid mt-4">
<div class="card-box">

    <!-- Header -->
    <div class="top-actions">
        <h2 class="section-title">📚 Manage Flashcards</h2>
        <asp:Button ID="btnAddFlashcard" runat="server"
            Text="➕ Add Flashcard"
            CssClass="btn btn-primary"
            OnClick="btnAddFlashcard_Click" />
    </div>

    <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold"></asp:Label>

    <hr />

    <!-- Academic Mapping Filters -->
    <div class="row">

        <div class="col-md-3 mb-3">
            <label>Board</label>
            <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged" />
        </div>

        <asp:PlaceHolder ID="phClass" runat="server" Visible="false">
            <div class="col-md-3 mb-3">
                <label>Class</label>
                <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" />
            </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder ID="phSubCategory" runat="server" Visible="false">
            <div class="col-md-3 mb-3">
                <label>Sub-Category</label>
                <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged" />
            </div>
        </asp:PlaceHolder>

        <div class="col-md-3 mb-3">
            <label>Subject</label>
            <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged" />
        </div>

        <div class="col-md-3 mb-3">
            <label>Chapter</label>
            <asp:DropDownList ID="ddlChapter" runat="server" CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlChapter_SelectedIndexChanged" />
        </div>

    </div>

    <hr />

    <!-- Flashcards Grid -->
    <asp:GridView ID="gvFlashcards" runat="server"
        CssClass="table table-bordered table-striped"
        AutoGenerateColumns="False"
        DataKeyNames="FlashcardId"
        EmptyDataText="No flashcards available."
        OnRowCommand="gvFlashcards_RowCommand">

        <Columns>

            <asp:BoundField DataField="BoardName" HeaderText="Board" />
            <asp:BoundField DataField="ClassOrSubCategory" HeaderText="Class/SubCategory" />
            <asp:BoundField DataField="SubjectName" HeaderText="Subject" />
            <asp:BoundField DataField="ChapterName" HeaderText="Chapter" />
            <asp:BoundField DataField="DisplayOrder" HeaderText="Order" />

            <asp:BoundField DataField="QuestionText" HeaderText="Question" />
            <asp:BoundField DataField="AnswerText" HeaderText="Answer" />

            <asp:TemplateField HeaderText="Active">
                <ItemTemplate>
                    <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge-active" : "badge-inactive" %>'>
                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server"
                        CommandName="EditFlashcard"
                        CommandArgument='<%# Eval("FlashcardId") %>'
                        CssClass="btn btn-sm btn-warning me-1">
                        Edit
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnDelete" runat="server"
                        CommandName="DeleteFlashcard"
                        CommandArgument='<%# Eval("FlashcardId") %>'
                        CssClass="btn btn-sm btn-danger"
                        OnClientClick="return confirm('Are you sure you want to delete this flashcard?');">
                        Delete
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>

</div>
</div>

</asp:Content>