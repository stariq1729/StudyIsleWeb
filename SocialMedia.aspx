<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SocialMedia.aspx.cs" Inherits="StudyIsleWeb.SocialMedia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*hero section*/
        .hero {
    padding: 80px 0;
    background: #f9fafc;
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
</asp:Content>
