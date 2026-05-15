<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StudyIsleWeb.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
     
    :root {
        --primary-color: #5b5aec;
        --primary-hover: #4a49d1;
        --bg-subtle: #f8fafc;
        --text-muted: #64748b;
        --border-color: #e2e8f0;
    }

    body {
        background-color: #f3f4f6;
        /* Subtle geometric pattern background */
        background-image: radial-gradient(#d1d5db 0.5px, transparent 0.5px);
        background-size: 20px 20px;
    }

    .login-wrapper {
        min-height: 90vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .login-card {
        max-width: 450px;
        width: 100%;
        background: #ffffff;
        border-radius: 24px;
        padding: 40px;
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        border: none;
        position: relative;
    }

    /* Floating Logo */
    .brand-logo {
        width: 48px;
        height: 48px;
        background: var(--primary-color);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 1.2rem;
        margin: 0 auto 24px auto;
        box-shadow: 0 4px 12px rgba(91, 90, 236, 0.3);
    }

    .form-label {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: var(--text-muted);
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 8px;
    }

    .input-group-custom {
        position: relative;
        margin-bottom: 20px;
    }

    .input-icon {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-muted);
        font-size: 14px;
    }

    .form-control-custom {
        width: 100%;
        padding: 12px 12px 12px 40px;
        background: var(--bg-subtle);
        border: 1px solid var(--border-color);
        border-radius: 10px;
        font-size: 14px;
        transition: all 0.2s;
    }

    .form-control-custom:focus {
        outline: none;
        border-color: var(--primary-color);
        background: #fff;
        box-shadow: 0 0 0 4px rgba(91, 90, 236, 0.1);
    }

    .btn-login {
        background: var(--primary-color);
        color: white;
        border: none;
        border-radius: 10px;
        padding: 12px;
        font-weight: 600;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: background 0.2s;
        cursor: pointer;
    }

    .btn-login:hover {
        background: var(--primary-hover);
    }

    .divider {
        display: flex;
        align-items: center;
        text-align: center;
        margin: 24px 0;
        color: var(--text-muted);
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
    }

    .divider::before, .divider::after {
        content: "";
        flex: 1;
        border-bottom: 1px solid var(--border-color);
    }

    .divider span { padding: 0 15px; }

    .google-btn-custom {
        width: 100%;
        background: #fff;
        border: 1px solid var(--border-color);
        border-radius: 10px;
        padding: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        font-weight: 500;
        color: #333;
        transition: background 0.2s;
        cursor: pointer;
    }

    .google-btn-custom:hover { background: #f9fafb; }

    .footer-link {
        text-align: center;
        margin-top: 24px;
        font-size: 14px;
        color: var(--text-muted);
    }

    .footer-link a {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 600;
    }


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-wrapper">
        <div class="login-card">
            
            <div class="brand-logo">S</div>

            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Welcome Back</h4>
                <p class="text-muted small">Continue your journey to success.</p>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group-custom">
                    <i class="fa-regular fa-envelope input-icon"></i>
                    <asp:TextBox ID="txtEmail" runat="server" 
                        CssClass="form-control-custom" 
                        TextMode="Email" 
                        placeholder="name@example.com">
                    </asp:TextBox>
                </div>
            </div>

            <div class="mb-3">
                <div class="form-label">
                    <span>Password</span>
                    <a href="ForgotPassword.aspx" class="text-decoration-none" style="font-size: 10px;">FORGOT?</a>
                </div>
                <div class="input-group-custom">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <asp:TextBox ID="txtPassword" runat="server" 
                        CssClass="form-control-custom" 
                        TextMode="Password" 
                        placeholder="••••••••">
                    </asp:TextBox>
                </div>
            </div>

            <div class="mt-4">
                <asp:LinkButton ID="btnLogin" runat="server" OnClick="btnLogin_Click" CssClass="btn-login">
                    Sign In <i class="fa-solid fa-chevron-right" style="font-size: 12px;"></i>
                </asp:LinkButton>
            </div>

            <div class="divider">
                <span>Or continue with</span>
            </div>

            <div class="mb-3">
                <asp:LinkButton ID="btnGoogleLogin" runat="server" OnClick="btnGoogleLogin_Click" CssClass="google-btn-custom">
                    <img src="https://www.gstatic.com/images/branding/product/1x/gsa_512dp.png" width="18" alt="G" />
                    Google
                </asp:LinkButton>
            </div>

            <div class="footer-link">
                Don't have an account? <a href="SignUp.aspx">Sign up</a>
            </div>

        </div>
    </div>
</asp:Content>
