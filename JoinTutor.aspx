<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JoinTutor.aspx.cs" Inherits="StudyIsleWeb.JoinTutor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Join Our Teaching Team - StudyIsle</title>

  
    <link href="Content/css/join-tutor.css" rel="stylesheet" />

    <style>
     .join-section {
    background: linear-gradient(135deg, #f1f5ff, #ffffff);
    padding: 60px 0;
}
        .join-section { padding: 60px 0; }
        .join-header h2 { font-weight: 700; margin-bottom: 5px; }
        .join-header p { color: #6c757d; font-size: 14px; }
        .join-card { background: #fff; padding: 35px 40px; border-radius: 18px; box-shadow: 0 15px 40px rgba(0,0,0,0.06); margin-top: 30px; }
        .section-title { font-weight: 600; font-size: 16px; color: #4f46e5; margin-bottom: 15px; }
        label { font-weight: 500; font-size: 14px; }
        .form-control, .form-select { border-radius: 8px; font-size: 14px; padding: 8px 12px; }
        .subject-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 12px 20px; margin-top: 10px; }
        .custom-check { display: flex; align-items: center; gap: 8px; font-size: 14px; cursor: pointer; }
        .validator { color: red; font-size: 12px; }
        .submit-btn { background: #4f46e5; color: #fff; padding: 10px 30px; border-radius: 25px; border: none; }
    </style>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="join-section">
<div class="container">

    <div class="text-center join-header">
        <h2>Join Our Teaching Team</h2>
        <p>Share your knowledge. Inspire students. Grow with StudyIsle.</p>
    </div>

    <div class="join-card">

        <!-- BASIC -->
        <h5 class="section-title">Basic Information</h5>
        <div class="row">

            <div class="col-md-6 mb-3">
                <label>Full Name *</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
            </div>

            <div class="col-md-6 mb-3">
                <label>Mobile *</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" />
            </div>

            <div class="col-md-6 mb-3">
                <label>Email *</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
            </div>

            <div class="col-md-6 mb-3">
                <label>Location *</label>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
            </div>

        </div>

        <!-- PROFESSIONAL -->
        <h5 class="section-title mt-4">Professional Details</h5>
        <div class="row">

            <div class="col-md-6 mb-3">
                <label>Qualification *</label>
                <asp:DropDownList ID="ddlQualification" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select</asp:ListItem>
                    <asp:ListItem>Graduation</asp:ListItem>
                    <asp:ListItem>Post Graduation</asp:ListItem>
                    <asp:ListItem>B.Ed / M.Ed</asp:ListItem>
                    <asp:ListItem>PhD</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label>Experience *</label>
                <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select</asp:ListItem>
                    <asp:ListItem>Fresher</asp:ListItem>
                    <asp:ListItem>2 Years</asp:ListItem>
                    <asp:ListItem>5+ Years</asp:ListItem>
                </asp:DropDownList>
            </div>

        </div>

        <!-- SUBJECTS -->
        <div class="mt-4">
            <label>Subjects *</label>
            <div class="subject-grid">
                <asp:CheckBox ID="chkMaths" runat="server" Text="Maths" />
                <asp:CheckBox ID="chkPhysics" runat="server" Text="Physics" />
                <asp:CheckBox ID="chkChemistry" runat="server" Text="Chemistry" />
                <asp:CheckBox ID="chkBiology" runat="server" Text="Biology" />
                <asp:CheckBox ID="chkEnglish" runat="server" Text="English" />
                <asp:CheckBox ID="chkComputer" runat="server" Text="Computer" />
            </div>
        </div>

        <!-- EMPLOYMENT -->
        <div class="mt-4">
            <label>Employment *</label>
            <asp:DropDownList ID="ddlEmployment" runat="server" CssClass="form-select">
                <asp:ListItem Value="">Select</asp:ListItem>
                <asp:ListItem>School</asp:ListItem>
                <asp:ListItem>Institute</asp:ListItem>
                <asp:ListItem>Freelancer</asp:ListItem>
            </asp:DropDownList>
        </div>

        <!-- CLASSES -->
        <div class="mt-4">
            <label>Classes *</label>
            <div class="subject-grid">
                <asp:CheckBox ID="chk6to8" runat="server" Text="6-8" />
                <asp:CheckBox ID="chk9to10" runat="server" Text="9-10" />
                <asp:CheckBox ID="chk11to12" runat="server" Text="11-12" />
            </div>
        </div>

        <!-- BOARDS -->
        <div class="mt-4">
            <label>Boards *</label>
            <div class="subject-grid">
                <asp:CheckBox ID="chkCBSE" runat="server" Text="CBSE" />
                <asp:CheckBox ID="chkICSE" runat="server" Text="ICSE" />
                <asp:CheckBox ID="chkIB" runat="server" Text="IB" />
                <asp:CheckBox ID="chkIGCSE" runat="server" Text="IGCSE" />
                <asp:CheckBox ID="chkAP" runat="server" Text="AP" />
                <asp:CheckBox ID="chkStateBoard" runat="server" Text="State Board" />
            </div>
        </div>

        <!-- DEMO -->
        <div class="mt-4">
            <label>Demo Link</label>
            <asp:TextBox ID="txtDemoLink" runat="server" CssClass="form-control" />
        </div>

        <!-- RESUME -->
        <div class="mt-4">
            <label>Resume</label>
            <asp:FileUpload ID="fileResume" runat="server" CssClass="form-control" />
        </div>

        <div class="text-center mt-4">
            <asp:Button ID="btnSubmit" runat="server"
                Text="Submit Application"
                CssClass="btn submit-btn"
                OnClick="btnSubmit_Click" />
        </div>

    </div>
</div>
</section>

</asp:Content>