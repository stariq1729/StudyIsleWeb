<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="StudyIsleWeb.SignUp" %>

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
        background-color: #f8fafc;
        background-image: 
            linear-gradient(30deg, #e2e8f0 12%, transparent 72.5%, transparent 87%, #e2e8f0 87.5%, #e2e8f0),
            linear-gradient(150deg, #e2e8f0 12%, transparent 72.5%, transparent 87%, #e2e8f0 87.5%, #e2e8f0),
            linear-gradient(30deg, #e2e8f0 12%, transparent 72.5%, transparent 87%, #e2e8f0 87.5%, #e2e8f0),
            linear-gradient(150deg, #e2e8f0 12%, transparent 72.5%, transparent 87%, #e2e8f0 87.5%, #e2e8f0),
            linear-gradient(60deg, #cbd5e1 25%, transparent 25.5%, transparent 75%, #cbd5e1 75%, #cbd5e1),
            linear-gradient(60deg, #cbd5e1 25%, transparent 25.5%, transparent 75%, #cbd5e1 75%, #cbd5e1);
        background-size: 80px 140px;
        background-position: 0 0, 0 0, 40px 70px, 40px 70px, 0 0, 40px 70px;
    }

    .signup-wrapper {
        min-height: 90vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .signup-card {
        max-width: 450px;
        width: 100%;
        background: #ffffff;
        border-radius: 24px;
        padding: 40px;
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        border: none;
    }

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
        margin-bottom: 8px;
        display: block;
    }

    .input-group-custom {
        position: relative;
        margin-bottom: 5px; /* Space for validator */
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

    .error-text {
        color: #ef4444;
        font-size: 11px;
        display: block;
        margin-bottom: 15px;
    }

    .btn-signup {
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
        text-decoration: none;
    }

    .btn-signup:hover { background: var(--primary-hover); color: white; }

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
        text-decoration: none;
    }

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
    <div class="signup-wrapper">
        <div class="signup-card">
            
            <div class="brand-logo">E</div>

            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Create Account</h4>
                <p class="text-muted small">Start your success journey with EduLead.</p>
            </div>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <div class="input-group-custom">
                    <i class="fa-regular fa-user input-icon"></i>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control-custom" placeholder="Enter your name"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                    ErrorMessage="Name is required" Display="Dynamic" CssClass="error-text" ValidationGroup="SignupGroup">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group-custom">
                    <i class="fa-regular fa-envelope input-icon"></i>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-custom" TextMode="Email" placeholder="name@example.com"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" Display="Dynamic" CssClass="error-text" ValidationGroup="SignupGroup">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <div class="input-group-custom">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" Display="Dynamic" CssClass="error-text" ValidationGroup="SignupGroup">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mt-4">
                <asp:LinkButton ID="btnSignup" runat="server" OnClick="btnSignup_Click" CssClass="btn-signup" ValidationGroup="SignupGroup">
                    Create Account <i class="fa-solid fa-chevron-right" style="font-size: 12px;"></i>
                </asp:LinkButton>
            </div>

            <div class="divider">
                <span>Or continue with</span>
            </div>

            <div class="mb-3">
                <asp:LinkButton ID="btnGoogleSignup" runat="server" OnClick="btnGoogleSignup_Click" CssClass="google-btn-custom" CausesValidation="false">
                    <img src="https://www.gstatic.com/images/branding/product/1x/gsa_512dp.png" width="18" alt="G" />
                    Google
                </asp:LinkButton>
            </div>

            <div class="footer-link">
                ALREADY HAVE AN ACCOUNT? <a href="Login.aspx">Sign in</a>
            </div>

        </div>
    </div>
</asp:Content>