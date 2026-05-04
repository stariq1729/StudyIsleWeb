<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CareerGuidance.aspx.cs" Inherits="StudyIsleWeb.CareerGuidance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets\css\Enquiry.css" rel="stylesheet" />
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
</asp:Content>
