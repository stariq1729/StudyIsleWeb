<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StudyIsleWeb.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-wrapper {
            min-height: 100vh;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            max-width: 420px;
            width: 100%;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .btn-primary {
            background-color: #4f46e5;
            border: none;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        .form-control {
            border-radius: 10px;
            padding: 10px 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="login-wrapper">
        <div class="card login-card">

            <div class="text-center mb-4">
                <h3 class="fw-bold">Welcome Back</h3>
                <p class="text-muted mb-0">
                    Login to continue your learning journey
                </p>
            </div>

            <!-- UI ONLY - no logic -->
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                    TextMode="Email" placeholder="you@example.com"></asp:TextBox>
            </div>

            <div class="mb-2">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                    TextMode="Password" placeholder="••••••••"></asp:TextBox>
            </div>

            <div class="text-end mb-3">
                <a href="#" class="text-decoration-none small">Forgot password?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server"
                Text="Login"
                CssClass="btn btn-primary w-100 py-2" />

            <div class="text-center mt-3">
                <small>
                    Don’t have an account?
                    <a href="#" class="text-decoration-none fw-semibold">Sign up</a>
                </small>
            </div>

        </div>
    </div>

</asp:Content>
