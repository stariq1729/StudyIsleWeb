<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs"
    Inherits="StudyIsleWeb.ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="Assets/CSS/contact-us.css" rel="stylesheet" />

    <!-- FONT AWESOME -->
   <style>
       /* ========================================
   CONTACT PAGE
======================================== */

.contact-page {
    padding: 70px 0;
    background: #f8fafc;
}

/* ========================================
   TOP SECTION
======================================== */

.contact-top {
    text-align: center;
    margin-bottom: 55px;
}

.mini-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: #eef2ff;
    color: #4f46e5;
    padding: 8px 16px;
    border-radius: 50px;
    font-size: 12px;
    font-weight: 700;
    margin-bottom: 18px;
}

.contact-top h1 {
    font-size: 62px;
    font-weight: 800;
    color: #0f172a;
    margin-bottom: 18px;
}

.contact-top p {
    max-width: 720px;
    margin: auto;
    color: #64748b;
    font-size: 18px;
    line-height: 1.8;
}

/* ========================================
   CONTACT INFO CARDS
======================================== */

.contact-info-wrapper {
    display: flex;
    gap: 30px;
    margin-bottom: 50px;
}

.contact-card {
    flex: 1;
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 22px;
    padding: 45px 25px;
    text-align: center;
    transition: 0.3s;
}

.contact-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 35px rgba(0,0,0,0.06);
}

.contact-icon {
    width: 62px;
    height: 62px;
    margin: auto;
    border-radius: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    margin-bottom: 22px;
}

.blue-icon {
    background: #eef2ff;
    color: #2563eb;
}

.green-icon {
    background: #ecfdf5;
    color: #16a34a;
}

.red-icon {
    background: #fef2f2;
    color: #ef4444;
}

.contact-card h4 {
    color: #94a3b8;
    font-size: 14px;
    font-weight: 700;
    margin-bottom: 16px;
}

.contact-card h3 {
    font-size: 24px;
    color: #0f172a;
    margin-bottom: 10px;
    font-weight: 700;
}

.contact-card p {
    color: #64748b;
    font-size: 15px;
}

/* ========================================
   MAIN WRAPPER
======================================== */

.contact-main-wrapper {
    display: flex;
    gap: 40px;
    align-items: flex-start;
}

/* ========================================
   FORM BOX
======================================== */

.contact-form-box {
    width: 55%;
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 24px;
    padding: 40px;
}

.contact-form-box h2 {
    font-size: 38px;
    font-weight: 700;
    margin-bottom: 35px;
    color: #0f172a;
}

/* ========================================
   FORM
======================================== */

.form-row {
    display: flex;
    gap: 20px;
}

.form-group {
    margin-bottom: 25px;
}

.form-group.half {
    width: 50%;
}

.form-group label {
    display: block;
    margin-bottom: 10px;
    font-weight: 600;
    color: #334155;
}

.form-control {
    width: 100%;
    height: 56px;
    border: 1px solid #d1d5db;
    border-radius: 14px;
    padding: 0 18px;
    font-size: 15px;
    outline: none;
    transition: 0.3s;
    background: #fff;
}

.form-control:focus {
    border-color: #4f46e5;
    box-shadow: 0 0 0 4px rgba(79,70,229,0.12);
}

.textarea {
    height: auto;
    padding-top: 16px;
    resize: none;
}

/* ========================================
   BUTTON
======================================== */

.submit-btn {
    width: 100%;
    height: 60px;
    border: none;
    border-radius: 14px;
    background: linear-gradient(90deg, #4f46e5, #4338ca);
    color: #fff;
    font-size: 17px;
    font-weight: 700;
    cursor: pointer;
    transition: 0.3s;
}

.submit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 25px rgba(79,70,229,0.25);
}

/* ========================================
   RIGHT CONTENT
======================================== */

.contact-right-content {
    width: 45%;
}

.contact-right-content h2 {
    font-size: 40px;
    font-weight: 700;
    margin-bottom: 35px;
    color: #0f172a;
}

/* ========================================
   WHY ITEM
======================================== */

.why-item {
    display: flex;
    gap: 18px;
    margin-bottom: 28px;
}

.why-icon {
    min-width: 58px;
    height: 58px;
    border-radius: 16px;
    border: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #475569;
    font-size: 20px;
    background: #fff;
}

.why-content h4 {
    font-size: 22px;
    margin-bottom: 8px;
    color: #0f172a;
}

.why-content p {
    color: #64748b;
    line-height: 1.7;
}

/* ========================================
   CTA
======================================== */

.contact-cta {
    margin-top: 45px;
    background: linear-gradient(135deg, #4338ca, #312e81);
    border-radius: 24px;
    padding: 45px;
    color: #fff;
}

.contact-cta h3 {
    font-size: 34px;
    margin-bottom: 18px;
}

.contact-cta p {
    color: rgba(255,255,255,0.85);
    line-height: 1.8;
    margin-bottom: 28px;
}

.cta-btn {
    display: inline-block;
    padding: 16px 28px;
    background: #fff;
    color: #312e81;
    border-radius: 12px;
    font-weight: 700;
    text-decoration: none;
    transition: 0.3s;
}

.cta-btn:hover {
    transform: translateY(-2px);
}

/* ========================================
   SUCCESS MESSAGE
======================================== */

.success-message {
    display: block;
    margin-top: 15px;
    color: green;
    font-weight: 600;
}

/* ========================================
   RESPONSIVE
======================================== */

@media(max-width:991px) {

    .contact-main-wrapper {
        flex-direction: column;
    }

    .contact-form-box,
    .contact-right-content {
        width: 100%;
    }

    .contact-info-wrapper {
        flex-direction: column;
    }

    .contact-top h1 {
        font-size: 48px;
    }
}

@media(max-width:768px) {

    .contact-page {
        padding: 50px 0;
    }

    .contact-top h1 {
        font-size: 38px;
    }

    .contact-top p {
        font-size: 16px;
    }

    .form-row {
        flex-direction: column;
    }

    .form-group.half {
        width: 100%;
    }

    .contact-form-box,
    .contact-cta {
        padding: 28px;
    }

    .contact-form-box h2,
    .contact-right-content h2 {
        font-size: 30px;
    }

    .contact-card h3 {
        font-size: 20px;
    }
}
   </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- CONTACT PAGE -->
    <section class="contact-page">

        <div class="container">

            <!-- TOP TITLE -->
            <div class="contact-top">

                <div class="mini-badge">
                    <i class="fa-regular fa-message"></i>
                    WE'RE HERE TO HELP
                </div>

                <h1>Get in Touch</h1>

                <p>
                    Have questions about our courses or need career guidance?
                    Our team is ready to support your educational journey.
                </p>

            </div>

            <!-- CONTACT CARDS -->
            <div class="contact-info-wrapper">

                <!-- EMAIL -->
                <div class="contact-card">

                    <div class="contact-icon blue-icon">
                        <i class="fa-regular fa-envelope"></i>
                    </div>

                    <h4>EMAIL US</h4>

                    <h3>supportstudyisle@gmail.com</h3>

                    <p>Online support 24/7</p>

                </div>

                <!-- CALL -->
                <div class="contact-card">

                    <div class="contact-icon green-icon">
                        <i class="fa-solid fa-phone"></i>
                    </div>

                    <h4>CALL / WHATSAPP</h4>

                    <h3>+91 9588234841</h3>

                    <p>Mon-Sat, 10am - 7pm IST</p>

                </div>

                <!-- OFFICE -->
                <div class="contact-card">

                    <div class="contact-icon red-icon">
                        <i class="fa-solid fa-location-dot"></i>
                    </div>

                    <h4>OUR OFFICE</h4>

                    <h3>Bhiwadi, Rajasthan</h3>

                    <p>301019, India</p>

                </div>

            </div>

            <!-- MAIN CONTENT -->
            <div class="contact-main-wrapper">

                <!-- LEFT -->
                <div class="contact-form-box">

                    <h2>Send us a message</h2>

                    <!-- ROW -->
                    <div class="form-row">

                        <!-- FULL NAME -->
                        <div class="form-group half">

                            <label>Full Name</label>

                            <asp:TextBox
                                ID="txtFullName"
                                runat="server"
                                CssClass="form-control"
                                placeholder="John Doe">
                            </asp:TextBox>

                        </div>

                        <!-- EMAIL -->
                        <div class="form-group half">

                            <label>Email Address</label>

                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                CssClass="form-control"
                                TextMode="Email"
                                placeholder="john@example.com">
                            </asp:TextBox>

                        </div>

                    </div>

                    <!-- SUBJECT -->
                    <div class="form-group">

                        <label>Subject</label>

                        <asp:DropDownList
                            ID="ddlSubject"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="General Inquiry" Value="General Inquiry" />
                            <asp:ListItem Text="Course Enrollment" Value="Course Enrollment" />
                            <asp:ListItem Text="Career Counselling" Value="Career Counselling" />
                            <asp:ListItem Text="Technical Support" Value="Technical Support" />

                        </asp:DropDownList>

                    </div>

                    <!-- MESSAGE -->
                    <div class="form-group">

                        <label>Message</label>

                        <asp:TextBox
                            ID="txtMessage"
                            runat="server"
                            CssClass="form-control textarea"
                            TextMode="MultiLine"
                            Rows="6"
                            placeholder="How can we help you?">
                        </asp:TextBox>

                    </div>

                    <!-- BUTTON -->
                    <div class="form-group">

                        <asp:Button
                            ID="btnSubmit"
                            runat="server"
                            Text="Submit Message"
                            CssClass="submit-btn"
                            OnClick="btnSubmit_Click" />

                    </div>

                    <!-- MESSAGE -->
                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="success-message">
                    </asp:Label>

                </div>

                <!-- RIGHT -->
                <div class="contact-right-content">

                    <h2>Why Reach Out?</h2>

                    <!-- ITEM -->
                    <div class="why-item">

                        <div class="why-icon">
                            <i class="fa-regular fa-clock"></i>
                        </div>

                        <div class="why-content">
                            <h4>Quick Response</h4>
                            <p>Our team typically responds within 2-4 business hours.</p>
                        </div>

                    </div>

                    <!-- ITEM -->
                    <div class="why-item">

                        <div class="why-icon">
                            <i class="fa-solid fa-globe"></i>
                        </div>

                        <div class="why-content">
                            <h4>Global Support</h4>
                            <p>Specialized assistance for IB, IGCSE, and international boards.</p>
                        </div>

                    </div>

                    <!-- ITEM -->
                    <div class="why-item">

                        <div class="why-icon">
                            <i class="fa-regular fa-message"></i>
                        </div>

                        <div class="why-content">
                            <h4>Expert Guidance</h4>
                            <p>Connect directly with certified career analysts and senior tutors.</p>
                        </div>

                    </div>

                    <!-- CTA -->
                    <div class="contact-cta">

                        <h3>Join Class Today</h3>

                        <p>
                            Experience the difference with StudyIsle's
                            personalized learning approach.
                        </p>

                        <a href="#" class="cta-btn">
                            Book Free Demo
                        </a>

                    </div>

                </div>

            </div>

        </div>

    </section>

</asp:Content>