<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JoinTutor.aspx.cs" Inherits="StudyIsleWeb.JoinTutor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Join Our Teaching Team - StudyIsle</title>

  
    <link href="Content/css/join-tutor.css" rel="stylesheet" />

    <style>
  
        .join-section { padding: 60px 0; }
        .join-header h2 { font-weight: 700; margin-bottom: 5px; }
        .join-header p { color: #6c757d; font-size: 14px; }
        .join-card { background: #fff; padding: 35px 40px; border-radius: 16px; box-shadow: 0 15px 40px rgba(0,0,0,0.06); margin-top: 0px; }
        .section-title { font-weight: 600; font-size: 18px; color: #4f46e5; margin-bottom: 15px; }
        label { font-weight: 500; font-size: 12px; }
        .form-control, .form-select { border-radius: 8px; font-size: 12px; padding: 8px 12px; }
        .subject-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 12px 20px; margin-top: 8px; }
        .custom-check { display: flex; align-items: center; gap: 8px; font-size: 14px; cursor: pointer; }
        .validator { color: red; font-size: 10px; }
        .submit-btn { background: #4f46e5; color: #fff; padding: 10px 30px; border-radius: 25px; border: none; }
       /* left card*/
        .left-panel h1 {
    font-size: 38px;
    line-height: 1.1;
}

.feature-box {
    display: flex;
    flex-direction: column;
    gap: 12px;
}



.help-card {
    background: linear-gradient(135deg, #4f46e5, #6d5dfc);
    color: white;
    padding: 12px;
    border-radius: 12px;
}

.help-card button {
    margin-top: 4px;
}

/* Container must allow the sticky behavior */
.join-section {
    background: #fdfdfd;
    padding: 60px 0;
}

/* Updated Sticky Wrapper Logic */
.sticky-wrapper {
    display: flex;
    flex-wrap: wrap; /* Allows wrapping on mobile */
    align-items: flex-start;
    gap: 0; /* Let Bootstrap columns handle spacing */
    position: relative;
}

.left-panel {
    position: -webkit-sticky;
    position: sticky;
    top: 20px; /* Distance from top when scrolling */
    z-index: 10;
    /* Ensure it stays in its own space */
    align-self: flex-start; 
}

/* Ensure the right panel doesn't slide under the left */
.right-panel {
    position: relative;
    z-index: 1;
}

/* Responsive fix: Disable sticky on small screens so they stack normally */
@media (max-width: 991px) {
    .left-panel {
        position: relative;
        top: 0;
        margin-bottom: 30px;
    }
}

.join-card {
    background: #fff;
    padding: 30px;
    border-radius: 40px; /* Extra rounded as per image */
    box-shadow: 0 20px 60px rgba(0,0,0,0.05);
    border: 1px solid #f0f0f0;
}

/* Feature Item Styling */
.feature-item {
    background: #ffffff;
    padding: 20px;
    border-radius: 15px;
    display: flex;
    gap: 16px;
    margin-bottom: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.02);
}

.feature-icon {
    width: 36px;
    height: 36px;
    background: #f0f0ff;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #4f46e5;
}

/* Input Styling to match image */
.form-control, .form-select {
    height: 40px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding-left: 12px;
}

/* Checkbox containers as seen in image */
.subject-grid .asp-check-container {
    border: 1px solid #e2e8f0;
    padding: 12px 15px;
    border-radius: 12px;
    display: flex;
    align-items: center;
}
/* Styling for the checkbox container */
/* Slimmer, professional card design */
.asp-check-container {
    border: 1px solid #e2e8f0;
    padding: 8px 12px; /* Reduced vertical padding from 12px to 8px */
    border-radius: 10px; /* Slightly tighter corners */
    display: flex;
    align-items: center;
    cursor: pointer;
    transition: all 0.2s ease;
    background: #fff;
    position: relative;
    user-select: none;
    min-height: 45px; /* Ensures a consistent but slim height */
}

/* Hover and Selected states remain the same for logic */
.asp-check-container:hover {
    border-color: #6366f1;
    background-color: #f8f9ff;
}

.asp-check-container.selected {
    background-color: #eef2ff;
    border-color: #4f46e5;
    box-shadow: 0 0 0 1px #4f46e5;
}

/* Slimmer text and alignment */
.asp-check-container label {
    margin-bottom: 0;
    margin-left: 8px;
    cursor: pointer;
    font-weight: 500;
    font-size: 14px; /* Matches the clean reference text size */
    color: #4b5563;
    flex-grow: 1;
}

.asp-check-container.selected label {
    color: #4f46e5;
}

/* Checkbox size adjustment */
.asp-check-container input[type="checkbox"] {
    width: 16px; /* Slightly smaller checkbox */
    height: 16px;
    cursor: pointer;
    accent-color: #4f46e5;
}}

/* Style the text inside the container */
/* Update this in your existing CSS */
.asp-check-container label {
    display: inline-block;
    margin-bottom: 0;
    margin-left: 10px;
    cursor: pointer;
    font-weight: 200;
    color: #4b5563;
    flex-grow: 1; /* Makes label take up remaining space */
    padding: 5px 0; /* Increases vertical hit area */
}

/* Ensure the span generated by ASP.NET doesn't block clicks */
.asp-check-container span {
    display: flex;
    align-items: center;
    width: 100%;
}

/* Why Choose Us Section */
/* SECTION */
.why-section {
    padding: 80px 0;
    background: #f9faff;
}

/* TAG */
.section-tag {
    display: inline-block;
    font-size: 12px;
    font-weight: 600;
    color: #6d5dfc;
    background: rgba(109, 93, 252, 0.1);
    padding: 6px 12px;
    border-radius: 20px;
    margin-bottom: 10px;
}

/* TITLE */
.section-title-main {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 10px;
}

/* SUBTITLE */
.section-subtitle {
    color: #6c757d;
    max-width: 600px;
    margin: 0 auto;
    font-size: 14px;
}

/* CARD */
.why-card {
    background: #fff;
    border-radius: 16px;
    padding: 25px;
    height: 100%;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05);
    transition: all 0.3s ease;
}

/* HOVER */
.why-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.08);
}

/* ICON */
.why-card .icon {
    font-size: 24px;
    margin-bottom: 15px;
}

/* TEXT */
.why-card h5 {
    font-weight: 600;
    margin-bottom: 10px;
}

.why-card p {
    font-size: 14px;
    color: #6c757d;
    margin: 0;
}
     /* How It works SECTION */
.process-section {
    padding: 80px 0;
    background: #ffffff;
}

/* TAG */
.process-tag {
    display: inline-block;
    font-size: 12px;
    font-weight: 600;
    color: #10b981;
    background: rgba(16, 185, 129, 0.1);
    padding: 6px 12px;
    border-radius: 20px;
    margin-bottom: 10px;
}

/* TITLE */
.process-title {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 10px;
}

/* SUBTITLE */
.process-subtitle {
    color: #6c757d;
    font-size: 14px;
}

/* CARD */
.process-card {
    position: relative;
    background: #f9faff;
    border-radius: 16px;
    padding: 25px 20px;
    text-align: left;
    height: 100%;
    box-shadow: 0 8px 20px rgba(0,0,0,0.04);
    transition: 0.3s ease;
}

.process-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(0,0,0,0.08);
}

/* STEP NUMBER (CIRCLE TOP LEFT) */
.step-number {
    position: absolute;
    top: -12px;
    left: -12px;
    background: #4f46e5;
    color: white;
    width: 32px;
    height: 32px;
    font-size: 14px;
    font-weight: 600;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* ICON */
.process-icon {
    font-size: 20px;
    margin-bottom: 10px;
}

/* TEXT */
.process-card h5 {
    font-weight: 600;
    margin-bottom: 8px;
}

.process-card p {
    font-size: 14px;
    color: #6c757d;
    margin: 0;
}

        /* FAQ Section Adjustments */
.faq-section {
    padding: 100px 0;
    background-color: #f8fafc; /* Very light blue/grey background */
}

.faq-badge {
    font-size: 13px;
    font-weight: 800;
    color: #6366f1;
    letter-spacing: 2px;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

/* Accordion Customization */
.custom-accordion .accordion-item {
    border: none;
    background-color: #fff;
    border-radius: 15px !important;
    margin-bottom: 15px;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
    overflow: hidden;
}

.custom-accordion .accordion-button {
    padding: 25px 30px;
    font-weight: 700;
    color: #1e293b;
    font-size: 17px;
    background-color: #fff;
    box-shadow: none;
}

/* Remove default blue focus and background */
.custom-accordion .accordion-button:not(.collapsed) {
    color: #4f46e5;
    background-color: #fff;
    box-shadow: none;
}

.custom-accordion .accordion-button:focus {
    box-shadow: none;
    border-color: rgba(0,0,0,.125);
}

/* Accordion body text */
.custom-accordion .accordion-body {
    padding: 0 30px 25px 30px;
    color: #64748b;
    font-size: 15px;
    line-height: 1.6;
    border-top: 1px solid #f1f5f9;
}

/* Customizing the Chevron Arrow */
.custom-accordion .accordion-button::after {
    background-size: 1rem;
    transition: transform 0.2s ease-in-out;
}
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="join-section">
    <div class="container">
        <!-- Add 'row' and 'sticky-wrapper' together -->
        <div class="row sticky-wrapper">
            
            <!-- LEFT PANEL (Sticky) -->
            <div class="col-lg-5 left-panel">
                <span class="badge rounded-pill mb-3" style="background:#eef2ff; color:#4f46e5; padding: 8px 16px;">
                    ★ TOP RATED PLATFORM
                </span>

                <h1 class="display-4 fw-bold mb-4" style="color:#1a1a1a;">
                    Empower the next <br />
                    <span style="color: #6366f1;">Generation</span> of thinkers.
                </h1>

                <p class="text-muted mb-5" style="font-size: 1rem;">
                    Join StudyIsle and reach thousands of students worldwide. <br />
                    We provide the tools, you provide the inspiration.
                </p>

                <!-- Feature Items -->
                <div class="feature-item">
                    <div class="feature-icon"><i class="fas fa-bolt"></i></div>
                    <div>
                        <h6 class="mb-1 fw-bold">Global Reach</h6>
                        <small class="text-muted">Teach students from over 50 countries and expand your professional network globally.</small>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="feature-icon"><i class="fas fa-clock"></i></div>
                    <div>
                        <h6 class="mb-1 fw-bold">Flexible Schedule</h6>
                        <small class="text-muted">Choose your own hours and teach from the comfort of your home, anytime.</small>
                    </div>
                </div>
                 <div class="feature-item">
     <div class="feature-icon"><i class="fas fa-secure"></i></div>
     <div>
         <h6 class="mb-1 fw-bold">Secure Payments</h6>
         <small class="text-muted">Get paid on time, every time, through our secure and transparent payment gateway.</small>
     </div>
 </div>

                <!-- Help Card (Blue) -->
                <div class="help-card mt-4" style="background: #6366f1; color: white; padding: 30px; border-radius: 20px;">
                    <div class="mb-3"><i class="fas fa-question-circle fa-2x"></i></div>
                    <h3 class="fw-bold">Need Assistance?</h3>
                    <p class="opacity-75 mb-4">Our dedicated support team is here to help you with your application and onboarding.</p>
                    <button class="btn btn-light rounded-pill px-4">Email Support →</button>
                </div>
            </div>


   <!-- RIGHT PANEL -->
<div class="col-lg-7 right-panel">
                 <div class="join-card">
        
        <!-- BASIC INFORMATION -->
        <h4 class="fw-bold mb-1">Basic Information</h4>
        <p class="text-muted mb-4 small">Please provide your personal contact details.</p>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Full Name *</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="John Doe" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Mobile Number *</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="+1 (555) 000-0000" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Email Address *</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="john@example.com" />
            </div>
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Location (City & State) *</label>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="USA, California" />
            </div>
        </div>

        <hr class="my-5" style="opacity: 0.1;" />

        <!-- PROFESSIONAL DETAILS -->
        <h4 class="fw-bold mb-1">Professional Details</h4>
        <p class="text-muted mb-4 small">Tell us about your background and experience.</p>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Highest Qualification *</label>
                <asp:DropDownList ID="ddlQualification" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select Highest Qualification</asp:ListItem>
                    <asp:ListItem>Graduation</asp:ListItem>
                    <asp:ListItem>Post Graduation</asp:ListItem>
                    <asp:ListItem>B.Ed / M.Ed</asp:ListItem>
                    <asp:ListItem>PhD</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Teaching Experience *</label>
                <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select Teaching Experience</asp:ListItem>
                    <asp:ListItem>Fresher</asp:ListItem>
                    <asp:ListItem>2 Years</asp:ListItem>
                    <asp:ListItem>5+ Years</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- SUBJECTS -->
<div class="mt-4">
    <label class="small fw-bold text-muted mb-2">Subjects You Can Teach *</label>
    <div class="subject-grid">
        <div class="asp-check-container">
            <asp:CheckBox ID="chkMaths" runat="server" Text="Maths" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkPhysics" runat="server" Text="Physics" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkChemistry" runat="server" Text="Chemistry" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkBiology" runat="server" Text="Biology" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkEnglish" runat="server" Text="English" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkComputer" runat="server" Text="Computer" />
        </div>
    </div>
</div>

        <div class="row mt-4">
            <!-- EMPLOYMENT -->
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Current Employment Status *</label>
                <asp:DropDownList ID="ddlEmployment" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select Status</asp:ListItem>
                    <asp:ListItem>School</asp:ListItem>
                    <asp:ListItem>Institute</asp:ListItem>
                    <asp:ListItem>Freelancer</asp:ListItem>
                </asp:DropDownList>
            </div>
            <!-- DEMO LINK -->
            <div class="col-md-6 mb-3">
                <label class="small fw-bold text-muted mb-2">Demo Class Link</label>
                <asp:TextBox ID="txtDemoLink" runat="server" CssClass="form-control" placeholder="YouTube or Drive link" />
            </div>
        </div>

<!-- CLASSES -->
<div class="mt-4">
    <label class="small fw-bold text-muted mb-2">Classes / Grades Comfortable With *</label>
    <div class="subject-grid" style="grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));">
        <div class="asp-check-container">
            <asp:CheckBox ID="chk6to8" runat="server" Text="6-8" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chk9to10" runat="server" Text="9-10" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chk11to12" runat="server" Text="11-12" />
        </div>
    </div>
</div>

        <!-- BOARDS -->
<div class="mt-4">
    <label class="small fw-bold text-muted mb-2">Boards You Have Experience With *</label>
    <div class="subject-grid">
        <div class="asp-check-container">
            <asp:CheckBox ID="chkCBSE" runat="server" Text="CBSE" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkICSE" runat="server" Text="ICSE" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkIB" runat="server" Text="IB" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkIGCSE" runat="server" Text="IGCSE" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkAP" runat="server" Text="AP" />
        </div>
        <div class="asp-check-container">
            <asp:CheckBox ID="chkStateBoard" runat="server" Text="State Board" />
        </div>
    </div>
</div>

        <!-- RESUME UPLOAD -->
        <div class="mt-5">
            <label class="small fw-bold text-muted mb-2">Resume Upload (PDF)</label>
            <div class="p-4 border border-dashed rounded-4 text-center" style="border-style: dashed !important; border-width: 2px !important; background: #fafafa;">
                <i class="fas fa-upload text-muted mb-3 fa-lg"></i>
                <asp:FileUpload ID="fileResume" runat="server" CssClass="form-control mb-2" />
                <p class="text-muted small mb-0">PDF format only, max 5MB</p>
            </div>
        </div>

        <!-- SUBMIT BUTTON -->
        <div class="text-center mt-5">
            <asp:Button ID="btnSubmit" runat="server"
                Text="Submit Application"
                CssClass="btn btn-primary w-100 py-3 rounded-pill fw-bold"
                style="background:#6366f1; border:none; box-shadow: 0 10px 20px rgba(99,102,241,0.2);"
                OnClick="btnSubmit_Click" />
        </div>

    </div>
</div>
            </div>
        </div>
</section>
    <!-- WHY CHOOSE US -->
<section class="why-section">
    <div class="container">

        <!-- Heading -->
        <div class="text-center mb-5">
            <span class="section-tag">WHY STUDYISLE</span>
            <h2 class="section-title-main">Why Educators Choose Us</h2>
            <p class="section-subtitle">
                We take care of everything — student matching, scheduling, resources, payments —
                so you can focus on what you do best: teaching.
            </p>
        </div>

        <!-- Cards -->
        <div class="row g-4">

            <div class="col-md-6 col-lg-4">
                <div class="why-card">
                    <div class="icon">💰</div>
                    <h5>Competitive Pay</h5>
                    <p>Earn ₹500–₹1,500 per session. Weekly payouts with no delays.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="why-card">
                    <div class="icon">⏱️</div>
                    <h5>Your Schedule, Your Rules</h5>
                    <p>Set your availability and teach anytime, anywhere.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="why-card">
                    <div class="icon">🌍</div>
                    <h5>Global Student Base</h5>
                    <p>Work with students across India, UAE, UK, US and more.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="why-card">
                    <div class="icon">📚</div>
                    <h5>Everything Provided</h5>
                    <p>Access curated materials, question banks, and teaching guides.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="why-card">
                    <div class="icon">🏅</div>
                    <h5>Career Growth</h5>
                    <p>Grow into leadership roles with certification and training.</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="why-card">
                    <div class="icon">🤝</div>
                    <h5>Supportive Community</h5>
                    <p>Collaborate with educators and grow together.</p>
                </div>
            </div>

        </div>
    </div>
</section>
   <%-- How It Works Section--%>
    <section class="process-section">
    <div class="container">

        <!-- Heading -->
        <div class="text-center mb-5">
            <span class="process-tag">HOW IT WORKS</span>
            <h2 class="process-title">From Application to First Session</h2>
            <p class="process-subtitle">
                Four simple steps and you're live — teaching students who need you.
            </p>
        </div>

        <!-- Steps -->
        <div class="row g-4 justify-content-center">

            <!-- Step 1 -->
            <div class="col-md-6 col-lg-3">
                <div class="process-card">
                    <div class="step-number">1</div>
                    <div class="process-icon">📝</div>
                    <h5>Apply Online</h5>
                    <p>
                        Fill the form below with your subject, board expertise and experience.
                        Takes 2 minutes.
                    </p>
                </div>
            </div>

            <!-- Step 2 -->
            <div class="col-md-6 col-lg-3">
                <div class="process-card">
                    <div class="step-number">2</div>
                    <div class="process-icon">🎤</div>
                    <h5>Quick Interview</h5>
                    <p>
                        A 15-minute video call with our academic head to assess teaching style
                        and subject depth.
                    </p>
                </div>
            </div>

            <!-- Step 3 -->
            <div class="col-md-6 col-lg-3">
                <div class="process-card">
                    <div class="step-number">3</div>
                    <div class="process-icon">📦</div>
                    <h5>Get Onboarded</h5>
                    <p>
                        Receive your resource kit, Zoom setup guide, Google Classroom access
                        and student matches.
                    </p>
                </div>
            </div>

            <!-- Step 4 -->
            <div class="col-md-6 col-lg-3">
                <div class="process-card">
                    <div class="step-number">4</div>
                    <div class="process-icon">🚀</div>
                    <h5>Start Teaching</h5>
                    <p>
                        Conduct your first session! Get rated, build your profile, and grow
                        your student roster.
                    </p>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- FAQ SECTION -->
    <section class="faq-section">
    <div class="container">
        <!-- Section Header -->
        <div class="text-center mb-5">
            <div class="faq-badge">
                <span class="emoji-icon">❓</span>TUTOR FAQ
            </div>
            <h1 class="section-title">Common Questions</h1>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="accordion custom-accordion" id="faqAccordion">
                    
                    <!-- Question 1 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                Which international boards do you teach?
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                We cover IB Diploma (DP), IB MYP, Cambridge IGCSE, Cambridge A-Level, AP (Advanced Placement), and Edexcel International. If your board isn't listed, reach out — we likely cover it.
                            </div>
                        </div>
                    </div>

                    <!-- Question 2 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                Are classes 1-on-1 or in groups?
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Dummy text: All our core sessions are strictly 1-on-1 to ensure maximum focus, though we do offer optional small-group workshops for exam revision.
                            </div>
                        </div>
                    </div>

                    <!-- Question 3 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                                What platform do you use for classes?
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Dummy text: We primarily use Zoom integrated with an interactive digital whiteboard, allowing students to save all session notes instantly.
                            </div>
                        </div>
                    </div>

                    <!-- Question 4 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour">
                                Can I get help with IB Internal Assessments (IA)?
                            </button>
                        </h2>
                        <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Dummy text: Yes, we provide specialized mentoring for IAs, Extended Essays (EE), and TOK, focusing on structure, criteria, and academic honesty.
                            </div>
                        </div>
                    </div>

                    <!-- Question 5 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive">
                                How do I reschedule a session?
                            </button>
                        </h2>
                        <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Dummy text: Rescheduling is easy via our student portal. We just ask for at least 24 hours' notice to coordinate with your tutor.
                            </div>
                        </div>
                    </div>

                    <!-- Question 6 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix">
                                Is the demo class really free?
                            </button>
                        </h2>
                        <div id="collapseSix" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Dummy text: Absolutely. The 30-minute demo is completely free and designed to help you meet the tutor and discuss your learning goals.
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        // Function to update the visual state of the card
        function updateCardState($card) {
            var $checkbox = $card.find('input[type="checkbox"]');
            if ($checkbox.is(':checked')) {
                $card.addClass('selected');
            } else {
                $card.removeClass('selected');
            }
        }

        // Handle clicking anywhere on the card
        $('.asp-check-container').on('click', function (e) {
            var $checkbox = $(this).find('input[type="checkbox"]');

            // If the user clicked the actual input or the label text, 
            // the browser handles the toggle automatically.
            // We only need to manually toggle if they click the "empty space" of the card.
            if (!$(e.target).is('input[type="checkbox"]') && !$(e.target).is('label')) {
                e.preventDefault();
                $checkbox.prop('checked', !$checkbox.prop('checked')).trigger('change');
            }
        });

        // Whenever the checkbox value changes (manual or script-based)
        $('.asp-check-container input[type="checkbox"]').on('change', function () {
            updateCardState($(this).closest('.asp-check-container'));
        });

        // Initialize on page load
        $('.asp-check-container').each(function () {
            updateCardState($(this));
        });
    });
</script></asp:Content>