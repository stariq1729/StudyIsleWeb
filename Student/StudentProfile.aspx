<%@ Page Title="Student Profile" Language="C#" MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" 
    Inherits="StudyIsleWeb.Student.StudentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    :root {
        --primary-purple: #6c63ff;
        --soft-bg: #f8f9fa;
    }

    body { background-color: #f4f7fe; }

    /* Profile Card Sidebar */
    .profile-sidebar {
        background: white;
        border-radius: 20px;
        overflow: hidden;
    }
    .profile-header-img {
        width: 120px; height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid #fff;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    /* Navigation List */
    .list-group-item {
        font-weight: 500;
        padding: 15px 20px;
        border: none !important;
        margin-bottom: 5px;
        color: #555;
        transition: 0.3s;
    }
    .list-group-item i { width: 25px; color: var(--primary-purple); }
    .list-group-item:hover {
        background-color: #f0efff !important;
        color: var(--primary-purple) !important;
        border-radius: 12px !important;
    }
    .text-danger:hover { background-color: #fff5f5 !important; color: #dc3545 !important; }

    /* Resource Cards */
    .resource-card {
        border: none;
        border-radius: 15px;
        background: white;
        transition: transform 0.2s;
    }
    .resource-card:hover { transform: translateY(-3px); }
    .icon-box {
        width: 50px; height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center; justify-content: center;
        background: #f0efff;
        color: var(--primary-purple);
        font-size: 1.2rem;
    }
    .badge-soft {
        background: #eef2ff;
        color: #6366f1;
        font-size: 11px;
        padding: 5px 10px;
        border-radius: 6px;
    }

    /* Modal Styling */
    .modal-bg {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.5); backdrop-filter: blur(4px);
        display: none; z-index: 1050; align-items: center; justify-content: center;
    }
    .modal-box {
        background: white; width: 90%; max-width: 550px;
        padding: 30px; border-radius: 20px; position: relative;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-5">
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="profile-sidebar shadow-sm p-4 text-center">
                <div class="mb-3">
                    <asp:Image ID="imgAvatar" runat="server" CssClass="profile-header-img" />
                </div>
                
                <h4 class="fw-bold mb-1"><asp:Label ID="lblName" runat="server" /></h4>
                <p class="text-muted small mb-3"><asp:Label ID="lblClass" runat="server" /> Student</p>

                <div class="d-flex justify-content-around py-3 border-top border-bottom mb-4">
                    <div><b class="d-block"><asp:Literal ID="litCount" runat="server" /></b><small class="text-muted">Bookmarks</small></div>
                    <div><b class="d-block">12</b><small class="text-muted">Completed</small></div>
                </div>

                <div class="text-start mb-4 bg-light p-3 rounded" style="font-size: 14px;">
                    <div class="mb-1"><strong>Exam:</strong> <asp:Label ID="lblExam" runat="server" /></div>
                    <div class="mb-1"><strong>Board:</strong> <asp:Label ID="lblBoard" runat="server" /></div>
                    <div class="mb-0"><strong>City:</strong> <asp:Label ID="lblCity" runat="server" /></div>
                </div>

                <div class="list-group text-start">
                    <a href="Dashboard.aspx" class="list-group-item list-group-item-action">
                        <i class="fas fa-th-large"></i> Dashboard
                    </a>
                    <button type="button" class="list-group-item list-group-item-action" onclick="openModal()">
                        <i class="fas fa-user-edit"></i> Edit Profile
                    </button>
                    <asp:LinkButton ID="lnkLogout" runat="server" CssClass="list-group-item list-group-item-action text-danger" OnClick="btnLogout_Click">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold mb-0">Saved Resources</h4>
                <span class="text-muted small">Updated just now</span>
            </div>
            
            <div class="row">
                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="col-12 mb-3">
                            <div class="resource-card shadow-sm p-3">
                                <div class="d-flex align-items-center">
                                    <div class="icon-box me-3">
                                        <i class='<%# Eval("ItemType").ToString() == "Resource" ? "fas fa-file-pdf" : "fas fa-lightbulb" %>'></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="fw-bold mb-1"><%# Eval("DisplayTitle") %></h6>
                                        <span class="badge-soft"><%# Eval("ItemType") %></span>
                                    </div>
                                    <div class="text-warning">
                                        <i class="fas fa-bookmark"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>

<div id="settingsModal" class="modal-bg">
    <div class="modal-box shadow-lg">
        <button type="button" class="btn-close position-absolute" style="top:20px; right:20px;" onclick="closeModal()"></button>
        <h5 class="fw-bold mb-4">Account Settings</h5>
        
        <div class="row">
            <div class="col-md-4 text-center border-end">
                <asp:Image ID="imgModalAvatar" runat="server" ClientIDMode="Static" style="width:80px; height:80px; border-radius:50%; object-fit:cover;" />
                <div class="d-flex flex-wrap justify-content-center mt-3">
                    <img src="../assets/img/Deault_Random_boy.png" class="m-1" style="width:35px; cursor:pointer;" onclick="setAvatar(this.src)" />
                    <img src="../assets/img/Default_Random_girl.png"  class="m-1" style="width:35px; cursor:pointer;" onclick="setAvatar(this.src)" />
                    <img src="../images/avatar3.png" class="m-1" style="width:35px; cursor:pointer;" onclick="setAvatar(this.src)" />
                </div>
                <asp:HiddenField ID="hfAvatar" runat="server" ClientIDMode="Static" />
            </div>
            <div class="col-md-8 ps-4">
                <div class="mb-3">
                    <label class="small fw-bold">Full Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control mt-1" />
                </div>
                <div class="mb-4">
                    <label class="small fw-bold">Date of Birth</label>
                    <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control mt-1" TextMode="Date" />
                </div>
                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary w-100 fw-bold" OnClick="btnUpdate_Click" />
            </div>
        </div>
    </div>
</div>

<script>
    function openModal() { document.getElementById("settingsModal").style.display = "flex"; }
    function closeModal() { document.getElementById("settingsModal").style.display = "none"; }
    function setAvatar(src) {
        document.getElementById("imgModalAvatar").src = src;
        document.getElementById("hfAvatar").value = src;
    }
</script>

</asp:Content>