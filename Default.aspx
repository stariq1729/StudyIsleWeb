<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StudyIsleWeb.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #eef1ff, #e3e8ff);
            padding: 120px 0 180px 0;
        }

        .hero-title {
            margin-bottom: 24px;
        }

        .hero-subtitle {
            margin-bottom: 30px;
        }



        .hero-title {
            font-size: 56px;
            font-weight: 700;
            line-height: 1.2;
            color: #1d1d1f;
        }

        .hero-subtitle {
            font-size: 18px;
            color: #6c757d;
            max-width: 500px;
        }

        .class-buttons .btn {
            border-radius: 12px;
            padding: 8px 18px;
            font-weight: 500;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            border: none;
            border-radius: 12px;
        }

            .btn-primary:hover {
                opacity: 0.9;
            }


        .class-btn {
            border-radius: 12px;
            padding: 8px 16px;
            font-size: 14px;
            min-width: 95px;
            background: #f3f4f6;
            border: 1px solid #e0e0e0;
            color: #333;
            transition: all 0.2s ease;
        }

            .class-btn:hover {
                background: #e0e7ff;
                border-color: #6366f1;
                color: #4f46e5;
            }

            .class-btn.active {
                background: linear-gradient(135deg, #4f46e5, #6366f1);
                color: #ffffff;
                border: none;
                box-shadow: 0 6px 14px rgba(79,70,229,0.4);
            }




        @media (max-width: 991px) {

            .hero-section {
                padding: 80px 0 100px 0;
                text-align: center;
            }

            .hero-image-wrapper {
                margin: 40px auto 0 auto;
            }

            .floating-badge,
            .rank-card {
                position: static;
                margin-top: 15px;
            }

            .rank-card {
                width: 100%;
            }

            .image-container img {
                height: auto;
            }

            .class-card {
                margin: 0 auto;
            }
        }

        @media (min-width: 992px) {
            .hero-section .col-lg-6:first-child {
                padding-right: 30px;
            }

            .hero-section .col-lg-6:last-child {
                padding-left: 10px;
            }
        }


        @media (max-width: 768px) {
            .hero-title {
                font-size: 36px;
            }

            .hero-section {
                padding: 60px 0;
            }
        }

        .class-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.05);
            max-width: 490px;
        }


            .class-card .btn {
                border-radius: 12px;
                padding: 8px 16px;
                font-size: 14px;
                min-width: 95px;
            }


            .class-card .btn-primary {
                margin-top: 10px;
            }

        .floating-badge {
            position: absolute;
            top: 20px;
            left: -25px;
            background: #ffffff;
            padding: 12px 18px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
            z-index: 2;
        }


        .badge-icon {
            background: #eef1ff;
            padding: 8px;
            border-radius: 50%;
        }

        .hero-image-wrapper {
            position: relative;
            max-width: 520px;
            margin-left: auto;
        }

        .image-card {
            background: #ffffff;
            border-radius: 26px;
            overflow: hidden;
            box-shadow: 0 30px 60px rgba(0,0,0,0.08);
            border: 1px solid rgba(0,0,0,0.05);
        }


        .image-inner {
            padding: 14px 14px 0 16px;
        }


            .image-inner img {
                width: 100%;
                height: 320px;
                object-fit: cover;
                border-radius: 18px;
                display: block;
            }

        .masterclass-section {
            padding: 18px 20px 20px 20px;
            background: #ffffff;
            text-align: left;
        }



        .image-container {
            line-height: 0; /* removes image bottom gap */
        }

            .image-container img {
                width: 100%;
                height: 340px;
                object-fit: cover;
                display: block;
            }

        .masterclass-section {
            padding: 18px 20px;
            text-align: left;
        }


        .rank-card {
            position: absolute;
            bottom: -20px;
            right: -15px;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: #ffffff;
            padding: 18px;
            border-radius: 18px;
            width: 210px;
            z-index: 3;
            box-shadow: 0 20px 40px rgba(79,70,229,0.4);
        }


        .progress-line {
            height: 4px;
            background: rgba(255,255,255,0.6);
            border-radius: 4px;
            margin-top: 10px;
        }

       /* till here hero section styles*/

       .achievement-strip {
    background: linear-gradient(135deg, #4f46e5, #6366f1);
    color: #ffffff;
    overflow: hidden;
    white-space: nowrap;
    padding: 12px 0;
}

.strip-content {
    display: inline-block;
    animation: scrollStrip 25s linear infinite;
}

.strip-content span {
    margin: 0 40px;
    font-weight: 500;
}

@keyframes scrollStrip {
    from {
        transform: translateX(0);
    }
    to {
        transform: translateX(-50%);
    }
}
/*css form second section*/
.interactive-image-wrapper {
    padding: 18px;
    border-radius: 32px;
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(99,102,241,0.18);
    box-shadow: 0 40px 80px rgba(0,0,0,0.6);
}

.interactive-image-card {
    border-radius: 22px;
    overflow: hidden;
}

.interactive-image-card img {
    width: 100%;
    height: 420px;
    object-fit: cover;
    display: block;
}



.interactive-section {
    background: radial-gradient(circle at 20% 20%, #1e293b 0%, #0b1120 60%);
    padding: 140px 0;
    color: #ffffff;
}

.feature-item {
    display: flex;
    gap: 20px;
    margin-bottom: 35px;
}

.feature-item h6 {
    font-size: 17px;
    font-weight: 600;
    margin-bottom: 6px;
}

.feature-item p {
    font-size: 14px;
    color: #94a3b8;
    margin: 0;
}

.feature-icon {
    width: 52px;
    height: 52px;
    background: rgba(99,102,241,0.12);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}


.interactive-title {
    font-size: 48px;
    font-weight: 700;
    line-height: 1.15;
    margin-bottom: 45px;
}

.interactive-title span {
    color: #6366f1;
}

.interactive-title span {
    color: #6366f1;
}
/*feature item*/
.feature-item {
    display: flex;
    gap: 20px;
    margin-bottom: 35px;
}

.feature-item h6 {
    font-size: 17px;
    font-weight: 600;
    margin-bottom: 6px;
}

.feature-item p {
    font-size: 14px;
    color: #94a3b8;
    margin: 0;
}

.feature-icon {
    width: 52px;
    height: 52px;
    background: rgba(99,102,241,0.12);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}


    </style>
</asp:Content>


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

        <%--another start from here--%>
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


</asp:Content>
