<%@ Page Title="About Us - StudyIsle" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="StudyIsleWeb.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    /* Main Section Container */
    .about-hero-section {
        background-color: #0a0b1e; 
        padding: 80px 20px;
        text-align: center;
        color: #ffffff;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 80vh;
    }

    .location-badge {
        background: rgba(100, 108, 255, 0.1);
        border: 1px solid rgba(100, 108, 255, 0.3);
        color: #7c83ff;
        padding: 6px 16px;
        border-radius: 50px;
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        display: inline-block;
        margin-bottom: 30px;
    }

    .hero-title {
        color: #ffffff;
        font-size: 4rem;
        font-weight: 700;
        line-height: 1.1;
        max-width: 900px;
        margin: 0 auto 25px auto;
    }

    .hero-title span.italic-blue { color: #7c83ff; font-style: italic; }
    .hero-title span.underline { text-decoration: underline; text-underline-offset: 8px; }

    .hero-description {
        color: #a0a0c0;
        font-size: 1.1rem;
        max-width: 600px;
        margin: 0 auto 60px auto;
    }

    /* FIX: Stats Grid Centering */
    .stats-container {
        display: flex;
        justify-content: center; /* This keeps cards in the middle */
        align-items: stretch;
        gap: 20px;
        flex-wrap: wrap;
        max-width: 1200px;
        margin: 0 auto;
        user-select: none;
        -webkit-tap-highlight-color: transparent;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        padding: 40px 20px;
        width: 260px; /* Fixed width prevents them from moving to the side */
        transition: transform 0.3s ease, border-color 0.3s ease;
        outline: none;
    }

    /* FIX: No Brightening on Click */
    .stat-card:hover {
        transform: translateY(-5px);
        border-color: rgba(124, 131, 255, 0.5);
    }

    .stat-card:active {
        background: rgba(255, 255, 255, 0.03) !important; /* Forces original color */
        transform: translateY(-2px);
    }

    .stat-icon {
        background: rgba(124, 131, 255, 0.1);
        color: #7c83ff;
        width: 45px;
        height: 45px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px auto;
    }

    .stat-number { font-size: 2.2rem; font-weight: 700; display: block; margin-bottom: 5px; }
    .stat-label { color: #717191; font-size: 0.75rem; text-transform: uppercase; font-weight: 600; }


    /* Story & Features Section second section start from here */
.story-section {
    padding: 100px 5%;
    background-color: #ffffff;
    display: flex;
    justify-content: center;
    gap: 40px;
    flex-wrap: wrap;
    color: #333;
    text-align: left;
}

.content-left { flex: 1; min-width: 300px; max-width: 600px; }
.content-right { flex: 1; min-width: 350px; max-width: 500px; }

.who-we-are-badge {
    background: #f0f2ff;
    color: #646cff;
    padding: 4px 12px;
    border-radius: 4px;
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    display: inline-block;
    margin-bottom: 20px;
}

.story-title { font-size: 2.2rem; font-weight: 700; line-height: 1.1; margin-bottom: 20px; color: #0a0b1e; }
.story-title span.italic-blue { color: #646cff; font-style: italic; }
.story-description { color: #666; font-size: 1.1rem; line-height: 1.1; margin-bottom: 16px; }

/* Features Hover Cards */
.feature-card-mini {
    display: flex;
    align-items: center;
    gap: 12px;
    background: #f8f9fa;
    border: 1px solid #eee;
    border-radius: 12px;
    padding: 15px 20px;
    margin-bottom: 14px;
    transition: all 0.3s ease;
    cursor: pointer;
    width: 90%;
}

.feature-card-mini .f-icon {
    font-size: 1.5rem;
    filter: grayscale(100%); /* Default is gray */
    opacity: 0.5;
    transition: all 0.3s ease;
}

.feature-card-mini h4 { font-size: 0.95rem; margin: 0; color: #555; transition: color 0.3s ease; }
.feature-card-mini p { font-size: 0.75rem; margin: 3px 0 0 0; color: #888; }

/* HOVER EFFECT: Become light and colored */
.feature-card-mini:hover {
    background: #ffffff;
    box-shadow: 0 10px 20px rgba(100, 108, 255, 0.1);
    border-color: #646cff;
}
.feature-card-mini:hover .f-icon { filter: grayscale(0%); opacity: 1; }
.feature-card-mini:hover h4 { color: #646cff; }

/* Dark Story Card (Right Side) */
/* Update the section to ensure both sides stretch to the same height */
.story-section {
    padding: 80px 5%;
    background-color: #ffffff;
    display: flex;
    justify-content: center;
    align-items: stretch; /* This makes the dark card match the left height */
    gap: 60px;
    flex-wrap: wrap;
    max-width: 1300px;
    margin: 0 auto;
}

/* Update the dark card for a perfect fit */
.dark-story-card {
    background: #0a0b1e;
    border-radius: 40px;
    padding: 60px; /* Increased padding to match the reference image */
    color: white;
    height: 100%; /* Ensures it fills the stretched container */
    display: flex;
    flex-direction: column;
    justify-content: center; /* Centers the text vertically inside the card */
    box-sizing: border-box;
    box-shadow: 0 30px 60px rgba(0,0,0,0.15);
}
/* Adjust the feature card layout to match the 2-column grid in the image */
.feature-cards-grid {
    display: grid;
    grid-template-columns: 1fr 1fr; /* Two cards side-by-side */
    gap: 20px;
    margin-top: 30px;
}

/* Ensure mini cards take full width of their grid cell */
.feature-card-mini {
    width: 100% !important; 
    margin-bottom: 0 !important;
}

/* Fix for the third card to span two columns if needed, 
   or keep it in the grid as per your preference */
.feature-card-mini:last-child {
    grid-column: 1 / 2; 
}
.founded-badge {
    background: rgba(255,255,255,0.1);
    padding: 5px 12px;
    border-radius: 4px;
    font-size: 9px;
    letter-spacing: 1px;
}

.dark-card-title { font-size: 2.2rem; margin: 20px 0; }
.dark-card-text { font-size: 0.9rem; line-height: 1.7; color: #b0b0d0; }
.dark-card-text b { color: white; border-bottom: 2px solid #646cff; }

.tag-container { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 30px; }
.story-tag {
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    padding: 6px 12px;
    border-radius: 50px;
    font-size: 9px;
    color: #888;
}

/* Third section css */
/* Pillars Section */
.pillars-section {
    padding: 100px 5%;
    background-color: #f8fafc;
    text-align: center;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.offer-badge {
    background: #f0f2ff;
    color: #646cff;
    padding: 4px 14px;
    border-radius: 50px;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    display: inline-block;
    margin-bottom: 20px;
}

.pillars-title {
    font-size: 2.5rem;
    font-weight: 800;
    color: #0a0b1e;
    margin-bottom: 15px;
}

.pillars-subtitle {
    color: #666;
    font-size: 1.1rem;
    margin-bottom: 40px;
}

/* Pillar Card Grid */
.pillars-container {
    display: flex;
    justify-content: center;
    gap: 24px;
    flex-wrap: wrap;
    max-width: 1200px;
    margin: 0 auto;
    user-select: none;
    -webkit-tap-highlight-color: transparent;
}

.pillar-card {
    background: #ffffff;
    border: 1px solid #eef0f7;
    border-radius: 24px;
    padding: 45px 35px;
    flex: 1;
    min-width: 300px;
    max-width: 360px;
    text-align: left;
    transition: all 0.3s ease;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
    cursor: pointer;
    outline: none;
}

.pillar-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 40px rgba(100, 108, 255, 0.1);
    border-color: #646cff;
}

/* FIX: Prevent brightening/flicker on click */
.pillar-card:active {
    background: #ffffff !important; 
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(100, 108, 255, 0.1);
}

.pillar-icon-box {
    width: 40px;
    height: 40px;
    background: #f8faff;
    border: 1px solid #eef0f7;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #646cff;
    font-size: 1.2rem;
    margin-bottom: 20px;
}

.pillar-card h3 {
    font-size: 1.4rem;
    font-weight: 700;
    color: #0a0b1e;
    margin-bottom: 15px;
}

.pillar-card p {
    color: #667;
    font-size: 0.95rem;
    line-height: 1.6;
    margin-bottom: 35px;
}

.learn-more-btn {
    color: #a0a0c0;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: color 0.3s ease;
}

.pillar-card:hover .learn-more-btn {
    color: #646cff;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- Adding FontAwesome for the icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <section class="about-hero-section">
    <div class="location-badge">
        <i class="fa-solid fa-location-dot"></i>&nbsp; EST. 2017 • BHIWADI, RAJASTHAN
    </div>

    <h1 class="hero-title">
        We Started In A <span class="italic-blue">Classroom.</span><br />
        Now We Teach The <span class="underline">World.</span>
    </h1>

    <p class="hero-description">
        StudyIsle began with one goal — to make quality education personal, affordable, and accessible for students globally.
    </p>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-award"></i></div>
            <span class="stat-number">9+</span>
            <span class="stat-label">Years In Education</span>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
            <span class="stat-number">1M+</span>
            <span class="stat-label">Students Reached</span>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-graduation-cap"></i></div>
            <span class="stat-number">3</span>
            <span class="stat-label">Core Services</span>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-globe"></i></div>
            <span class="stat-number">Global</span>
            <span class="stat-label">IB & IGCSE Students</span>
        </div>
    </div>
</section>
    <section class="story-section">
    <!-- Left Content -->
    <div class="content-left">
        <span class="who-we-are-badge">Who We Are</span>
        <h2 class="story-title">Built for <span class="italic-blue">Students.</span><br />Designed Around How They Learn.</h2>
        <p class="story-description">
            StudyIsle is an online and offline education platform founded in 2017 in Bhiwadi, Rajasthan. 
            We teach students across India and globally — through free study resources, live classes, 
            1-on-1 international board tuition and certified career counselling.
        </p>

        <!-- GRID for Feature Cards -->
        <div class="feature-cards-grid">
            <div class="feature-card-mini">
                <div class="f-icon"><i class="fa-solid fa-puzzle-piece" style="color: #82ca9d;"></i></div>
                <div>
                    <h4>Adaptive Teaching</h4>
                    <p>We teach the way students want to learn.</p>
                </div>
            </div>

            <div class="feature-card-mini">
                <div class="f-icon"><i class="fa-solid fa-language" style="color: #8884d8;"></i></div>
                <div>
                    <h4>Bilingual Delivery</h4>
                    <p>Concepts in Hindi and English.</p>
                </div>
            </div>

            <div class="feature-card-mini">
                <div class="f-icon"><i class="fa-solid fa-chart-line" style="color: #ffc658;"></i></div>
                <div>
                    <h4>Continuous Assessment</h4>
                    <p>Regular evaluations to track progress.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Content (Stretched Dark Card) -->
    <div class="content-right">
        <div class="dark-story-card">
            <span class="founded-badge">FOUNDED 2017</span>
            <h3 class="dark-card-title">Our Story</h3>
            <p class="dark-card-text">
                Two educators — <b>Pranav and Ambar</b> — saw a persistent gap in the system. 
                While content was everywhere, genuine guidance was nowhere.
            </p>
            <p class="dark-card-text">
                StudyIsle was born in a single classroom in Bhiwadi and has since expanded to serve aspirants worldwide, bridging that gap between <i style="color:#646cff">content and clarity.</i>
            </p>
            
            <div class="tag-container">
                <span class="story-tag"><i class="fa-solid fa-circle-nodes"></i> Online & Offline</span>
                <span class="story-tag"><i class="fa-solid fa-book"></i> CBSE • ICSE</span>
                <span class="story-tag"><i class="fa-solid fa-graduation-cap"></i> JEE • NEET</span>
                <span class="story-tag"><i class="fa-solid fa-globe"></i> IB • IGCSE</span>
            </div>
        </div>
    </div>
</section>
    <section class="pillars-section">
    <span class="offer-badge">What We Offer</span>
    <h2 class="pillars-title">Three Core Pillars. All Done Well.</h2>
    <p class="pillars-subtitle">Helping students get the outcome they came for.</p>

    <div class="pillars-container">
        <!-- Pillar 1 -->
        <div class="pillar-card">
            <div class="pillar-icon-box">
                <i class="fa-solid fa-book-open"></i>
            </div>
            <h3>Free Study Material</h3>
            <p>Chapter notes, NCERT solutions, MCQs, past papers and mock tests — free for all boards. Updated for 2024–25.</p>
            <a href="#" class="learn-more-btn">Learn More <i class="fa-solid fa-arrow-right-long"></i></a>
        </div>

        <!-- Pillar 2 -->
        <div class="pillar-card">
            <div class="pillar-icon-box">
                <i class="fa-solid fa-compass"></i>
            </div>
            <h3>Career Counselling</h3>
            <p>Certified psychometric-based career guidance for students from Class 9 to graduates. Stream, college and career path clarity in one session.</p>
            <a href="#" class="learn-more-btn">Learn More <i class="fa-solid fa-arrow-right-long"></i></a>
        </div>

        <!-- Pillar 3 -->
        <div class="pillar-card">
            <div class="pillar-icon-box">
                <i class="fa-solid fa-globe"></i>
            </div>
            <h3>IB & IGCSE Online Tuition</h3>
            <p>Personalised 1-on-1 sessions for IB Diploma, IGCSE, A-Level and AP students. IA, EE and TOK support included.</p>
            <a href="#" class="learn-more-btn">Learn More <i class="fa-solid fa-arrow-right-long"></i></a>
        </div>
    </div>
</section>
</asp:Content>