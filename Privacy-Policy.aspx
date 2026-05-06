<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Privacy-Policy.aspx.cs" Inherits="StudyIsleWeb.Privacy_Policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        /* Smooth Scrolling and Layout */
        html { scroll-behavior: smooth; }
        body { background-color: #fcfcfc; }

        .privacy-container {
            display: flex;
            padding: 20px;
            max-width: 1200px;
            margin: 40px auto;
            gap: 50px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            align-items: flex-start;
        }

        /* Sticky Sidebar */
        .privacy-nav {
            flex: 0 0 260px;
            position: sticky;
            top: 100px; /* Adjusted for header clearance */
            padding-top: 10px;
        }

        .nav-title {
            font-size: 11px;
            font-weight: 700;
            color: #9ca3af;
            letter-spacing: 1.5px;
            margin-bottom: 25px;
            text-transform: uppercase;
        }

        .privacy-nav ul { list-style: none; padding: 0; margin: 0; }
        
        .privacy-nav li a {
            display: flex;
            align-items: center;
            padding: 12px 0;
            text-decoration: none;
            color: #4b5563;
            font-size: 15px;
            transition: all 0.2s ease;
            border-bottom: 1px solid transparent;
        }

        .privacy-nav li a i { 
            margin-right: 15px; 
            width: 20px; 
            text-align: center; 
            color: #9ca3af; 
            font-size: 16px;
        }

        .privacy-nav li a:hover { color: #16a34a; transform: translateX(5px); }
        .privacy-nav li a:hover i { color: #16a34a; }

        /* Content Card */
        .privacy-card {
            flex: 1;
            background: #ffffff;
            border: 1px solid #f0f0f0;
            border-radius: 30px;
            padding: 50px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.02);
        }

        .badge-trusted {
            display: inline-flex;
            align-items: center;
            background: #f0fdf4;
            color: #16a34a;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            margin-bottom: 20px;
            border: 1px solid #dcfce7;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        h1 { font-size: 32px; color: #111827; margin: 0 0 12px 0; font-weight: 700; }
        .last-updated { color: #6b7280; font-size: 13px; margin-bottom: 25px; border-bottom: 1px solid #f3f4f6; padding-bottom: 15px; }

        section { padding: 30px 0; border-bottom: 1px solid #f9fafb; }
        section:last-of-type { border-bottom: none; }

        .section-header { display: flex; align-items: center; gap: 18px; margin-bottom: 25px; }
        .icon-box {
            width: 46px; height: 46px;
            background: #f0fdf4;
            color: #16a34a;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
            font-size: 20px;
        }

        h2 { font-size: 24px; color: #111827; margin: 0; font-weight: 600; }
        p { color: #4b5563; line-height: 1.8; font-size: 15px; margin-bottom: 15px; }
        
        .sub-label { display: block; font-weight: 700; color: #111827; margin: 25px 0 12px 0; font-size: 15px; }
        
        ul.policy-list { padding-left: 20px; list-style-type: disc; }
        ul.policy-list li { color: #4b5563; line-height: 1.8; font-size: 15px; margin-bottom: 12px; padding-left: 5px; }
        ul.policy-list li b { color: #111827; }

        /* Custom Components */
        .no-sell-banner {
            background: #f0fdf4;
            border: 1px solid #dcfce7;
            color: #15803d;
            padding: 20px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            font-size: 15px;
            font-weight: 600;
            margin: 25px 0;
        }

        .alert-warning {
            background: #fffbeb;
            border: 1px solid #fef3c7;
            color: #92400e;
            padding: 22px;
            border-radius: 16px;
            display: flex;
            gap: 15px;
            margin: 20px 0;
            font-size: 14px;
            line-height: 1.6;
        }

        .contact-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 30px; }
        .contact-card { background: #f9fafb; padding: 25px; border-radius: 20px; border: 1px solid #f3f4f6; }
        .contact-label { font-size: 11px; font-weight: 700; color: #9ca3af; text-transform: uppercase; margin-bottom: 12px; letter-spacing: 0.8px; }
        .contact-detail { display: flex; align-items: center; gap: 12px; font-size: 15px; font-weight: 600; color: #111827; }

        .office-card { background: #f9fafb; padding: 25px; border-radius: 20px; border: 1px solid #f3f4f6; margin-top: 20px; }
        
        .footer-note { text-align: center; color: #9ca3af; font-size: 13px; margin-top: 40px; padding-top: 30px; border-top: 1px solid #f3f4f6; }

        @media (max-width: 992px) {
            .privacy-container { flex-direction: column; padding: 20px; }
            .privacy-nav { position: relative; top: 0; flex: 1; width: 100%; margin-bottom: 30px; }
            .privacy-card { padding: 30px; }
            .contact-grid { grid-template-columns: 1fr; }
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
                <li><a href="#use"><i class="fas fa-user-check"></i> How We Use It</a></li>
                <li><a href="#sharing"><i class="fas fa-share-alt"></i> Sharing Your Data</a></li>
                <li><a href="#cookies"><i class="fas fa-cookie"></i> Cookies</a></li>
                <li><a href="#security"><i class="fas fa-lock"></i> Security</a></li>
                <li><a href="#rights"><i class="fas fa-user-shield"></i> Your Rights</a></li>
                <li><a href="#children"><i class="fas fa-child"></i> Children's Privacy</a></li>
                <li><a href="#contact"><i class="fas fa-envelope"></i> Contact Us</a></li>
            </ul>
        </nav>

        <!-- Main Content Card -->
        <div class="privacy-card">
            <div class="badge-trusted"><i class="fas fa-shield-alt" style="margin-right:8px;"></i> Trusted Security</div>
            <h1>Privacy Policy</h1>
            <div class="last-updated">Last updated: May 5, 2026</div>

            <!-- Overview -->
            <section id="overview">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-info"></i></div>
                    <h2>Overview</h2>
                </div>
                <p>StudyIsle Education Pvt. Ltd. ("StudyIsle", "we", "us") is committed to protecting your personal data. This policy explains what information we collect, how we use it and your rights under applicable law including India's Digital Personal Data Protection Act 2023.</p>
                <p>By using our website, booking a session or accessing any of our services, you agree to this Privacy Policy. If you do not agree, please do not use our platform.</p>
            </section>

            <!-- What We Collect -->
            <section id="collect">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-database"></i></div>
                    <h2>What We Collect</h2>
                </div>
                <span class="sub-label">Information you provide directly</span>
                <ul class="policy-list">
                    <li>Full name, email address and phone/WhatsApp number (via contact and booking forms)</li>
                    <li>Academic details — board, grade, subjects and goals</li>
                    <li>Session preferences and any messages you send us</li>
                    <li>Payment details when enrolling in paid courses (processed via third-party payment gateways)</li>
                </ul>

                <span class="sub-label">Information collected automatically</span>
                <ul class="policy-list">
                    <li>Device and browser type, operating system</li>
                    <li>IP address and approximate location</li>
                    <li>Pages visited, time spent and links clicked</li>
                    <li>Referral source (how you arrived at our website)</li>
                </ul>

                <span class="sub-label">Information from third parties</span>
                <ul class="policy-list">
                    <li>If you sign in via Google or any third party service, we may receive your basic profile information</li>
                    <li>Psychometric assessment results from our assessment partner (EduMilestones)</li>
                </ul>
            </section>

            <!-- How We Use It -->
            <section id="use">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-user-cog"></i></div>
                    <h2>How We Use It</h2>
                </div>
                <p>We use your personal data only for the following purposes:</p>
                <ul class="policy-list">
                    <li>To confirm and schedule your booked sessions (demo classes, counselling)</li>
                    <li>To match you with the right tutor or counsellor</li>
                    <li>To send session reminders and follow-ups via WhatsApp or email</li>
                    <li>To send study resources, newsletters or promotions (only if you have opted in)</li>
                    <li>To improve our platform and personalise your experience</li>
                    <li>To comply with legal and regulatory requirements</li>
                </ul>
                <div class="no-sell-banner">
                    <i class="fas fa-check-circle" style="margin-right:12px; font-size: 18px;"></i>
                    We do not sell your personal data to advertisers or third parties.
                </div>
            </section>

            <!-- Sharing Your Data -->
            <section id="sharing">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-share-nodes"></i></div>
                    <h2>Sharing Your Data</h2>
                </div>
                <p>We share your data only in the following limited circumstances:</p>
                <ul class="policy-list">
                    <li><b>Tutors and Counsellors:</b> Your name, grade and subject details are shared with your assigned tutor or counsellor to prepare for your session.</li>
                    <li><b>Payment Processors:</b> Billing information is handled securely by our payment gateway partners (e.g. Razorpay). We do not store card details.</li>
                    <li><b>Assessment Partners:</b> If you take a psychometric test, your results are shared with our assessment platform to generate your report.</li>
                    <li><b>Legal Requirements:</b> We may disclose information if required by law or a court order.</li>
                </ul>
                <p><b>We never sell, rent or trade your personal information to any third party for marketing purposes.</b></p>
            </section>

            <!-- Cookies -->
            <section id="cookies">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-cookie-bite"></i></div>
                    <h2>Cookies</h2>
                </div>
                <p>We use cookies to make our website work properly and to understand how visitors use it.</p>
                <ul class="policy-list">
                    <li><b>Essential cookies:</b> Required for the website to function — login, form submissions, session management.</li>
                    <li><b>Analytics cookies:</b> Help us understand traffic patterns (e.g. Google Analytics). Data is anonymised.</li>
                    <li><b>Preference cookies:</b> Remember your settings and preferences across visits.</li>
                </ul>
                <p style="font-size: 14px; color: #9ca3af;">You can disable cookies in your browser settings. Note that some features may not work correctly if cookies are disabled.</p>
            </section>

            <!-- Data Storage & Security -->
            <section id="security">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-shield-halved"></i></div>
                    <h2>Data Storage & Security</h2>
                </div>
                <p>Your data is stored on secure servers located in India. We use industry-standard encryption (SSL/TLS) for all data transmitted between your browser and our servers.</p>
                <p>We retain your personal data for as long as your account is active or as needed to provide services. You may request deletion at any time.</p>
                <div class="alert-warning">
                    <i class="fas fa-exclamation-triangle" style="font-size: 20px; margin-top: 2px;"></i>
                    <span>No method of transmission over the internet is 100% secure. While we take every precaution, we cannot guarantee absolute security of your data.</span>
                </div>
            </section>

            <!-- Your Rights -->
            <section id="rights">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-eye"></i></div>
                    <h2>Your Rights</h2>
                </div>
                <p>Under India's Digital Personal Data Protection Act 2023 and applicable law, you have the right to:</p>
                <ul class="policy-list">
                    <li><b>Access:</b> Request a copy of the personal data we hold about you</li>
                    <li><b>Correction:</b> Ask us to correct inaccurate or incomplete data</li>
                    <li><b>Deletion:</b> Request that we delete your personal data</li>
                    <li><b>Withdraw Consent:</b> Opt out of marketing communications at any time</li>
                    <li><b>Grievance Redressal:</b> Raise a complaint if you believe your data rights have been violated</li>
                </ul>
                <p>To exercise any of these rights, email us at <b style="color:#16a34a;">islestudy@gmail.com</b>. We will respond within 30 days.</p>
            </section>

            <!-- Children's Privacy -->
            <section id="children">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-user-shield"></i></div>
                    <h2>Children's Privacy</h2>
                </div>
                <p>StudyIsle serves students including those under 18. Where a student is a minor, we require a parent or guardian to provide consent before we collect or process their personal data.</p>
                <p>If you believe we have collected data from a minor without proper consent, please contact us immediately and we will delete it promptly.</p>
            </section>

            <!-- Contact Us -->
            <section id="contact">
                <div class="section-header">
                    <div class="icon-box"><i class="fas fa-envelope-open-text"></i></div>
                    <h2>Contact Us</h2>
                </div>
                <div class="contact-grid">
                    <div class="contact-card">
                        <div class="contact-label">Email Feedback</div>
                        <div class="contact-detail">
                            <i class="fas fa-envelope" style="color: #16a34a;"></i>
                            supportstudyisle@gmail.com
                        </div>
                    </div>
                    <div class="contact-card">
                        <div class="contact-label">Customer Support</div>
                        <div class="contact-detail">
                            <i class="fab fa-whatsapp" style="color: #25d366; font-size: 20px;"></i>
                            9588234841
                        </div>
                    </div>
                </div>
                <div class="office-card">
                    <div class="contact-label">Registered Office</div>
                    <div class="contact-detail" style="font-size: 14px; font-weight: 500;">
                        StudyIsle Education, Bhiwadi, Rajasthan — 301019, India
                    </div>
                </div>
            </section>

            <div class="footer-note">
                © 2026 StudyIsle Education Pvt. Ltd. Dedicated to protecting your digital rights.
            </div>
        </div>
    </div>
</asp:Content>