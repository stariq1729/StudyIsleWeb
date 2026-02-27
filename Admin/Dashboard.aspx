<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StudyIsleWeb.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h4 class="dashboard-title">Dashboard Overview</h4>

    <div class="row g-4">

        <div class="col-md-3">
            <div class="dashboard-card shadow-sm">
                <h6>Total Boards</h6>
                <h3><asp:Literal ID="litBoards" runat="server"></asp:Literal></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card shadow-sm">
                <h6>Total Classes</h6>
                <h3><asp:Literal ID="litClasses" runat="server"></asp:Literal></h3>
            </div>
        </div>

                <div class="col-md-3">
            <div class="dashboard-card shadow-sm">
                <h6>Total Resources</h6>
                <h3><asp:Literal ID="litResources" runat="server"></asp:Literal></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card shadow-sm">
                <h6>Total Subjects</h6>
                <h3><asp:Literal ID="litSubjects" runat="server"></asp:Literal></h3>
            </div>
        </div>



    </div>
</asp:Content>
