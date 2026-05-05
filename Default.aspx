<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StudyIsleWeb.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- this is hero section--%>

    <section class="hero-section py-5">
        <div class="container">
            <div class="row align-items-center g-2">


                <!-- LEFT SIDE -->
                <div class="col-lg-6">

                    <!-- Small Badge -->
                    <div class="hero-badge mb-3">
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">INDIA’S #1 LIVE LEARNING APP
                        </span>
                    </div>

                    <!-- Main Heading -->
                    <h1 class="hero-title mb-4">From Free Notes to
Your
                         <span style="color: #4f46e5;">Dream College.</span>

                    </h1>

                    <!-- Supporting Paragraph -->
                    <p class="hero-subtitle mb-4">
                       Free study material. Expert career counselling. 1-on-1 online tuition for IB & IGCSE. Everything in one place.
                    </p>

                    <!-- Class Buttons -->
                    <!-- Class Selection Card -->
                    <div class="class-card p-4 mt-4">

                        <p class="small text-muted mb-3 fw-semibold">
                           TOP COURSES
                        </p>

                        <div class="class-buttons mb-4">

                            <a href="BoardResourceTypes.aspx?board=cbse" class="btn class-btn m-1">CBSE</a>
                            <a href="BoardResourceTypes.aspx?board=icse" class="btn class-btn m-1">ICSE</a>
                            <a href="BoardResourceTypes.aspx?board=jee" class="btn class-btn m-1">JEE</a>
                            <a href="BoardResourceTypes.aspx?board=neet" class="btn class-btn m-1">NEET</a>

                           

                        </div>

                        <a href="/Register.aspx" class="btn btn-primary btn-lg w-100">Start Free Learning →
                        </a>
                    </div>
                    <!-- Reviews -->
                    <div class="hero-reviews">
                        <small class="text-muted">⭐ 4.9/5 from 50k+ parent reviews </small>                    
                    </div>
                </div>
                <!-- RIGHT SIDE -->
                <div class="col-lg-6 text-center">

                    <div class="hero-image-wrapper">

                        <!-- Main White Card -->
                        <div class="image-card shadow-lg">

                           <div class="image-inner">
    <!-- Carousel Wrapper -->
    <div id="heroImageCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <div class="carousel-inner">
            
            <!-- Image 1 -->
            <div class="carousel-item active" data-bs-interval="3000">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f" 
                     class="d-block w-100" alt="Live Learning 1" />
            </div>

            <!-- Image 2 -->
            <div class="carousel-item" data-bs-interval="3000">
                <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644" 
                     class="d-block w-100" alt="Live Learning 2" />
            </div>

            <!-- Image 3 -->
            <div class="carousel-item" data-bs-interval="3000">
                <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3" 
                     class="d-block w-100" alt="Live Learning 3" />
            </div>

        </div>
        <!-- Navigation Buttons -->
    <button class="carousel-control-prev" type="button" data-bs-target="#heroImageCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroImageCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
    </div>
</div>

                            <div class="masterclass-section">
                                <h6 class="mb-1">Today's Masterclass</h6>
                                <p class="mb-0 text-muted small">
                                    Mastering Quadratic Equations • 14k students watching
                                </p>
                            </div>
                        </div>
                        <!-- Floating Badge -->
                        <div class="floating-badge shadow">
                            <div class="badge-icon">👨‍🏫</div>
                            <div>
                                <small class="text-muted d-block">TOP EDUCATORS</small>
                                <strong>IITians & PhDs</strong>
                            </div>
                        </div>

                        <!-- Rank Card -->
                        <div class="rank-card shadow">
                            <h6 class="mb-1">Rank 1</h6>
                            <p class="mb-2 small">
                                Our student AIR 1 in JEE Advanced 2024
                            </p>
                            <div class="progress-line"></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
        <%--end of hero section--%>


       <%-- moving strip  (ticker bar)--%>
        <!-- Moving Achievement Strip -->
<div class="achievement-strip">
    <div class="strip-content">
        <span>• 50k+ Questions Solved Daily</span>
        <span>• AIR 1, 4, 7 & 12 in JEE 2024</span>
        <span>• Best Live Learning App Award 2023</span>
        <span>• 50k+ Questions Solved Daily</span>
        <span>• AIR 1, 4, 7 & 12 in JEE 2024</span>
        <span>• Best Live Learning App Award 2023</span>
         <span>• 50k+ Questions Solved Daily</span>
 <span>• AIR 1, 4, 7 & 12 in JEE 2024</span>
 <span>• Best Live Learning App Award 2023</span>
 <span>• 50k+ Questions Solved Daily</span>
 <span>• AIR 1, 4, 7 & 12 in JEE 2024</span>
 <span>• Best Live Learning App Award 2023</span>
    </div>
</div>


        <%--============Career Guidance section start from here========--%>
    <!-- =========================
   <!-- ======================================
   CAREER GUIDANCE SECTION
====================================== -->
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


       <%-- == Books section start from here==--%>

   <section class="ncert-section">
    <div class="container">

        <!-- Header Row -->
        <div class="row align-items-center mb-5">
            <div class="col-md-8">
                <h1 class="ncert-title">Free Study Material for
CBSE, ICSE & <spam>Competitive Exams</spam> </h1>
                <p class="ncert-subtitle">
                    Thousands of chapter-wise notes, NCERT solutions, solved past papers, and topic MCQs — all free, all expert-verified, fully updated for the 2024–25 syllabus.
                </p>
            </div>

            <div class="col-md-4 text-md-end text-start mt-3 mt-md-0">
                <a href="#" class="view-all-btn">
                    View All Resources →
                </a>
            </div>
        </div>

        <!-- Subject Row -->
        <div class="row g-2 justify-content-center text-center">

            <div class="col-lg-2 col-md-4 col-6">
                <a href="Mathematics.aspx" class="subject-card">
                    <div class="icon-box math">Σ</div>
                    <h6>Mathematics</h6>
                    <span>SOLUTIONS • NOTES</span>
                </a>
            </div>

            <div class="col-lg-2 col-md-4 col-6">
                <a href="Physics.aspx" class="subject-card">
                    <div class="icon-box physics">⚙</div>
                    <h6>Physics</h6>
                    <span>SOLUTIONS • NOTES</span>
                </a>
            </div>

            <div class="col-lg-2 col-md-4 col-6">
                <a href="Chemistry.aspx" class="subject-card">
                    <div class="icon-box chemistry">🧪</div>
                    <h6>Chemistry</h6>
                    <span>SOLUTIONS • NOTES</span>
                </a>
            </div>

            <div class="col-lg-2 col-md-4 col-6">
                <a href="Biology.aspx" class="subject-card">
                    <div class="icon-box biology">🧬</div>
                    <h6>Biology</h6>
                    <span>SOLUTIONS • NOTES</span>
                </a>
            </div>

            <div class="col-lg-2 col-md-4 col-6">
                <a href="English.aspx" class="subject-card">
                    <div class="icon-box english">A</div>
                    <h6>English</h6>
                    <span>SOLUTIONS • NOTES</span>
                </a>
            </div>

            <div class="col-lg-2 col-md-4 col-6">
                <a href="SST.aspx" class="subject-card">
                    <div class="icon-box sst">🌍</div>
                    <h6>SST</h6>
                    <span>SOLUTIONS • NOTES</span>
                </a>
            </div>

        </div>

        <!-- Bottom Feature Row -->
        <div class="row mt-5 g-4">

            <div class="col-md-4">
                <div class="feature-card">
                    <h6>RD Sharma Solutions</h6>
                    <p>Concept-wise solutions for all grades.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card">
                    <h6>Revision Notes</h6>
                    <p>Summarized notes for last-minute prep.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card">
                    <h6>Previous Year Papers</h6>
                    <p>10-Year board exam paper vault.</p>
                </div>
            </div>

        </div>

    </div>
</section>






        <%--another section from here online interactive class section--%>
   <%-- this section css code is not applying properly on UI--%>

        <section class="interactive-section py-5">
    <div class="container">
        <div class="row align-items-center g-5">

            <!-- LEFT IMAGE -->
<div class="col-lg-6 mb-4 mb-lg-0">
    <div class="interactive-image-wrapper">

        <div class="interactive-image-card">
        
            <img src="https://images.unsplash.com/photo-1610484826967-09c5720778c7?q=80&w=1000"
                         alt="Interactive Learning" />
        </div>

    </div>
</div>


            <!-- RIGHT CONTENT -->
            <div class="col-lg-6">

                <span class="tech-badge">Live Online Classes</span>

                <h2 class="interactive-title">
                    Live Classes That
Feel Like 
                    <span>Personal Tutor.</span>
                </h2>

                <!-- Feature Item 1 -->
                <div class="feature-item">
                    <div class="feature-icon">🎥</div>
                    <div>
                        <h6>Two-Way Audio/Video Interaction</h6>
                        <p>Ask questions live. Your teacher responds directly — no waiting, no muting.</p>
                    </div>
                </div>

                <!-- Feature Item 2 -->
                <div class="feature-item">
                    <div class="feature-icon">💬</div>
                    <div>
                        <h6>Dedicated Doubt-Solving Teacher in Every Class</h6>
                        <p>A second teacher in every class clears doubts from chat in real time.</p>
                    </div>
                </div>

                <!-- Feature Item 3 -->
                <div class="feature-item">
                    <div class="feature-icon">⚡</div>
                    <div>
                        <h6>
Live Leaderboards That Keep You Sharp</h6>
                        <p>In-class quizzes and live rankings against 10k+ students keep every session sharp.</p>
                    </div>
                </div>

            </div>

        </div>
    </div>
</section>

  <%--  =======Course section start from here======--%>
    
<%--<section class="course-section">
    <div class="container">

        <!-- Header -->
        <div class="text-center">
            <h2 class="section-title">Choose Your Learning Path</h2>
            <p class="section-subtitle">
                Explore structured programs tailored for every academic goal.
            </p>
        </div>

        <!-- Filter Pills -->
<div class="text-center filter-wrapper">
    <button type="button" class="filter-btn active">All</button>
    <button type="button" class="filter-btn">Class 6-8 Foundation</button>
    <button type="button" class="filter-btn">Class 9-10 Boards</button>
    <button type="button" class="filter-btn">JEE / NEET</button>
    <button type="button" class="filter-btn">International Boards</button>
    <button type="button" class="filter-btn">Career Counselling</button>
</div>


        <!-- Course Grid -->
        <div class="row g-3">

            <!-- Repeat this block for 6 cards -->

            <div class="col-lg-4 col-md-6 col-12">

                <div class="course-card">
                    <div class="course-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=1200" />

                        <span class="course-badge">CLASS 9-10 BOARDS</span>
                    </div>
                    <div class="course-body">
                        <h5 class="course-title">Class 10 CBSE Board Mastery</h5>
                        <ul class="course-features">
                            <li>Daily Live Classes</li>
                            <li>Notes & PDFs</li>
                            <li>Weekly Mock Tests</li>
                        </ul>
                    </div>
                    <div class="course-footer d-flex justify-content-between">
                        <span class="course-price">₹2,499/mo</span>
                        <a href="#" class="course-link">Explore Course →</a>
                    </div>
                </div>
            </div>
                       <div class="col-lg-4 col-md-6 col-12">

                <div class="course-card">
                    <div class="course-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=1200" />

                        <span class="course-badge">CLASS 9-10 BOARDS</span>
                    </div>
                    <div class="course-body">
                        <h5 class="course-title">Class 10 CBSE Board Mastery</h5>
                        <ul class="course-features">
                            <li>Daily Live Classes</li>
                            <li>Notes & PDFs</li>
                            <li>Weekly Mock Tests</li>
                        </ul>
                    </div>
                    <div class="course-footer d-flex justify-content-between">
                        <span class="course-price">₹2,499/mo</span>
                        <a href="#" class="course-link">Explore Course →</a>
                    </div>
                </div>
            </div>
                        <div class="col-lg-4 col-md-6 col-12">

                <div class="course-card">
                    <div class="course-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1509062522246-3755977927d7?q=80&w=1200" />

                        <span class="course-badge">CLASS 9-10 BOARDS</span>
                    </div>
                    <div class="course-body">
                        <h5 class="course-title">Class 10 CBSE Board Mastery</h5>
                        <ul class="course-features">
                            <li>Daily Live Classes</li>
                            <li>Notes & PDFs</li>
                            <li>Weekly Mock Tests</li>
                        </ul>
                    </div>
                    <div class="course-footer d-flex justify-content-between">
                        <span class="course-price">₹2,499/mo</span>
                        <a href="#" class="course-link">Explore Course →</a>
                    </div>
                </div>
            </div>
                        <div class="col-lg-4 col-md-6 col-12">

                <div class="course-card">
                    <div class="course-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1584697964358-3e14ca57658b?q=80&w=1200" />

                        <span class="course-badge">CLASS 9-10 BOARDS</span>
                    </div>
                    <div class="course-body">
                        <h5 class="course-title">Class 10 CBSE Board Mastery</h5>
                        <ul class="course-features">
                            <li>Daily Live Classes</li>
                            <li>Notes & PDFs</li>
                            <li>Weekly Mock Tests</li>
                        </ul>
                    </div>
                    <div class="course-footer d-flex justify-content-between">
                        <span class="course-price">₹2,499/mo</span>
                        <a href="#" class="course-link">Explore Course →</a>
                    </div>
                </div>
            </div>
                       <div class="col-lg-4 col-md-6 col-12">

                <div class="course-card">
                    <div class="course-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=1200" />

                        <span class="course-badge">CLASS 9-10 BOARDS</span>
                    </div>
                    <div class="course-body">
                        <h5 class="course-title">Class 10 CBSE Board Mastery</h5>
                        <ul class="course-features">
                            <li>Daily Live Classes</li>
                            <li>Notes & PDFs</li>
                            <li>Weekly Mock Tests</li>
                        </ul>
                    </div>
                    <div class="course-footer d-flex justify-content-between">
                        <span class="course-price">₹2,499/mo</span>
                        <a href="#" class="course-link">Explore Course →</a>
                    </div>
                </div>
            </div>
                       <div class="col-lg-4 col-md-6 col-12">

                <div class="course-card">
                    <div class="course-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=1200" />

                        <span class="course-badge">CLASS 9-10 BOARDS</span>
                    </div>
                    <div class="course-body">
                        <h5 class="course-title">Class 10 CBSE Board Mastery</h5>
                        <ul class="course-features">
                            <li>Daily Live Classes</li>
                            <li>Notes & PDFs</li>
                            <li>Weekly Mock Tests</li>
                        </ul>
                    </div>
                    <div class="course-footer d-flex justify-content-between">
                        <span class="course-price">₹2,499/mo</span>
                        <a href="#" class="course-link">Explore Course →</a>
                    </div>
                </div>
            </div>

        </div>

    </div>
</section>--%>
   <%-- ==course section end==--%>



   <%-- ===========TESTIMONIALS SECTION START FROM HERE===========--%>

<!-- RESULTS SECTION -->
<!-- RESULTS SECTION -->
<section class="results-section py-5">
    <div class="container">

        <!-- Section Header -->
        <div class="text-center mb-4">
            <div class="section-icon mb-2">
                <i class="bi bi-trophy-fill"></i>
            </div>
            <h2 class="results-title">RESULTS THAT SPEAK FOR US</h2>
            <p class="results-subtitle">
                Over 50,000 students selected in top IITs & medical colleges in the last 3 years.
            </p>
        </div>

        <!-- Class Selection Buttons -->
        <ul class="nav nav-pills justify-content-center mb-5" id="classTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="class12-tab" data-bs-toggle="pill" data-bs-target="#class12" type="button" role="tab">Class 12</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="class10-tab" data-bs-toggle="pill" data-bs-target="#class10" type="button" role="tab">Class 10</button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content" id="classTabContent">
            
            <!-- Class 12 Pane (Fixed 5 Cards) -->
            <div class="tab-pane fade show active" id="class12" role="tabpanel">
                <div class="row g-3 justify-content-center">
                    <!-- Card 1 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Aditi Jain</h6>
                            <div class="student-rank">AIR 1</div>
                            <small class="exam-label">JEE ADV 2024</small>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Rahul S.</h6>
                            <div class="student-rank">99.98 %ile</div>
                            <small class="exam-label">CAT 2023</small>
                        </div>
                    </div>
                    <!-- Card 3 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/women/68.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Priya K.</h6>
                            <div class="student-rank">AIR 52</div>
                            <small class="exam-label">NEET 2024</small>
                        </div>
                    </div>
                    <!-- Card 4 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/men/50.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Arjun M.</h6>
                            <div class="student-rank">AIR 112</div>
                            <small class="exam-label">JEE ADV 2024</small>
                        </div>
                    </div>
                    <!-- Card 5 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/women/22.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Sana V.</h6>
                            <div class="student-rank">99.5 %ile</div>
                            <small class="exam-label">JEE Main</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Class 10 Pane (Fixed 5 Cards) -->
            <div class="tab-pane fade" id="class10" role="tabpanel">
                <div class="row g-3 justify-content-center">
                    <!-- Card 1 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/men/45.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Vihan D.</h6>
                            <div class="student-rank">98% Board</div>
                            <small class="exam-label">CBSE 10th</small>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/women/11.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Megha R.</h6>
                            <div class="student-rank">97.5% Board</div>
                            <small class="exam-label">ICSE 10th</small>
                        </div>
                    </div>
                    <!-- Card 3 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/men/20.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Ishaan K.</h6>
                            <div class="student-rank">99% Board</div>
                            <small class="exam-label">CBSE 10th</small>
                        </div>
                    </div>
                    <!-- Card 4 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/women/5.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Riya P.</h6>
                            <div class="student-rank">96.8% Board</div>
                            <small class="exam-label">State Board</small>
                        </div>
                    </div>
                    <!-- Card 5 -->
                    <div class="col-xl-2 col-lg-4 col-md-6">
                        <div class="result-card">
                            <span class="topper-badge">TOPPER</span>
                            <img src="https://randomuser.me/api/portraits/men/15.jpg" class="student-img" alt="Student" />
                            <h6 class="student-name">Aarav J.</h6>
                            <div class="student-rank">95.4% Board</div>
                            <small class="exam-label">CBSE 10th</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Featured Testimonial Banner -->
        <div class="featured-testimonial mt-5">
            <div class="row align-items-center">
                <div class="col-lg-8 col-12 text-center text-lg-start">
                    <h4 class="featured-quote">"It wasn't just a course, it was a lifestyle change for my prep."</h4>
                    <p class="featured-author">— Mother of AIR 45, JEE Advanced 2024</p>
                </div>
                <div class="col-lg-4 col-12 text-center text-lg-end mt-3 mt-lg-0">
                    <a href="#" class="watch-btn">Watch Testimonial</a>
                </div>
            </div>
        </div>

    </div>
</section>

   <%-- ============Notes section start from here ==========--%>
    <!-- Study Notes Section -->
<section class="notes-section">
    <div class="container">
        <div class="row align-items-center">

            <!-- LEFT CONTENT -->
            <div class="col-lg-6 mb-5 mb-lg-0">
                <div class="notes-content">
                    <h2 class="notes-heading">
                        Everything You Need to <br />
                        Succeed.
                    </h2>

                    <p class="notes-description">
                        Don't waste time hunting for materials. Our Study Hub is a curated
                        repository of high-quality resources designed by top academic experts.
                    </p>

                    <ul class="notes-features">
                        <li>Expert-verified content for all boards</li>
                        <li>Updated as per latest 2024–25 syllabus</li>
                        <li>Downloadable for offline study</li>
                        <li>Interactive explanations for hard concepts</li>
                    </ul>

                    <a href="#" class="studyhub-btn">
                        Access Full Study Hub
                    </a>
                </div>
            </div>

            <!-- RIGHT CARDS -->
<div class="col-lg-6">
    <div class="row g-3 notes-grid">

        <div class="col-md-4 col-sm-6">
            <a href="/Notes/ChapterNotes.aspx" class="note-card pastel-blue">
                <div class="note-icon">
                    <i class="bi bi-file-earmark-text"></i>
                </div>
                <h5 class="note-title">Chapter Notes</h5>
                <p class="note-sub">2,500+ PDFs</p>
            </a>
        </div>

        <div class="col-md-4 col-sm-6">
            <a href="/Notes/MCQs.aspx" class="note-card pastel-green">
                <div class="note-icon">
                    <i class="bi bi-question-circle"></i>
                </div>
                <h5 class="note-title">Topic MCQs</h5>
                <p class="note-sub">50,000+ Qs</p>
            </a>
        </div>

        <div class="col-md-4 col-sm-6">
            <a href="/Notes/MockTests.aspx" class="note-card pastel-purple">
                <div class="note-icon">
                    <i class="bi bi-journal-check"></i>
                </div>
                <h5 class="note-title">Mock Tests</h5>
                <p class="note-sub">500+ Series</p>
            </a>
        </div>

        <div class="col-md-4 col-sm-6">
            <a href="/Notes/PreviousYear.aspx" class="note-card pastel-orange">
                <div class="note-icon">
                    <i class="bi bi-clock-history"></i>
                </div>
                <h5 class="note-title">Previous Year Qs</h5>
                <p class="note-sub">15 Years</p>
            </a>
        </div>

        <div class="col-md-4 col-sm-6">
            <a href="/Notes/VideoConcepts.aspx" class="note-card pastel-pink">
                <div class="note-icon">
                    <i class="bi bi-play-circle"></i>
                </div>
                <h5 class="note-title">Video Concepts</h5>
                <p class="note-sub">10,000+ Mins</p>
            </a>
        </div>

        <div class="col-md-4 col-sm-6">
            <a href="/Notes/NCERT.aspx" class="note-card pastel-cyan">
                <div class="note-icon">
                    <i class="bi bi-book"></i>
                </div>
                <h5 class="note-title">NCERT Solutions</h5>
                <p class="note-sub">All Subjects</p>
            </a>
        </div>

    </div>
</div>


        </div>
    </div>
</section>


   <%-- ==========AI-Powered section start from here========--%>

   <section class="ai-section">
    <div class="container">
        <div class="row align-items-center">

            <!-- LEFT SIDE -->
            <div class="col-lg-6 mb-5 mb-lg-0">
                <div class="ai-card">

                    <div class="card-header-row">
                        <div>
                            <h6>Ayush's Performance</h6>
                            <span>Physics • Mock Test Series #14</span>
                        </div>
                        <div class="rank-badge">TOP 5% RANK</div>
                    </div>

                    <div class="divider"></div>

                    <div class="chart-area"></div>

                    <div class="metrics-row">
                        <div class="metric-box">
                            <span>Accuracy</span>
                            <h4>94.2%</h4>
                        </div>
                        <div class="metric-box">
                            <span>Time Spent</span>
                            <h4>42 mins</h4>
                        </div>
                    </div>

                </div>
            </div>

            <!-- RIGHT SIDE -->
            <div class="col-lg-6">

                <span class="ai-badge">AI-Powered Insights</span>

                <h2 class="ai-heading">
                   Know What's Holding
Your Rank Back —<spam style="color: #4f46e5;"> and Fix It.</spam>
                </h2>

                <p class="ai-description">
                  Our AI finds the exact topics costing you marks — so you stop guessing and start improving.
                </p>

                <div class="feature-item">
                    <div class="icon-box">
                        <i class="fa fa-brain"></i>
                    </div>
                    <div>
                        <h6>Pinpoint Gap Identification</h6>
                        <p>Pinpoints the exact sub-topic pulling your score down — not just the chapter.</p>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="icon-box">
                        <i class="fa fa-chart-line"></i>
                    </div>
                    <div>
                        <h6>Percentile Comparison</h6>
                        <p>See where you stand against the top 1% of students nationwide.
</p>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="icon-box">
                        <i class="fa fa-arrow-trend-up"></i>
                    </div>
                    <div>
                        <h6>Predicted JEE / NEET Rank</h6>
                        <p>Get an estimated rank based on your test pattern and improvement curve.</p>
                    </div>
                </div>
                 <div class="feature-item">
     <div class="icon-box">
         <i class="fa fa-clock"></i>
     </div>
     <div>
         <h6>
Time Management Analysis</h6>
         <p>Identifies which question types eat your time so you stop losing marks at the end.</p>
     </div>
 </div>

            </div>

        </div>
    </div>
</section>

   <%-- =====================================================--%>
<!-- Tutors Section -->
<section class="tutors-section">
    <div class="container text-center">

        <!-- Section Heading -->
        <h2 class="tutors-title">Highly Qualified Teachers.<br />
                                     <span style="color: #4f46e5;">Proven Results.</span>
        </h2>
        <p class="tutors-subtitle">
10+ years of teaching experience. Strong board scores. Dream college admissions. That's what our teachers deliver.        </p>

        <div class="row justify-content-center mt-5">

            <!-- Tutor 1 -->
            <div class="col-md-6 col-lg-4 mb-5">
                <div class="tutor-item">
                    <div class="tutor-img-wrapper">
                        <img src="..\assets\tutorimg\Pranav.jpg"
                             class="tutor-img"
                             alt="Pranav Maheshwari">
                        <span class="verify-badge">✓</span>
                    </div>

                    <h6 class="tutor-name">Pranav Maheshwari</h6>
                    <p class="tutor-subject">Physics & Science Specialist</p>
                    <p class="tutor-exp">AP • IB • IGCSE • A-Level • CBSE & ICSE<br />
                        • 8+ Years Experience</p>
                    <div class="tutor-rating">★★★★★</div>
                </div>
            </div>

            <!-- Tutor 2 -->
            <div class="col-md-6 col-lg-4 mb-5">
                <div class="tutor-item">
                    <div class="tutor-img-wrapper">
                        <img src="..\assets\tutorimg\Ambar.jpg"
                             class="tutor-img"
                             alt="MD Ambar">
                        <span class="verify-badge">✓</span>
                    </div>

                    <h6 class="tutor-name">MD Ambar</h6>
                    <p class="tutor-subject">Mathematics Faculty</p>
                    <p class="tutor-exp">JEE & NEET Mentor • IB & Cambridge • Vedic Maths Expert
                        • 9+ Years Experience</p>
                    <div class="tutor-rating">★★★★★</div>
                </div>
            </div>

        </div>

        <!-- Join CTA -->
        <div class="join-tutor-box mt-4">
            <div class="row align-items-center">
                <div class="col-md-8 text-md-start text-center">
                    <h6 class="mb-1">Are you a passionate educator?</h6>
                    <p>Join our community of world-class tutors and impact thousands of Student's lives.</p>
                </div>

                <div class="col-md-4 text-md-end text-center mt-3 mt-md-0">
                    <a href="JoinTutor.aspx" class="btn join-outline-btn">
                        Join as a Tutor
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>


   <%-- =================International Curriculum section (ICSection)=================--%>

    <!-- ==================================
   INTERNATIONAL CURRICULUM SECTION
================================== -->

<%--<section class="ic-section">

    <div class="container">

        <div class="row align-items-center">

            <!-- LEFT CONTENT -->
            <div class="col-lg-6 ic-left">

                <span class="ic-badge">
                    <i class="bi bi-globe"></i> GLOBAL EXCELLENCE
                </span>

                <h2 class="ic-title">
                    Master the <span>International</span>
                    Curriculum with Ease.
                </h2>

                <p class="ic-desc">
                    From IB Diploma to IGCSE and AP, we provide world-class tutoring
                    and mentorship designed for global standards. Our experts help
                    you navigate complex assessments and excel in your academic journey.
                </p>

                <!-- Feature -->
                <div class="ic-feature">

                    <div class="ic-icon">
                        <i class="bi bi-book"></i>
                    </div>

                    <div>
                        <h6>IB & IGCSE Specialists</h6>
                        <p>
                            Tutors with deep expertise in International Baccalaureate
                            and Cambridge curricula.
                        </p>
                    </div>

                </div>

                <div class="ic-feature">

                    <div class="ic-icon">
                        <i class="bi bi-stars"></i>
                    </div>

                    <div>
                        <h6>IA, EE & TOK Support</h6>
                        <p>
                            Specialized guidance for Internal Assessments,
                            Extended Essays and Theory of Knowledge.
                        </p>
                    </div>

                </div>

                <div class="ic-feature">

                    <div class="ic-icon">
                        <i class="bi bi-people"></i>
                    </div>

                    <div>
                        <h6>Global University Prep</h6>
                        <p>
                            Beyond academics, we help you build a profile for
                            top universities worldwide.
                        </p>
                    </div>

                </div>

                <div class="ic-highlight">
                    <i class="bi bi-check-circle"></i>
                    Personalized 1-on-1 Learning Roadmaps
                </div>

            </div>


            <!-- RIGHT FORM -->
            <div class="col-lg-6">

                <div class="ic-form-card">

                    <h4>Get a Free Consultation</h4>

                    <p class="form-sub">
                        Fill in your details and we'll reach out to you directly.
                    </p>

                    <form>

                        <div class="row g-3">

                            <div class="col-md-6">
                                <input type="text" class="form-control"
                                    placeholder="Full Name">
                            </div>

                            <div class="col-md-6">
                                <input type="email" class="form-control"
                                    placeholder="Email Address">
                            </div>

                            <div class="col-12">
                                <input type="text" class="form-control"
                                    placeholder="Phone Number">
                            </div>

                            <div class="col-12">
                                <select class="form-select">
                                    <option>IB Diploma / MYP</option>
                                    <option>IGCSE</option>
                                    <option>AP</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <textarea class="form-control"
                                    rows="3"
                                    placeholder="Tell us about your academic goals..."></textarea>
                            </div>

                        </div>

                        <button type="submit" class="ic-submit-btn">
                            Submit Inquiry <i class="bi bi-send"></i>
                        </button>

                        <small class="ic-note">
                            We will contact you directly within 24 hours
                        </small>

                    </form>

                </div>

            </div>

        </div>

    </div>

</section>--%>



<!-- ================= ENQUIRY SECTION START ================= -->
<section class="enquiry-section">

    <div class="container">
        <div class="row align-items-center">

            <!-- LEFT SIDE -->
            <div class="col-lg-6 mb-5 mb-lg-0 enquiry-left">

                <div class="admission-badge">
                    IB & IGCSE Online Tuition
                </div>

                <h3 class="main-heading">
                  Struggling with IB or IGCSE?
                    <span class="gradient-text">We've Got You.</span>
                </h3>

                <p class="main-description">
Personalised 1-on-1 online tuition for IB, IGCSE, A-Level and AP students. Real specialists. Real results.                </p>

                <div class="feature-wrapper">

                    <div class="feature-item">
                        <div class="icon-box blue">
                            <i class="bi bi-person"></i>
                        </div>
                        <div>
                            <h6>One-on-One Online Sessions</h6>
                            <p>Built around your school, syllabus and pace. Fully personalised.</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box orange">
                            <i class="bi bi-award"></i>
                        </div>
                        <div>
                            <h6>IA, Extended Essay & TOK Mentoring</h6>
                            <p>Step-by-step guidance on Internal Assessments, Extended Essays and TOK.
</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box blue">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <div>
                            <h6>Exam Technique & Past Paper</h6>
                            <p>Learn exactly how examiners mark. Practice with real papers and expert feedback.</p>
                        </div>
                    </div>
                    <div class="feature-item">
    <div class="icon-box green">
        <i class="bi bi-globe"></i>
    </div>
    <div>
        <h6>Top University Application Support</h6>
        <p>Build your profile for UK, US and Canadian universities — grades to strategy.</p>
    </div>
</div>

                </div>

                <div class="rating-box">
                    <strong>4.9/5</strong> from over 12,000 students
                </div>

            </div>

           <!-- RIGHT SIDE FORM -->
            <div class="col-lg-6">
                <div class="enquiry-card">

                    <div class="card-top-border"></div>

                    <div class="card-body p-4">

                        <h4 class="form-title">Student Inquiry Form</h4>
                        <p class="form-subtitle">
                            Takes less than 2 minutes to complete
                        </p>

                        <div class="row g-3 mt-2">

                            <!-- Name -->
                            <div class="col-md-6">
                                <asp:TextBox ID="txtName" runat="server"
                                    CssClass="custom-input"
                                    placeholder="Student Name" />
                            </div>

                            <!-- Email -->
                            <div class="col-md-6">
                                <asp:TextBox ID="txtEmail" runat="server"
                                    CssClass="custom-input"
                                    TextMode="Email"
                                    placeholder="Email ID" />
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6">
                                <asp:TextBox ID="txtPhone" runat="server"
                                    CssClass="custom-input"
                                    placeholder="WhatsApp / Phone Number" />
                            </div>

                            <!-- Country -->
                            <div class="col-md-6">
                                <asp:DropDownList ID="ddlCountry"
                                    runat="server"
                                    CssClass="custom-input">
                                    <asp:ListItem Text="Select Country" Value="" />
                                    <asp:ListItem>India</asp:ListItem>
                                    <asp:ListItem>UAE</asp:ListItem>
                                    <asp:ListItem>USA</asp:ListItem>
                                    <asp:ListItem>UK</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Grade -->
                            <div class="col-md-6">
                                <asp:DropDownList ID="ddlGrade"
                                    runat="server"
                                    CssClass="custom-input">
                                    <asp:ListItem Text="Current Class / Grade" Value="" />
                                    <asp:ListItem>Grade 8</asp:ListItem>
                                    <asp:ListItem>Grade 9</asp:ListItem>
                                    <asp:ListItem>Grade 10</asp:ListItem>
                                    <asp:ListItem>Grade 11</asp:ListItem>
                                    <asp:ListItem>Grade 12</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Board -->
                            <div class="col-md-6">
                                <asp:DropDownList ID="ddlBoard"
                                    runat="server"
                                    CssClass="custom-input">
                                    <asp:ListItem Text="Board / Curriculum" Value="" />
                                    <asp:ListItem>CBSE</asp:ListItem>
                                    <asp:ListItem>ICSE</asp:ListItem>
                                    <asp:ListItem>IB</asp:ListItem>
                                    <asp:ListItem>Cambridge</asp:ListItem>
                                    <asp:ListItem>IGCSE</asp:ListItem>
                                    <asp:ListItem>AP</asp:ListItem>
                                    <asp:ListItem>A-Level</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Subjects -->
                            <div class="col-12">
                                <label class="section-label">Subject Interests</label>

                                <asp:CheckBoxList ID="chkSubjects"
                                    runat="server"
                                    RepeatDirection="Horizontal"
                                    CssClass="subject-pill-list">

                                    <asp:ListItem>Maths</asp:ListItem>
                                    <asp:ListItem>Physics</asp:ListItem>
                                    <asp:ListItem>Chemistry</asp:ListItem>
                                    <asp:ListItem>Biology</asp:ListItem>
                                   
                                    <asp:ListItem>English</asp:ListItem>

                                </asp:CheckBoxList>
                            </div>

                            <!-- Timeline -->
                            <div class="col-12">
                                <label class="section-label">
                                    When do you want to start classes?
                                </label>

                                <asp:RadioButtonList ID="rblTimeline"
                                    runat="server"
                                    RepeatDirection="Horizontal"
                                    CssClass="timeline-list">

                                    <asp:ListItem>Immediately</asp:ListItem>
                                    <asp:ListItem>Within 1 Month</asp:ListItem>
                                    <asp:ListItem>Just Enquiring</asp:ListItem>

                                </asp:RadioButtonList>
                            </div>

                            <!-- Submit -->
                            <div class="col-12">
                                <asp:Button ID="btnSubmit"
                                    runat="server"
                                    Text="Submit Application →"
                                    CssClass="btn-submit"
                                    OnClick="btnSubmit_Click"/>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- ================= ENQUIRY SECTION END ================= -->


    <%--==================blog sectio start from here ==================--%>



<div class="container mt-4 blogs-section">

    <!-- 🔷 HEADER -->
    <div class="text-center mb-4">
        <h2 class="fw-bold">Student Success Hub</h2>
        <p class="text-muted">
            High-impact strategies, resources, and expert tips to ace 
            <b>CBSE</b>, <b>JEE</b>, and <b>NEET</b> exams.
        </p>
    </div>

    <!-- 🔷 CATEGORY TABS -->
    <div class="text-center mb-4">

        <!-- Latest -->
        <asp:LinkButton ID="btnLatest" runat="server" CssClass="btn btn-primary me-2"
            OnClick="btnLatest_Click">Latest</asp:LinkButton>

        <!-- Dynamic Categories -->
        <asp:Repeater ID="rptCategories" runat="server">
            <ItemTemplate>
                <asp:LinkButton runat="server"
                    CssClass="btn btn-outline-secondary me-2"
                    CommandArgument='<%# Eval("CategoryId") %>'
                    OnCommand="Category_Click">
                    <%# Eval("CategoryName") %>
                </asp:LinkButton>
            </ItemTemplate>
        </asp:Repeater>

    </div>

    <!-- 🔷 BLOG CARDS -->
    <div class="row">

       <asp:Repeater ID="rptBlogs" runat="server">
<ItemTemplate>

    <div class="col-md-4 mb-4">

        <!-- 🔥 FULL CARD CLICKABLE -->
        <a href='BlogDetails.aspx?slug=<%# Eval("Slug") %>' 
           style="text-decoration:none; color:inherit; display:block;">

            <div class="card h-100 shadow-sm">

                <!-- Image -->
                <img src='<%# Eval("CoverImage") %>' 
                     class="card-img-top" 
                     style="height:200px; object-fit:cover;" />

                <div class="card-body">

                    <!-- Category Tag -->
                    <span class="badge bg-primary mb-2">
                        <%# Eval("CategoryName") %>
                    </span>

                    <!-- 🔥 Author + Date Row -->
                    <div class="d-flex align-items-center mb-2">

                        <!-- Author Image -->
                        <img src='<%# string.IsNullOrEmpty(Eval("AuthorImage").ToString()) ? "/uploads/default-user.png" : Eval("AuthorImage") %>'
     style="width:30px; height:30px; border-radius:50%; object-fit:cover; margin-right:8px;" />

                        <!-- Author Name -->
                        <small class="text-muted">
                            <%# Eval("AuthorName") %>
                        </small>

                    </div>

                    <!-- Title -->
                   <h5 class="card-title clamp-title">
                        <%# Eval("Title") %>
                    </h5>

                    <!-- Description -->
                   <p class="card-text text-muted clamp-desc">
                        <%# Eval("ShortDescription") %>
                    </p>

                </div>

                <div class="card-footer d-flex justify-content-between align-items-center">

                    <!-- 🔥 Dynamic Read Time -->
                    <small class="text-muted">
                        <%# Eval("ReadTime") %> min read
                    </small>

                    <!-- Actions -->
                    <div>
                        <i class="fa fa-bookmark me-2" 
                           style="cursor:pointer;"
                           onclick="event.preventDefault(); event.stopPropagation();">
                        </i>

                        <i class="fa fa-share" 
                           style="cursor:pointer;"
                           onclick="event.preventDefault(); event.stopPropagation(); shareBlog('<%# Eval("Slug") %>')">
                        </i>
                    </div>

                </div>

            </div>

        </a>

    </div>

</ItemTemplate>
</asp:Repeater>
    </div>

</div>

    <script>
function shareBlog(slug) {
    let url = window.location.origin + "/BlogDetails.aspx?slug=" + slug;

    if (navigator.share) {
        navigator.share({
            title: 'Check this blog',
            url: url
        });
    } else {
        navigator.clipboard.writeText(url);
        alert("Link copied!");
    }
}
    </script>
</asp:Content>
