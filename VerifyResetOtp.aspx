<%@ Page Title="Verify OTP" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="VerifyResetOtp.aspx.cs"
    Inherits="StudyIsleWeb.VerifyResetOtp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .otp-wrapper {
            min-height: 100vh;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .otp-card {
            width: 100%;
            max-width: 420px;
            background: #fff;
            border-radius: 18px;
            padding: 35px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .otp-card h3 {
            font-weight: 700;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 14px;
            text-align: center;
            font-size: 20px;
            letter-spacing: 4px;
        }

        .btn-verify {
            background: #4f46e5;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
        }

        .btn-verify:hover {
            background: #4338ca;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="otp-wrapper">

        <div class="otp-card">

            <!-- Heading -->
            <div class="text-center mb-4">

                <h3>Verify OTP</h3>

                <p class="text-muted mb-0">
                    Enter the 6-digit OTP sent to your email.
                </p>

            </div>

            <!-- OTP -->
            <div class="mb-3">

                <asp:TextBox ID="txtOtp"
                    runat="server"
                    CssClass="form-control"
                    MaxLength="6"
                    placeholder="000000">
                </asp:TextBox>

            </div>

            <!-- Button -->
            <div class="d-grid mb-3">

                <asp:Button ID="btnVerifyOtp"
                    runat="server"
                    Text="Verify OTP"
                    CssClass="btn btn-verify"
                    OnClick="btnVerifyOtp_Click" />

            </div>

            <!-- Message -->
            <div class="text-center">

                <asp:Label ID="lblMessage"
                    runat="server"
                    ForeColor="Red">
                </asp:Label>

            </div>

        </div>

    </div>

</asp:Content>