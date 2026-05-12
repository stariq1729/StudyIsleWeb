<%@ Page Title="Student Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="StudyIsleWeb.Student.StudentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        /* Update your existing <style> section or add this */
:root {
    --bg-body: #f8fafc;
    --card-bg: #ffffff;
    --accent-purple: #6366f1;
    --text-dark: #0f172a;
}

body { background-color: var(--bg-body); }

/* Bento Card Styling */
.bento-card {
    background: var(--card-bg);
    border-radius: 28px;
    border: 1px solid rgba(226, 232, 240, 0.6);
    padding: 1rem;
    transition: all 0.3s ease;
}

.bento-card:hover { transform: translateY(-5px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); }

/* Identity Section */
.hero-text { color: var(--text-dark); line-height: 1; }
.hero-name { color: var(--accent-purple); }

.profile-main-card { border-radius: 35px !important; }
.avatar-frame {
    padding: 8px;
    border: 3px solid var(--accent-purple);
    border-radius: 22px;
    display: inline-block;
}

/* AI Insight Section */
.ai-card {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    border-radius: 35px;
    color: white;
}

.btn-manage {
    background: #f1f5f9;
    color: #64748b;
    border-radius: 14px;
    transition: 0.2s;
}

.btn-manage:hover { background: #e2e8f0; color: #0f172a; }

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
<div class="container py-5 px-lg-5">
    <div class="row g-5">
        <div class="col-lg-5">
            <div class="mb-5">
                <span class="badge rounded-pill bg-white text-muted border px-3 py-2 mb-4 shadow-sm">
                    <i class="fas fa-circle text-success me-2 small"></i>ACADEMIC YEAR 2024-25
                </span>
                <h1 class="display-4 fw-bold hero-text">
                    Perspective is <br />
                    <span class="hero-name">everything, <asp:Literal ID="litFirstName" runat="server" />.</span>
                </h1>
                <p class="text-muted fs-5 mt-4">
                    Your roadmap for <strong><asp:Label ID="lblExamHeader" runat="server" /></strong> is dynamically updating based on your progress.
                </p>
            </div>

            <div class="bento-card profile-main-card shadow-sm text-center p-4">
                <div class="avatar-frame mb-3 mt-2">
                    <asp:Image ID="imgMainAvatar" runat="server" CssClass="rounded-4" style="width: 100px; height: 100px; object-fit: cover;" />
                </div>
                <h2 class="fw-bold mb-1"><asp:Label ID="lblNameFull" runat="server" /></h2>
                <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2 text-uppercase fw-bold mb-4" style="font-size: 11px;">
                    <asp:Label ID="lblClassBadge" runat="server" /> STUDENT
                </span>

                <div class="d-flex justify-content-between align-items-center bg-light p-3 rounded-4 mb-3 mx-2">
                    <div class="d-flex align-items-center">
                        <div class="bg-white p-2 rounded-3 shadow-sm me-3"><i class="fas fa-bolt text-warning"></i></div>
                        <span class="text-muted fw-bold small text-uppercase">Account Tier</span>
                    </div>
                    <span class="fw-bold">PRO PLAN</span>
                </div>

                <button type="button" class="btn btn-manage w-100 py-3 fw-bold border-0 mt-2" onclick="openModal()">
                    <i class="fas fa-cog me-2"></i>MANAGE ACCOUNT
                </button>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="bento-card h-100 shadow-sm">
                        <div class="bg-primary bg-opacity-10 rounded-3 p-2 d-inline-block mb-3">
                            <i class="fas fa-gem text-primary"></i>
                        </div>
                        <p class="text-muted fw-bold small text-uppercase mb-1">Academic Standing</p>
                        <h4 class="fw-bold"><asp:Label ID="lblClassStat" runat="server" /></h4>
                        <small class="text-muted">Currently enrolled</small>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="bento-card h-100 shadow-sm">
                        <div class="bg-danger bg-opacity-10 rounded-3 p-2 d-inline-block mb-3">
                            <i class="fas fa-bullseye text-danger"></i>
                        </div>
                        <p class="text-muted fw-bold small text-uppercase mb-1">Target Focus</p>
                        <h4 class="fw-bold"><asp:Label ID="lblExamStat" runat="server" /></h4>
                        <small class="text-muted">Primary objective</small>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="bento-card h-100 shadow-sm">
                        <div class="bg-warning bg-opacity-10 rounded-3 p-2 d-inline-block mb-3">
                            <i class="fas fa-layer-group text-warning"></i>
                        </div>
                        <p class="text-muted fw-bold small text-uppercase mb-1">Preparation Board</p>
                        <h4 class="fw-bold"><asp:Label ID="lblBoardStat" runat="server" /></h4>
                        <small class="text-muted">Curriculum style</small>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="bento-card h-100 shadow-sm">
                        <div class="bg-success bg-opacity-10 rounded-3 p-2 d-inline-block mb-3">
                            <i class="fas fa-map-marker-alt text-success"></i>
                        </div>
                        <p class="text-muted fw-bold small text-uppercase mb-1">Regional Sector</p>
                        <h4 class="fw-bold"><asp:Label ID="lblCityStat" runat="server" /></h4>
                        <small class="text-muted">Location verified</small>
                    </div>
                </div>

                <div class="col-12 mt-4">
                    <div class="ai-card p-5 shadow-lg">
                        <span class="badge bg-white bg-opacity-10 text-white rounded-pill px-3 py-2 mb-4 fw-bold">AI INSIGHT</span>
                        <h2 class="fw-bold mb-4">Ready to accelerate your <asp:Label ID="lblExamInsight" runat="server" /> preparation?</h2>
                        <p class="text-secondary fs-5 mb-5 opacity-75">
                            Our algorithm has mapped out your next 4 weeks. Complete your profile details to unlock the full curriculum analysis.
                        </p>
                        <div class="d-flex gap-3">
                            <button type="button" class="btn btn-white bg-white text-dark fw-bold px-4 py-3 rounded-pill" onclick="openModal()">COMPLETE PROFILE</button>
                            <button type="button" class="btn btn-outline-light px-4 py-3 rounded-pill opacity-50" onclick="alert('Analysis skipped')">SKIP FOR NOW</button>
                        </div>
                    </div>
                </div>
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