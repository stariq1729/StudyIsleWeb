<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardResource.aspx.cs" Inherits="StudyIsleWeb.BoardResource" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/css/board-resource.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="board-resource-header">
        <div class="container">
            <h1 id="lblHeading" runat="server"></h1>
            <p>Select class to explore resources.</p>

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

    <section class="resource-body">
        <div class="container">
            <h3>Content will load here.</h3>
        </div>
    </section>

</asp:Content>