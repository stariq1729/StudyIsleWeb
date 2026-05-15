<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs"
    Inherits="StudyIsleWeb.ResetPassword" %>

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

        .reset-wrapper {
            min-height: 90vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .reset-card {
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
            margin-bottom: 5px;
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

        .btn-reset-action {
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

        .btn-reset-action:hover {
            background: var(--primary-hover);
            color: white;
        }

        .instruction {
            font-size: 11px;
            line-height: 1.4;
            color: var(--text-muted);
            margin-top: 8px;
            display: block;
        }

        .error-text {
            font-size: 11px;
            margin-top: 4px;
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="reset-wrapper">
        <div class="reset-card">
            
            <div class="brand-logo"><i class="fa-solid fa-key"></i></div>

            <div class="text-center mb-4">
                <h4 class="fw-bold mb-1">Reset Password</h4>
                <p class="text-muted small">Create a secure new password for your account.</p>
            </div>

            <div class="mb-3">
                <label class="form-label">New Password</label>
                <div class="input-group-custom">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ControlToValidate="txtNewPassword" 
                    ErrorMessage="New password is required" Display="Dynamic" CssClass="error-text text-danger" ValidationGroup="ResetGroup">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <div class="input-group-custom">
                    <i class="fa-solid fa-check-double input-icon"></i>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                </div>
                
                <asp:RequiredFieldValidator ID="rfvConfirmPass" runat="server" ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Please confirm your password" Display="Dynamic" CssClass="error-text text-danger" ValidationGroup="ResetGroup">
                </asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="cvPasswords" runat="server" 
                    ControlToCompare="txtNewPassword" 
                    ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Passwords do not match" 
                    Display="Dynamic" CssClass="error-text text-danger" ValidationGroup="ResetGroup">
                </asp:CompareValidator>

                <small class="instruction">
                    <i class="fa-solid fa-circle-info me-1"></i>
                    Must be 8+ characters with uppercase, lowercase, and a number.
                </small>
            </div>

            <div class="mt-4">
                <asp:LinkButton ID="btnResetPassword" runat="server" OnClick="btnResetPassword_Click" CssClass="btn-reset-action" ValidationGroup="ResetGroup">
                    Update Password <i class="fa-solid fa-rotate-right" style="font-size: 12px;"></i>
                </asp:LinkButton>
            </div>

            <div class="text-center mt-3">
                <asp:Label ID="lblMessage" runat="server" CssClass="error-text"></asp:Label>
            </div>

        </div>
    </div>
</asp:Content>