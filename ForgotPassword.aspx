<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs"
    Inherits="StudyIsleWeb.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .forgot-wrapper {
            min-height: 100vh;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .forgot-card {
            width: 100%;
            max-width: 430px;
            border-radius: 18px;
            padding: 35px;
            background: #fff;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .forgot-card h3 {
            font-weight: 700;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 14px;
        }

        .btn-reset {
            background: #4f46e5;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
        }

        .btn-reset:hover {
            background: #4338ca;
        }

        .back-link {
            text-decoration: none;
            font-size: 14px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="forgot-wrapper">

        <div class="forgot-card">

            <!-- Heading -->
            <div class="text-center mb-4">

                <h3>Forgot Password?</h3>

                <p class="text-muted mb-0">
                    Enter your email and we'll send you an OTP
                    to reset your password.
                </p>

            </div>

            <!-- Email -->
            <div class="mb-3">

                <label class="form-label">Email Address</label>

                <asp:TextBox ID="txtEmail"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Email"
                    placeholder="you@example.com">
                </asp:TextBox>

            </div>

            <!-- Button -->
            <div class="d-grid mb-3">

                <asp:Button ID="btnSendOtp"
                    runat="server"
                    Text="Send OTP"
                    CssClass="btn btn-reset"
                    OnClick="btnSendOtp_Click" />

            </div>

            <!-- Message -->
            <div class="text-center mb-3">

                <asp:Label ID="lblMessage"
                    runat="server"
                    ForeColor="Red">
                </asp:Label>

            </div>

            <!-- Back -->
            <div class="text-center">

                <a href="Login.aspx" class="back-link">
                    ← Back to Login
                </a>

            </div>

        </div>

    </div>

</asp:Content>