<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StudyIsleWeb.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
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

        <%--another section from here--%>

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

<!-- ================= ENQUIRY SECTION START ================= -->
<section class="enquiry-section py-5">
    <div class="container">
        <div class="row align-items-center">

            <!-- LEFT SIDE -->
            <div class="col-lg-6 mb-5 mb-lg-0 enquiry-left">

                <div class="admission-badge">
                    Admissions Open 2025–26
                </div>

                <h2 class="main-heading">
                    Unlock Your <br />
                    <span class="gradient-text">Academic Potential</span>
                </h2>

                <p class="main-description">
                    Join thousands of students across the globe who have transformed 
                    their grades with our personalized 1-on-1 expert coaching.
                    Our counselors will call you to build a custom roadmap for your success.
                </p>

                <div class="feature-wrapper">

                    <div class="feature-item">
                        <div class="icon-box blue">
                            <i class="bi bi-person"></i>
                        </div>
                        <div>
                            <h6>Senior Counselors</h6>
                            <p>Expert 1-on-1 call for academic planning.</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box orange">
                            <i class="bi bi-award"></i>
                        </div>
                        <div>
                            <h6>Top-Tier Results</h6>
                            <p>Specialized tutors for IB, CBSE, IGCSE & AP.</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box green">
                            <i class="bi bi-globe"></i>
                        </div>
                        <div>
                            <h6>Global Recognition</h6>
                            <p>Supporting students in 20+ countries worldwide.</p>
                        </div>
                    </div>

                </div>

                <div class="rating-box">
                    <strong>4.9/5</strong> from over 12,000 students
                </div>

            </div>

           <!-- RIGHT SIDE FORM -->
            <div class="col-lg-6">
                <div class="enquiry-card">

                    <div class="card-top-border"></div>

                    <div class="card-body p-4">

                        <h4 class="form-title">Student Inquiry Form</h4>
                        <p class="form-subtitle">
                            Takes less than 2 minutes to complete
                        </p>

                        <div class="row g-3 mt-2">

                            <!-- Name -->
                            <div class="col-md-6">
                                <asp:TextBox ID="txtName" runat="server"
                                    CssClass="custom-input"
                                    placeholder="Student Name" />
                            </div>

                            <!-- Email -->
                            <div class="col-md-6">
                                <asp:TextBox ID="txtEmail" runat="server"
                                    CssClass="custom-input"
                                    TextMode="Email"
                                    placeholder="Email ID" />
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6">
                                <asp:TextBox ID="txtPhone" runat="server"
                                    CssClass="custom-input"
                                    placeholder="WhatsApp / Phone Number" />
                            </div>

                            <!-- Country -->
                            <div class="col-md-6">
                                <asp:DropDownList ID="ddlCountry"
                                    runat="server"
                                    CssClass="custom-input">
                                    <asp:ListItem Text="Select Country" Value="" />
                                    <asp:ListItem>India</asp:ListItem>
                                    <asp:ListItem>UAE</asp:ListItem>
                                    <asp:ListItem>USA</asp:ListItem>
                                    <asp:ListItem>UK</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Grade -->
                            <div class="col-md-6">
                                <asp:DropDownList ID="ddlGrade"
                                    runat="server"
                                    CssClass="custom-input">
                                    <asp:ListItem Text="Current Class / Grade" Value="" />
                                    <asp:ListItem>Grade 8</asp:ListItem>
                                    <asp:ListItem>Grade 9</asp:ListItem>
                                    <asp:ListItem>Grade 10</asp:ListItem>
                                    <asp:ListItem>Grade 11</asp:ListItem>
                                    <asp:ListItem>Grade 12</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Board -->
                            <div class="col-md-6">
                                <asp:DropDownList ID="ddlBoard"
                                    runat="server"
                                    CssClass="custom-input">
                                    <asp:ListItem Text="Board / Curriculum" Value="" />
                                    <asp:ListItem>CBSE</asp:ListItem>
                                    <asp:ListItem>ICSE</asp:ListItem>
                                    <asp:ListItem>IB</asp:ListItem>
                                    <asp:ListItem>Cambridge</asp:ListItem>
                                    <asp:ListItem>IGCSE</asp:ListItem>
                                    <asp:ListItem>AP</asp:ListItem>
                                    <asp:ListItem>A-Level</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Subjects -->
                            <div class="col-12">
                                <label class="section-label">Subject Interests</label>

                                <asp:CheckBoxList ID="chkSubjects"
                                    runat="server"
                                    RepeatDirection="Horizontal"
                                    CssClass="subject-pill-list">

                                    <asp:ListItem>Maths</asp:ListItem>
                                    <asp:ListItem>Physics</asp:ListItem>
                                    <asp:ListItem>Chemistry</asp:ListItem>
                                    <asp:ListItem>Biology</asp:ListItem>
                                    <asp:ListItem>Economics</asp:ListItem>
                                    <asp:ListItem>English</asp:ListItem>

                                </asp:CheckBoxList>
                            </div>

                            <!-- Timeline -->
                            <div class="col-12">
                                <label class="section-label">
                                    When do you want to start classes?
                                </label>

                                <asp:RadioButtonList ID="rblTimeline"
                                    runat="server"
                                    RepeatDirection="Horizontal"
                                    CssClass="timeline-list">

                                    <asp:ListItem>Immediately</asp:ListItem>
                                    <asp:ListItem>Within 1 Month</asp:ListItem>
                                    <asp:ListItem>Just Enquiring</asp:ListItem>

                                </asp:RadioButtonList>
                            </div>

                            <!-- Submit -->
                            <div class="col-12">
                                <asp:Button ID="btnSubmit"
                                    runat="server"
                                    Text="Submit Application →"
                                    CssClass="btn-submit"
                                    OnClick="btnSubmit_Click"/>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- ================= ENQUIRY SECTION END ================= -->




</asp:Content>
