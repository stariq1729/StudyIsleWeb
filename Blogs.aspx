<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Blogs.aspx.cs" Inherits="StudyIsleWeb.Blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<section class="blogs-wrapper">

    <div class="container">

        <!-- HERO -->
        <div class="blogs-hero text-center">
            <h1 class="hero-title">Student Success Hub</h1>

            <p class="hero-subtitle">
                High-impact strategies, resources, and expert tips to ace
                <span>CBSE</span>, <span>JEE</span>, and
                <span>NEET</span> exams.
            </p>

            <!-- FILTER TABS -->
            <div class="filter-tabs">
                <button class="tab-btn active">Latest Updates</button>
                <button class="tab-btn">JEE Main & Advanced</button>
                <button class="tab-btn">NEET UG</button>
                <button class="tab-btn">CBSE Boards</button>
                <button class="tab-btn">Study Strategy</button>
            </div>
        </div>

        <hr class="section-divider" />

 <!-- BLOG GRID -->
<div class="row g-4">

    <%-- ===== ROW 1 ===== --%>

    <div class="col-lg-4 col-md-6">
        <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1503676260728-1c00da094a0b" />
                <span class="category-badge">JEE</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=3" class="author-avatar" />
                        <span class="author-name">Dr. Anand Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 18, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">
                    JEE Main 2025: 6-Month Roadmap to 99+ Percentile
                </h3>
                <p class="blog-excerpt">
                    A strategic approach to Physics, Chemistry, and Mathematics for top scores.
                </p>
                <div class="blog-footer">
                    <span class="read-time">10 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- ===== ROW 1 - CARD 2 ===== --%>

    <div class="col-lg-4 col-md-6">
        <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1581090700227-4c4f50c90c1b" />
                <span class="category-badge">NEET</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=5" class="author-avatar" />
                        <span class="author-name">Meera Sharma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 16, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">
                    Mastering NEET Biology: Top 10 Diagrams
                </h3>
                <p class="blog-excerpt">
                    Important NCERT diagrams that can boost your NEET score significantly.
                </p>
                <div class="blog-footer">
                    <span class="read-time">7 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- ===== ROW 1 - CARD 3 ===== --%>

    <div class="col-lg-4 col-md-6">
        <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1588072432836-e10032774350" />
                <span class="category-badge">CBSE</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=8" class="author-avatar" />
                        <span class="author-name">Rahul Kapoor</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 14, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">
                    How to Score 100/100 in CBSE Maths
                </h3>
                <p class="blog-excerpt">
                    Smart presentation techniques and preparation strategy for board exams.
                </p>
                <div class="blog-footer">
                    <span class="read-time">8 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- ===== ROW 2 ===== --%>

    <!-- Just duplicate same structure 6 more times with different content -->

    <div class="col-lg-4 col-md-6">
        <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1492724441997-5dc865305da7" />
                <span class="category-badge">Strategy</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=12" class="author-avatar" />
                        <span class="author-name">Anjali Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 12, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">Daily Study Routine for Toppers</h3>
                <p class="blog-excerpt">A practical daily study timetable used by rank holders.</p>
                <div class="blog-footer">
                    <span class="read-time">6 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Duplicate 4 more similar cards -->
    
    <!-- Card 5 -->
    <div class="col-lg-4 col-md-6"> 
        <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1492724441997-5dc865305da7" />
                <span class="category-badge">Strategy</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=12" class="author-avatar" />
                        <span class="author-name">Anjali Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 12, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">Daily Study Routine for Toppers</h3>
                <p class="blog-excerpt">A practical daily study timetable used by rank holders.</p>
                <div class="blog-footer">
                    <span class="read-time">6 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div> </div>

    <!-- Card 6 -->
    <div class="col-lg-4 col-md-6">
                <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1492724441997-5dc865305da7" />
                <span class="category-badge">Strategy</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=12" class="author-avatar" />
                        <span class="author-name">Anjali Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 12, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">Daily Study Routine for Toppers</h3>
                <p class="blog-excerpt">A practical daily study timetable used by rank holders.</p>
                <div class="blog-footer">
                    <span class="read-time">6 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Card 7 -->
    <div class="col-lg-4 col-md-6">
                <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1492724441997-5dc865305da7" />
                <span class="category-badge">Strategy</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=12" class="author-avatar" />
                        <span class="author-name">Anjali Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 12, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">Daily Study Routine for Toppers</h3>
                <p class="blog-excerpt">A practical daily study timetable used by rank holders.</p>
                <div class="blog-footer">
                    <span class="read-time">6 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Card 8 -->
    <div class="col-lg-4 col-md-6">
                <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1492724441997-5dc8675305da7" />
                <span class="category-badge">Strategy</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=12" class="author-avatar" />
                        <span class="author-name">Anjali Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 12, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">Daily Study Routine for Toppers</h3>
                <p class="blog-excerpt">A practical daily study timetable used by rank holders.</p>
                <div class="blog-footer">
                    <span class="read-time">6 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Card 9 -->
    <div class="col-lg-4 col-md-6">
                <div class="blog-card">
            <div class="blog-img">
                <img src="https://images.unsplash.com/photo-1492724441997-5dc865305da7" />
                <span class="category-badge">Strategy</span>
            </div>
            <div class="blog-body">
                <div class="author-row">
                    <div class="author-info">
                        <img src="https://i.pravatar.cc/40?img=12" class="author-avatar" />
                        <span class="author-name">Anjali Verma</span>
                        <span class="dot">•</span>
                        <span class="post-date">Feb 12, 2025</span>
                    </div>
                </div>
                <h3 class="blog-title">Daily Study Routine for Toppers</h3>
                <p class="blog-excerpt">A practical daily study timetable used by rank holders.</p>
                <div class="blog-footer">
                    <span class="read-time">6 min read</span>
                    <div class="action-icons">
                        <i class="bi bi-bookmark"></i>
                        <i class="bi bi-share"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>



        <!-- PAGINATION -->
        <div class="pagination-wrapper">
            <button class="page-btn disabled">Previous</button>
            <button class="page-number active">1</button>
            <button class="page-number">2</button>
            <button class="page-number">3</button>
            <button class="page-btn">Next</button>
        </div>

    </div>

</section>

</asp:Content>
