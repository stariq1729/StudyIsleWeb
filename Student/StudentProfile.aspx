<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs"
    Inherits="StudyIsleWeb.Student.StudentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.profile-card {
    background: #6c63ff;
    color: white;
    padding: 20px;
    border-radius: 15px;
}
.avatar {
    width:80px;
    height:80px;
    border-radius:50%;
}
.select-avatar {
    width:40px;
    height:40px;
    border-radius:50%;
    cursor:pointer;
}
.modal-bg {
    position:fixed;
    top:0;left:0;
    width:100%;height:100%;
    background:rgba(0,0,0,0.5);
    display:none;
}
.modal-box {
    background:white;
    width:500px;
    margin:100px auto;
    padding:20px;
    border-radius:10px;
}
</style>

<div class="container mt-4">
    <div class="row">

        <!-- LEFT PANEL -->
        <div class="col-md-4">

            <div class="profile-card text-center">

                <asp:Image ID="imgAvatar" runat="server" CssClass="avatar mb-2" />

                <h5><asp:Label ID="lblName" runat="server" /></h5>

                <p><asp:Label ID="lblClass" runat="server" /></p>

                <hr />

                <p><b>Exam:</b> <asp:Label ID="lblExam" runat="server" /></p>
                <p><b>Board:</b> <asp:Label ID="lblBoard" runat="server" /></p>
                <p><b>City:</b> <asp:Label ID="lblCity" runat="server" /></p>

                <button type="button" class="btn btn-light mt-2" onclick="openModal()">Settings</button>

            </div>

        </div>

        <!-- RIGHT PANEL -->
        <div class="col-md-8">

            <h4>Resource Library</h4>
            <asp:Repeater ID="rptResources" runat="server">
    <ItemTemplate>
       <div class="card p-3 mb-2 d-flex justify-content-between align-items-center">
    
    <div>
        <span class="badge bg-info">
            <%# Eval("ItemType") %>
        </span>

        <div class="fw-bold mt-1">
            <%# Eval("ItemType").ToString() == "Resource" 
                ? Eval("Title") 
                : Eval("QuizLabel") %>
        </div>
    </div>

    <i class="fas fa-bookmark text-warning"></i>

</div>
    </ItemTemplate>
</asp:Repeater>

        </div>

    </div>
</div>

<!-- MODAL -->
<div id="modal" class="modal-bg">
    <div class="modal-box">

        <h4>Account Settings</h4>

        <div class="text-center mb-3">
            <asp:Image ID="imgModalAvatar" runat="server" CssClass="avatar" />
        </div>

        <div class="text-center mb-3">
            <img src="/images/avatar1.png" class="select-avatar" onclick="setAvatar(this.src)" />
            <img src="/images/avatar2.png" class="select-avatar" onclick="setAvatar(this.src)" />
            <img src="/images/avatar3.png" class="select-avatar" onclick="setAvatar(this.src)" />
        </div>

        <asp:HiddenField ID="hfAvatar" runat="server" />

        <asp:TextBox ID="txtName" runat="server" CssClass="form-control mb-2" />
        <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control mb-2" TextMode="Date" />

        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile"
            CssClass="btn btn-primary w-100" OnClick="btnUpdate_Click" />

        <button class="btn btn-secondary w-100 mt-2" onclick="closeModal()">Close</button>

    </div>
</div>

<script>
function openModal() {
    document.getElementById("modal").style.display = "block";
}
function closeModal() {
    document.getElementById("modal").style.display = "none";
}
function setAvatar(src) {
    document.getElementById("<%= imgModalAvatar.ClientID %>").src = src;
    document.getElementById("<%= hfAvatar.ClientID %>").value = src;
}
</script>

</asp:Content>