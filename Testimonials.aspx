<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Testimonials.aspx.cs" Inherits="StudyIsleWeb.Testimonials" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
    --primary-purple: #635bff;
    --light-purple: #f0efff;
    --text-dark: #1a1f36;
    --text-muted: #4f566b;
}

.testimonial-hero {
    padding: 40px 0;
    text-align: center;
    background-color: #f8f9fb;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Badge */
.badge-container {
    margin-bottom: 20px;
}
.status-badge {
    background-color: var(--light-purple);
    color: var(--primary-purple);
    padding: 8px 16px;
    border-radius: 50px;
    font-size: 10px;
    font-weight: 500;
}

/* Typography */
.hero-title {
    font-size: 2.2rem;
    font-weight: 700;
    color: var(--text-dark);
    line-height: 1.1;
    margin-bottom: 18px;
}
.highlight-text {
    color: var(--primary-purple);
}
.hero-description {
    max-width: 600px;
    margin: 0 auto 30px;
    color: var(--text-muted);
    font-size: 1rem;
    line-height: 1.2;
}

/* Buttons */
.hero-btns {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 40px;
}
.btn-primary-pill {
    background-color: var(--primary-purple);
    color: white;
    padding: 12px 24px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 400;
    transition: 0.3s;
}
.btn-primary-pill:hover {
    background-color: #4e45e4;
    color: white;
    transform: translateY(-2px);
}
.btn-outline-pill {
    background-color: white;
    color: var(--text-muted);
    padding: 12px 24px;
    border-radius: 50px;
    border: 1px solid #e3e8ee;
    text-decoration: none;
    font-weight: 400;
    transition: 0.3s;
}
.btn-outline-pill:hover {
    background-color: #f7fafc;
    transform: translateY(-2px);
}

/* Stats Section */
.stats-row {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 30px;
    margin-top: 16px;
}
.stat-item {
    display: flex;
    align-items: center;
    gap: 10px;
}
.stat-icon {
    width: 40px;
    height: 40px;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--primary-purple);
    font-size: 1rem;
}
.stat-text {
    text-align: left;
}
.stat-number {
    display: block;
    font-weight: 700;
    color: var(--text-dark);
    font-size: 1rem;
}
.stat-label {
    display: block;
    font-size: 0.75rem;
    color: #a3acb9;
    letter-spacing: 1px;
    font-weight: 500;
}

/* Responsive */
@media (max-width: 768px) {
    .hero-title { font-size: 2.5rem; }
    .stats-row { flex-direction: column; align-items: center; gap: 25px; }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="testimonial-hero">
    <div class="container">
        <!-- Top Badge -->
        <div class="badge-container">
            <span class="status-badge">10,000+ Students Transformed</span>
        </div>

        <!-- Main Heading -->
        <h1 class="hero-title">
            Real Stories,<br />
            <span class="highlight-text">Exceptional Results.</span>
        </h1>

        <!-- Subheading -->
        <p class="hero-description">
            Hear from the global community of learners who have accelerated their careers 
            with StudyIsle's industry-led curriculum.
        </p>

        <!-- CTA Buttons -->
        <div class="hero-btns">
            <a href="#" class="btn btn-primary-pill">Start Your Journey <i class="fas fa-chevron-right"></i></a>
            <a href="#" class="btn btn-outline-pill">View Case Studies</a>
        </div>

        <!-- Statistics Row -->
        <div class="stats-row">
            <div class="stat-item">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-text">
                    <span class="stat-number">150+ Countries</span>
                    <span class="stat-label">LEARNERS</span>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon"><i class="far fa-star"></i></div>
                <div class="stat-text">
                    <span class="stat-number">4.9 / 5.0</span>
                    <span class="stat-label">RATING</span>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon"><i class="fas fa-award"></i></div>
                <div class="stat-text">
                    <span class="stat-number">200+ Global</span>
                    <span class="stat-label">PARTNERS</span>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon"><i class="fas fa-book-open"></i></div>
                <div class="stat-text">
                    <span class="stat-number">1,200+</span>
                    <span class="stat-label">COURSES</span>
                </div>
            </div>
        </div>
    </div>
</section>
</asp:Content>
