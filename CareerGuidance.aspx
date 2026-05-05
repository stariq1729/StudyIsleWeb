<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CareerGuidance.aspx.cs" Inherits="StudyIsleWeb.CareerGuidance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets\css\Enquiry.css" rel="stylesheet" />
    <style>
        /* Subject Section Styles */

        .subjects-section {
    padding: 80px 0;
    background-color: #ffffff;
}

/* Header Styles */
.subjects-badge {
    font-size: 14px;
    font-weight: 700;
    color: #6366f1;
    letter-spacing: 2px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-bottom: 15px;
}

.blue-dash {
    width: 12px;
    height: 12px;
    background-color: #60a5fa;
    display: inline-block;
}

.section-title {
    font-size: 42px;
    font-weight: 800;
    color: #111827;
    margin-bottom: 20px;
}

.section-subtitle {
    color: #6b7280;
    font-size: 18px;
    line-height: 1.6;
}

/* Card Styles */
.subject-card {
    background-color: #f9fafb; /* Light grey base */
    border-radius: 30px;
    padding: 40px 30px;
    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
    height: 100%;
    border: 1px solid transparent;
    cursor: pointer;
}

/* Hover Effect: Brighter and Lifted */
.subject-card:hover {
    background-color: #ffffff; /* Brighter */
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.05);
    border-color: #e5e7eb;
}

.subject-icon {
    width: 50px;
    height: 50px;
    margin-bottom: 25px;
}

.subject-icon img {
    width: 100%;
    height: auto;
    object-fit: contain;
}

.subject-name {
    font-size: 20px;
    font-weight: 700;
    color: #111827;
    margin-bottom: 10px;
}

.subject-desc {
    font-size: 14px;
    color: #9ca3af;
    margin-bottom: 25px;
}

/* Tags Styles */
.tag-container {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.subject-tag {
    background-color: #ffffff;
    color: #9ca3af;
    font-size: 11px;
    font-weight: 600;
    padding: 4px 12px;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    text-transform: uppercase;
    transition: all 0.3s ease;
}

/* Brighter tags on card hover */
.subject-card:hover .subject-tag {
    border-color: #6366f1;
    color: #6366f1;
}
/* Icon Container Styling */
.subject-icon {
    font-size: 28px; /* Size of the icon */
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    transition: transform 0.3s ease;
}

/* Specific Icon Colors from Image_1241f1.png */
.icon-purple { color: #a855f7; }
.icon-indigo { color: #6366f1; }
.icon-green  { color: #4ade80; }
.icon-pink   { color: #ec4899; }
.icon-emerald{ color: #10b981; }
.icon-blue   { color: #3b82f6; }
.icon-orange { color: #f97316; }
.icon-cyan   { color: #06b6d4; }

/* Brighter effect on hover */
.subject-card:hover .subject-icon {
    transform: scale(1.1);
    filter: brightness(1.2);
}

/* Ensure the card background actually gets brighter */
.subject-card {
    background-color: #f8f9fa; /* Slightly off-white */
    border: 1px solid transparent;
    transition: all 0.3s ease;
}

.subject-card:hover {
    background-color: #ffffff !important;
    box-shadow: 0 15px 30px rgba(0,0,0,0.08);
    border-color: #f1f1f1;
}

/* How it works Section Styles */
.how-it-works-section {
    padding: 100px 0;
    background-color: #fff;
}

.how-badge {
    font-size: 13px;
    font-weight: 800;
    color: #6366f1;
    letter-spacing: 2px;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

/* Process Flow Layout */
.process-wrapper {
    position: relative;
    margin-top: 60px;
}

/* The horizontal line behind the numbers */
.process-line {
    position: absolute;
    top: 25px; /* Centers it with the number badges */
    left: 10%;
    right: 10%;
    height: 1px;
    background-color: #f0f0f0;
    z-index: 1;
}

.process-item {
    position: relative;
    z-index: 2;
    text-align: center;
}

/* Purple Number Badges */
.number-badge {
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #a855f7 0%, #6366f1 100%);
    color: white;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    margin: 0 auto 30px;
    box-shadow: 0 10px 20px rgba(99, 102, 241, 0.2);
}

.step-icon {
    font-size: 32px;
    margin-bottom: 20px;
}

.step-content h5 {
    font-size: 18px;
    font-weight: 700;
    color: #111827;
    margin-bottom: 15px;
}

.step-content p {
    font-size: 14px;
    color: #6b7280;
    line-height: 1.6;
    padding: 0 10px;
}

/* Mobile Fix: Hide line and adjust spacing on small screens */
@media (max-width: 768px) {
    .process-line {
        display: none;
    }
    .process-item {
        margin-bottom: 50px;
    }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="enquiry-section">

    <div class="container">
        <div class="row align-items-center">

            <!-- LEFT SIDE -->
            <div class="col-lg-6 mb-5 mb-lg-0 enquiry-left">

                <div class="admission-badge">
                    IB & IGCSE Online Tuition
                </div>

                <h3 class="main-heading">
                  Struggling with IB or IGCSE?
                    <span class="gradient-text">We've Got You.</span>
                </h3>

                <p class="main-description">
Personalised 1-on-1 online tuition for IB, IGCSE, A-Level and AP students. Real specialists. Real results.                </p>

                <div class="feature-wrapper">

                    <div class="feature-item">
                        <div class="icon-box blue">
                            <i class="bi bi-person"></i>
                        </div>
                        <div>
                            <h6>One-on-One Online Sessions</h6>
                            <p>Built around your school, syllabus and pace. Fully personalised.</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box orange">
                            <i class="bi bi-award"></i>
                        </div>
                        <div>
                            <h6>IA, Extended Essay & TOK Mentoring</h6>
                            <p>Step-by-step guidance on Internal Assessments, Extended Essays and TOK.
</p>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="icon-box blue">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <div>
                            <h6>Exam Technique & Past Paper</h6>
                            <p>Learn exactly how examiners mark. Practice with real papers and expert feedback.</p>
                        </div>
                    </div>
                    <div class="feature-item">
    <div class="icon-box green">
        <i class="bi bi-globe"></i>
    </div>
    <div>
        <h6>Top University Application Support</h6>
        <p>Build your profile for UK, US and Canadian universities — grades to strategy.</p>
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
    <section class="subjects-section">
    <div class="container">
        <!-- Section Header -->
        <div class="text-center mb-5">
            <div class="subjects-badge">
                <span class="blue-dash"></span> SUBJECTS
            </div>
            <h2 class="section-title">Every Subject, Every Board</h2>
            <p class="section-subtitle">
                From HL Maths to IGCSE Economics — our tutors are curriculum specialists<br class="d-none d-md-block"> 
                who know exactly what examiners want.
            </p>
        </div>

        <!-- Subjects Grid -->
       <div class="row g-4">
    <!-- Mathematics -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-purple"><i class="bi bi-rulers"></i></div>
            <h5 class="subject-name">Mathematics</h5>
            <p class="subject-desc">AA/AI HL & SL - Extended & Core</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">A-Level</span>
            </div>
        </div>
    </div>

    <!-- Physics -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-indigo"><i class="bi bi-atom"></i></div>
            <h5 class="subject-name">Physics</h5>
            <p class="subject-desc">HL & SL - Paper 1, 2 & 3 focus</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">AP</span>
            </div>
        </div>
    </div>

    <!-- Chemistry -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-green"><i class="bi bi-bezier2"></i></div>
            <h5 class="subject-name">Chemistry</h5>
            <p class="subject-desc">Organic, Inorganic & Physical</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">A-Level</span>
            </div>
        </div>
    </div>

    <!-- Biology -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-pink"><i class="bi bi-dna"></i></div>
            <h5 class="subject-name">Biology</h5>
            <p class="subject-desc">HL & SL - IA guidance included</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">AP</span>
            </div>
        </div>
    </div>

    <!-- Economics -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-emerald"><i class="bi bi-graph-up-arrow"></i></div>
            <h5 class="subject-name">Economics</h5>
            <p class="subject-desc">Micro, Macro & IA Commentary</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">A-Level</span>
            </div>
        </div>
    </div>

    <!-- Business -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-blue"><i class="bi bi-bar-chart-steps"></i></div>
            <h5 class="subject-name">Business Studies</h5>
            <p class="subject-desc">Case study & exam technique</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
            </div>
        </div>
    </div>

    <!-- English -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-orange"><i class="bi bi-file-earmark-text"></i></div>
            <h5 class="subject-name">English Lang & Lit</h5>
            <p class="subject-desc">Paper 1, Paper 2 & IO prep</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">A-Level</span>
            </div>
        </div>
    </div>

    <!-- Computer Science -->
    <div class="col-lg-3 col-md-6">
        <div class="subject-card">
            <div class="subject-icon icon-cyan"><i class="bi bi-display"></i></div>
            <h5 class="subject-name">Computer Science</h5>
            <p class="subject-desc">Java, Python & IA projects</p>
            <div class="tag-container">
                <span class="subject-tag">IB</span>
                <span class="subject-tag">IGCSE</span>
                <span class="subject-tag">AP</span>
            </div>
        </div>
    </div>
</div>

        </div>
   
</section>
    <section class="how-it-works-section">
    <div class="container">
        <!-- Section Header -->
        <div class="text-center mb-5">
            <div class="how-badge">
                <span class="emoji-icon">📋</span> HOW IT WORKS
            </div>
            <h2 class="section-title">From Booking to Better Grades</h2>
            <p class="section-subtitle">
                Four simple steps — and you're learning with the best.
            </p>
        </div>

        <div class="process-wrapper">
            <!-- Connecting Line -->
            <div class="process-line"></div>

            <div class="row">
                <!-- Step 1 -->
                <div class="col-md-3 process-item">
                    <div class="number-badge">1</div>
                    <div class="step-content">
                        <div class="step-icon">📝</div>
                        <h5>Book Free Demo</h5>
                        <p>Fill the form above with your board, subject and grade. Takes 30 seconds.</p>
                    </div>
                </div>

                <!-- Step 2 -->
                <div class="col-md-3 process-item">
                    <div class="number-badge">2</div>
                    <div class="step-content">
                        <div class="step-icon">🎯</div>
                        <h5>Get Matched</h5>
                        <p>Our coordinator pairs you with a tutor who specialises in your exact curriculum and level.</p>
                    </div>
                </div>

                <!-- Step 3 -->
                <div class="col-md-3 process-item">
                    <div class="number-badge">3</div>
                    <div class="step-content">
                        <div class="step-icon">💻</div>
                        <h5>Attend Live Class</h5>
                        <p>Join your 1-on-1 or small-group session on Zoom with an interactive whiteboard.</p>
                    </div>
                </div>

                <!-- Step 4 -->
                <div class="col-md-3 process-item">
                    <div class="number-badge">4</div>
                    <div class="step-content">
                        <div class="step-icon">📈</div>
                        <h5>See Results</h5>
                        <p>Get weekly progress reports, exam-style practice and personalised improvement plans.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</asp:Content>
