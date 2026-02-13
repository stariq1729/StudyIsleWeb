<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JoinTutor.aspx.cs" Inherits="StudyIsleWeb.JoinTutor" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Join Our Teaching Team - StudyIsle</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/css/join-tutor.css" rel="stylesheet" />
    <style>
        body {
    background: linear-gradient(135deg, #f1f5ff, #ffffff);
    font-family: 'Segoe UI', sans-serif;
}

.join-section {
    padding: 60px 0;
}

.join-header h2 {
    font-weight: 700;
    margin-bottom: 5px;
}

.join-header p {
    color: #6c757d;
    font-size: 14px;
}

.join-card {
    background: #ffffff;
    padding: 35px 40px;
    border-radius: 18px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.06);
    margin-top: 30px;
}

.section-title {
    font-weight: 600;
    font-size: 16px;
    color: #4f46e5;
    margin-bottom: 15px;
}

label {
    font-weight: 500;
    font-size: 14px;
}

.form-control, .form-select {
    border-radius: 8px;
    font-size: 14px;
    padding: 8px 12px;
}
/* Clean Checkbox Grid */

.subject-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 12px 20px;
    margin-top: 10px;
}

/* Each checkbox item */
.custom-check {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
    cursor: pointer;
}

/* Improve default checkbox */
.custom-check input[type="checkbox"] {
    width: 16px;
    height: 16px;
    cursor: pointer;
}


.validator {
    color: red;
    font-size: 12px;
}

.submit-btn {
    background: #4f46e5;
    color: #fff;
    padding: 10px 30px;
    border-radius: 25px;
    border: none;
    font-weight: 500;
    transition: 0.3s ease;
}

.submit-btn:hover {
    background: #4338ca;
}

    </style>
</head>
<body>

<form id="form1" runat="server">

<section class="join-section">
<div class="container">

    <!-- Header -->
    <div class="text-center join-header">
        <h2>Join Our Teaching Team</h2>
        <p>Share your knowledge. Inspire students. Grow with StudyIsle.</p>
    </div>

    <!-- Form Card -->
    <div class="join-card">

        <!-- BASIC INFO -->
        <h5 class="section-title">Basic Information</h5>

        <div class="row">

            <!-- Full Name -->
            <div class="col-md-6 mb-3">
                <label>Full Name *</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server"
                    ControlToValidate="txtName"
                    ErrorMessage="Required"
                    CssClass="validator"
                    Display="Dynamic" />
            </div>

            <!-- Mobile -->
            <div class="col-md-6 mb-3">
                <label>Mobile Number (WhatsApp) *</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                    ControlToValidate="txtMobile"
                    ErrorMessage="Required"
                    CssClass="validator"
                    Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMobile" runat="server"
                    ControlToValidate="txtMobile"
                    ValidationExpression="^[0-9]{10}$"
                    ErrorMessage="Enter valid 10 digit number"
                    CssClass="validator"
                    Display="Dynamic" />
            </div>

            <!-- Email -->
            <div class="col-md-6 mb-3">
                <label>Email ID *</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Required"
                    CssClass="validator"
                    Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ErrorMessage="Invalid Email"
                    CssClass="validator"
                    Display="Dynamic" />
            </div>

            <!-- Location -->
            <div class="col-md-6 mb-3">
                <label>Country & State *</label>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvLocation" runat="server"
                    ControlToValidate="txtLocation"
                    ErrorMessage="Required"
                    CssClass="validator"
                    Display="Dynamic" />
            </div>

        </div>

        <!-- PROFESSIONAL INFO -->
        <h5 class="section-title mt-4">Professional Details</h5>

        <div class="row">

            <div class="col-md-6 mb-3">
                <label>Highest Qualification *</label>
                <asp:DropDownList ID="ddlQualification" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select</asp:ListItem>
                    <asp:ListItem>Graduation</asp:ListItem>
                    <asp:ListItem>Post Graduation</asp:ListItem>
                    <asp:ListItem>B.Ed / M.Ed</asp:ListItem>
                    <asp:ListItem>PhD</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvQualification" runat="server"
                    InitialValue=""
                    ControlToValidate="ddlQualification"
                    ErrorMessage="Required"
                    CssClass="validator"
                    Display="Dynamic" />
            </div>

            <div class="col-md-6 mb-3">
                <label>Teaching Experience *</label>
                <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Select</asp:ListItem>
                    <asp:ListItem>Fresher</asp:ListItem>
                    <asp:ListItem>0–2 Years</asp:ListItem>
                    <asp:ListItem>2–5 Years</asp:ListItem>
                    <asp:ListItem>5+ Years</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvExperience" runat="server"
                    InitialValue=""
                    ControlToValidate="ddlExperience"
                    ErrorMessage="Required"
                    CssClass="validator"
                    Display="Dynamic" />
            </div>

        </div>

        <!-- Subjects -->
       <div class="mt-4">
    <label class="fw-semibold d-block mb-2">Subjects You Can Teach *</label>

    <div class="subject-grid">

        <label class="custom-check">
            <asp:CheckBox ID="chkMaths" runat="server" />
            <span>Maths</span>
        </label>

        <label class="custom-check">
            <asp:CheckBox ID="chkPhysics" runat="server" />
            <span>Physics</span>
        </label>

        <label class="custom-check">
            <asp:CheckBox ID="chkChemistry" runat="server" />
            <span>Chemistry</span>
        </label>

        <label class="custom-check">
            <asp:CheckBox ID="chkBiology" runat="server" />
            <span>Biology</span>
        </label>

        <label class="custom-check">
            <asp:CheckBox ID="chkEnglish" runat="server" />
            <span>English</span>
        </label>

        <label class="custom-check">
            <asp:CheckBox ID="chkComputer" runat="server" />
            <span>Computer</span>
        </label>

    </div>
</div>


        <!-- Resume -->
        <div class="mt-4">
            <label>Resume Upload (PDF) *</label>
            <asp:FileUpload ID="fileResume" runat="server" CssClass="form-control" />
        </div>

        <!-- Submit -->
        <div class="text-center mt-4">
            <asp:Button ID="btnSubmit" runat="server"
                Text="Submit Application"
                CssClass="btn submit-btn" />
        </div>

    </div>
</div>
</section>

</form>
</body>
</html>
