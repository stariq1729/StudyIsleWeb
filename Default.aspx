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
                    <h1 class="hero-title mb-4">Live Learning
                        <br />
                        That <span style="color: #4f46e5;">Wins Results.</span>

                    </h1>

                    <!-- Supporting Paragraph -->
                    <p class="hero-subtitle mb-4">
                        Join 1 million+ students across the globe.
                    Personalized live classes for Class 1-12, JEE, NEET and more.
                    </p>

                    <!-- Class Buttons -->
                    <!-- Class Selection Card -->
                    <div class="class-card p-4 mt-4">

                        <p class="small text-muted mb-3 fw-semibold">
                            SELECT YOUR CLASS TO START
                        </p>

                        <div class="class-buttons mb-4">

                            <a href="/Courses.aspx?class=6" class="btn class-btn m-1">Class 6</a>
                            <a href="/Courses.aspx?class=7" class="btn class-btn m-1">Class 7</a>
                            <a href="/Courses.aspx?class=8" class="btn class-btn m-1">Class 8</a>
                            <a href="/Courses.aspx?class=9" class="btn class-btn m-1">Class 9</a>

                            <!-- Active Class -->
                            <a href="/Courses.aspx?class=10" class="btn class-btn active m-1">Class 10</a>

                            <a href="/Courses.aspx?class=11" class="btn class-btn m-1">Class 11</a>
                            <a href="/Courses.aspx?class=12" class="btn class-btn m-1">Class 12</a>
                            <a href="/Courses.aspx?class=jee-neet" class="btn class-btn m-1">JEE/NEET</a>

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
                                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f"
                                    alt="Live Learning" />
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
    </div>
</div>

        <%--another section from here--%>

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

                <span class="tech-badge">WAVE INTERACTIVE TECH</span>

                <h2 class="interactive-title">
                    Classrooms That Feel Like A 
                    <span>Personal Tutor.</span>
                </h2>

                <!-- Feature Item 1 -->
                <div class="feature-item">
                    <div class="feature-icon">🎥</div>
                    <div>
                        <h6>Two-Way Audio/Video Interaction</h6>
                        <p>Teachers can talk directly to students to solve doubts in real-time.</p>
                    </div>
                </div>

                <!-- Feature Item 2 -->
                <div class="feature-item">
                    <div class="feature-icon">💬</div>
                    <div>
                        <h6>Instant Doubt Solving via Chat</h6>
                        <p>A secondary teacher dedicated to clearing every doubt as it pops up.</p>
                    </div>
                </div>

                <!-- Feature Item 3 -->
                <div class="feature-item">
                    <div class="feature-icon">⚡</div>
                    <div>
                        <h6>Engagement Hotspots</h6>
                        <p>Compete with 10k+ students in live leaderboard challenges.</p>
                    </div>
                </div>

            </div>

        </div>
    </div>
</section>

  <%--  =======Course section start from here======--%>
    
<section class="course-section">
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
</section>
   <%-- ==course section end==--%>

   <%-- == Books section start from here==--%>

   <section class="ncert-section">
    <div class="container">

        <!-- Header Row -->
        <div class="row align-items-center mb-5">
            <div class="col-md-8">
                <h1 class="ncert-title">Free NCERT & Revision Hub</h1>
                <p class="ncert-subtitle">
                    Access thousands of chapter-wise solutions, revision notes, and past year papers curated by experts.
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

    <%--============Career Guidance section start from here========--%>
    <!-- =========================
     CAREER GUIDANCE SECTION
========================== -->
<section class="career-section">
    <div class="container">
        <div class="career-wrapper">

            <div class="row align-items-center">

                <!-- LEFT CONTENT -->
                <div class="col-lg-6 career-left">
                    
                    <span class="career-badge">
                        ★ Personalized Guidance
                    </span>

                    <h2 class="career-heading">
                        Not sure where to start? 
                        <span>Speak 1-on-1.</span>
                    </h2>

                    <p class="career-description">
                        Every child is unique. Our expert academic counselors provide 
                        personalized roadmaps for your specific goals—completely free.
                    </p>

                    <div class="career-features">
                        <div class="feature-item">
                            <i class="bi bi-calendar-check"></i>
                            Pick your preferred time
                        </div>

                        <div class="feature-item">
                            <i class="bi bi-camera-video"></i>
                            Video  consultation
                        </div>

                        <div class="feature-item">
                            <i class="bi bi-file-earmark-text"></i>
                            Detailed Academic Report
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
                    
                    <div class="counsellor-card">

                        <div class="counsellor-top">
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Counsellor" />
                            <h5>Dr. Shweta Iyer</h5>
                            <p>Senior Academic Counselor</p>
                        </div>

                        <div class="counsellor-info">
                            <div class="info-row">
                                <span>Experience</span>
                                <strong>12+ Years</strong>
                            </div>

                            <div class="info-row">
                                <span>Specialization</span>
                                <strong>JEE & NEET Expert</strong>
                            </div>
                        </div>

                        <div class="next-slot">
                            Next Available Slot<br />
                            <strong>Today, 4:30 PM</strong>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</section>



   <%-- ===========TESTIMONIALS SECTION START FROM HERE===========--%>

<section class="results-section py-5">
    <div class="container">

        <!-- Section Header -->
        <div class="text-center mb-5">
            <div class="section-icon mb-2">
                <i class="bi bi-trophy-fill"></i>
            </div>
            <h2 class="results-title">RESULTS THAT SPEAK FOR US</h2>
            <p class="results-subtitle">
                Over 50,000 students selected in top IITs & medical colleges in the last 3 years.
            </p>
        </div>

        <!-- Result Cards -->
        <div class="row g-3 justify-content-center">

            <!-- Card 1 -->
            <div class="col-xl-3 col-lg-4 col-md-6 col-12">
                <div class="result-card">
                    <span class="topper-badge">TOPPER</span>

                    <img src="https://randomuser.me/api/portraits/women/44.jpg"
                        class="student-img" alt="Student" />

                    <h6 class="student-name">Aditi Jain</h6>
                    <div class="student-rank">AIR 1</div>
                    <small class="exam-label">JEE ADV 2024</small>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-xl-3 col-lg-4 col-md-6 col-12">
                <div class="result-card">
                    <span class="topper-badge">TOPPER</span>

                    <img src="https://randomuser.me/api/portraits/men/32.jpg"
                        class="student-img" alt="Student" />

                    <h6 class="student-name">Rahul S.</h6>
                    <div class="student-rank">99.98 %ile</div>
                    <small class="exam-label">CAT 2023</small>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-xl-3 col-lg-4 col-md-6 col-12">
                <div class="result-card">
                    <span class="topper-badge">TOPPER</span>

                    <img src="https://randomuser.me/api/portraits/women/68.jpg"
                        class="student-img" alt="Student" />

                    <h6 class="student-name">Priya K.</h6>
                    <div class="student-rank">AIR 52</div>
                    <small class="exam-label">NEET 2024</small>
                </div>
            </div>

            <!-- Card 4 -->
            <div class="col-xl-3 col-lg-4 col-md-6 col-12">
                <div class="result-card">
                    <span class="topper-badge">TOPPER</span>

                    <img src="https://randomuser.me/api/portraits/men/45.jpg"
                        class="student-img" alt="Student" />

                    <h6 class="student-name">Vihan D.</h6>
                    <div class="student-rank">98% Board</div>
                    <small class="exam-label">CBSE 10th</small>
                </div>
            </div>

        </div>
        <br />
        <!-- Featured Purple Testimonial -->
        <div class="featured-testimonial mt-5">
            <div class="row align-items-center">
                <div class="col-lg-8 col-12">
                    <h4 class="featured-quote">
                        "It wasn't just a course, it was a lifestyle change for my prep."
                    </h4>
                    <p class="featured-author">
                        — Mother of AIR 45, JEE Advanced 2024
                    </p>
                </div>

                <div class="col-lg-4 col-12 text-lg-end mt-3 mt-lg-0">
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
                    Reports That Drive Rank Improvements.
                </h2>

                <p class="ai-description">
                    We go beyond just scores. Our AI engine analyzes your behavior to identify conceptual gaps, time-management issues, and strength areas.
                </p>

                <div class="feature-item">
                    <div class="icon-box">
                        <i class="fa fa-brain"></i>
                    </div>
                    <div>
                        <h6>Gap Identification</h6>
                        <p>We pinpoint exactly which sub-topic is pulling your score down.</p>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="icon-box">
                        <i class="fa fa-chart-line"></i>
                    </div>
                    <div>
                        <h6>Comparative Analytics</h6>
                        <p>See where you stand against the top 1% percentile nationwide.</p>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="icon-box">
                        <i class="fa fa-arrow-trend-up"></i>
                    </div>
                    <div>
                        <h6>Predictive Ranking</h6>
                        <p>Get an estimated JEE/NEET rank based on consistent test patterns.</p>
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
        <h2 class="tutors-title">Learn From the Masters</h2>
        <p class="tutors-subtitle">
            Our teachers aren’t just experts in their subjects; they are mentors who inspire curious minds.
        </p>

        <div class="row justify-content-center mt-5">

            <!-- Tutor 1 -->
            <div class="col-md-6 col-lg-4 mb-5">
                <div class="tutor-item">
                    <div class="tutor-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=400&q=80"
                             class="tutor-img"
                             alt="Dr. Anand Verma">
                        <span class="verify-badge">✓</span>
                    </div>

                    <h6 class="tutor-name">Dr. Anand Verma</h6>
                    <p class="tutor-subject">Biology Specialist</p>
                    <p class="tutor-exp">Ph.D., AIIMS Delhi • 15+ Years Exp</p>
                    <div class="tutor-rating">★★★★★</div>
                </div>
            </div>

            <!-- Tutor 2 -->
            <div class="col-md-6 col-lg-4 mb-5">
                <div class="tutor-item">
                    <div class="tutor-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1595152772835-219674b2a8a6?auto=format&fit=crop&w=400&q=80"
                             class="tutor-img"
                             alt="Sameer Pathak">
                        <span class="verify-badge">✓</span>
                    </div>

                    <h6 class="tutor-name">Sameer Pathak</h6>
                    <p class="tutor-subject">Physics Guru</p>
                    <p class="tutor-exp">IIT Bombay Alumnus • 12+ Years Exp</p>
                    <div class="tutor-rating">★★★★★</div>
                </div>
            </div>

        </div>

        <!-- Join CTA -->
        <div class="join-tutor-box mt-4">
            <div class="row align-items-center">
                <div class="col-md-8 text-md-start text-center">
                    <h6 class="mb-1">Are you a passionate educator?</h6>
                    <p>Join our community of world-class tutors and impact thousands of lives.</p>
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



<!-- ================= ENQUIRY SECTION START ================= -->
<section class="enquiry-section">

    <div class="container">
        <div class="row align-items-center">

            <!-- LEFT SIDE -->
            <div class="col-lg-6 mb-5 mb-lg-0 enquiry-left">

                <div class="admission-badge">
                    Admissions Open 2025–26
                </div>

                <h2 class="main-heading">
                    Unlock Your <br />
                    <span class="gradient-text">Academic Potential</span>
                </h2>

                <p class="main-description">
                    Join thousands of students across the globe who have transformed 
                    their grades with our personalized 1-on-1 expert coaching.
                    Our counselors will call you to build a custom roadmap for your success.
                </p>

                <div class="feature-wrapper">

                    <div class="feature-item">
                        <div class="icon-box blue">
                            <i class="bi bi-person"></i>
                        </div>
                        <div>
                            <h6>Senior Counselors</h6>
                            <p>Expert 1-on-1 call for academic planning.</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box orange">
                            <i class="bi bi-award"></i>
                        </div>
                        <div>
                            <h6>Top-Tier Results</h6>
                            <p>Specialized tutors for IB, CBSE, IGCSE & AP.</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box green">
                            <i class="bi bi-globe"></i>
                        </div>
                        <div>
                            <h6>Global Recognition</h6>
                            <p>Supporting students in 20+ countries worldwide.</p>
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




</asp:Content>
