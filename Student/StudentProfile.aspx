<%@ Page Title="Student Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="StudyIsleWeb.Student.StudentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
    :root {
        --primary: #6366f1;
        --bg-body: #fafbff;
        --card-bg: #ffffff;
        --text-main: #0f172a;
        --text-muted: #64748b;
        --radius: 24px;
        --shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.04), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
    }
    body{
        background-color: #fafbff !important;
    }
    /* Main Grid Layout */
    .dashboard-container {
    display: grid;
    grid-template-columns: 400px 1fr;
    gap: 40px; /* Increased gap between left and right side */
    padding: 40px 0; /* Vertical padding only */
    max-width: 1100px; /* Adjust this to match your Navbar container width */
    margin: 0 auto; /* Centers the whole dashboard */
    font-family: 'Inter', sans-serif;
    align-items: start;
}

    /* Left Column: Hero & Profile Card */
    .left-col { display: flex; flex-direction: column; gap: 30px; }
    /* The Badge at the top */
.ai-badge-top { 
    display: inline-block;
    margin-bottom: 12px; /* Increased gap between badge and H1 */
    color: #64748b; 
    border: 1px solid #e2e8f0;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 700;
}

/* The H1 Heading */
.Profile-hero-section h1 { 
    font-size: 3rem !important; /* Forces the size */
    font-weight: 800 !important; /* Maximum thickness */
    color: #0f172a; 
    line-height: 1.0; /* Tighter line spacing for that modern look */
    margin-bottom: 22px;
    letter-spacing: -2px; /* Pulls letters closer like the reference */
}
   
    .hero-name { color: var(--primary); }

    .profile-card {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 40px;
        text-align: center;
        box-shadow: var(--shadow);
        border: 1px solid #f1f5f9;
    }

    .avatar-wrapper {
        position: relative;
        display: inline-block;
        margin-bottom: 20px;
    }

    .avatar-ring {
        padding: 8px;
        border: 4px solid var(--primary);
        border-radius: 35%; /* Squircle look from image */
        display: block;
    }

    .status-dot {
        width: 18px; height: 18px;
        background: #22c55e;
        border: 3px solid #fff;
        border-radius: 50%;
        position: absolute;
        bottom: 8px; right: 8px;
    }

    /* Right Column: Stats Grid & AI Card */
    .right-col { display: flex; flex-direction: column; gap: 30px; }

    .stats-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 25px;
    }

    /* Make right cards more compact */
.stat-card {
    background: #fff;
    border-radius: 24px;
    padding: 20px 25px; /* Reduced vertical padding */
    border: 1px solid #f1f5f9;
    height: fit-content; /* Card only grows to fit content */
}

/* Shrink the AI Card height */
.ai-card {
    background: #0f172a;
    border-radius: 24px;
    padding: 30px 40px; /* Reduced padding to shrink height */
    color: white;
    margin-top: 10px; /* Slight gap from cards above */
}

.ai-card h2 {
    font-size: 2rem;
    margin: 15px 0;
}

    .stat-card:hover { transform: translateY(-5px); }
    .stat-label { font-size: 10px; font-weight: 700; margin-bottom:0.25rem; color: var(--text-muted); text-uppercase: uppercase; letter-spacing: 0.5px; }
    .stat-value { display: block; font-size: 1.125rem; line-height:1,75rem; font-weight: 700; color: var(--text-main); margin: 5px 0; }
    .stat-sub { font-size: 12px; color: var(--text-muted); }

    /* AI Insight Card */
    /*.ai-card {
        background: #0f172a;
        border-radius: var(--radius);
        padding: 40px;
        color: white;
        position: relative;
        overflow: hidden;
    }
*/
    .ai-badge { background: rgba(255,255,255,0.1); padding: 5px 12px; border-radius: 20px; font-size: 10px; font-weight: 800; 
                padding-bottom:12px;

    }
    
    /* Buttons */
    .btn-manage { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 12px; font-size: 12px; font-weight: 700; cursor: pointer; width: 100%; transition: 0.3s; }
    .btn-manage:hover { background: #f1f5f9; }

    .btn-white { background: white; color: black; border-radius: 12px; padding: 12px 25px; border: none; font-weight: 700; }
    .btn-outline { background: transparent; border: 1px solid rgba(255,255,255,0.2); color: white; border-radius: 12px; padding: 12px 25px; font-weight: 600; margin-left: 10px; }


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
<div class="dashboard-container">
    
    <div class="left-col">
        <div class="Profile-hero-section">
            <span class="ai-badge-top" style="color: #64748b; border: 1px solid #e2e8f0;">● ACADEMIC YEAR 2024-25</span>
            <h1>Perspective is everything,<br/> <span class="hero-name"><asp:Literal ID="litFirstName" runat="server" />.</span></h1>
            <p style="color: var(--text-muted); line-height: 1.75; font-size:1.125rem; font-weight:500;">
                Your roadmap for <strong><asp:Label ID="lblExamHeader" runat="server" /></strong> is dynamically updating based on your progress.
            </p>
        </div>

        <div class="profile-card">
            <div class="avatar-wrapper">
                <div class="avatar-ring">
                    <asp:Image ID="imgMainAvatar" runat="server" style="width: 100px; height: 100px; border-radius: 28%; object-fit: cover;" />
                </div>
                <div class="status-dot"></div>
            </div>
            <h2 style="font-weight: 800; margin-bottom: 5px;"><asp:Label ID="lblNameFull" runat="server" /></h2>
            <p class="stat-label" style="color: var(--primary); margin-bottom: 25px;">
                <asp:Label ID="lblClassBadge" runat="server" /> STUDENT
            </p>

            <div style="background: #f8fafc; border-radius: 16px; padding: 15px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                <span class="stat-label"><i class="fas fa-bolt text-warning me-2"></i>Account Tier</span>
                <span style="font-weight: 800; font-size: 12px;">PRO PLAN</span>
            </div>

            <button type="button" class="btn-manage" onclick="openModal()">
                <i class="fas fa-cog me-2"></i> MANAGE ACCOUNT
            </button>
        </div>
    </div>

    <div class="right-col">
        <div class="stats-grid">
            <div class="stat-card">
                <div style="color: #3b82f6; margin-bottom: 15px;"><i class="fas fa-gem"></i></div>
                <span class="stat-label">Academic Standing</span>
                <span class="stat-value"><asp:Label ID="lblClassStat" runat="server" /></span>
                <span class="stat-sub">Currently enrolled</span>
            </div>
            <div class="stat-card">
                <div style="color: #ef4444; margin-bottom: 15px;"><i class="fas fa-bullseye"></i></div>
                <span class="stat-label">Target Focus</span>
                <span class="stat-value"><asp:Label ID="lblExamStat" runat="server" /></span>
                <span class="stat-sub">Primary objective</span>
            </div>
            <div class="stat-card">
                <div style="color: #8b5cf6; margin-bottom: 15px;"><i class="fas fa-layer-group"></i></div>
                <span class="stat-label">Preparation Board</span>
                <span class="stat-value"><asp:Label ID="lblBoardStat" runat="server" /></span>
                <span class="stat-sub">Curriculum style</span>
            </div>
            <div class="stat-card">
                <div style="color: #ec4899; margin-bottom: 15px;"><i class="fas fa-map-marker-alt"></i></div>
                <span class="stat-label">Regional Sector</span>
                <span class="stat-value"><asp:Label ID="lblCityStat" runat="server" /></span>
                <span class="stat-sub">Location verified</span>
            </div>
        </div>

        <div class="ai-card">
            <span class="ai-badge">AI INSIGHT</span>
            <h2 style="font-weight: 700; margin: 20px 0;">Ready to accelerate your <asp:Label ID="lblExamInsight" runat="server" /> preparation?</h2>
            <p style="opacity: 0.7; margin-bottom: 30px; font-weight: 400;">
                Our algorithm has mapped out your next 4 weeks. Complete your profile details to unlock the full curriculum analysis.
            </p>
            <div class="d-flex">
                <button type="button" class="btn-white" onclick="openModal()">COMPLETE PROFILE</button>
                <button type="button" class="btn-outline" onclick="alert('Analysis skipped')">SKIP FOR NOW</button>
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