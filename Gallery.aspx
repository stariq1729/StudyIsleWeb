<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="StudyIsleWeb.Gallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        /* =========================================
   GALLERY HERO SECTION
========================================= */

.gallery-hero-section {
    padding-top: 40px;
    padding-bottom: 60px;
    background: #f7f8fc;
}

/* TOP LABEL */

.spotlight-top {
    position: relative;
    margin-bottom: 22px;
}

.spotlight-line {
    width: 100%;
    height: 1px;
    background: #d9dff1;
}

.spotlight-badge {
    position: absolute;
    left: 50%;
    top: -10px;
    transform: translateX(-50%);
    background: #f7f8fc;
    padding: 0 18px;
    font-size: 10px;
    font-weight: 700;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: #7367ff;
}

/* HERO CARD */

.hero-card {
    position: relative;
    width: 100%;
    height: 450px;
    border-radius: 32px;
    overflow: hidden;
    display: block;
    text-decoration: none;
    box-shadow: 0 18px 50px rgba(0,0,0,0.12);
}

/* IMAGE */

.hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    transition: 0.5s ease;
}

.hero-card:hover .hero-image {
    transform: scale(1.04);
}

/* OVERLAY */

.hero-overlay {
    position: absolute;
    inset: 0;
    background:
        linear-gradient(
            to top,
            rgba(0,0,0,0.88) 10%,
            rgba(0,0,0,0.40) 45%,
            rgba(0,0,0,0.10) 100%
        );
}

/* CONTENT */

.hero-content {
    position: absolute;
    left: 45px;
    bottom: 40px;
    z-index: 5;
    max-width: 650px;
    color: #ffffff;
}


.hero-title {
    font-size: 38px;
    line-height: 1.05;
    font-weight: 800;
    margin-bottom: 18px;
    color: #ffffff;
}

.hero-description {
    font-size: 12px;
    line-height: 1.7;
    color: rgba(255,255,255,0.92);
    margin-bottom: 20px;
}

/* FOOTER */

.hero-footer {
    display: flex;
    align-items: center;
    gap: 16px;
}

.hero-date {
    padding: 11px 18px;
    border-radius: 40px;
    background: rgba(255,255,255,0.14);
    backdrop-filter: blur(10px);
    font-size: 12px;
    font-weight: 600;
    color: #ffffff;
}

.hero-arrow {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #ffffff;
    color: #111827;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    transition: 0.3s;
}

.hero-card:hover .hero-arrow {
    transform: rotate(-45deg);
}

/* RESPONSIVE */

@media(max-width:991px) {

    .hero-card {
        height: 460px;
    }

    .hero-content {
        left: 30px;
        right: 30px;
        bottom: 30px;
    }

    .hero-title {
        font-size: 42px;
    }

    .hero-description {
        font-size: 16px;
    }
}

@media(max-width:768px) {

    .gallery-hero-section {
        padding-top: 105px;
    }

    .hero-card {
        height: 350px;
        border-radius: 24px;
    }

    .hero-content {
        left: 22px;
        right: 22px;
        bottom: 22px;
    }

    .hero-title {
        font-size: 30px;
    }

    .hero-description {
        font-size: 14px;
        line-height: 1.6;
    }

    .hero-footer {
        flex-wrap: wrap;
    }
}
/* =========================================
   INSTITUTE FEED SECTION
========================================= */

.institute-feed-section {
    padding-bottom: 60px;
    background: #f7f8fc;
}

/* HEADER */

.feed-header {
    margin-bottom: 38px;
}

.feed-title {
    font-size: 34px;
    line-height: 1;
    font-weight: 800;
    color: #0f172a;
    margin-bottom: 6px;
}

.feed-subtitle {
    font-size: 14px;
    color: #64748b;
    line-height: 1.2;
}

/* GRID */

.feed-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px !important;
}

/* CARD */

.feed-card {
    position: relative;
    height: 260px;
    width: 320px;
    border-radius: 28px;
    overflow: hidden;
    display: block;
    text-decoration: none;
    background: #e2e8f0;
    box-shadow: 0 10px 20px rgba(0,0,0,0.08);
}

/* IMAGE */

.feed-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: 0.5s ease;
}

.feed-card:hover .feed-image {
    transform: scale(1.08);
}

/* OVERLAY */

.feed-overlay {
    position: absolute;
    inset: 0;
    background:
        linear-gradient(
            to top,
            rgba(0,0,0,0.88) 0%,
            rgba(0,0,0,0.25) 45%,
            rgba(0,0,0,0.05) 100%
        );

    opacity: 0;
    transition: 0.4s ease;
}

.feed-card:hover .feed-overlay {
    opacity: 1;
}

/* CONTENT */

.feed-content {
    position: absolute;
    left: 22px;
    right: 22px;
    bottom: 22px;
    z-index: 5;
    color: #ffffff;

    transform: translateY(30px);
    opacity: 0;
    transition: 0.4s ease;
}

.feed-card:hover .feed-content {
    transform: translateY(0);
    opacity: 1;
}

/* TAG */

/* TITLE */

.feed-card-title {
    font-size: 22px;
    line-height: 1.1;
    font-weight: 700;
    margin-bottom: 8px;
    color: #ffffff;
}

/* DESCRIPTION */

.feed-card-description {
    font-size: 12px;
    line-height: 1.2;
    color: rgba(255,255,255,0.88);
    margin-bottom: 12px;
}

/* FOOTER */

.feed-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.feed-date {
    font-size: 12px;
    font-weight: 600;
    color: rgba(255,255,255,0.92);
}

.feed-arrow {
    width: 26px;
    height: 26px;
    border-radius: 50%;
    background: rgba(255,255,255,0.16);
    backdrop-filter: blur(10px);

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 14px;
    color: #ffffff;

    transition: 0.3s;
}

.feed-card:hover .feed-arrow {
    transform: rotate(-45deg);
}

/* RESPONSIVE */

@media(max-width:991px) {

    .feed-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .feed-title {
        font-size: 42px;
    }
}

@media(max-width:768px) {

    .institute-feed-section {
        padding-bottom: 60px;
    }

    .feed-grid {
        grid-template-columns: 1fr;
        gap: 22px;
    }

    .feed-card {
        height: 240px;
        border-radius: 22px;
    }

    .feed-title {
        font-size: 34px;
    }

    .feed-subtitle {
        font-size: 15px;
    }

    .feed-card-title {
        font-size: 24px;
    }
}
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- =========================================
         GALLERY HERO SECTION
    ========================================== -->

   <div class="gallery-hero-section">

    <div class="container">

        <!-- TOP LABEL -->

        <div class="spotlight-top">

            <div class="spotlight-line"></div>

            <div class="spotlight-badge">
                Latest Spotlight
            </div>

        </div>

        <!-- HERO REPEATER -->

        <asp:Repeater ID="rptHeroGallery" runat="server">

            <ItemTemplate>

                <a href='GalleryDetails.aspx?id=<%# Eval("GalleryId") %>'
                    class="hero-card">

                    <!-- IMAGE -->

                    <img src='<%# Eval("ImagePath") %>'
                        alt='<%# Eval("Title") %>'
                        class="hero-image" />

                    <!-- OVERLAY -->

                    <div class="hero-overlay"></div>

                    <!-- CONTENT -->

                    <div class="hero-content">

                     

                        <h1 class="hero-title">
                            <%# Eval("Title") %>
                        </h1>

                        <p class="hero-description">
                            <%# Eval("Description") %>
                        </p>

                        <div class="hero-footer">

                            <div class="hero-date">
                                <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                            </div>

                            <div class="hero-arrow">
                                ↗
                            </div>

                        </div>

                    </div>

                </a>

            </ItemTemplate>

        </asp:Repeater>

    </div>

</div>
    <!-- =========================================
     INSTITUTE FEED SECTION
========================================= -->

<div class="institute-feed-section">

    <div class="container">

        <!-- HEADER -->

        <div class="feed-header">

            <h2 class="feed-title">
                Institute Feed
            </h2>

            <p class="feed-subtitle">
                Daily updates and highlights from StudyIsle Institute.
            </p>

        </div>

        <!-- GRID -->

        <div class="feed-grid">

            <asp:Repeater ID="rptGalleryFeed" runat="server">

                <ItemTemplate>

                    <a href='GalleryDetails.aspx?id=<%# Eval("GalleryId") %>'
                        class="feed-card">

                        <!-- IMAGE -->

                        <img src='<%# Eval("ImagePath") %>'
                            alt='<%# Eval("Title") %>'
                            class="feed-image" />

                        <!-- OVERLAY -->

                        <div class="feed-overlay"></div>

                        <!-- CONTENT -->

                        <div class="feed-content">

                            

                            <h3 class="feed-card-title">
                                <%# Eval("Title") %>
                            </h3>

                            <p class="feed-card-description">
                                <%# Eval("Description") %>
                            </p>

                            <div class="feed-footer">

                                <div class="feed-date">
                                    <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                                </div>

                                <div class="feed-arrow">
                                    ↗
                                </div>

                            </div>

                        </div>

                    </a>

                </ItemTemplate>

            </asp:Repeater>

        </div>

    </div>

</div>
</asp:Content>
