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

.google-btn img {
    width: 20px;
    height: 20px;
}

.divider {
    display: flex;
    align-items: center;
    text-align: center;
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

   <div class="login-wrapper">
    <div class="card login-card">

        <!-- Header -->
        <div class="text-center mb-4">
            <h3 class="fw-bold">Welcome Back</h3>
            <p class="text-muted mb-0">
                Login to continue your learning journey
            </p>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server"
                CssClass="form-control"
                TextMode="Email"
                placeholder="you@example.com">
            </asp:TextBox>
        </div>

        <!-- Password -->
        <div class="mb-2">
            <label class="form-label">Password</label>
            <asp:TextBox ID="txtPassword" runat="server"
                CssClass="form-control"
                TextMode="Password"
                placeholder="••••••••">
            </asp:TextBox>
        </div>

        <!-- Forgot -->
        <div class="text-end mb-3">
            <a href="#" class="text-decoration-none small">
                Forgot password?
            </a>
        </div>

        <!-- Login Button -->
        <asp:Button ID="btnLogin" runat="server"
            Text="Login"
            OnClick="btnLogin_Click"
            CssClass="btn btn-primary w-100 py-2" />
                <!-- Divider -->
        <div class="divider">
            <span>OR</span>
        </div>

                <!-- Google Sign-In (UI Only) -->
        <div class="mb-3">
           <asp:Button ID="btnGoogleLogin" runat="server"
    Text="Continue with Google"
    CssClass="google-btn w-100"
    OnClick="btnGoogleLogin_Click" />
<%--  OnClick="btnGoogleLogin_Click" remove the OnClick event handler for btnGoogleLogin since it's not implemented yet--%>
        </div>


    </div>
</div>


</asp:Content>
