<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CareerCouncelling.aspx.cs" Inherits="StudyIsleWeb.CareerCouncelling" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets\css\CareerGuide.css" rel="stylesheet" />
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
</asp:Content>
