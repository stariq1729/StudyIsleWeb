<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="StudyIsleWeb.Gallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        /* =========================================
   GALLERY HERO SECTION
========================================= */

.gallery-hero-section {
    padding-top: 40px;
    padding-bottom: 60px;
    background: #fdfdff;
}

/* TOP LABEL */

.spotlight-top {
    position: relative;
    margin-bottom: 22px;
}

.spotlight-line {
    width: 100%;
    height: 1px;
    background: #d9dff1;
}

.spotlight-badge {
    position: absolute;
    left: 50%;
    top: -10px;
    transform: translateX(-50%);
    background: #f7f8fc;
    padding: 0 18px;
    font-size: 10px;
    font-weight: 700;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: #7367ff;
}

/* HERO CARD */

.hero-card {
    position: relative;
    width: 100%;
    height: 450px;
    border-radius: 32px;
    overflow: hidden;
    display: block;
    text-decoration: none;
    box-shadow: 0 18px 50px rgba(0,0,0,0.12);
}

/* IMAGE */

.hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    transition: 0.5s ease;
}

.hero-card:hover .hero-image {
    transform: scale(1.04);
}

/* OVERLAY */

.hero-overlay {
    position: absolute;
    inset: 0;
    background:
        linear-gradient(
            to top,
            rgba(0,0,0,0.88) 10%,
            rgba(0,0,0,0.40) 45%,
            rgba(0,0,0,0.10) 100%
        );
}

/* CONTENT */

.hero-content {
    position: absolute;
    left: 45px;
    bottom: 40px;
    z-index: 5;
    max-width: 650px;
    color: #ffffff;
}


.hero-title {
    font-size: 38px;
    line-height: 1.05;
    font-weight: 800;
    margin-bottom: 18px;
    color: #ffffff;
}

.hero-description {
    font-size: 12px;
    line-height: 1.7;
    color: rgba(255,255,255,0.92);
    margin-bottom: 20px;
}

/* FOOTER */

.hero-footer {
    display: flex;
    align-items: center;
    gap: 16px;
}

.hero-date {
    padding: 11px 18px;
    border-radius: 40px;
    background: rgba(255,255,255,0.14);
    backdrop-filter: blur(10px);
    font-size: 12px;
    font-weight: 600;
    color: #ffffff;
}

.hero-arrow {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #ffffff;
    color: #111827;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    transition: 0.3s;
}

.hero-card:hover .hero-arrow {
    transform: rotate(-45deg);
}

/* RESPONSIVE */

@media(max-width:991px) {

    .hero-card {
        height: 460px;
    }

    .hero-content {
        left: 30px;
        right: 30px;
        bottom: 30px;
    }

    .hero-title {
        font-size: 42px;
    }

    .hero-description {
        font-size: 16px;
    }
}

@media(max-width:768px) {

    .gallery-hero-section {
        padding-top: 105px;
    }

    .hero-card {
        height: 350px;
        border-radius: 24px;
    }

    .hero-content {
        left: 22px;
        right: 22px;
        bottom: 22px;
    }

    .hero-title {
        font-size: 30px;
    }

    .hero-description {
        font-size: 14px;
        line-height: 1.6;
    }

    .hero-footer {
        flex-wrap: wrap;
    }
}
/* =========================================
   INSTITUTE FEED SECTION
========================================= */

.institute-feed-section {
    padding-bottom: 60px;
    background: #fdfdff;
}

/* HEADER */

.feed-header {
    margin-bottom: 38px;
}

.feed-title {
    font-size: 34px;
    line-height: 1;
    font-weight: 800;
    color: #0f172a;
    margin-bottom: 6px;
}

.feed-subtitle {
    font-size: 14px;
    color: #64748b;
    line-height: 1.2;
}

/* GRID */

.feed-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px !important;
}

/* CARD */

.feed-card {
    position: relative;
    height: 260px;
    width: 320px;
    border-radius: 28px;
    overflow: hidden;
    display: block;
    text-decoration: none;
    background: #e2e8f0;
    box-shadow: 0 10px 20px rgba(0,0,0,0.08);
}

/* IMAGE */

.feed-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: 0.5s ease;
}

.feed-card:hover .feed-image {
    transform: scale(1.08);
}

/* OVERLAY */

.feed-overlay {
    position: absolute;
    inset: 0;
    background:
        linear-gradient(
            to top,
            rgba(0,0,0,0.88) 0%,
            rgba(0,0,0,0.25) 45%,
            rgba(0,0,0,0.05) 100%
        );

    opacity: 0;
    transition: 0.4s ease;
}

.feed-card:hover .feed-overlay {
    opacity: 1;
}

/* CONTENT */

.feed-content {
    position: absolute;
    left: 22px;
    right: 22px;
    bottom: 22px;
    z-index: 5;
    color: #ffffff;

    transform: translateY(30px);
    opacity: 0;
    transition: 0.4s ease;
}

.feed-card:hover .feed-content {
    transform: translateY(0);
    opacity: 1;
}

/* TAG */

/* TITLE */

.feed-card-title {
    font-size: 22px;
    line-height: 1.1;
    font-weight: 700;
    margin-bottom: 8px;
    color: #ffffff;
}

/* DESCRIPTION */

.feed-card-description {
    font-size: 12px;
    line-height: 1.2;
    color: rgba(255,255,255,0.88);
    margin-bottom: 12px;
}

/* FOOTER */

.feed-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.feed-date {
    font-size: 12px;
    font-weight: 600;
    color: rgba(255,255,255,0.92);
}

.feed-arrow {
    width: 26px;
    height: 26px;
    border-radius: 50%;
    background: rgba(255,255,255,0.16);
    backdrop-filter: blur(10px);

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 14px;
    color: #ffffff;

    transition: 0.3s;
}

.feed-card:hover .feed-arrow {
    transform: rotate(-45deg);
}

/* RESPONSIVE */

@media(max-width:991px) {

    .feed-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .feed-title {
        font-size: 42px;
    }
}

@media(max-width:768px) {

    .institute-feed-section {
        padding-bottom: 60px;
    }

    .feed-grid {
        grid-template-columns: 1fr;
        gap: 22px;
    }

    .feed-card {
        height: 240px;
        border-radius: 22px;
    }

    .feed-title {
        font-size: 34px;
    }

    .feed-subtitle {
        font-size: 15px;
    }

    .feed-card-title {
        font-size: 24px;
    }
}
/* =========================================
   STATS COUNTER SECTION - EXACT UI
========================================= */

.stats-section {
    padding: 20px 0;
    background: #fdfdff; /* White background to pop the soft gray shadows */
}

.stats-grid {
    display: grid;
    /* PC: 4 boxes in a row */
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.stat-card {
    background: #ffffff;
    padding: 36px 16px;
    border-radius: 22px;
    text-align: center;
    /* Soft, large spread shadow to match image */
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.04);
    border: 1.5px solid rgba(0, 0, 0, 0.01);
    transition: transform 0.3s ease;
}

/* ICON WRAPPERS - Rounded squares from image */
.stat-icon-box {
    width: 55px;
    height: 35px;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 12px;
    font-size: 20px;
}

/* Exact Color Palette from Image */
.bg-light-blue { background-color: #f0f3ff; color: #5c67f2; }
.bg-light-orange { background-color: #fff5ed; color: #e67e22; }
.bg-light-green { background-color: #f0fdf9; color: #27ae60; }
.bg-solid-purple { 
    background-color: #5c67f2; 
    color: #ffffff; 
    box-shadow: 0 10px 20px rgba(92, 103, 242, 0.3); 
}

.stat-number {
    display: block;
    font-size: 38px;
    font-weight: 600;
    color: #1a1a1a;
    letter-spacing: -1px;
    margin-bottom: 2px;
}

.stat-label {
    display: block;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.2px;
    color: #8c94a3;
}

/* RESPONSIVE LOGIC */
@media(max-width: 1024px) {
    /* Tablet & Mobile: 2 boxes in a row */
    .stats-grid {
        grid-template-columns: repeat(2, 1fr);
        padding: 0 20px;
    }
}

@media(max-width: 480px) {
    .stat-card {
        padding: 35px 15px;
    }
    .stat-number {
        font-size: 32px;
    }
}

/* =========================================
   EMPOWERING LEADERS - PIXEL PERFECT
========================================= */

.empower-section {
    padding: 20px 0;
    background: #fdfdff;
}

.empower-container {
    display: flex;
    align-items: flex-start; /* Aligns left text and right grid at the top */
    justify-content: space-between;
    gap: 50px;
}

/* LEFT SIDE */
.empower-left {
    flex: 0 0 45%; /* Precise width for text area */
    padding-top: 20px;
}

.empower-title {
    font-size: 42px;
    font-weight: 700;
    line-height: 1.1;
    color: #0f172a;
    margin-bottom: 40px;
    letter-spacing: -1.5px;
}

.empower-title span { color: #6366f1; }

.feature-item {
    display: flex;
    align-items: flex-start;
    gap: 18px;
    margin-bottom: 22px;
}

.feature-icon-circle {
    width: 48px;
    height: 48px;
    background: #111827;
    border-radius: 12px; /* Slightly squircle as per image */
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    flex-shrink: 0;
    font-size: 14px;
}
.feature-text h5{
    color:#0f172a;
}
/* RIGHT SIDE GRID - THE FIX */
.empower-right {
    flex: 0 0 50%;
    display: grid;
    /* 2 main columns with a specific gap */
    grid-template-columns: 1fr 1fr; 
    column-gap: 20px;
    align-items: start;
}

/* Column 1: Top Image and White Card */
.grid-col-1 {
    margin-top:30px;
    display: flex;
   /* width:230px;*/
    flex-direction: column;
    gap:20px; /* Precise vertical gap between img and card */
}

/* Column 2: Dark Card and Tall Image */
.grid-col-2 {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding-top: -60px; /* Pushes the whole right column down to match UI offset */
}

        .grid-img {
            width: 100%;
            border-radius: 32px;
            object-fit: cover;
            display: block;
            border: 4px solid #F9F9F9;
        }

/* CARDS */
.ui-card {
    border-radius: 32px;
    padding: 25px 18px;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.08);
}

.card-dark {
    background: #0f172a;
    color: #ffffff;
}

.card-white {
    background: #ffffff;
    border: 1px solid #f1f5f9;
}

.ui-card i, .ui-card span.icon {
    font-size: 28px;
    color: #6366f1;
    display: block;
    margin-bottom: 15px;
}

.ui-card h5 {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 6px;
}

.ui-card p {
    font-size: 12px;
    color: #94a3b8;
    line-height: 1.2;
}

/* RESPONSIVE */
@media (max-width: 1100px) {
    .empower-container { flex-direction: column; }
    .empower-left, .empower-right { flex: 0 0 100%; width: 100%; }
    .empower-title { font-size: 40px; }
}
/* =========================================
   TESTIMONIALS SECTION
========================================= */
.testimonials-section {
    padding: 80px 0;
    text-align: center;
    background: #fdfdff;
}

.section-header h2 {
    font-size: 36px;
    font-weight: 800;
    color: #0f172a;
    margin-bottom: 10px;
}

.section-header p {
    font-size: 14px;
    color: #64748b;
    margin-bottom: 50px;
}

.testimonial-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
    max-width: 1200px;
    margin: 0 auto 80px;
}

.testimonial-card {
    background: #ffffff;
    padding: 40px 30px;
    border-radius: 40px;
    text-align: left;
    position: relative;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.05);
    border: 1px solid #f1f5f9;
}

.stars { color: #f97316; font-size: 14px; margin-bottom: 20px; }

.quote-icon {
    position: absolute;
    top: 30px;
    right: 35px;
    font-size: 40px;
    color: #f1f5f9;
    font-family: serif;
    font-weight: bold;
}

.testimonial-text {
    font-size: 15px;
    line-height: 1.7;
    color: #475569;
    font-style: italic;
    margin-bottom: 30px;
    min-height: 100px;
}

.testimonial-footer {
    display: flex;
    align-items: center;
    gap: 15px;
    border-top: 1px solid #f1f5f9;
    padding-top: 20px;
}

.user-avatar {
    width: 45px;
    height: 45px;
    background: #f8fafc;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #94a3b8;
}

.user-info h5 {
    font-size: 15px;
    font-weight: 700;
    margin: 0;
    color: #0f172a;
}

.user-info span {
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    color: #6366f1;
    letter-spacing: 0.5px;
}

/* =========================================
   SUCCESS STORY CTA BANNER
========================================= */
.cta-banner {
    background: #5d5ced;
    padding: 40px 20px;
    border-radius: 30px;
    color: white;
    text-align: center;
    max-width: 1100px;
    margin: 0 auto;
    box-shadow: 0 30px 60px rgba(92, 103, 242, 0.3);
}

.cta-banner h2 {
    font-size: 40px;
    font-weight: 700;
    line-height: 1.1;
    margin-bottom: 18px;
}

.cta-banner h2 span {
    text-decoration: underline;
    text-decoration-thickness: 3px;
    text-underline-offset: 8px;
}

.cta-banner p {
    font-size: 16px;
    max-width: 600px;
    margin: 0 auto 40px;
    opacity: 0.9;
    line-height: 1.4;
}

.cta-buttons {
    display: flex;
    justify-content: center;
    gap: 18px;
}

.btn-white {
    background: white;
    color: #5c67f2;
    padding: 16px 35px;
    border-radius: 15px;
    font-weight: 700;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 10px;
    transition: 0.3s;
}

.btn-outline {
    background: rgba(255, 255, 255, 0.1);
    color: white;
    padding: 16px 35px;
    border-radius: 15px;
    font-weight: 700;
    text-decoration: none;
    border: 1px solid rgba(255, 255, 255, 0.2);
    transition: 0.3s;
}

.btn-white:hover { transform: translateY(-3px); }

/* RESPONSIVE */
@media (max-width: 991px) {
    .testimonial-grid { grid-template-columns: repeat(2, 1fr); }
    .cta-banner h2 { font-size: 34px; }
}

@media (max-width: 768px) {
    .testimonial-grid { grid-template-columns: 1fr; }
    .cta-buttons { flex-direction: column; align-items: center; }
}
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- =========================================
         GALLERY HERO SECTION
    ========================================== -->

   <div class="gallery-hero-section">

    <div class="container">

        <!-- TOP LABEL -->

        <div class="spotlight-top">

            <div class="spotlight-line"></div>

            <div class="spotlight-badge">
                Latest Spotlight
            </div>

        </div>

        <!-- HERO REPEATER -->

        <asp:Repeater ID="rptHeroGallery" runat="server">

            <ItemTemplate>

                <a href='GalleryDetails.aspx?id=<%# Eval("GalleryId") %>'
                    class="hero-card">

                    <!-- IMAGE -->

                    <img src='<%# Eval("ImagePath") %>'
                        alt='<%# Eval("Title") %>'
                        class="hero-image" />

                    <!-- OVERLAY -->

                    <div class="hero-overlay"></div>

                    <!-- CONTENT -->

                    <div class="hero-content">

                     

                        <h1 class="hero-title">
                            <%# Eval("Title") %>
                        </h1>

                        <p class="hero-description">
                            <%# Eval("Description") %>
                        </p>

                        <div class="hero-footer">

                            <div class="hero-date">
                                <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                            </div>

                            <div class="hero-arrow">
                                ↗
                            </div>

                        </div>

                    </div>

                </a>

            </ItemTemplate>

        </asp:Repeater>

    </div>

</div>
    <!-- =========================================
     INSTITUTE FEED SECTION
========================================= -->

<div class="institute-feed-section">

    <div class="container">

        <!-- HEADER -->

        <div class="feed-header">

            <h2 class="feed-title">
                Institute Feed
            </h2>

            <p class="feed-subtitle">
                Daily updates and highlights from StudyIsle Institute.
            </p>

        </div>

        <!-- GRID -->

        <div class="feed-grid">

            <asp:Repeater ID="rptGalleryFeed" runat="server">

                <ItemTemplate>

                    <a href='GalleryDetails.aspx?id=<%# Eval("GalleryId") %>'
                        class="feed-card">

                        <!-- IMAGE -->

                        <img src='<%# Eval("ImagePath") %>'
                            alt='<%# Eval("Title") %>'
                            class="feed-image" />

                        <!-- OVERLAY -->

                        <div class="feed-overlay"></div>

                        <!-- CONTENT -->

                        <div class="feed-content">

                            

                            <h3 class="feed-card-title">
                                <%# Eval("Title") %>
                            </h3>

                            <p class="feed-card-description">
                                <%# Eval("Description") %>
                            </p>

                            <div class="feed-footer">

                                <div class="feed-date">
                                    <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                                </div>

                                <div class="feed-arrow">
                                    ↗
                                </div>

                            </div>

                        </div>

                    </a>

                </ItemTemplate>

            </asp:Repeater>

        </div>

    </div>

</div>


   <div class="stats-section">
    <div class="container">
        <div class="stats-grid">

            <div class="stat-card">
                <div class="stat-icon-box bg-light-blue">
                    <span style="font-size: 30px;">👥</span>
                </div>
                <span class="stat-number">5,000+</span>
                <span class="stat-label">Students Enrolled</span>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-orange">
                    <span style="font-size: 30px;">🏅</span>
                </div>
                <span class="stat-number">120+</span>
                <span class="stat-label">Gold Medalists</span>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-green">
                    <span style="font-size: 30px;">🎓</span>
                </div>
                <span class="stat-number">98%</span>
                <span class="stat-label">Success Rate</span>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-solid-purple">
                    <span style="font-size: 30px;">⭐</span>
                </div>
                <span class="stat-number">12+</span>
                <span class="stat-label">Years of Excellence</span>
            </div>

        </div>
    </div>
</div>
    <section class="empower-section">
    <div class="container empower-container">
        
        <div class="empower-left">
            <h2 class="empower-title">
                Empowering the<br />
                <span>Next Generation</span> of<br />
                Leaders
            </h2>

            <div class="feature-list">
                <div class="feature-item">
                    <div class="feature-icon-circle">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="feature-text">
                        <h5 style="font-weight:600; margin-bottom:4px;">Expert Faculty</h5>
                        <p style="color:#64748b; font-size:14px;">Decades of combined teaching experience from top academic backgrounds.</p>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="feature-icon-circle">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="feature-text">
                        <h5 style="font-weight:600; margin-bottom:4px;">Modern Facilities</h5>
                        <p style="color:#64748b; font-size:14px;">Equipped with high-tech labs and expansive libraries for all subjects.</p>
                    </div>
                </div>

                <div class="feature-item">
                    <div class="feature-icon-circle">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="feature-text">
                        <h5 style="font-weight:600; margin-bottom:4px;">Personalized Care</h5>
                        <p style="color:#64748b; font-size:14px;">Small batch sizes to ensure every student gets individual attention.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="empower-right">
            
            <div class="grid-col-1">
                <img src="Uploads/HeroBanners/g1.jpeg" class="grid-img" style="height: 260px; " alt="Faculty" />
                
                <div class="ui-card card-white">
                    <span class="icon">📖</span>
                    <h5>Focus on Concepts</h5>
                </div>
            </div>

            <div class="grid-col-2">
                <div class="ui-card card-dark">
                    <span class="icon" style="color: #818cf8;">✦</span>
                    <h5>Daily Assessments</h5>
                    <p>Track progress every single day.</p>
                </div>

                <img src="Uploads/HeroBanners/g2.jpeg"  class="grid-img" style="height: 320px;" alt="Students" />
            </div>

        </div>

    </div>
</section>
    <section class="testimonials-section">
    <div class="container">
        <%--<div class="section-header">
            <h2>Trusted by 1000+ Parents</h2>
            <p>Hear what they say about their child's journey with us.</p>
        </div>

        <div class="testimonial-grid">
            <div class="testimonial-card">
                <div class="stars">★★★★★</div>
                <div class="quote-icon">”</div>
                <p class="testimonial-text">"The growth I've seen in my daughter's confidence and problem-solving skills is truly remarkable. The teachers are mentors."</p>
                <div class="testimonial-footer">
                    <div class="user-avatar">👤</div>
                    <div class="user-info">
                        <h5>Mrs. Anjali Sharma</h5>
                        <span>Parent of Grade 10 Topper</span>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <div class="stars">★★★★★</div>
                <div class="quote-icon">”</div>
                <p class="testimonial-text">"Structured curriculum and consistent feedback helped my son secure a top rank. The focus on basics is what makes them different."</p>
                <div class="testimonial-footer">
                    <div class="user-avatar">👤</div>
                    <div class="user-info">
                        <h5>Mr. Rajive Gupta</h5>
                        <span>IIT Aspirant Parent</span>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <div class="stars">★★★★★</div>
                <div class="quote-icon">”</div>
                <p class="testimonial-text">"The daily updates in the gallery keep us connected to the institute. Highly professional and result-oriented approach."</p>
                <div class="testimonial-footer">
                    <div class="user-avatar">👤</div>
                    <div class="user-info">
                        <h5>Dr. Sunita Varma</h5>
                        <span>Medical Parent</span>
                    </div>
                </div>
            </div>
        </div>--%>

        <div class="cta-banner">
            <h2>Ready to start your<br /><span>Success Story?</span></h2>
            <p>Join Elite Institute today and take the first step towards your dream career with expert guidance and a community that cares.</p>
            <div class="cta-buttons">
                <a href="CareerGuidance.aspx" class="btn-white">Enroll Now ↗</a>
               
            </div>
        </div>
    </div>
</section>
</asp:Content>
