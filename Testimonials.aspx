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
/* Section Layout */
.stories-section { padding: 50px 0; background: #fff; }
.stories-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 20px; }
.section-title { font-size: 22px; font-weight: 600; margin: 0; color: #1a1f36; }
.section-subtitle { color: #4f566b; margin: 5px 0 0; }
.view-all { color: #635bff; text-decoration: none; font-weight: 600; font-size: 12px; }

/* Grid & Cards */
.stories-grid { display: flex; gap: 20px; overflow-x: auto; padding-bottom: 10px; }
.story-card {
    min-width: 216px;
    height: 360px;
    background: #111; /* Fallback */
    border-radius: 16px;
    position: relative;
    cursor: pointer;
    transition: transform 0.3s ease;
    overflow: hidden;
}
.story-card:hover { transform: translateY(-5px); }

/* Card Content */
.story-overlay {
    position: absolute;
    bottom: 20px;
    left: 15px;
    display: flex;
    align-items: center;
    gap: 10px;
    color: white;
}
.user-avatar-small { width: 32px; height: 32px; border-radius: 50%; border: 2px solid #635bff; }
.user-name { display: block; font-weight: 600; font-size: 13px; }
.user-role { font-size: 11px; opacity: 0.8; }

/* Apply Card */
.apply-card {
    background: white;
    border: 2px dashed #e3e8ee;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
}
.apply-icon { font-size: 24px; color: #e3e8ee; margin-bottom: 10px; }
.apply-link { color: #635bff; font-weight: 700; text-decoration: none; font-size: 14px; }

/* Modal Overlay */
.story-modal {
    display: none;
    position: fixed;
    z-index: 1000;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.9);
    justify-content: center;
    align-items: center;
}
.modal-content {
    width: 350px;
    height: 600px;
    background: #111;
    border-radius: 20px;
    position: relative;
    color: white;
    overflow: hidden;
}
.close-story {
    position: absolute;
    right: 15px; top: 15px;
    font-size: 30px; cursor: pointer; z-index: 10;
}
#storyVideo { width: 100%; height: 100%; object-fit: cover; }

.modal-header {
    position: absolute;
    top: 20px; left: 20px;
    display: flex; align-items: center; gap: 10px;
    z-index: 5;
}
.modal-footer {
    position: absolute;
    bottom: 20px; left: 20px; right: 20px;
    z-index: 5;
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
    <section class="stories-section">
    <div class="container">
        <div class="stories-header">
            <div>
                <h2 class="section-title">Status Stories</h2>
                <p class="section-subtitle">Video updates from our top graduates.</p>
            </div>
            <a href="#" class="view-all">View all</a>
        </div>

        <div class="stories-grid">
            <!-- Video Card 1 -->
            <div class="story-card" onclick="openStory('Sarah Jenkins', 'UX Design Student', 'video1.mp4')">
                <div class="story-overlay">
                    <img src="path/to/sarah-thumb.jpg" alt="Sarah" class="user-avatar-small">
                    <div class="user-info">
                        <span class="user-name">Sarah Jenkins</span>
                        <span class="user-role">UX Design Student</span>
                    </div>
                </div>
            </div>

            <!-- Video Card 2 -->
            <div class="story-card" onclick="openStory('James Wilson', 'Python Developer', 'video2.mp4')">
                <div class="story-overlay">
                    <img src="path/to/james-thumb.jpg" alt="James" class="user-avatar-small">
                    <div class="user-info">
                        <span class="user-name">James Wilson</span>
                        <span class="user-role">Python Developer</span>
                    </div>
                </div>
            </div>

            <!-- Apply Today Card -->
            <div class="story-card apply-card">
                <div class="apply-content">
                    <div class="apply-icon"><i class="fas fa-user-plus"></i></div>
                    <p>Your Turn Next?</p>
                    <a href="#" class="apply-link">Apply Today</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Full Screen Video Modal -->
<div id="storyModal" class="story-modal">
    <div class="modal-content">
        <span class="close-story" onclick="closeStory()">&times;</span>
        <div class="modal-header">
             <img src="" id="modalAvatar" class="user-avatar-small">
             <div class="user-info-modal">
                 <h4 id="modalName" style="margin:0; font-size:14px;"></h4>
                 <p id="modalRole" style="margin:0; font-size:12px; opacity:0.8;"></p>
             </div>
        </div>
        <video id="storyVideo" controls autoplay>
            <source src="" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        <div class="modal-footer">
            <i class="fas fa-quote-left"></i>
            <p id="modalQuote">The mentor support here is unparalleled. I went from knowing nothing to landing a junior role in 6 months.</p>
        </div>
    </div>
</div>
    <script>
        function openStory(name, role, videoSrc) {
            const modal = document.getElementById('storyModal');
            const video = document.getElementById('storyVideo');

            document.getElementById('modalName').innerText = name;
            document.getElementById('modalRole').innerText = role;
            video.src = videoSrc;

            modal.style.display = 'flex';
            video.play();
        }

        function closeStory() {
            const modal = document.getElementById('storyModal');
            const video = document.getElementById('storyVideo');

            modal.style.display = 'none';
            video.pause();
            video.src = "";
        }

        // Close if user clicks outside the card
        window.onclick = function (event) {
            let modal = document.getElementById('storyModal');
            if (event.target == modal) {
                closeStory();
            }
        }
    </script>
</asp:Content>
