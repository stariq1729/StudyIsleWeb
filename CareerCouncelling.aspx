<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CareerCouncelling.aspx.cs" Inherits="StudyIsleWeb.CareerCouncelling" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets\css\CareerGuide.css" rel="stylesheet" />
    <style>
                /* Custom styles for this page */
        /* Audience Section */
.audience-section {
    padding: 60px 0;
    background-color: #ffffff;
}

.section-header .sub-title {
    color: #6366f1;
    font-weight: 700;
    font-size: 12px;
    letter-spacing: 1.2px;
    display: block;
    margin-bottom: 10px;
}

.section-header .main-title {
    font-size: 34px;
    font-weight: 800;
    color: #1e293b;
    margin-bottom: 15px;
    letter-spacing: -0.5px;
}

.section-header .main-title span {
    color: #6366f1;
}

.section-header .section-desc {
    color: #64748b;
    font-size: 16px;
    max-width: 600px;
    margin: 0 auto;
}

/* Compact Card Styling */
.audience-card {
    background: #fff;
    padding: 30px 25px; /* Reduced padding for smaller height */
    border-radius: 18px;
    height: 100%;
    border: 1px solid #f1f5f9;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.02);
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
}

/* Icon Styling - Matched to Image */
.card-icon-box {
    margin-bottom: 20px;
}

.card-icon-box i {
    font-size: 32px;
    color: #6366f1;
    -webkit-text-stroke: 0.5px #6366f1; /* Makes the outline icons look sharper */
}

.audience-tag {
    display: block;
    color: #6366f1;
    font-size: 11px;
    font-weight: 700;
    margin-bottom: 10px;
}

.card-title {
    font-size: 20px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 12px;
    line-height: 1.3;
}

.card-text {
    color: #64748b;
    line-height: 1.5;
    font-size: 14px;
    margin-bottom: 0;
}

/* Hover Effect - Subtle Lift */
.audience-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 30px rgba(99, 102, 241, 0.1);
    border-color: #e2e8f0;
}

/* Responsive */
@media (max-width: 768px) {
    .section-header .main-title {
        font-size: 28px;
    }
    .audience-card {
        padding: 25px 20px;
    }
}

                /*
                WHAT YOU GET SECTION
                */  
                /* Session Details Section */
.session-details-section {
    padding: 100px 0;
    background-color: #ffffff;
}

/* Typography Left Side */
.session-details-section .sub-title {
    color: #6366f1;
    font-weight: 600;
    font-size: 10px;
    letter-spacing: 1px;
    display: block;
    margin-bottom: 10px;
}

.session-details-section .main-title {
    font-size: 36px;
    font-weight: 800;
    color: #0f172a;
    line-height: 1;
}

.session-details-section .main-title span {
    color: #6366f1;
}

.session-details-section .section-desc {
    color: #64748b;
    font-size: 14px;
    max-width: 400px;
}

/* Benefit List Styling */
.benefit-list {
    display: flex;
    flex-direction: column;
    gap: 26px;
}

.benefit-item {
    display: flex;
    gap: 20px;
    align-items: flex-start;
}

.benefit-icon {
    font-size: 20px;
    padding-top: 4px;
}

.benefit-icon.pink-icon { color: #f472b6; }
.benefit-icon.blue-icon { color: #38bdf8; }
.benefit-icon.orange-icon { color: #fb923c; }
.benefit-icon.purple-icon { color: #a78bfa; }

.benefit-text h4 {
    font-size: 14px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 6px;
}

.benefit-text p {
    color: #64748b;
    font-size: 12px;
    line-height: 1.2;
    margin: 0;
}

/* Right Side: Dark Card */
.session-card {
    background: linear-gradient(145deg, #0f172a 0%, #1e1b4b 100%);
    padding: 40px;
    border-radius: 36px;
    color: #ffffff;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
}

.card-badge {
    background: rgba(255, 255, 255, 0.1);
    padding: 6px 16px;
    border-radius: 100px;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 1px;
    display: inline-block;
    margin-bottom: 25px;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.card-heading {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 30px;
}

/* Timeline/Steps */
.timeline-wrapper {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.timeline-item {
    display: flex;
    gap: 20px;
}

.step-number {
    width: 30px;
    height: 30px;
    background: #6366f1;
    color: #fff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    flex-shrink: 0;
}

.step-content h5 {
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 4px;
}

.step-content p {
    color: #94a3b8;
    font-size: 12px;
    line-height: 1.1;
    margin: 0;
}

/* Mobile Adjustments */
@media (max-width: 768px) {
    .session-details-section .main-title { font-size: 36px; }
    .session-card { padding: 30px 20px; border-radius: 30px; }
}
    
/* How It Works Section */
.process-section {
    padding: 60px 0; /* Compact padding */
    background-color: #f9fafb;
}

.process-wrapper {
    position: relative;
    margin-top: 40px;
}

/* The horizontal line */
.process-line {
    position: absolute;
    top: 40px; /* Aligns with the middle of the icons */
    left: 10%;
    right: 10%;
    height: 1px;
    background: #e2e8f0;
    z-index: 1;
}

.process-item {
    position: relative;
    z-index: 2;
    text-align: center;
    padding: 0 10px;
}

.process-icon {
    width: 80px;
    height: 80px;
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 10px rgba(0,0,0,0.02);
}

.process-icon i {
    font-size: 28px;
    color: #64748b;
}

/* Active Step Styling (to match the purple glow in the image) */
.active-step .process-icon {
    border-color: #6366f1;
    box-shadow: 0 0 20px rgba(99, 102, 241, 0.15);
}

.active-step .process-icon i {
    color: #6366f1;
}

.process-item h4 {
    font-size: 18px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 10px;
}

.process-item p {
    font-size: 14px;
    color: #64748b;
    line-height: 1.5;
    max-width: 200px;
    margin: 0 auto;
}

/* Hover Effect */
.process-item:hover .process-icon {
    transform: scale(1.1);
    border-color: #6366f1;
}

/* Responsive Logic */
@media (max-width: 991px) {
    .process-line {
        display: none; /* Hide line on mobile for vertical layout */
    }
    .process-item {
        margin-bottom: 40px;
    }
}

/* Assessment Grid Section */
.assessment-grid-section {
    padding: 60px 0;
    background-color: #ffffff;
}

        .assessment-grid-section .sub-title {
            color: #6366f1;
            font-weight: 600;
            font-size: 10px;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            
        }

.assessment-grid-section .main-title {
    font-size: 28px;
    font-weight: 700;
    color: #1e293b;
    line-height: 1.1;
}

.assessment-grid-section .main-title span {
    color: #6366f1;
}

.assessment-description p {
    color: #64748b;
    font-size: 12px;
    line-height: 1.1;
}

/* Assessment Button with Line spacing */
.btn-assessment {
    display: inline-block;
    background-color: #6366f1;
    color: #ffffff;
    padding: 12px 24px;
    border-radius: 12px;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.btn-assessment:hover {
    background-color: #4f46e5;
    color: #ffffff;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
}

/* Mini Cards Grid */
.mini-card {
    background: #ffffff;
    border: 1px solid #f1f5f9;
    padding: 15px;
    border-radius: 18px;
    transition: all 0.3s ease;
    height: 100%;
}

.mini-card i {
    font-size: 20px;
    display: block;
    margin-bottom: 12px;
}

/* Icon Colors */
.pink-text { color: #f472b6; }
.blue-text { color: #38bdf8; }
.orange-text { color: #fb923c; }
.purple-text { color: #a78bfa; }
.green-text { color: #34d399; }
.indigo-text { color: #818cf8; }

.mini-card h5 {
    font-size: 14px;
    font-weight: 500;
    color: #1e293b;
    margin-bottom: 6px;
}

.mini-card p {
    font-size: 12px;
    color: #64748b;
    margin-bottom: 0;
    line-height: 1.2;
}

/* Card Hover Effect */
.mini-card:hover {
    border-color: #e2e8f0;
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
}

/* Mobile responsive adjustments */
@media (max-width: 991px) {
    .assessment-grid-section .main-title {
        font-size: 32px;
    }
}

/* Counsellor Profile Section */
.counsellor-profile-section {
    padding: 60px 0;
    background-color: #ffffff;
}

/* Image Container with Dark Glow/Shadow */
.counsellor-image-container {
    border-radius: 30px;
    overflow: hidden;
    background: #000;
    padding: 2px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.counsellor-image-container img {
    border-radius: 28px;
    width: 100%;
    display: block;
    opacity: 0.9; /* Slight dimming to match the image style */
}

/* Green Banner */
.cert-banner {
    display: inline-flex;
    align-items: center;
    background-color: #f0fdf4;
    color: #166534;
    padding: 7px 14px;
    border: 1px solid #bbf7d0;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 600;
}

.profile-name {
    font-size: 30px;
    font-weight: 800;
    color: #0f172a;
    margin-bottom: 5px;
}

.profile-location {
    color: #94a3b8;
    font-size: 14px;
    margin-bottom: 22px;
}

/* Badges/Pills */
.profile-badges {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
}

.badge-pill {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    color: #475569;
    padding: 6px 14px;
    border-radius: 100px;
    font-size: 12px;
    font-weight: 500;
}

.profile-bio p {
    color: #475569;
    line-height: 1.1;
    font-size: 14px;
}

/* Expertise Checklist */
.expertise-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.expertise-list li {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    margin-bottom: 12px;
    color: #475569;
    font-size: 15px;
}

.expertise-list i {
    color: #475569; /* Dark checkmarks as per image */
    font-weight: bold;
}

/* CTA Link */
/* --- REPLACE EXISTING .btn-book-session WITH THIS --- */
.btn-book-session {
    display: inline-block;
    background-color: #6366f1; /* Solid purple from reference images */
    color: #ffffff;
    padding: 14px 30px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 16px;
    border: none; /* Removes default button border */
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 4px 14px rgba(99, 102, 241, 0.3);
    text-align: center;
}

/* Updated Hover State: Lift effect + Glow */
.btn-book-session:hover {
    background-color: #4f46e5; /* Slightly darker purple on hover */
    color: #ffffff;
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
}

/* Active State: Slight "push down" effect when clicked */
.btn-book-session:active {
    transform: translateY(-1px);
}

/* Mobile Adjustments */
@media (max-width: 991px) {
    .ps-lg-5 { padding-left: 15px !important; }
    .profile-name { font-size: 28px; }
}

/* FAQ Section Styling */
.faq-section {
    padding: 80px 0;
    background-color: #ffffff;
}

.faq-section .accordion-item {
    border-top: none;
    border-right: none;
    border-left: none;
    border-bottom: 1px solid #f1f5f9; /* Light line separator */
    margin-bottom: 10px;
}

.faq-section .accordion-button {
    padding: 25px 0;
    font-size: 18px;
    font-weight: 700;
    color: #1e293b;
    background-color: transparent !important;
    box-shadow: none !important;
}

/* Match the grey italic answer style from the image */
.faq-section .accordion-body {
    padding: 0 0 25px 0;
    color: #94a3b8;
    font-style: italic;
    font-size: 15px;
    line-height: 1.6;
}

/* Arrow icon styling */
.faq-section .accordion-button::after {
    background-size: 14px;
    background-position: center;
    transition: transform 0.3s ease;
}

/* Customizing the active state (when open) */
.faq-section .accordion-button:not(.collapsed) {
    color: #1e293b;
}

/* Mobile Adjustments */
@media (max-width: 991px) {
    .faq-section .accordion-button {
        font-size: 16px;
    }
}
/* Final CTA Section */
.final-cta-section {
    padding: 100px 0 60px;
    background: radial-gradient(circle at center, #1e2445 0%, #0f1225 100%);
    color: #ffffff;
    position: relative;
}

/* Limited Slots Pill */
.slots-pill {
    background: rgba(255, 255, 255, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    padding: 6px 16px;
    border-radius: 100px;
    font-size: 11px;
    letter-spacing: 1px;
    font-weight: 700;
    color: #cbd5e1;
}

.cta-heading {
    font-size: 48px;
    font-weight: 800;
    letter-spacing: -1px;
}

.cta-subtext {
    color: #94a3b8;
    font-size: 18px;
    line-height: 1.6;
}

/* Glowing Button Styling */
.btn-glow-primary {
    background-color: #6366f1;
    color: #ffffff;
    border: none;
    padding: 16px 36px;
    border-radius: 14px;
    font-weight: 700;
    font-size: 18px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 0 30px rgba(99, 102, 241, 0.4); /* The glow effect */
}

.btn-glow-primary:hover {
    background-color: #4f46e5;
    transform: translateY(-3px);
    box-shadow: 0 0 45px rgba(99, 102, 241, 0.6);
}

/* Contact Footer Elements */
.cta-divider {
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    width: 80%;
    margin: 0 auto;
}

.contact-icon-circle {
    width: 45px;
    height: 45px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    color: #cbd5e1;
}

.contact-label {
    font-size: 10px;
    color: #64748b;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.contact-value {
    font-size: 15px;
    font-weight: 600;
    color: #ffffff;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .cta-heading { font-size: 32px; }
    .cta-subtext { font-size: 16px; }
    .btn-glow-primary { width: 100%; padding: 14px; }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <%-- CAREER GUIDANCE SECTION
====================================== -->--%>
<section class="career-section">
    <div class="container">
        <div class="career-wrapper">
            <div class="row align-items-center">

                <!-- LEFT CONTENT -->
                <div class="col-lg-6 career-left">

                    <span class="career-badge">★ Free Career Counselling</span>

                    <h2 class="career-heading">
                        Not Sure Which Stream,
Subject or College to
                        <span>Choose?</span>
                    </h2>

                    <p class="career-description">
                      Whether you're choosing your stream after Class 10 or colleges after Class 12, our expert counsellors help you make the right decision. One conversation can shape your career.
                    </p>

                    <div class="career-features">
                        <div class="feature-item">
                            <i class="bi bi-calendar-check"></i>
                           Stream & Subject Selection After Class 10
                        </div>
                        <div class="feature-item">
                            <i class="bi bi-camera-video"></i>
                           Career Path Clarity for College Students
                        </div>
                        <div class="feature-item">
                            <i class="bi bi-file-earmark-text"></i>
                           College Shortlisting & Admission Guidance
                        </div>
                        <div class="feature-item">
                            <i class="bi bi-shield-check"></i>
                            100% Personal Attention
                        </div>
                    </div>

                    <div class="career-cta-area">
                        <a href="https://studyisle.edumilestones.com/" class="career-cta">
                            Schedule 1:1 Call →
                        </a>
                        <div class="online-status">
                            <span class="dot"></span>
                            <span class="dot"></span>
                            <span class="dot"></span>
                            <small>14 counselors online now</small>
                        </div>
                    </div>

                </div>

                <!-- RIGHT CARD -->
                <div class="col-lg-6 career-right">

                    <div class="counsellor-card-wrapper">

                        <div class="counsellor-card">

                            <!-- Yellow corner ribbon (clipped inside card) -->
                            <div class="slots-ribbon"></div>
                            <div class="slots-ribbon-text">LIMITED<br>SLOTS</div>

                            <!-- Profile -->
                            <div class="counsellor-top">
                                <img src="..\assets\tutorimg\Pranav.jpg" alt="Dr. Shweta Iyer" />
                                <h5>Pranav Maheshwari</h5>
                                <p>Certified Career Analyst (CCA)</p>
                            </div>

                            <!-- Info rows -->
                            <div class="counsellor-info">
                                <div class="info-row">
                                    <span>Teaching Experience</span>
                                    <strong>8+ Years</strong>
                                </div>
                                <div class="info-row">
    <span>Counselling Experience</span>
    <strong>2+ Years</strong>
</div>
                                <div class="info-row">
                                    <span>Specialization</span>
                                    <strong>Stream & College Selection</strong>
                                </div>
                                <div class="info-row">
    <span>Certification</span>
    <strong>BCPA (India) & ACCPH (UK)</strong>
</div>
                            </div>

                            <!-- Next slot -->
                            <div class="next-slot">
                                Next Available Slot
                                <strong>Today, 4:30 PM</strong>
                            </div>

                        </div>
                        <!-- END .counsellor-card -->

                        <!-- Success badge: outside card, inside wrapper -->
                        <div class="success-badge">
                            <span class="badge-label">✦ Success Story</span>
                            <p>"Pranav helped my son choose the right branch!"</p>
                        </div>

                    </div>
                    <!-- END .counsellor-card-wrapper -->

                </div>
                <!-- END RIGHT CARD -->

            </div>
        </div>
    </div>
</section>


    <!-- WHO IS IT FOR SECTION -->
<!-- WHO IS IT FOR SECTION -->
<section class="audience-section">
    <div class="container">
        <div class="section-header text-center">
            <span class="sub-title">WHO IS IT FOR</span>
            <h2 class="main-title">Right for You if You're <span>At a Crossroads.</span></h2>
            <p class="section-desc">Our counselling covers every major decision point in a student's academic journey.</p>
        </div>

        <div class="row mt-4 justify-content-center">
            <!-- Card 1 -->
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="audience-card">
                    <div class="card-icon-box">
                        <i class="bi bi-book"></i>
                    </div>
                    <span class="audience-tag">CLASS 9 & 10</span>
                    <h3 class="card-title">Choosing Your Stream</h3>
                    <p class="card-text">Science, Commerce or Arts? We map your strengths, interests and goals to find the right fit — before you commit.</p>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="audience-card">
                    <div class="card-icon-box">
                        <i class="bi bi-mortarboard"></i>
                    </div>
                    <span class="audience-tag">CLASS 11 & 12</span>
                    <h3 class="card-title">College & Career Planning</h3>
                    <p class="card-text">Shortlist colleges based on rank, budget and career path. Get a clear roadmap from board exams to admission.</p>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="audience-card">
                    <div class="card-icon-box">
                        <i class="bi bi-bank"></i>
                    </div>
                    <span class="audience-tag">COLLEGE STUDENTS</span>
                    <h3 class="card-title">What's Next After Graduation?</h3>
                    <p class="card-text">Confused about your future after a degree? We assess your skills and ambitions to find a clear direction ahead.</p>
                </div>
            </div>
        </div>
    </div>
</section>

    <!-- WHAT YOU GET SECTION -->
<section class="session-details-section">
    <div class="container">
        <div class="row align-items-center">
            
            <!-- LEFT CONTENT -->
            <div class="col-lg-6 mb-5 mb-lg-0">
                <span class="sub-title">WHAT YOU GET</span>
                <h2 class="main-title mb-3">One Session.<br><span>A Lot of Clarity.</span></h2>
                <p class="section-desc mb-5">No generic advice. Everything is based on your individual assessment, goals and situation.</p>

                <div class="benefit-list">
                    <!-- Item 1 -->
                    <div class="benefit-item">
                        <div class="benefit-icon pink-icon"><i class="bi bi-lightbulb"></i></div>
                        <div class="benefit-text">
                            <h4>Psychometric Career Assessment</h4>
                            <p>A structured test to understand your aptitude, interests and personality before the session.</p>
                        </div>
                    </div>
                    <!-- Item 2 -->
                    <div class="benefit-item">
                        <div class="benefit-icon blue-icon"><i class="bi bi-map"></i></div>
                        <div class="benefit-text">
                            <h4>Personalised Career Roadmap</h4>
                            <p>A step-by-step plan tailored to your profile — subjects, colleges, exams and timelines.</p>
                        </div>
                    </div>
                    <!-- Item 3 -->
                    <div class="benefit-item">
                        <div class="benefit-icon orange-icon"><i class="bi bi-file-earmark-text"></i></div>
                        <div class="benefit-text">
                            <h4>Written Session Summary</h4>
                            <p>Key decisions and next steps documented and shared after your call.</p>
                        </div>
                    </div>
                    <!-- Item 4 -->
                    <div class="benefit-item">
                        <div class="benefit-icon purple-icon"><i class="bi bi-chat-dots"></i></div>
                        <div class="benefit-text">
                            <h4>Post-Session Support</h4>
                            <p>Follow-up questions answered via WhatsApp — so the guidance doesn't stop when the call does.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- RIGHT DARK CARD -->
            <div class="col-lg-6">
                <div class="session-card">
                    <span class="card-badge">HOW A SESSION LOOKS</span>
                    <h3 class="card-heading">A Typical 45-Minute Session</h3>
                    
                    <div class="timeline-wrapper">
                        <!-- Step 1 -->
                        <div class="timeline-item">
                            <div class="step-number">1</div>
                            <div class="step-content">
                                <h5>Introduction (5 mins)</h5>
                                <p>Your background, current situation and what's confusing you.</p>
                            </div>
                        </div>
                        <!-- Step 2 -->
                        <div class="timeline-item">
                            <div class="step-number">2</div>
                            <div class="step-content">
                                <h5>Assessment Review (10 mins)</h5>
                                <p>Counsellor reviews your psychometric results with you.</p>
                            </div>
                        </div>
                        <!-- Step 3 -->
                        <div class="timeline-item">
                            <div class="step-number">3</div>
                            <div class="step-content">
                                <h5>Guidance & Options (20 mins)</h5>
                                <p>Specific streams, colleges or career paths laid out clearly.</p>
                            </div>
                        </div>
                        <!-- Step 4 -->
                        <div class="timeline-item">
                            <div class="step-number">4</div>
                            <div class="step-content">
                                <h5>Q&A & Next Steps (10 mins)</h5>
                                <p>Your questions answered. Action plan discussed and confirmed.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

    <!-- HOW IT WORKS SECTION -->
<section class="process-section">
    <div class="container">
        <div class="section-header text-center mb-5">
            <span class="sub-title">HOW IT WORKS</span>
            <h2 class="main-title">4 Simple Steps to <span>Your Career Clarity.</span></h2>
        </div>

        <div class="process-wrapper">
            <!-- Line connecting the steps -->
            <div class="process-line"></div>

            <div class="row">
                <!-- Step 1 -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="process-item">
                        <div class="process-icon">
                            <i class="bi bi-pencil-square"></i>
                        </div>
                        <h4>Fill the Form</h4>
                        <p>Share your details and what you need help with.</p>
                    </div>
                </div>

                <!-- Step 2 -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="process-item active-step">
                        <div class="process-icon">
                            <i class="bi bi-lightbulb"></i>
                        </div>
                        <h4>Take Assessment</h4>
                        <p>Complete a quick psychometric test online — free.</p>
                    </div>
                </div>

                <!-- Step 3 -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="process-item">
                        <div class="process-icon">
                            <i class="bi bi-telephone-outbound"></i>
                        </div>
                        <h4>1-on-1 Session</h4>
                        <p>45-minute private video call with Pranav.</p>
                    </div>
                </div>

                <!-- Step 4 -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="process-item">
                        <div class="process-icon">
                            <i class="bi bi-map"></i>
                        </div>
                        <h4>Get Your Plan</h4>
                        <p>Receive your written roadmap and next steps.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

    <!-- PSYCHOMETRIC ASSESSMENT SECTION -->
<section class="assessment-grid-section">
    <div class="container">
        <div class="row align-items-center">
            
            <!-- LEFT CONTENT -->
            <div class="col-lg-5 mb-5 mb-lg-0">
                <span class="sub-title">PSYCHOMETRIC ASSESSMENT</span>
                <h2 class="main-title mb-4">Decisions Based on<br><span>Data, Not Guesswork.</span></h2>
                
                <div class="assessment-description">
                    <p>Before your session, you'll take a free career assessment. This helps Pranav understand your strengths and match the right career paths to you — not just the popular ones.</p>
                    <p class="mt-4">We assess across <strong>20 career clusters</strong>, <strong>160+ career paths</strong> and <strong>3,000+ occupations</strong> — so no option is missed.</p>
                </div>

                <div class="mt-5">
                    <a href="#" class="btn-assessment">Take Free Assessment →</a>
                </div>
            </div>

            <!-- RIGHT GRID -->
            <div class="col-lg-7">
                <div class="row g-2"> <!-- g-3 handles the tight gap between cards -->
                    <!-- Card 1 -->
                    <div class="col-md-6">
                        <div class="mini-card">
                            <i class="bi bi-bar-chart-line pink-text"></i>
                            <h5>Class 9 & 10</h5>
                            <p>Career path & subject suitability</p>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div class="col-md-6">
                        <div class="mini-card">
                            <i class="bi bi-eyedropper blue-text"></i>
                            <h5>Class 11 & 12 Science</h5>
                            <p>Engineering, Medical, Research paths</p>
                        </div>
                    </div>
                    <!-- Card 3 -->
                    <div class="col-md-6">
                        <div class="mini-card">
                            <i class="bi bi-briefcase orange-text"></i>
                            <h5>Class 11 & 12 Commerce</h5>
                            <p>Finance, Law, Management paths</p>
                        </div>
                    </div>
                    <!-- Card 4 -->
                    <div class="col-md-6">
                        <div class="mini-card">
                            <i class="bi bi-palette purple-text"></i>
                            <h5>Arts & Humanities</h5>
                            <p>Creative, social and teaching careers</p>
                        </div>
                    </div>
                    <!-- Card 5 -->
                    <div class="col-md-6">
                        <div class="mini-card">
                            <i class="bi bi-mortarboard green-text"></i>
                            <h5>College Graduates</h5>
                            <p>Career shift or advancement planning</p>
                        </div>
                    </div>
                    <!-- Card 6 -->
                    <div class="col-md-6">
                        <div class="mini-card">
                            <i class="bi bi-gear indigo-text"></i>
                            <h5>Engineering Stream</h5>
                            <p>Right branch before college admission</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
    <!-- MEET THE COUNSELLOR SECTION -->
<section class="counsellor-profile-section">
    <div class="container">
        <div class="section-header text-center mb-5">
            <span class="sub-title">YOUR COUNSELLOR</span>
            <h2 class="main-title">Meet <span>Pranav Maheshwari</span></h2>
        </div>

        <div class="row align-items-start">
            <!-- Left: Image with Dark Glow -->
            <div class="col-lg-5 col-md-12 mb-4 mb-lg-0">
                <div class="counsellor-image-container">
                    <img src="assets/tutorimg/Pranav.jpg" alt="Pranav Maheshwari" class="img-fluid" />
                </div>
            </div>

            <!-- Right: Content -->
            <div class="col-lg-7 col-md-12 ps-lg-5">
                <!-- Green Certification Badge -->
                <div class="cert-banner mb-4">
                    <i class="bi bi-check2-square me-2"></i>
                    Certified Career Analyst — BCPA India & ACCPH UK
                </div>

                <h3 class="profile-name">Pranav Maheshwari</h3>
                <p class="profile-location">Bhiwadi, Rajasthan · Online & Offline Sessions</p>

                <!-- Experience Pills -->
                <div class="profile-badges mb-4">
                    <span class="badge-pill">9+ Years Teaching</span>
                    <span class="badge-pill">3+ Years Career Counselling</span>
                    <span class="badge-pill">Physics & Science Educator</span>
                    <span class="badge-pill">IB · IGCSE · AP · CBSE</span>
                </div>

                <div class="profile-bio mb-4">
                    <p>Pranav is a Certified Career Analyst accredited by both BCPA (India) and ACCPH (UK). He has guided hundreds of students through stream selection, college choices and career decisions — with a focus on clarity, honesty and outcomes that actually fit the student.</p>
                </div>

                <!-- Expertise Checklist -->
                <ul class="expertise-list">
                    <li><i class="bi bi-check2"></i> Stream selection after Class 10 (Science / Commerce / Arts)</li>
                    <li><i class="bi bi-check2"></i> College shortlisting based on rank, budget and career goals</li>
                    <li><i class="bi bi-check2"></i> Engineering branch selection</li>
                    <li><i class="bi bi-check2"></i> Career guidance for college graduates & working professionals</li>
                    <li><i class="bi bi-check2"></i> Psychometric-based career planning (20 clusters, 3,000+ occupations)</li>
                </ul>

                <div class="mt-5">
    <button type="button" href="#" class="btn-book-session">Book a Free Session with Pranav →</button>
</div>
            </div>
        </div>
    </div>
</section>
    <!-- FAQ SECTION -->
<section class="faq-section">
    <div class="container">
        <div class="section-header text-center mb-5">
            <span class="sub-title">FAQS</span>
            <h2 class="main-title">Common Questions</h2>
        </div>

        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-6">
                <div class="accordion accordion-flush" id="faqLeft">
                    <!-- Q1 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q1">
                                Is the session really free?
                            </button>
                        </h2>
                        <div id="q1" class="accordion-collapse collapse" data-bs-parent="#faqLeft">
                            <div class="accordion-body">
                                Yes — completely free. No hidden charges, no credit card, no upsell during the call.
                            </div>
                        </div>
                    </div>
                    <!-- Q2 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q2">
                                How long is the session?
                            </button>
                        </h2>
                        <div id="q2" class="accordion-collapse collapse" data-bs-parent="#faqLeft">
                            <div class="accordion-body">
                                A typical session lasts about 45 minutes, allowing enough time for assessment review and roadmap planning.
                            </div>
                        </div>
                    </div>
                    <!-- Q3 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q3">
                                Can my parents join the session?
                            </button>
                        </h2>
                        <div id="q3" class="accordion-collapse collapse" data-bs-parent="#faqLeft">
                            <div class="accordion-body">
                                Absolutely. We encourage parents to join so everyone is on the same page regarding the student's future path.
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-lg-6">
                <div class="accordion accordion-flush" id="faqRight">
                    <!-- Q4 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q4">
                                What is a psychometric assessment?
                            </button>
                        </h2>
                        <div id="q4" class="accordion-collapse collapse" data-bs-parent="#faqRight">
                            <div class="accordion-body">
                                It is a scientifically designed test that evaluates your interests, personality traits, and aptitudes to suggest the best career fit.
                            </div>
                        </div>
                    </div>
                    <!-- Q5 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q5">
                                Is this for school students only?
                            </button>
                        </h2>
                        <div id="q5" class="accordion-collapse collapse" data-bs-parent="#faqRight">
                            <div class="accordion-body">
                                While we specialize in Class 9-12, we also provide guidance for college graduates and early-career professionals.
                            </div>
                        </div>
                    </div>
                    <!-- Q6 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q6">
                                How do I book?
                            </button>
                        </h2>
                        <div id="q6" class="accordion-collapse collapse" data-bs-parent="#faqRight">
                            <div class="accordion-body">
                                Simply click the "Schedule 1:1 Call" button and pick a time slot that works best for you.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
    <!-- FINAL CTA SECTION -->
<section class="final-cta-section">
    <div class="container text-center">
        <!-- Top Badge -->
        <div class="mb-4">
            <span class="slots-pill">LIMITED SLOTS WEEKLY</span>
        </div>

        <!-- Main Heading -->
        <h2 class="cta-heading mb-3">Book Your Free 1-on-1 Clarity Call.</h2>
        
        <!-- Subtext -->
        <p class="cta-subtext mb-5">
            Ready to clear your career confusion? Click below to WhatsApp us and schedule<br class="d-none d-md-block"> 
            your free 1-on-1 session. Most calls are confirmed within 48 hours.
        </p>

        <!-- Glowing Button -->
        <div class="mb-5">
            <button type="button" class="btn-glow-primary">Schedule Free 1-on-1 Call →</button>
        </div>

        <hr class="cta-divider">

        <!-- Contact Info Footer -->
        <div class="row justify-content-center mt-4">
            <div class="col-auto d-flex align-items-center mx-4 mb-3">
                <div class="contact-icon-circle me-3">
                    <i class="bi bi-telephone"></i>
                </div>
                <div class="text-start">
                    <span class="contact-label">CALL OR WHATSAPP</span><br>
                    <span class="contact-value">+91 76652 46654</span>
                </div>
            </div>
            <div class="col-auto d-flex align-items-center mx-4 mb-3">
                <div class="contact-icon-circle me-3">
                    <i class="bi bi-envelope"></i>
                </div>
                <div class="text-start">
                    <span class="contact-label">EMAIL US</span><br>
                    <span class="contact-value">contact@studyisle.in</span>
                </div>
            </div>
        </div>
    </div>
</section>
</asp:Content>
