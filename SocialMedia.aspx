<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SocialMedia.aspx.cs" Inherits="StudyIsleWeb.SocialMedia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*hero section*/
        .hero {
    padding: 80px 0;
    background: #eef2ff;
    font-family: 'Segoe UI', sans-serif;
}

.hero-container {
    max-width: 1200px;
    margin: auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 40px;
}

/* LEFT CONTENT */
.hero-content {
    flex: 1;
}

.hero-tag {
    display: inline-block;
    background: #eef2ff;
    color: #4f46e5;
    font-size: 12px;
    padding: 6px 14px;
    border-radius: 20px;
    font-weight: 600;
    margin-bottom: 20px;
    letter-spacing: 0.5px;
}

.hero h1 {
    font-size: 48px;
    font-weight: 700;
    color: #0f172a;
    line-height: 1.2;
    margin-bottom: 20px;
}

.hero .highlight {
    color: #4f46e5;
}

.hero p {
    font-size: 16px;
    color: #475569;
    margin-bottom: 30px;
    line-height: 1.6;
}

/* BUTTONS */
.hero-buttons {
    display: flex;
    gap: 15px;
}

.btn {
    padding: 12px 22px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.3s;
}

.btn.primary {
    background: #4f46e5;
    color: #fff;
}

.btn.primary:hover {
    background: #4338ca;
}

.btn.secondary {
    border: 1px solid #d1d5db;
    color: #0f172a;
    background: #fff;
}

.btn.secondary:hover {
    background: #f1f5f9;
}

/* RIGHT IMAGE */
.hero-image {
    flex: 1;
    display: flex;
    justify-content: center;
}

.image-placeholder {
    width: 100%;
    max-width: 450px;
    height: 300px;
    background: #e5e7eb;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #6b7280;
    font-weight: 500;
}


/* RESPONSIVE */
@media (max-width: 900px) {
    .hero-container {
        flex-direction: column;
        text-align: center;
    }

    .hero-buttons {
        justify-content: center;
    }

    .hero h1 {
        font-size: 36px;
    }
}
/*   social sectiopn*/
.social-section {
    padding: 40px 0;
    background: #f9fafc;
    text-align: center;
    font-family: 'Segoe UI', sans-serif;
}

/* HEADER */
.social-header h2 {
    font-size: 32px;
    font-weight: 700;
    color: #0f172a;
}

.social-header p {
    max-width: 700px;
    margin: 10px auto 40px;
    color: #64748b;
    font-size: 14px;
}

/* CARDS */
.social-cards {
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
    margin-bottom: 60px;
}

.social-card {
    width: 180px;
    background: #fff;
    padding: 25px 15px;
    border-radius: 14px;
    text-decoration: none;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    transition: 0.3s ease;
    color: #0f172a;
}

.social-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

/* ICON */
.social-card .icon {
    width: 50px;
    height: 50px;
    margin: 0 auto 15px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    color: #fff;
}

/* PLATFORM COLORS */
.instagram .icon { background: #e1306c; }
.linkedin .icon { background: #0077b5; }
.twitter .icon { background: #1da1f2; }
.youtube .icon { background: #ff0000; }
.facebook .icon { background: #1877f2; }

/* TEXT */
.social-card h4 {
    font-size: 16px;
    margin-bottom: 5px;
}

.social-card span {
    font-size: 13px;
    color: #64748b;
}

/* WHY FOLLOW */
.why-follow h3 {
    font-size: 22px;
    margin-bottom: 30px;
    color: #0f172a;
}

.why-grid {
    display: flex;
    justify-content: center;
    gap: 40px;
    flex-wrap: wrap;
}

.why-item {
    max-width: 250px;
}

.why-item h4 {
    font-size: 15px;
    color: #4f46e5;
    margin-bottom: 10px;
}

.why-item p {
    font-size: 13px;
    color: #64748b;
    line-height: 1.6;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .social-cards {
        gap: 15px;
    }

    .why-grid {
        gap: 20px;
    }
}

/*last secton c*/
.contact-section {
    padding: 60px 0;
    background: #F5F5F5;
    text-align: center;
    font-family: 'Segoe UI', sans-serif;
}

/* HEADER */
.contact-header h2 {
    font-size: 32px;
    font-weight: 700;
    color: #0f172a;
}

.contact-header p {
    max-width: 650px;
    margin: 10px auto 50px;
    color: #64748b;
    font-size: 14px;
}

/* CARDS */
.contact-cards {
    display: flex;
    justify-content: center;
    gap: 30px;
    flex-wrap: wrap;
    margin-bottom: 50px;
}

.contact-card {
    width: 280px;
    background: #fff;
    padding: 35px 20px;
    border-radius: 18px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.06);
    transition: 0.3s ease;
}

.contact-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 28px rgba(0,0,0,0.1);
}

/* ICON */
.icon-box {
    width: 55px;
    height: 55px;
    margin: 0 auto 20px;
    border-radius: 14px;
    background: #eef2ff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    color: #4f46e5;
}

/* TEXT */
.contact-card h4 {
    font-size: 16px;
    margin-bottom: 8px;
    color: #0f172a;
}

.contact-card a {
    display: block;
    font-size: 14px;
    color: #4f46e5;
    margin-bottom: 6px;
    text-decoration: none;
    font-weight: 500;
}

.contact-card .location {
    display: block;
    font-size: 14px;
    color: #4f46e5;
    margin-bottom: 6px;
    font-weight: 500;
}

.contact-card p {
    font-size: 13px;
    color: #64748b;
}

/* CTA BUTTON */
.contact-cta {
    margin-top: 10px;
}

.cta-btn {
    display: inline-block;
    padding: 14px 28px;
    background: #4f46e5;
    color: #fff;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    box-shadow: 0 10px 25px rgba(79, 70, 229, 0.3);
    transition: 0.3s;
}

.cta-btn:hover {
    background: #4338ca;
    transform: translateY(-2px);
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .contact-cards {
        gap: 20px;
    }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <%-- Hero Section--%>
    <section class="hero">
    <div class="hero-container">

        <!-- LEFT CONTENT -->
        <div class="hero-content">
            <div class="hero-tag">
                <span>GLOBAL EXCELLENCE IN ONLINE LEARNING</span>
            </div>

            <h1>
                Empower Your Future <br>
                with <span class="highlight">EduStream</span>
            </h1>

            <p>
                Join over 50,000+ students worldwide. Master real-world skills
                with expert-led courses designed for your career success.
            </p>

            <div class="hero-buttons">
                <a href="#" class="btn primary">Explore Courses →</a>
                <a href="#" class="btn secondary">Meet Mentors</a>
            </div>
        </div>

        <!-- RIGHT IMAGE PLACEHOLDER -->
        <div class="hero-image">
            <!-- Add your image here later -->
            <div class="image-placeholder">
                Your Image Here
            </div>
        </div>

    </div>
</section>
   <%-- social media section--%>
    <section class="social-section">

    <!-- HEADING -->
    <div class="social-header">
        <h2>Join Our Growing Community</h2>
        <p>
            "The best way to learn is to learn together." Connect with us across all platforms for daily insights,
            student success stories, and live webinars.
        </p>
    </div>

    <!-- SOCIAL CARDS -->
    <div class="social-cards">

        <a href="#" class="social-card instagram">
            <div class="icon"><i class="fab fa-instagram"></i></div>
            <h4>Instagram</h4>
            <span>12k+ Fellows</span>
        </a>

        <a href="#" class="social-card linkedin">
            <div class="icon"><i class="fab fa-linkedin-in"></i></div>
            <h4>LinkedIn</h4>
            <span>24k+ Fellows</span>
        </a>

        <a href="#" class="social-card twitter">
            <div class="icon"><i class="fab fa-twitter"></i></div>
            <h4>Twitter</h4>
            <span>8k+ Fellows</span>
        </a>

        <a href="#" class="social-card youtube">
            <div class="icon"><i class="fab fa-youtube"></i></div>
            <h4>YouTube</h4>
            <span>45k+ Fellows</span>
        </a>

        <a href="#" class="social-card facebook">
            <div class="icon"><i class="fab fa-facebook-f"></i></div>
            <h4>Facebook</h4>
            <span>15k+ Fellows</span>
        </a>

    </div>

    <!-- WHY FOLLOW -->
    <div class="why-follow">

        <h3>Why Follow EduStream Social Media?</h3>

        <div class="why-grid">

            <div class="why-item">
                <h4>Daily Learning Nuggets</h4>
                <p>
                    Quick, actionable tips delivered to your feed daily. Master coding, design, and business in minutes.
                </p>
            </div>

            <div class="why-item">
                <h4>Live Industry Q&As</h4>
                <p>
                    Direct access to industry leaders through our exclusive LinkedIn and YouTube live sessions.
                </p>
            </div>

            <div class="why-item">
                <h4>Career Opportunities</h4>
                <p>
                    Be the first to hear about internship openings and job placements from our hiring partners.
                </p>
            </div>

        </div>

    </div>

</section>

   <%-- Last section of the page--%>
    <section class="contact-section">

    <!-- HEADER -->
    <div class="contact-header">
        <h2>Let's Talk Education</h2>
        <p>
            Our academic counselors and support specialists are standing by to help you choose
            the right path for your career goals.
        </p>
    </div>

    <!-- CARDS -->
    <div class="contact-cards">

        <!-- EMAIL -->
        <div class="contact-card">
            <div class="icon-box">
                <i class="fas fa-envelope"></i>
            </div>
            <h4>Email Us</h4>
            <a href="mailto:hello@edustream.edu">hello@edustream.edu</a>
            <p>For course inquiries and support</p>
        </div>

        <!-- CALL -->
        <div class="contact-card">
            <div class="icon-box">
                <i class="fas fa-phone"></i>
            </div>
            <h4>Call Support</h4>
            <a href="tel:+1234567890">+1 (234) 567-890</a>
            <p>Mon-Fri from 9am to 6pm</p>
        </div>

        <!-- LOCATION -->
        <div class="contact-card">
            <div class="icon-box">
                <i class="fas fa-map-marker-alt"></i>
            </div>
            <h4>Headquarters</h4>
            <span class="location">San Francisco, CA</span>
            <p>123 Academic Way, Suite 400</p>
        </div>

    </div>

    <!-- CTA BUTTON -->
    <div class="contact-cta">
        <a href="#" class="cta-btn">Book a Free Consultation</a>
    </div>

</section>

<!-- FONT AWESOME -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- FONT AWESOME (for icons) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</asp:Content>
