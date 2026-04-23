<%@ Page Title="Student Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="StudyIsleWeb.Student.StudentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        :root { --primary-purple: #6366f1; --bg-light: #f8fafc; --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1); }
        body { background-color: #f4f7fe; font-family: 'Inter', sans-serif; }

        /* Sidebar UI */
        .sidebar-card { background: #fff; border-radius: 24px; overflow: hidden; border: none; }
        .sidebar-header { background: #6366f1; height: 100px; position: relative; border-radius: 0 0 20px 20px; }
        .avatar-container { position: relative; margin-top: -60px; display: inline-block; }
        .profile-img { width: 110px; height: 110px; border-radius: 50%; border: 5px solid #fff; background: #fff; object-fit: cover; }
        .status-indicator { width: 15px; height: 15px; background: #22c55e; border: 3px solid #fff; border-radius: 50%; position: absolute; bottom: 10px; right: 10px; }
        
        .info-pill { background: #f8fafc; border-radius: 16px; padding: 12px 16px; margin-bottom: 12px; display: flex; align-items: center; text-align: left; }
        .info-pill i { width: 36px; height: 36px; background: #fff; border-radius: 10px; display: flex; align-items: center; justify-content: center; margin-right: 12px; color: #6366f1; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }

        /* Stepper UI */
        .step-dot { height: 6px; width: 25px; background: #e2e8f0; border-radius: 10px; display: inline-block; margin: 0 2px; }
        .step-dot.active { background: #6366f1; }

        /* Resource Cards */
        .filter-tab { background: #fff; border-radius: 12px; padding: 8px 20px; color: #64748b; border: 1px solid #e2e8f0; margin-left: 8px; cursor: pointer; transition: 0.3s; }
        .filter-tab.active { background: #6366f1; color: #fff; border-color: #6366f1; }
        
        .res-card { background: #fff; border-radius: 20px; border: 1px solid #f1f5f9; transition: 0.3s; }
        .res-card:hover { transform: translateY(-5px); box-shadow: var(--card-shadow); }
        .res-icon { width: 45px; height: 45px; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
        .launch-btn { color: #6366f1; font-weight: 600; text-decoration: none; font-size: 14px; }

        /* Full Screen Modal */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(15, 23, 42, 0.4); backdrop-filter: blur(8px); display: none; z-index: 9999; align-items: center; justify-content: center; }
        .modal-content-box { background: #fff; width: 95%; max-width: 800px; border-radius: 30px; max-height: 90vh; overflow-y: auto; padding: 40px; position: relative; }
        .avatar-selection img { width: 45px; height: 45px; border-radius: 50%; cursor: pointer; border: 2px solid transparent; transition: 0.2s; }
        .avatar-selection img:hover { border-color: #6366f1; transform: scale(1.1); }
        /* Add these to your <style> section */
.modal-body-content { padding: 40px; overflow-y: auto; max-height: calc(90vh - 100px); }
.modal-footer-sticky { padding: 20px 40px; background: #fff; border-top: 1px solid #f1f5f9; display: flex; gap: 15px; border-radius: 0 0 30px 30px; }
.input-group-custom { position: relative; margin-bottom: 5px; }
.input-group-custom i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #94a3b8; }
.form-control-custom { padding-left: 45px !important; background-color: #f8fafc !important; border: 1px solid #e2e8f0 !important; border-radius: 12px !important; height: 50px; }
.section-label { font-size: 11px; letter-spacing: 1px; color: #6366f1; font-weight: 800; margin-bottom: 15px; margin-top: 25px; }
.field-label { font-size: 10px; font-weight: 700; color: #94a3b8; margin-bottom: 5px; display: block; }
/* Hide scrollbar for the main modal box */
.modal-content-box {
    overflow: hidden !important; 
    display: flex;
    flex-direction: column;
}

/* Enable scrollbar only for the body area */
.modal-body-content {
    padding: 40px;
    overflow-y: auto;
    flex: 1; /* Takes up remaining space */
    scrollbar-width: thin; /* For Firefox */
}

/* Optional: Make the scrollbar look cleaner */
.modal-body-content::-webkit-scrollbar {
    width: 6px;
}
.modal-body-content::-webkit-scrollbar-thumb {
    background-color: #e2e8f0;
    border-radius: 10px;
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container-fluid py-5 px-lg-5">
    <div class="row">
        <div class="col-lg-3 col-md-4 mb-4">
            <div class="sidebar-card shadow-sm text-center pb-4">
                <div class="sidebar-header">
                    <button type="button" class="btn btn-sm text-white position-absolute" style="top:15px; right:15px; background: rgba(255,255,255,0.2); border-radius: 10px;" onclick="openModal()">
                        <i class="fas fa-cog"></i>
                    </button>
                </div>
                <div class="avatar-container">
                    <asp:Image ID="imgAvatar" runat="server" CssClass="profile-img" />
                    <div class="status-indicator"></div>
                </div>
                
                <h3 class="fw-bold mt-2 mb-0"><asp:Label ID="lblName" runat="server" /></h3>
                <span class="text-primary fw-bold small text-uppercase"><asp:Label ID="lblClass" runat="server" /></span>

                <div class="px-4 mt-4">
                    <div class="info-pill">
                        <i class="fas fa-bullseye"></i>
                        <div><small class="text-muted d-block">TARGET EXAM</small><strong><asp:Label ID="lblExam" runat="server" /></strong></div>
                    </div>
                    <div class="info-pill">
                        <i class="fas fa-chalkboard"></i>
                        <div><small class="text-muted d-block">BOARD</small><strong><asp:Label ID="lblBoard" runat="server" /></strong></div>
                    </div>
                    <div class="info-pill">
                        <i class="fas fa-map-marker-alt"></i>
                        <div><small class="text-muted d-block">CITY</small><strong><asp:Label ID="lblCity" runat="server" /></strong></div>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center px-4 mt-4">
                    <div class="text-start">
                        <small class="text-muted d-block mb-1">ONBOARDING</small>
                        <div class="step-dot active"></div><div class="step-dot active"></div><div class="step-dot"></div>
                    </div>
                    <div class="badge bg-primary bg-opacity-10 text-primary p-2 px-3 rounded-pill">
                        <i class="fas fa-bolt me-1"></i> PRO MEMBER
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-9 col-md-8">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
                <h2 class="fw-bold m-0">Resource Library</h2>
                <div class="d-flex mt-2 mt-lg-0">
                    <div class="filter-tab active">All</div>
                    <div class="filter-tab">MCQ</div>
                    <div class="filter-tab">PDF</div>
                    <div class="filter-tab">Blog</div>
                    <div class="filter-tab">Video</div>
                </div>
            </div>

            <div class="row">
               <asp:Repeater ID="rptResources" runat="server">
    <ItemTemplate>
        <div class="col-md-6 mb-4">
            <div class="res-card p-4 shadow-sm">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div class="res-icon" style='<%# GetCategoryStyle(Eval("ItemType").ToString()) %>'>
                        <i class='<%# GetIconClass(Eval("ItemType").ToString()) %>'></i>
                    </div>
                    <asp:LinkButton runat="server" ID="btnDelete" CommandArgument='<%# Eval("BookmarkId") %>' CssClass="text-muted">
                        <i class="far fa-trash-alt"></i>
                    </asp:LinkButton>
                </div>
                <div class="mb-3">
                    <span class="badge bg-primary bg-opacity-10 text-primary small"><%# Eval("ItemType") %></span>
                    <h5 class="fw-bold mt-2"><%# Eval("DisplayTitle") %></h5>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <small class="text-muted">Added <%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></small>
                    <a href="#" class="launch-btn">Launch <i class="fas fa-external-link-alt ms-1"></i></a>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
            </div>
        </div>
    </div>
</div>

<div id="settingsModal" class="modal-overlay">
    <div class="modal-content-box">
        <button type="button" class="btn-close position-absolute" style="top:30px; right:30px; z-index:100;" onclick="closeModal()"></button>
        
        <div class="modal-body-content">
            <h3 class="fw-bold mb-1">Account Settings</h3>
            <p class="text-muted mb-4">Update your learning profile and personal details</p>

            <div class="text-center mb-4">
                <div class="position-relative d-inline-block">
                    <asp:Image ID="imgModalAvatar" runat="server" ClientIDMode="Static" CssClass="rounded-circle border" style="width:100px; height:100px; object-fit:cover;" />
                    <asp:FileUpload ID="fuModalImage" runat="server" style="display:none;" onchange="previewModalImage(this)" />
                    <div onclick="triggerFileUpload()" class="bg-primary text-white rounded-circle position-absolute bottom-0 end-0 d-flex align-items-center justify-content-center" style="width:32px; height:32px; border:3px solid #fff; cursor:pointer;">
                        <i class="fas fa-camera small"></i>
                    </div>
                </div>
                <p class="field-label mt-3">Avatar Selection</p>
                <div class="avatar-selection d-flex justify-content-center gap-2">
                    <img src="../assets/img/Deault_Random_boy.png" onclick="setAvatar(this.src)" />
                    <img src="../assets/img/Default_Random_girl.png" onclick="setAvatar(this.src)" />
                </div>
                <asp:HiddenField ID="hfAvatar" runat="server" ClientIDMode="Static" />
            </div>

            <div class="section-label">Personal Information</div>
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="field-label">Full Name (Read Only)</label>
                    <div class="input-group-custom">
                        <i class="fas fa-user"></i>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="field-label">Date of Birth (Read Only)</label>
                    <div class="input-group-custom">
                        <i class="fas fa-calendar-alt"></i>
                        <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="field-label">Email (Read Only)</label>
                    <div class="input-group-custom">
                        <i class="fas fa-envelope"></i>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" />
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="field-label">Mobile Number</label>
                    <div class="input-group-custom">
                        <i class="fas fa-phone"></i>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control form-control-custom" />
                    </div>
                </div>
            </div>

            <div class="section-label">Academic Profile</div>
            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <label class="field-label">Class / Grade</label>
                    <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select form-control-custom"></asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="field-label">School Board</label>
                    <asp:DropDownList ID="ddlBoard" runat="server" CssClass="form-select form-control-custom"></asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="field-label">Competitive Exam</label>
                    <asp:DropDownList ID="ddlExam" runat="server" CssClass="form-select form-control-custom"></asp:DropDownList>
                </div>
            </div>

            <div class="section-label">Location & Address</div>
            <div class="row g-3 mb-2">
                <div class="col-md-6"><label class="field-label">State</label><asp:TextBox ID="txtState" runat="server" CssClass="form-control form-control-custom" /></div>
                <div class="col-md-6"><label class="field-label">City</label><asp:TextBox ID="txtCity" runat="server" CssClass="form-control form-control-custom" /></div>
                <div class="col-md-6"><label class="field-label">Pincode</label><asp:TextBox ID="txtPincode" runat="server" CssClass="form-control form-control-custom" /></div>
                <div class="col-md-6"><label class="field-label">Area</label><asp:TextBox ID="txtArea" runat="server" CssClass="form-control form-control-custom" /></div>
                <div class="col-12"><label class="field-label">Full Communication Address</label>
                    <asp:TextBox ID="txtFullAddress" runat="server" CssClass="form-control form-control-custom" TextMode="MultiLine" Rows="2" style="height:auto !important;" />
                </div>
            </div>
        </div>

        <div class="modal-footer-sticky">
            <button type="button" class="btn btn-light flex-grow-1 py-3 fw-bold" onclick="closeModal()">Discard Changes</button>
            <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary flex-grow-1 py-3 fw-bold" OnClick="btnUpdate_Click" />
        </div>
    </div>
</div>
<script>
    function openModal() {
        document.getElementById("settingsModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("settingsModal").style.display = "none";
    }

    function setAvatar(src) {
        document.getElementById("imgModalAvatar").src = src;
        document.getElementById("hfAvatar").value = src;
    }

    function previewModalImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("imgModalAvatar").src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    function triggerFileUpload() {
        document.getElementById('<%= fuModalImage.ClientID %>').click();
    }
</script></asp:Content>