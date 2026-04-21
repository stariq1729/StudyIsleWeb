<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="StudyIsleWeb.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .signup-wrapper {
            min-height: 100vh;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .signup-card {
            max-width: 420px;
            width: 100%;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .form-control {
            border-radius: 10px;
            padding: 10px 14px;
        }

        .btn-primary {
            background-color: #4f46e5;
            border: none;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        .google-btn {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 500;
            cursor: pointer;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #ddd;
        }

        .divider span {
            padding: 0 10px;
            font-size: 13px;
            color: #666;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="signup-wrapper">
        <div class="card signup-card">

            <!-- Header -->
            <div class="text-center mb-4">
                <h3 class="fw-bold">Create Account</h3>
                <p class="text-muted mb-0">
                    Start your success journey with StudyIsle
                </p>
            </div>

            <!-- Full Name -->
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtName" runat="server"
                    CssClass="form-control"
                    placeholder="Enter your name"></asp:TextBox>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="form-control"
                    TextMode="Email"
                    placeholder="Email@example.com"></asp:TextBox>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="••••••••"></asp:TextBox>
            </div>

            <!-- Create Button -->
            <asp:Button ID="btnSignup" runat="server"
                Text="Create Account"
                CssClass="btn btn-primary w-100 py-2"
                OnClick="btnSignup_Click" />

            <!-- Divider -->
            <div class="divider">
                <span>OR CONTINUE WITH</span>
            </div>

            <!-- Google -->
            <asp:Button ID="btnGoogleSignup" runat="server"
                Text="Continue with Google"
                CssClass="google-btn w-100"
                OnClick="btnGoogleSignup_Click" />

            <!-- Login Redirect -->
            <div class="text-center mt-3">
                <small>
                    Already have an account?
                    <a href="Login.aspx" class="fw-semibold text-decoration-none">
                        Sign in
                    </a>
                </small>
            </div>

        </div>
    </div>

</asp:Content>