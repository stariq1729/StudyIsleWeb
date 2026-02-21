<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NcertBook.aspx.cs" Inherits="StudyIsleWeb.NcertBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/css/board-resource.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="board-resource-header">
        <div class="container">
            <h1>NCERT Books</h1>
            <p>Select class to explore books.</p>

            <div class="class-tabs">
                <asp:Repeater ID="rptClasses" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton
                            runat="server"
                            CssClass='<%# (int)Eval("ClassId") == SelectedClassId ? "class-btn active" : "class-btn" %>'
                            CommandArgument='<%# Eval("ClassId") %>'
                            OnCommand="Class_Command">
                            <%# Eval("ClassName") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <section class="resource-body">
        <div class="container">

            <asp:Repeater ID="rptSubjects" runat="server" OnItemDataBound="rptSubjects_ItemDataBound">
                <ItemTemplate>

                    <div class="subject-section">

                        <div class="subject-header">
                            <span class="subject-bar"></span>
                            <h3><%# Eval("SubjectName") %> Books</h3>
                        </div>

                        <div class="books-container">
                            <asp:Repeater ID="rptBooks" runat="server">
                                <ItemTemplate>
                                    <div class="book-card">
                                        <img src='<%# Eval("ThumbnailPath") %>' alt="book" />
                                        <div class="book-info">
                                            <h5><%# Eval("Title") %></h5>
                                            <a href="#" class="read-btn">Read Online</a>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </section>

</asp:Content>