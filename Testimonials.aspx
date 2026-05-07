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
    padding: 10px 20px;   /* reduced size */
    border-radius: 50px;
    text-decoration: none;
    font-weight: 400;
    font-size: 15px;     /* smaller text */
    line-height: 1.2;
    transition: 0.3s;
}

.btn-outline-pill {
    background-color: white;
    color: var(--text-muted);
    padding: 10px 20px;   /* reduced size */
    border-radius: 50px;
    border: 1px solid #e3e8ee;
    text-decoration: none;
    font-weight: 400;
    font-size: 15px;     /* smaller text */
    line-height: 1.2;
    transition: 0.3s;
}
.btn-primary-pill:hover {
    background-color: #4e45e4;
    color: white;
    transform: translateY(-2px);
}
/*.btn-outline-pill {
    background-color: white;
    color: var(--text-muted);
    padding: 12px 24px;
    border-radius: 50px;
    border: 1px solid #e3e8ee;
    text-decoration: none;
    font-weight: 400;
    transition: 0.3s;
}*/
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

 /* voice section*/

.voices-section { padding: 60px 0; background-color: #fcfcfd; }

.section-header-centered { text-align: center; margin-bottom: 50px; }
.title-underline { 
    width: 50px; height: 3px; background: #635bff; 
    margin: 10px auto; border-radius: 2px; 
}

/* The Masonry Magic */
.masonry-wrapper {
    column-count: 3; /* 3 columns on desktop */
    column-gap: 20px;
    width: 100%;
}

.testimonial-card {
    background: #fff;
    border: 1px solid #e3e8ee;
    border-radius: 16px;
    padding: 20px;
    margin-bottom: 20px; /* Space between stacked cards */
    display: inline-block; /* Essential for column layout */
    width: 100%;
    box-sizing: border-box;
    transition: 0.3s ease;
}

.testimonial-card:hover { transform: translateY(-5px); border-color: #635bff; }

/* Card Components */
.card-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 15px; }
.user-profile { display: flex; align-items: center; gap: 10px; }
.avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
.user-name { display: block; font-weight: 700; font-size: 14px; color: #1a1f36; }
.user-label { font-size: 11px; color: #697386; }
.rating-stars { color: #635bff; font-size: 12px; }

.card-img { 
    width: 100%; border-radius: 12px; margin-bottom: 15px; 
    object-fit: cover; display: block; 
}

.card-quote { 
    font-size: 14px; line-height: 1.6; color: #4f566b; 
    font-style: italic; margin: 0; 
}

/* Responsive Columns */
@media (max-width: 992px) { .masonry-wrapper { column-count: 2; } }
@media (max-width: 600px) { .masonry-wrapper { column-count: 1; } }

.cta-wrapper {
    padding: 20px 0;
    background-color: #fcfcfd; /* Matches the previous section background */
}

.cta-card {
    background-color: #635bff;
    border-radius: 24px;
    padding: 40px 14px;
    position: relative; /* Essential for the circles */
    overflow: hidden; /* Clips the circles at the border */
    text-align: center;
    box-shadow: 0 16px 32px rgba(99, 91, 255, 0.2);
}

.cta-content {
    position: relative;
    z-index: 2; /* Keeps text above circles */
}

.cta-heading {
    color: #ffffff;
    font-size: 1.6rem;
    font-weight: 700;
    margin-bottom: 14px;
}

.cta-subtext {
    color: rgba(255, 255, 255, 0.9);
    max-width: 600px;
    margin: 0 auto 39px;
    font-size: 0.9rem;
    line-height: 1.1;
}

/* Button Group */
.cta-buttons {
    display: flex;
    justify-content: center;
    gap: 12px;
    flex-wrap: wrap;
}

.btn-white-pill {
    background-color: #ffffff;
    color: #635bff;
    padding: 12px 28px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: 12px;
    transition: 0.3s ease;
}

.btn-white-pill:hover {
    background-color: #f0efff;
    transform: scale(1.05);
}

.btn-dark-pill {
    background-color: #4e45e4; /* Slightly darker than the main purple */
    color: #ffffff;
    padding: 12px 28px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: 12px;
    transition: 0.3s ease;
}

.btn-dark-pill:hover {
    background-color: #4138d6;
    transform: scale(1.05);
}

/* Decorative Circles */
.circle {
    position: absolute;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
}

.circle-top-right {
    width: 160px;
    height: 160px;
    top: -50px;
    right: -50px;
}

.circle-bottom-left {
    width: 200px;
    height: 200px;
    bottom: -70px;
    left: -70px;
}

/* Mobile Adjustments */
@media (max-width: 768px) {
    .cta-heading { font-size: 1.8rem; }
    .cta-card { padding: 40px 15px; }
    .cta-buttons { flex-direction: column; align-items: center; }
    .btn-white-pill, .btn-dark-pill { width: 80%; }
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
    <section class="voices-section">
    <div class="container">
        <div class="section-header-centered">
            <h2 class="section-title">Voices of Success</h2>
            <div class="title-underline"></div>
        </div>

        <div class="masonry-wrapper">
            <!-- Card 1: Image + Text -->
            <div class="testimonial-card">
                <div class="card-header">
                    <div class="user-profile">
                        
                        <img src="\assets\tutorimg\Pranav.jpg" alt="David" class="avatar">
                        <div class="user-meta">
                            <span class="user-name">David Chen</span>
                            <span class="user-label">Full Stack Graduate</span>
                        </div>
                    </div>
                    <div class="rating-stars">★★★★★</div>
                </div>
                <img src="\assets\tutorimg\Pranav.jpg" class="card-img" alt="Project">
                <p class="card-quote">"The practical projects are what sets this course apart. You build real-world applications that employers actually care about."</p>
            </div>

            <!-- Card 2: Text Only -->
            <div class="testimonial-card">
                <div class="card-header">
                    <div class="user-profile">
                        <img src="\assets\tutorimg\Pranav.jpg" alt="Elena" class="avatar">
                        <div class="user-meta">
                            <span class="user-name">Elena Rodriguez</span>
                            <span class="user-label">Data Science Enthusiast</span>
                        </div>
                    </div>
                    <div class="rating-stars">★★★★☆</div>
                </div>
                <p class="card-quote">"I never thought I could understand complex algorithms, but the breakdown of concepts here is so intuitive. Efficient and engaging learning."</p>
            </div>

            <!-- Card 3: Image + Text -->
            <div class="testimonial-card">
                <div class="card-header">
                    <div class="user-profile">
                        <img src="\assets\tutorimg\Pranav.jpg" alt="Maria" class="avatar">
                        <div class="user-meta">
                            <span class="user-name">Maria Garcia</span>
                            <span class="user-label">Marketing Specialist</span>
                        </div>
                    </div>
                    <div class="rating-stars">★★★★★</div>
                </div>
                <img src="\assets\tutorimg\Pranav.jpg" class="card-img" alt="Landscape">
                <p class="card-quote">"The curriculum is always up to date with industry trends. I improved my ROI by 40% after implementing what I learned."</p>
            </div>

            <!-- Card 4: Text Only -->
            <div class="testimonial-card">
                <div class="card-header">
                    <div class="user-profile">
                        <img src="\assets\tutorimg\Pranav.jpg" alt="Kevin" class="avatar">
                        <div class="user-meta">
                            <span class="user-name">Kevin Park</span>
                            <span class="user-label">Cloud Architect</span>
                        </div>
                    </div>
                    <div class="rating-stars">★★★★★</div>
                </div>
                <p class="card-quote">"The certification prep matches the official exams perfectly. Passed on my first try thanks to the practice modules."</p>
            </div>
        </div>
    </div>
</section>
    <section class="cta-wrapper">
    <div class="container">
        <div class="cta-card">
            <!-- Decorative Background Circles -->
            <div class="circle circle-top-right"></div>
            <div class="circle circle-bottom-left"></div>

            <div class="cta-content">
                <h2 class="cta-heading">Ready to write your story?</h2>
                <p class="cta-subtext">
                    Join 10,000+ ambitious learners. Get unlimited access to top-tier courses and a supporting community.
                </p>
                <div class="cta-buttons">
                    <a href="#" class="btn-white-pill">Join StudyIsle Free</a>
                    <a href="#" class="btn-dark-pill">Talk to an Advisor</a>
                </div>
            </div>
        </div>
    </div>
</section>
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
