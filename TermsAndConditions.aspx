<%@ Page Title="Terms and Conditions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TermsAndConditions.aspx.cs" Inherits="StudyIsleWeb.TermsAndConditions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        /* Smooth Scrolling */
        html { scroll-behavior: smooth; }
        body { background-color: #fcfcfc; }

        /* Sidebar Sticky Alignment */
        .terms-nav {
            position: sticky;
            top: 100px;
        }

        .nav-title {
            font-size: 11px;
            font-weight: 800;
            color: #9ca3af;
            letter-spacing: 1.5px;
            margin-bottom: 25px;
            text-transform: uppercase;
        }

        .terms-nav ul { list-style: none; padding: 0; margin: 0; }
        
        .terms-nav li a {
            display: flex;
            align-items: center;
            padding: 12px 0;
            text-decoration: none;
            color: #4b5563;
            font-size: 15px;
            transition: all 0.2s ease;
        }

        .terms-nav li a i { 
            margin-right: 15px; 
            width: 20px; 
            text-align: center; 
            color: #9ca3af; 
            font-size: 16px;
        }

        .terms-nav li a:hover { color: #3b82f6; }
        .terms-nav li a:hover i { color: #3b82f6; }

        /* Content Card */
        .terms-card {
            background: #ffffff;
            border: 1px solid #f0f0f0;
            border-radius: 30px;
            padding: 60px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.02);
            margin-bottom: 50px;
        }

        .badge-compliance {
            display: inline-flex;
            align-items: center;
            background: #eff6ff;
            color: #2563eb;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            margin-bottom: 20px;
            border: 1px solid #dbeafe;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        h1 { font-size: 42px; color: #111827; margin: 0 0 10px 0; font-weight: 700; }
        .last-updated { color: #6b7280; font-size: 15px; margin-bottom: 40px; }

        .intro-quote {
            border-left: 3px solid #3b82f6;
            padding: 15px 25px;
            background: #f9fafb;
            margin-bottom: 40px;
            font-style: italic;
            font-size: 17px;
            color: #374151;
            line-height: 1.6;
        }

        section { padding: 35px 0; border-bottom: 1px solid #f3f4f6; }
        section:last-of-type { border-bottom: none; }

        .section-header { display: flex; align-items: center; gap: 18px; margin-bottom: 22px; }
        .icon-box {
            width: 40px; height: 40px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-size: 16px;
        }

        h2 { font-size: 24px; color: #111827; margin: 0; font-weight: 600; }
        h3 { font-size: 14px; color: #111827; font-weight: 800; text-transform: uppercase; margin: 30px 0 15px 0; letter-spacing: 0.5px; }
        
        p, li { color: #4b5563; line-height: 1.7; font-size: 15px; margin-bottom: 15px; }
        ul.terms-list { padding-left: 20px; list-style-type: disc; }
        ul.terms-list li { margin-bottom: 12px; }
        ul.terms-list li b { color: #111827; }

        .modify-notice { font-style: italic; color: #6b7280; font-size: 14px; margin-top: 10px; display: block; }

        /* Info Banner (Green) */
        .banner-info {
            background: #f0fdf4;
            border: 1px solid #dcfce7;
            color: #15803d;
            padding: 20px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 25px 0;
            font-size: 14px;
            font-weight: 600;
        }

        /* Warning Banner (Yellow) */
        .banner-warning {
            background: #fffbeb;
            border: 1px solid #fef3c7;
            color: #92400e;
            padding: 20px;
            border-radius: 14px;
            display: flex;
            gap: 15px;
            margin: 25px 0;
            font-size: 14px;
            line-height: 1.5;
        }

        /* Contact Section */
        .contact-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 25px; }
        .contact-card { background: #f9fafb; padding: 25px; border-radius: 18px; border: 1px solid #f3f4f6; }
        .contact-label { font-size: 11px; font-weight: 700; color: #9ca3af; text-transform: uppercase; margin-bottom: 12px; letter-spacing: 0.5px; }
        .contact-detail { display: flex; align-items: center; gap: 12px; font-size: 15px; font-weight: 600; color: #111827; }
        .office-card { background: #f9fafb; padding: 25px; border-radius: 18px; border: 1px solid #f3f4f6; margin-top: 20px; }
        
        .footer-note { text-align: center; color: #9ca3af; font-size: 13px; margin-top: 60px; padding-top: 30px; border-top: 1px solid #f3f4f6; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row">
            
            <div class="col-lg-3">
                <nav class="terms-nav">
                    <div class="nav-title">On This Page</div>
                    <ul class="list-unstyled">
                        <li><a href="#agreement"><i class="far fa-circle-check"></i> Agreement</a></li>
                        <li><a href="#services"><i class="far fa-book-open"></i> Our Services</a></li>
                        <li><a href="#accounts"><i class="far fa-shield-halved"></i> Accounts</a></li>
                        <li><a href="#payments"><i class="far fa-credit-card"></i> Payments</a></li>
                        <li><a href="#sessions"><i class="far fa-calendar-days"></i> Sessions & Bookings</a></li>
                        <li><a href="#content"><i class="far fa-file-lines"></i> Content & IP</a></li>
                        <li><a href="#conduct"><i class="far fa-user"></i> User Conduct</a></li>
                        <li><a href="#liability"><i class="far fa-circle-exclamation"></i> Liability</a></li>
                        <li><a href="#termination"><i class="far fa-user-xmark"></i> Termination</a></li>
                        <li><a href="#law"><i class="far fa-globe"></i> Governing Law</a></li>
                        <li><a href="#contact"><i class="far fa-envelope"></i> Contact</a></li>
                    </ul>
                </nav>
            </div>

            <div class="col-lg-9">
                <div class="terms-card">
                    <div class="badge-compliance"><i class="far fa-file-text me-2"></i> Compliance & Terms</div>
                    <h1>Terms and Conditions</h1>
                    <div class="last-updated">Last updated: May 5, 2026</div>

                    <div class="intro-quote">
                        By accessing or using StudyIsle's website, booking any session or enrolling in any course, you agree to be bound by these Terms & Conditions.
                    </div>

                    <section id="agreement">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-check-circle"></i></div>
                            <h2>1. Agreement to Terms</h2>
                        </div>
                        <p>By accessing or using StudyIsle's website, booking any session or enrolling in any course, you agree to be bound by these Terms & Conditions. Please read them carefully before using our services.</p>
                        <p>These terms apply to all users — students, parents, guardians and visitors. If you are under 18, your parent or guardian must review and accept these terms on your behalf.</p>
                        <p>We reserve the right to update these terms at any time. Continued use of our services constitutes acceptance of the revised terms.</p>
                    </section>

                    <section id="services">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-book-open"></i></div>
                            <h2>2. Our Services</h2>
                        </div>
                        <p>StudyIsle provides the following services:</p>
                        <ul class="terms-list">
                            <li><b>Free Study Material:</b> Chapter notes, NCERT solutions, MCQs, past papers and mock tests available free of charge.</li>
                            <li><b>Live Online Classes:</b> Interactive live classes for CBSE, ICSE, JEE, NEET and other boards.</li>
                            <li><b>IB & IGCSE Online Tuition:</b> Personalised 1-on-1 sessions for international board students including IA, EE and TOK support.</li>
                            <li><b>Career Counselling:</b> Free 1-on-1 sessions with a Certified Career Analyst for stream, college and career guidance.</li>
                            <li><b>Test Series & AI Reports:</b> Mock tests with AI-powered performance analysis.</li>
                        </ul>
                        <span class="modify-notice">We reserve the right to modify, suspend or discontinue any service at any time with reasonable notice.</span>
                    </section>

                    <section id="accounts">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-shield-alt"></i></div>
                            <h2>3. Accounts & Registration</h2>
                        </div>
                        <ul class="terms-list">
                            <li>You must provide accurate and complete information when creating an account or booking a session.</li>
                            <li>You are responsible for maintaining the confidentiality of your login credentials.</li>
                            <li>You must notify us immediately of any unauthorised use of your account.</li>
                            <li>One person may not create multiple accounts to misuse free session offers.</li>
                            <li>We reserve the right to suspend or delete accounts that violate these terms.</li>
                        </ul>
                    </section>

                    <section id="payments">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-credit-card"></i></div>
                            <h2>4. Payments & Fees</h2>
                        </div>
                        <ul class="terms-list">
                            <li>All fees are displayed in Indian Rupees (INR) and are inclusive of applicable GST unless stated otherwise.</li>
                            <li>Payments are processed through secure third-party gateways (e.g. Razorpay). We do not store payment card details.</li>
                            <li>Access to paid services begins upon successful payment confirmation.</li>
                            <li>Subscription fees are billed at the start of each billing cycle (monthly or annual as selected).</li>
                            <li>We reserve the right to change our pricing with 30 days' notice. Existing subscribers will not be affected mid-cycle.</li>
                        </ul>
                        <div class="banner-info">
                            <i class="fas fa-check-circle"></i>
                            Demo classes, career counselling sessions and free study material are provided at zero cost with no payment required.
                        </div>
                    </section>

                    <section id="sessions">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-calendar-alt"></i></div>
                            <h2>5. Sessions & Bookings</h2>
                        </div>
                        
                        <h3>DEMO CLASSES (IB/IGCSE TUITION)</h3>
                        <ul class="terms-list">
                            <li>Each student is entitled to one free demo class per subject.</li>
                            <li>Demo sessions are 45 minutes in duration.</li>
                            <li>Slots are confirmed via WhatsApp within 2 hours of booking.</li>
                            <li>Please reschedule or cancel at least 12 hours in advance if you cannot attend.</li>
                        </ul>

                        <h3>CAREER COUNSELLING SESSIONS</h3>
                        <ul class="terms-list">
                            <li>Free counselling sessions are 45 minutes and conducted via video call.</li>
                            <li>One free session per student. Additional sessions may be offered at our discretion.</li>
                            <li>Guidance provided is advisory in nature. StudyIsle is not liable for outcomes based on counselling advice.</li>
                        </ul>

                        <h3>PAID TUITION SESSIONS</h3>
                        <ul class="terms-list">
                            <li>Rescheduling is permitted with at least 24 hours' notice.</li>
                            <li>Sessions cancelled with less than 12 hours' notice may be forfeited without refund.</li>
                            <li>Technical issues on the student's end (poor internet, device failure) do not entitle a refund unless agreed upon case by case.</li>
                        </ul>
                    </section>

                    <section id="content">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-file-alt"></i></div>
                            <h2>6. Content & Intellectual Property</h2>
                        </div>
                        <p>All content on the StudyIsle platform — including study notes, videos, test questions, reports and course materials — is the intellectual property of StudyIsle Education Pvt. Ltd.</p>
                        <ul class="terms-list">
                            <li>You may use content for personal, non-commercial study purposes only.</li>
                            <li>You may not copy, reproduce, distribute, sell or commercially exploit any content without our written permission.</li>
                            <li>Recording or sharing live class sessions without permission is strictly prohibited.</li>
                            <li>Unauthorised use of our content may result in legal action.</li>
                        </ul>
                    </section>

                    <section id="conduct">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-user-shield"></i></div>
                            <h2>7. User Conduct</h2>
                        </div>
                        <p>You agree not to:</p>
                        <ul class="terms-list">
                            <li>Use our platform for any unlawful purpose</li>
                            <li>Harass, abuse or disrespect tutors, counsellors or other users</li>
                            <li>Share your account access or login credentials with others</li>
                            <li>Attempt to hack, disrupt or interfere with our platform</li>
                            <li>Upload or share harmful, offensive or copyrighted content</li>
                            <li>Misrepresent your identity or academic credentials</li>
                        </ul>
                    </section>

                    <section id="liability">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-exclamation-circle"></i></div>
                            <h2>8. Limitation of Liability</h2>
                        </div>
                        <div class="banner-warning">
                            <i class="fas fa-circle-exclamation"></i>
                            <span>StudyIsle provides educational services and guidance. We do not guarantee specific academic results, exam scores, college admissions or career outcomes.</span>
                        </div>
                        <p>To the maximum extent permitted by law, StudyIsle shall not be liable for:</p>
                        <ul class="terms-list">
                            <li>Any indirect, incidental or consequential loss arising from use of our services</li>
                            <li>Academic results or exam performance</li>
                            <li>Outcomes of career or college counselling decisions</li>
                            <li>Technical disruptions beyond our reasonable control (internet outages, platform downtime)</li>
                        </ul>
                        <p><b>Our total liability to you for any claim shall not exceed the amount you paid us in the 3 months preceding the claim.</b></p>
                    </section>

                    <section id="termination">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-user-minus"></i></div>
                            <h2>9. Termination</h2>
                        </div>
                        <p>We may suspend or terminate your access to StudyIsle at any time if:</p>
                        <ul class="terms-list">
                            <li>You breach any of these Terms & Conditions</li>
                            <li>We reasonably suspect fraudulent activity on your account</li>
                            <li>You fail to make payment for paid services</li>
                        </ul>
                        <p>You may cancel your account at any time by contacting us at <b style="color:#3b82f6;">islestudy@gmail.com</b>. Refunds upon cancellation are governed by our Refund Policy.</p>
                    </section>

                    <section id="law">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-globe"></i></div>
                            <h2>10. Governing Law</h2>
                        </div>
                        <p>These Terms & Conditions are governed by the laws of India. Any disputes shall be subject to the exclusive jurisdiction of the courts of Rajasthan, India.</p>
                        <p><i>We encourage you to contact us first to resolve any issue amicably before taking legal action.</i></p>
                    </section>

                    <section id="contact">
                        <div class="section-header">
                            <div class="icon-box"><i class="fas fa-envelope"></i></div>
                            <h2>11. Contact Us</h2>
                        </div>
                        <div class="contact-grid">
                            <div class="contact-card">
                                <div class="contact-label">Email Support</div>
                                <div class="contact-detail">
                                    <i class="fas fa-envelope" style="color: #3b82f6;"></i>
                                    supportstudyisle@gmail.com
                                </div>
                            </div>
                            <div class="contact-card">
                                <div class="contact-label">WhatsApp / Phone</div>
                                <div class="contact-detail">
                                    <i class="fab fa-whatsapp" style="color: #25d366; font-size: 20px;"></i>
                                    +9588234841
                                </div>
                            </div>
                        </div>
                        <div class="office-card">
                            <div class="contact-label">Registered Office</div>
                            <div class="contact-detail" style="font-size: 13px; font-weight: 500;">
                                StudyIsle Education, Bhiwadi, Rajasthan — 301019, India
                            </div>
                        </div>
                    </section>

                    <div class="footer-note">
                        © 2026 StudyIsle Education Pvt. Ltd. All rights reserved.
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>