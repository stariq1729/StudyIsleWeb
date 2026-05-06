<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GalleryDetails.aspx.cs" Inherits="StudyIsleWeb.GalleryDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        /* =========================================
           GALLERY DETAILS PAGE
        ========================================= */

        .gallery-details-page {
            background: #f7f8fc;
            
            padding-bottom: 40px;
        }

        /* TOP IMAGE SECTION */

        .details-hero-section {
            background: #020617;
           /* border-radius: 0 0 40px 40px;*/
            padding: 10px 0;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .details-image-wrap {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .details-main-image {
            width: 100%;
            max-width: 520px;
            height: 650px;
            object-fit: cover;
            border-radius: 18px;
            box-shadow: 0 18px 50px rgba(0,0,0,0.35);
        }

        /* CONTENT AREA */

        .details-content-grid {
            display: grid;
            grid-template-columns: 1.4fr 0.7fr;
            gap: 45px;
            align-items: start;
        }

        /* LEFT */

        .details-left {
            width: 100%;
        }

        .details-top-meta {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

       .details-tag {
            background: #7367ff;
            color: #ffffff;
            padding: 7px 14px;
            border-radius: 30px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .details-date {
            font-size: 12px;
            color: #64748b;
            font-weight: 600;
        }

        .details-title {
            font-size: 38px;
            line-height: 1.1;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 26px;
        }

        .details-description-box {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            padding: 20px 22px;
        }

        .details-description {
            font-size: 12px;
            line-height: 1.6;
            color: #475569;
            margin: 0;
            font-style: italic;
        }

        /* RIGHT CARDS */

        .details-right {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .info-card-dark {
            background: #0f172a;
            border-radius: 24px;
            padding: 22px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
        }

        .info-card-dark::before {
            content: "";
            position: absolute;
            width: 140px;
            height: 140px;
            border-radius: 50%;
            background: rgba(255,255,255,0.04);
            right: -60px;
            top: -60px;
        }

        .info-card-light {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 22px;
        }

        .card-small-title {
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 14px;
            color: #8b5cf6;
        }

        .dark-main-title {
            font-size: 20px;
            font-weight: 700;
            line-height: 1.4;
            margin-bottom: 16px;
            color: #ffffff;
        }

        .dark-address {
            font-size: 14px;
            line-height: 1.6;
            color: rgba(255,255,255,0.75);
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 18px;
        }

        .contact-item:last-child {
            margin-bottom: 0;
        }

        .contact-icon {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            color: #6366f1;
        }

        .contact-text {
            font-size: 15px;
            font-weight: 600;
            color: #334155;
        }

        /* RESPONSIVE */

        @media(max-width:991px) {

            .details-content-grid {
                grid-template-columns: 1fr;
            }

            .details-title {
                font-size: 42px;
            }

            .details-main-image {
                height: 360px;
            }
        }

        @media(max-width:768px) {

            .gallery-details-page {
                padding-top: 95px;
            }

            .details-hero-section {
                padding: 40px 0;
                border-radius: 0 0 30px 30px;
            }

            .details-main-image {
                height: 280px;
                border-radius: 16px;
            }

            .details-title {
                font-size: 32px;
            }

            .details-description {
                font-size: 15px;
            }

            .details-description-box,
            .info-card-dark,
            .info-card-light {
                padding: 22px;
            }
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="gallery-details-page">

        <!-- HERO IMAGE -->

        <div class="details-hero-section">

            <div class="container">

                <div class="details-image-wrap">

                    <asp:Image ID="imgGallery"
                        runat="server"
                        CssClass="details-main-image" />

                </div>

            </div>

        </div>

        <!-- CONTENT -->

        <div class="container">

            <div class="details-content-grid">

                <!-- LEFT -->

                <div class="details-left">

                    <!-- META -->

                    <div class="details-top-meta">

                        

                        <div class="details-date">

                            <asp:Literal ID="litDate"
                                runat="server">
                            </asp:Literal>

                        </div>

                    </div>

                    <!-- TITLE -->

                    <h1 class="details-title">

                        <asp:Literal ID="litTitle"
                            runat="server">
                        </asp:Literal>

                    </h1>

                    <!-- DESCRIPTION -->

                    <div class="details-description-box">

                        <p class="details-description">

                            <asp:Literal ID="litDescription"
                                runat="server">
                            </asp:Literal>

                        </p>

                    </div>

                </div>

                <!-- RIGHT -->

                <div class="details-right">

                    <!-- LOCATION CARD -->

                    <div class="info-card-dark">

                        <div class="card-small-title">
                            Our Location
                        </div>

                        <div class="dark-main-title">
                            StudyIsle Institute Campus
                        </div>

                        <div class="dark-address">
                            Academic Block B, Floor 2<br />
                            Downtown Education Hub,<br />
                            Sector 12
                        </div>

                    </div>

                    <!-- CONTACT CARD -->

                    <div class="info-card-light">

                        <div class="card-small-title">
                            Contact Us
                        </div>

                        <!-- PHONE -->

                        <div class="contact-item">

                            <div class="contact-icon">
                                ☎
                            </div>

                            <div class="contact-text">
                                +91 98765-43210
                            </div>

                        </div>

                        <!-- EMAIL -->

                        <div class="contact-item">

                            <div class="contact-icon">
                                ✉
                            </div>

                            <div class="contact-text">
                                admissions@studyisle.com
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>
