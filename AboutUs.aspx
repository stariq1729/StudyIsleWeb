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
</asp:Content>