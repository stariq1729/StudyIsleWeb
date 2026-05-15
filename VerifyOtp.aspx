<%@ Page Title="Verify OTP" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="VerifyOtp.aspx.cs" Inherits="StudyIsleWeb.VerifyOtp" %>

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

        .otp-wrapper {
            min-height: 90vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .otp-card {
            max-width: 420px;
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

        .form-control-otp {
            width: 100%;
            padding: 15px;
            background: var(--bg-subtle);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 8px;
            text-align: center;
            transition: all 0.2s;
            color: #1e293b;
            margin-bottom: 5px;
        }

        .form-control-otp:focus {
            outline: none;
            border-color: var(--primary-color);
            background: #fff;
            box-shadow: 0 0 0 4px rgba(91, 90, 236, 0.1);
        }

        .btn-verify {
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

        .btn-verify:hover {
            background: var(--primary-hover);
            color: white;
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

        .error-text {
            font-size: 12px;
            display: block;
            margin-top: 8px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="otp-wrapper">
        <div class="otp-card">
            
            <div class="brand-logo"><i class="fa-solid fa-envelope-circle-check"></i></div>

            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Verify Your Email</h4>
                <p class="text-muted small">Please enter the verification code sent to your inbox.</p>
            </div>

            <div class="mb-4">
                <asp:TextBox ID="txtOtp" runat="server" 
                    CssClass="form-control-otp" 
                    MaxLength="6" 
                    placeholder="000000">
                </asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvOtp" runat="server" 
                    ControlToValidate="txtOtp" 
                    ErrorMessage="OTP is required" 
                    Display="Dynamic" 
                    CssClass="error-text text-danger text-center" 
                    ValidationGroup="VerifyGroup">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <asp:LinkButton ID="btnVerify" runat="server" 
                    OnClick="btnVerify_Click" 
                    CssClass="btn-verify" 
                    ValidationGroup="VerifyGroup">
                    Verify Email <i class="fa-solid fa-arrow-right-to-bracket" style="font-size: 14px;"></i>
                </asp:LinkButton>
            </div>

            <div class="text-center">
                <asp:Label ID="lblMessage" runat="server" CssClass="error-text text-danger"></asp:Label>
            </div>

            <div class="footer-link">
                Entered the wrong email? <a href="SignUp.aspx">Go back</a>
            </div>

        </div>
    </div>

</asp:Content>