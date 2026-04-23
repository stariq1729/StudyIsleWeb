<%@ Page Title="Setup Profile" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="StudentRegister.aspx.cs"
    Inherits="StudyIsleWeb.Student.StudentRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    :root {
        --primary-blue: #4e46e5;
        --bg-light: #f8fafc;
        --text-dark: #1e293b;
        --text-muted: #64748b;
        --border-color: #e2e8f0;
    }

    body { background-color: #f1f5f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

    /* Main Container Card */
    .onboarding-card {
        background: #ffffff;
        border-radius: 24px;
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02);
        border: none;
        max-width: 650px;
        margin: 40px auto;
        padding: 40px;
    }

    /* Progress Steps Indicators */
    .step-indicator-container {
        display: flex;
        gap: 8px;
        justify-content: flex-end;
    }
    .step-bar {
        height: 6px;
        width: 30px;
        background: #e2e8f0;
        border-radius: 10px;
    }
    .step-bar.active { background: var(--primary-blue); }

    /* Avatar Section */
    .avatar-wrapper { position: relative; width: 100px; margin: 0 auto 20px; }
    .main-avatar {
        width: 100px; height: 100px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid #fff;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .camera-btn {
        position: absolute; bottom: 0; right: 0;
        background: var(--primary-blue);
        color: white; border-radius: 50%;
        width: 32px; height: 32px;
        display: flex; align-items: center; justify-content: center;
        cursor: pointer; border: 2px solid #fff;
    }
    .avatar-presets { display: flex; gap: 10px; justify-content: center; margin-top: 15px; }
    .preset-img {
        width: 40px; height: 40px; border-radius: 50%;
        cursor: pointer; border: 2px solid transparent; transition: 0.2s;
    }
    .preset-img:hover { transform: scale(1.1); }
    .preset-img.active { border-color: var(--primary-blue); }
    
    .gender-radio {
    display: flex;
    gap: 10px; /* space between options */
    margin-top: 10px;
    margin-bottom:8px;
}

.gender-radio input[type="radio"] {
    margin-right: 2px; /* space between circle and text */
    transform: scale(1.5); /* slightly bigger radio */
    cursor: pointer;
    margin-bottom:8px;
}

.gender-radio label {
    margin-right: 18px;
    font-size: 14px;
    cursor: pointer;
    margin-bottom:8px;
}
    /* Form Elements */
    .input-group-custom { margin-bottom: 20px; }
    .input-label {
        font-size: 0.75rem; font-weight: 700; color: var(--text-muted);
        text-transform: uppercase; margin-bottom: 8px; display: block;
    }
    .form-control-custom {
        width: 100%; padding: 12px 16px;
        background: #f8fafc; border: 1px solid var(--border-color);
        border-radius: 12px; transition: all 0.2s;
    }
    .form-control-custom:focus {
        background: #fff; border-color: var(--primary-blue); outline: none;
        box-shadow: 0 0 0 4px rgba(78, 70, 229, 0.1);
    }

    /* Grid Selection Cards (Step 2) */
    .select-card {
        background: #fff; border: 1.5px solid var(--border-color);
        border-radius: 12px; padding: 15px; cursor: pointer;
        display: flex; align-items: center; gap: 12px; flex: 1 1 200px;
        transition: 0.2s; font-weight: 500;
    }
    .select-card:hover { border-color: var(--primary-blue); background: #f5f3ff; }
    .select-card.active { border-color: var(--primary-blue); background: #f5f3ff; color: var(--primary-blue); }

    /* Pill Selectors */
    .select-pill {
        padding: 8px 20px; background: #fff; border: 1px solid var(--border-color);
        border-radius: 30px; cursor: pointer; transition: 0.2s; font-size: 0.9rem;
    }
    .select-pill:hover { border-color: var(--primary-blue); }
    .select-pill.active { background: var(--primary-blue); color: white; border-color: var(--primary-blue); }

    /* Info Alert Box */
    .info-box {
        background: #fffbeb; border: 1px solid #fef3c7;
        border-radius: 12px; padding: 15px; display: flex; gap: 12px; margin-top: 20px;
    }

    /* Buttons */
    .btn-next {
        background: var(--primary-blue); color: white; border: none;
        padding: 14px; border-radius: 12px; font-weight: 600; width: 100%;
        transition: 0.3s; margin-top: 10px;
    }
    .btn-next:hover { opacity: 0.9; transform: translateY(-1px); }
    .btn-back {
        background: transparent; border: 1px solid var(--border-color);
        color: var(--text-muted); padding: 14px 25px; border-radius: 12px; font-weight: 600;
    }

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:HiddenField ID="hfExam" runat="server" />
    <asp:HiddenField ID="hfClass" runat="server" />
    <asp:HiddenField ID="hfBoard" runat="server" />
    <asp:HiddenField ID="hfSelectedAvatar" runat="server" Value="/images/avatars/default.png" />

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 style="font-weight: 800; color: var(--text-dark);">Setup Your Profile</h1>
            <p style="color: var(--text-muted);">Tell us more to personalize your experience.</p>
        </div>

        <div class="onboarding-card">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h4 class="mb-0" style="font-weight:700">Setup your profile</h4>
                    <small class="text-muted">Step <asp:Literal ID="litStepNum" runat="server" Text="1" /> of 3</small>
                </div>
                <div class="step-indicator-container">
                    <div id="bar1" class="step-bar active" runat="server"></div>
                    <div id="bar2" class="step-bar" runat="server"></div>
                    <div id="bar3" class="step-bar" runat="server"></div>
                </div>
            </div>

            <asp:Panel ID="pnlStep1" runat="server">
                <div class="avatar-section text-center">
                   <div class="avatar-wrapper">
    <asp:Image ID="imgProfilePreview" runat="server" 
        ImageUrl="/images/avatars/default.png" 
        CssClass="main-avatar" ClientIDMode="Static" />
    
    <label for="<%= FileUploadAvatar.ClientID %>" class="camera-btn" style="z-index: 10; cursor: pointer;">
        <i class="fas fa-camera"></i>
    </label>

    <asp:FileUpload ID="FileUploadAvatar" runat="server" 
        style="display:none;" onchange="previewImage(this)" />
</div>
                    <small class="text-muted d-block mb-2">OR CHOOSE AN AVATAR</small>
                    <div class="avatar-presets">
                        <img src="../assets/img/Deault_Random_boy.png" class="preset-img" onclick="setAvatar(this)" />
                        <img src="../assets/img/Default_Random_girl.png" class="preset-img" onclick="setAvatar(this)" />
                       <%-- <img src="../assets/img/avatar3.png" class="preset-img" onclick="setAvatar(this)" />--%>
                    </div>
                </div>

                <div class="mt-4">
                    <div class="input-group-custom">
                        <span class="input-label">Full Name</span>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control-custom" placeholder="e.g. John Doe" />
                    </div>
                    <div class="input-group-custom">
                        <span class="input-label">Email</span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-custom" ReadOnly="true" />
                    </div>
                    <div class="input-group-custom">
                        <span class="input-label">Mobile Number</span>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control-custom" placeholder="+91 XXXXX XXXXX" />
                    </div>
                    <div class="input-group-custom">
                        <span class="input-label">Date of Birth</span>
                        <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control-custom" TextMode="Date" />
                    </div>
                  <div class="input-group-custom">
    <span class="input-label">Gender</span>

    <asp:RadioButtonList ID="rblGender" runat="server"
        RepeatDirection="Horizontal"
        RepeatLayout="Flow"
        AutoPostBack="false"
        CssClass="gender-radio">

        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
    </asp:RadioButtonList>
</div>
                    <asp:Button ID="btnStep1Next" runat="server" Text="Continue" CssClass="btn-next" OnClick="btnStep1Next_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlStep2" runat="server" Visible="false">
                <div class="input-group-custom">
                    <span class="input-label">Select Target Exam</span>
                    <div class="d-flex flex-wrap gap-3">
                        <asp:Repeater ID="rptExam" runat="server">
                            <ItemTemplate>
                                <div class="select-card" onclick="selectOption(this,'exam','<%# Eval("Id") %>')">
                                    <i class="fas fa-graduation-cap"></i> <%# Eval("Name") %>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="input-group-custom">
                    <span class="input-label">Your Grade (Class)</span>
                    <div class="d-flex flex-wrap gap-2">
                        <asp:Repeater ID="rptClass" runat="server">
                            <ItemTemplate>
                                <div class="select-pill" onclick="selectOption(this,'class','<%# Eval("Id") %>')">
                                    <%# Eval("Name") %>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="input-group-custom">
                    <span class="input-label">School Board</span>
                    <div class="d-flex flex-wrap gap-2">
                        <asp:Repeater ID="rptBoard" runat="server">
                            <ItemTemplate>
                                <div class="select-pill" onclick="selectOption(this,'board','<%# Eval("Id") %>')">
                                    <%# Eval("Name") %>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-4">
                    <asp:Button ID="btnBackStep2" runat="server" Text="Back" CssClass="btn-back" OnClick="btnBackStep2_Click" />
                    <asp:Button ID="btnStep2Next" runat="server" Text="Next Step" CssClass="btn-next" style="margin-top:0" OnClick="btnStep2Next_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlStep3" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-6 input-group-custom">
                        <span class="input-label">State</span>
                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control-custom" placeholder="Select State" />
                    </div>
                    <div class="col-md-6 input-group-custom">
                        <span class="input-label">City</span>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control-custom" placeholder="e.g. Kota" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 input-group-custom">
                        <span class="input-label">Pincode</span>
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control-custom" placeholder="6-digit ZIP" />
                    </div>
                    <div class="col-md-6 input-group-custom">
                        <span class="input-label">Area</span>
                        <asp:TextBox ID="txtArea" runat="server" CssClass="form-control-custom" placeholder="e.g. Indra Vihar" />
                    </div>
                </div>
                <div class="input-group-custom">
                    <span class="input-label">Full Address</span>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control-custom" TextMode="MultiLine" Rows="3" placeholder="House No, Street Name, etc." />
                </div>

                <div class="info-box">
                    <span style="font-size: 20px;">📍</span>
                    <div>
                        <strong style="font-size: 0.85rem; color: #92400e;">CENTER MATCHING</strong>
                        <p class="mb-0" style="font-size: 0.8rem; color: #b45309;">We'll use this to recommend our nearest premium offline centers.</p>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-4">
                    <asp:Button ID="btnBackStep3" runat="server" Text="Back" CssClass="btn-back" OnClick="btnBackStep3_Click" />
                    <asp:Button ID="btnFinish" runat="server" Text="Finish Setup" CssClass="btn-next" style="margin-top:0; background: #059669;" OnClick="btnFinish_Click" />
                </div>
            </asp:Panel>

        </div>
    </div>

    <script>
        // 1. Preview for Custom File Upload
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    // Force the source update
                    var img = document.getElementById('imgProfilePreview');
                    if (img) {
                        img.src = e.target.result;
                    }
                    // Clear active state from presets
                    document.querySelectorAll('.preset-img').forEach(i => i.classList.remove('active'));
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 2. Selection for Preset Avatars
        function setAvatar(el) {
            // Remove active class from others
            document.querySelectorAll('.preset-img').forEach(i => i.classList.remove('active'));

            // Add active class to clicked one
            el.classList.add('active');

            // Update the big preview
            var preview = document.getElementById('imgProfilePreview');
            preview.src = el.src;

            // Save the URL to the hidden field so C# can see it
            document.getElementById('<%= hfSelectedAvatar.ClientID %>').value = el.src;
    }

        // Selection Logic for Cards/Pills
        function selectOption(el, type, value) {
            let items = el.parentElement.querySelectorAll("div");
            items.forEach(i => i.classList.remove("active"));
            el.classList.add("active");

            if (type === "exam") document.getElementById("<%= hfExam.ClientID %>").value = value;
            if (type === "class") document.getElementById("<%= hfClass.ClientID %>").value = value;
            if (type === "board") document.getElementById("<%= hfBoard.ClientID %>").value = value;
        }
    </script>
</asp:Content>