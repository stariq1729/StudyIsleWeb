<%@ Page Title="Verify OTP" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="VerifyOtp.aspx.cs" Inherits="StudyIsleWeb.VerifyOtp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
    .otp-wrapper {
        min-height: 100vh;
        background: linear-gradient(135deg, #4f46e5, #6366f1);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .otp-card {
        max-width: 400px;
        width: 100%;
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.15);
    }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="otp-wrapper">
    <div class="card otp-card text-center">

        <h4 class="fw-bold mb-2">Verify Your Email</h4>
        <p class="text-muted">Enter the OTP sent to your email</p>

        <asp:TextBox ID="txtOtp" runat="server"
            CssClass="form-control text-center mb-3"
            placeholder="Enter OTP"></asp:TextBox>

        <asp:Button ID="btnVerify" runat="server"
            Text="Verify OTP"
            CssClass="btn btn-primary w-100"
            OnClick="btnVerify_Click" />

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger mt-2"></asp:Label>

    </div>
</div>

</asp:Content>