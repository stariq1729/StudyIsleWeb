<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NcertBook.aspx.cs" Inherits="StudyIsleWeb.NcertBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/css/board-resource.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HEADER -->
    <section class="board-resource-header">
        <div class="container">
            <h1>NCERT Books</h1>
            <p>Select class to explore books.</p>

            <!-- CLASS TABS -->
            <div class="class-tabs">
                <button class="class-btn">Class 6</button>
                <button class="class-btn">Class 7</button>
                <button class="class-btn">Class 8</button>
                <button class="class-btn">Class 9</button>
                <button class="class-btn">Class 10</button>
                <button class="class-btn">Class 11</button>
                <button class="class-btn active">Class 12</button>
            </div>
        </div>
    </section>

    <!-- BODY -->
    <section class="resource-body">
        <div class="container">
            <h3>Class 12 Books will load here.</h3>
        </div>
    </section>

</asp:Content>