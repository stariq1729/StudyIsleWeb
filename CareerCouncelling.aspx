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
</asp:Content>
