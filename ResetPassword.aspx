<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs"
    Inherits="StudyIsleWeb.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .reset-wrapper {
            min-height: 100vh;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .reset-card {
            width: 100%;
            max-width: 430px;
            background: #fff;
            border-radius: 18px;
            padding: 35px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .reset-card h3 {
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
        .instruction {
            font-size: 0.70rem;
            color: #6b7280;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="reset-wrapper">

        <div class="reset-card">

            <!-- Heading -->
            <div class="text-center mb-4">

                <h3>Reset Password</h3>

                <p class="text-muted mb-0">
                    Create a new password for your account.
                </p>

            </div>

            <!-- New Password -->
            <div class="mb-3">

                <label class="form-label">
                    New Password
                </label>

                <asp:TextBox ID="txtNewPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Enter new password">
                </asp:TextBox>

                

            </div>

            <!-- Confirm Password -->
            <div class="mb-3">

                <label class="form-label">
                    Confirm Password
                </label>

                <asp:TextBox ID="txtConfirmPassword"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Password"
                    placeholder="Confirm new password">
                </asp:TextBox>
                <small class="text-muted instruction">
    Password must be at least 8 characters and include uppercase,
    lowercase, and a number.
</small>
            </div>

            <!-- Button -->
            <div class="d-grid mb-3">

                <asp:Button ID="btnResetPassword"
                    runat="server"
                    Text="Update Password"
                    CssClass="btn btn-reset"
                    OnClick="btnResetPassword_Click" />

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