<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Privacy-Policy.aspx.cs" Inherits="StudyIsleWeb.Privacy_Policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        /* Smooth Scrolling */
        html { scroll-behavior: smooth; }

        .privacy-container {
            display: flex;
            max-width: 1200px;
            margin: 40px auto;
            gap: 40px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            align-items: flex-start;
        }

        /* Sidebar Navigation */
        .privacy-nav {
            flex: 0 0 250px;
            position: sticky;
            top: 20px;
        }

        .nav-title {
            font-size: 12px;
            font-weight: bold;
            color: #888;
            letter-spacing: 1px;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        .privacy-nav ul { list-style: none; padding: 0; }
        
        .privacy-nav li a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            text-decoration: none;
            color: #555;
            font-size: 15px;
            border-radius: 8px;
            transition: 0.3s;
            margin-bottom: 5px;
        }

        .privacy-nav li a i { margin-right: 15px; width: 20px; text-align: center; color: #999; }

        .privacy-nav li a:hover { background-color: #f0fdf4; color: #16a34a; }
        .privacy-nav li a:hover i { color: #16a34a; }

        /* Main Content Card */
        .privacy-card {
            flex: 1;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        .badge {
            display: inline-flex;
            align-items: center;
            background: #f0fdf4;
            color: #16a34a;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
            margin-bottom: 15px;
            border: 1px solid #dcfce7;
        }

        h1 { font-size: 32px; color: #111827; margin-bottom: 10px; }
        .last-updated { color: #6b7280; font-size: 14px; margin-bottom: 40px; }

        section { padding: 30px 0; border-bottom: 1px solid #f3f4f6; }
        section:last-child { border-bottom: none; }

        .section-header { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        .icon-box {
            width: 40px; height: 40px;
            background: #f0fdf4;
            color: #16a34a;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }

        h2 { font-size: 22px; color: #1f2937; margin: 0; }
        p, li { color: #4b5563; line-height: 1.6; font-size: 15px; }
        ul { padding-left: 20px; }
        li { margin-bottom: 10px; }

        /* Contact Grid */
        .contact-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .contact-item { 
            background: #f9fafb; padding: 20px; border-radius: 15px; border: 1px solid #f3f4f6;
        }
        .contact-label { font-size: 11px; font-weight: bold; color: #9ca3af; text-transform: uppercase; margin-bottom: 10px; }
        .contact-value { display: flex; align-items: center; gap: 10px; font-weight: 500; color: #111827; }
        
        .alert-box {
            background: #fffbeb; border: 1px solid #fef3c7; color: #92400e;
            padding: 15px; border-radius: 12px; display: flex; gap: 15px; margin: 20px 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="privacy-container">
        <!-- Sidebar Navigation -->
        <nav class="privacy-nav">
            <div class="nav-title">Privacy Guide</div>
            <ul>
                <li><a href="#overview"><i class="fas fa-info-circle"></i> Overview</a></li>
                <li><a href="#collect"><i class="fas fa-database"></i> What We Collect</a></li>
                <li><a href="#use"><i class="fas fa-user-gear"></i> How We Use It</a></li>
                <li><a href="#sharing"><i class="fas fa-share-nodes"></i> Sharing Your Data</a></li>
                <li><a href="#cookies"><i class="fas fa-cookie-bite"></i> Cookies</a></li>
                <li><a href="#security"><i class="fas fa-shield-halved"></i> Security</a></li>
                <li><a href="#rights"><i class="fas fa-eye"></i> Your Rights</a></li>
                <li><a href="#children"><i class="fas fa-shield-check"></i> Children's Privacy</a></li>
                <li><a href="#contact"><i class="fas fa-envelope"></i> Contact Us</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <div class="privacy-card">
            <div class="badge"><i class="fas fa-shield-check" style="margin-right:5px;"></i> TRUSTED SECURITY</div>
            <h1>Privacy Policy</h1>
            <div class="last-updated">Last updated: May 5, 2026</div>

            <section id="overview">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-info-circle"></i></div>
                    <h2>Overview</h2>
                </div>
                <p>StudyIsle Education Pvt. Ltd. ("StudyIsle", "we", "us") is committed to protecting your personal data. This policy explains what information we collect, how we use it and your rights under applicable law including India's Digital Personal Data Protection Act 2023.</p>
                <p>By using our website, booking a session or accessing any of our services, you agree to this Privacy Policy. If you do not agree, please do not use our platform.</p>
            </section>

            <section id="collect">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-database"></i></div>
                    <h2>What We Collect</h2>
                </div>
                <strong>Information you provide directly:</strong>
                <ul>
                    <li>Full name, email address and phone/WhatsApp number (via contact and booking forms)</li>
                    <li>Academic details — board, grade, subjects and goals</li>
                    <li>Session preferences and any messages you send us</li>
                    <li>Payment details when enrolling in paid courses (processed via third-party payment gateways)
</li>
                </ul>
                                <strong>Information collected automatically</strong>
                <ul>
                    <li>Device and browser type, operating system</li>
                    <li>IP address and approximate location</li>
                    <li>Pages visited, time spent and links clicked</li>
                    <li>Referral source (how you arrived at our website)</li>
                </ul>
                <strong>Information from third parties</strong>
                <ul>

                    <li>If you sign in via Google or any third-party service, we may receive your basic profile information</li>
                    <li>Psychometric assessment results from our assessment partner (EduMilestones)</li>
                </ul>
            </section>

            <section id="use">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-user-gear"></i></div>
                    <h2>How We Use It</h2>
                </div>
                <ul>
                    <li>To confirm and schedule your booked sessions.</li>
                    <li>To match you with the right tutor or counsellor.</li>
                </ul>
                <div class="badge" style="background:#f0fdf4; color:#16a34a; width:100%; justify-content:center; padding:15px; border-radius:10px;">
                    <i class="fas fa-check-circle" style="margin-right:10px"></i> We do not sell your personal data to advertisers.
                </div>
            </section>

            <section id="security">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-shield-halved"></i></div>
                    <h2>Data Storage & Security</h2>
                </div>
                <p>Your data is stored on secure servers located in India. We use industry-standard encryption (SSL/TLS).</p>
                <div class="alert-box">
                    <i class="fas fa-circle-exclamation"></i>
                    <span>No method of transmission over the internet is 100% secure. We cannot guarantee absolute security.</span>
                </div>
            </section>

            <section id="contact">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-envelope"></i></div>
                    <h2>Contact Us</h2>
                </div>
                <div class="contact-grid">
                    <div class="contact-item">
                        <div class="contact-label">Email Feedback</div>
                        <div class="contact-value"><i class="fas fa-envelope" style="color:#16a34a"></i> supportstudyisle@gmail.com</div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-label">Customer Support</div>
                        <div class="contact-value"><i class="fab fa-whatsapp" style="color:#25d366"></i> 9588234841</div>
                    </div>
                </div>
            </section>

            <div style="text-align:center; color:#9ca3af; font-size:12px; margin-top:40px; border-top: 1px solid #f3f4f6; padding-top:20px;">
                © 2026 StudyIsle Education Pvt. Ltd. Dedicated to protecting your digital rights.
            </div>
        </div>
    </div>
</asp:Content>