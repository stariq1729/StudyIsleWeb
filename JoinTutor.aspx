<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JoinTutor.aspx.cs" Inherits="StudyIsleWeb.JoinTutor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Join Our Teaching Team - StudyIsle</title>

  
    <link href="Content/css/join-tutor.css" rel="stylesheet" />

    <style>
  
        .join-section { padding: 60px 0; }
        .join-header h2 { font-weight: 700; margin-bottom: 5px; }
        .join-header p { color: #6c757d; font-size: 14px; }
        .join-card { background: #fff; padding: 35px 40px; border-radius: 16px; box-shadow: 0 15px 40px rgba(0,0,0,0.06); margin-top: 0px; }
        .section-title { font-weight: 600; font-size: 14px; color: #4f46e5; margin-bottom: 15px; }
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
.why-choose-section {
    padding: 80px 0;
    background: #fff;
}

.benefit-list {
    list-style: none;
    padding: 0;
}

.benefit-item {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    font-size: 14px;
    color: #4b5563;
}

.benefit-item i {
    color: #10b981; /* Green checkmark */
    margin-right: 12px;
    font-size: 16px;
}

/* Image with Floating Testimonial */
.img-wrapper {
    position: relative;
    padding-bottom: 40px;
}

.main-feature-img {
    border-radius: 40px;
    width: 100%;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

.testimonial-float {
    position: absolute;
    bottom: 0;
    left: -30px;
    background: #fff;
    padding: 25px;
    border-radius: 20px;
    box-shadow: 0 15px 30px rgba(0,0,0,0.1);
    max-width: 280px;
    z-index: 2;
}

/* FAQ Section */
.faq-section {
    padding-bottom: 80px;
}

.faq-card {
    background: #fff;
    border: 1px solid #eef2ff;
    border-radius: 20px;
    padding: 25px;
    height: 100%;
    transition: transform 0.3s ease;
}

.faq-card:hover {
    transform: translateY(-5px);
}

.faq-icon {
    color: #6366f1;
    font-size: 18px;
    margin-right: 10px;
}

.faq-card h5 {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
}

.faq-card p {
    font-size: 14px;
    color: #6b7280;
    line-height: 1.6;
    margin: 0;
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
<section class="why-choose-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 pe-lg-5">
                <h2 class="fw-bold mb-3">Why thousands of educators choose <span style="color:#6366f1;">StudyIsle</span></h2>
                <p class="text-muted mb-4">StudyIsle is more than just a tutoring platform. It's a community of dedicated professionals committed to making high-quality education accessible to everyone.</p>
                
                <ul class="benefit-list">
                    <li class="benefit-item"><i class="fas fa-check-circle"></i> Access to a growing community of eager learners worldwide.</li>
                    <li class="benefit-item"><i class="fas fa-check-circle"></i> Professional development workshops and certification programs.</li>
                    <li class="benefit-item"><i class="fas fa-check-circle"></i> State-of-the-art virtual classroom with interactive whiteboards.</li>
                    <li class="benefit-item"><i class="fas fa-check-circle"></i> Dedicated support team available 24/7 for technical assistance.</li>
                </ul>
            </div>
            
            <div class="col-lg-6 mt-5 mt-lg-0">
                <div class="img-wrapper">
                    <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f"  class="main-feature-img" alt="Educators" />
                    <div class="testimonial-float">
                        <p class="fw-bold mb-2">"The best decision for my career."</p>
                        <small class="text-muted">- Sarah Jenkins, Senior Math Educator</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FAQ SECTION -->
<section class="faq-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Frequently Asked Questions</h2>
            <p class="text-muted">Everything you need to know about the application process and teaching on StudyIsle.</p>
        </div>
        
        <div class="row g-4">
            <!-- FAQ 1 -->
            <div class="col-md-6">
                <div class="faq-card">
                    <h5><i class="far fa-question-circle faq-icon"></i> What are the minimum requirements?</h5>
                    <p>We typically require a Bachelor's degree in your subject area and at least 1 year of teaching experience. However, we also value passion and unique teaching styles.</p>
                </div>
            </div>
            <!-- FAQ 2 -->
            <div class="col-md-6">
                <div class="faq-card">
                    <h5><i class="far fa-question-circle faq-icon"></i> How do I get paid?</h5>
                    <p>Payments are processed bi-weekly via direct bank transfer or PayPal. You can track your earnings in real-time through your teacher dashboard.</p>
                </div>
            </div>
            <!-- FAQ 3 -->
            <div class="col-md-6">
                <div class="faq-card">
                    <h5><i class="far fa-question-circle faq-icon"></i> Can I choose my own hours?</h5>
                    <p>Absolutely. You can set your availability in your profile, and students will book sessions based on your schedule.</p>
                </div>
            </div>
            <!-- FAQ 4 -->
            <div class="col-md-6">
                <div class="faq-card">
                    <h5><i class="far fa-question-circle faq-icon"></i> Is there a fee to join?</h5>
                    <p>No, joining StudyIsle as a teacher is completely free. We take a small commission from each session to maintain the platform and support services.</p>
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