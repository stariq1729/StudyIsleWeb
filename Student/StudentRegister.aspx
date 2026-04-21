<%@ Page Title="Setup Profile" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="StudentRegister.aspx.cs"
    Inherits="StudyIsleWeb.Student.StudentRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.select-card, .select-pill {
    border:1px solid #ddd;
    border-radius:10px;
    padding:10px 15px;
    cursor:pointer;
    transition:0.2s;
}
.select-card:hover, .select-pill:hover {
    border-color:#6c63ff;
}
.select-card.active {
    background:#f3f2ff;
    border-color:#6c63ff;
}
.select-pill {
    border-radius:20px;
}
.select-pill.active {
    background:#6c63ff;
    color:white;
}
</style>

<asp:HiddenField ID="hfExam" runat="server" />
<asp:HiddenField ID="hfClass" runat="server" />
<asp:HiddenField ID="hfBoard" runat="server" />

<div class="container mt-5">
    <div class="text-center mb-4">
        <h2>Setup Your Profile</h2>
    </div>

    <div class="card p-4 mx-auto" style="max-width:600px">

        <!-- STEP 1 -->
        <asp:Panel ID="pnlStep1" runat="server">

            <h5 class="text-center">Step 1 of 3</h5>

            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control mb-2" placeholder="Full Name" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-2" ReadOnly="true" />
            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control mb-2" placeholder="Mobile" />
            <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control mb-3" TextMode="Date" />

            <asp:Button ID="btnStep1Next" runat="server" Text="Continue"
                CssClass="btn btn-primary w-100" OnClick="btnStep1Next_Click" />

        </asp:Panel>

        <!-- STEP 2 -->
        <asp:Panel ID="pnlStep2" runat="server" Visible="false">

            <h5 class="text-center">Step 2 of 3</h5>

            <label>Target Exam</label>
            <div class="d-flex flex-wrap gap-2 mb-3">
                <asp:Repeater ID="rptExam" runat="server">
                    <ItemTemplate>
                        <div class="select-card"
                             onclick="selectOption(this,'exam','<%# Eval("Id") %>')">
                            <%# Eval("Name") %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <label>Class</label>
            <div class="d-flex flex-wrap gap-2 mb-3">
                <asp:Repeater ID="rptClass" runat="server">
                    <ItemTemplate>
                        <div class="select-pill"
                             onclick="selectOption(this,'class','<%# Eval("Id") %>')">
                            <%# Eval("Name") %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <label>Board</label>
            <div class="d-flex flex-wrap gap-2 mb-3">
                <asp:Repeater ID="rptBoard" runat="server">
                    <ItemTemplate>
                        <div class="select-pill"
                             onclick="selectOption(this,'board','<%# Eval("Id") %>')">
                            <%# Eval("Name") %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="d-flex justify-content-between">
                <asp:Button ID="btnBackStep2" runat="server" Text="Back"
                    CssClass="btn btn-secondary" OnClick="btnBackStep2_Click" />

                <asp:Button ID="btnStep2Next" runat="server" Text="Next"
                    CssClass="btn btn-primary" OnClick="btnStep2Next_Click" />
            </div>

        </asp:Panel>

        <!-- STEP 3 -->
        <asp:Panel ID="pnlStep3" runat="server" Visible="false">

            <h5 class="text-center">Step 3 of 3</h5>

            <asp:TextBox ID="txtState" runat="server" CssClass="form-control mb-2" placeholder="State" />
            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control mb-2" placeholder="City" />
            <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control mb-2" placeholder="Pincode" />
            <asp:TextBox ID="txtArea" runat="server" CssClass="form-control mb-2" placeholder="Area" />
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control mb-3" TextMode="MultiLine" placeholder="Full Address" />

            <div class="d-flex justify-content-between">
                <asp:Button ID="btnBackStep3" runat="server" Text="Back"
                    CssClass="btn btn-secondary" OnClick="btnBackStep3_Click" />

                <asp:Button ID="btnFinish" runat="server" Text="Finish"
                    CssClass="btn btn-success" OnClick="btnFinish_Click" />
            </div>

        </asp:Panel>

    </div>
</div>

<script>
function selectOption(el, type, value) {

    let items = el.parentElement.querySelectorAll("div");
    items.forEach(i => i.classList.remove("active"));
    el.classList.add("active");

    if (type === "exam")
        document.getElementById("<%= hfExam.ClientID %>").value = value;

    if (type === "class")
        document.getElementById("<%= hfClass.ClientID %>").value = value;

    if (type === "board")
        document.getElementById("<%= hfBoard.ClientID %>").value = value;
    }
</script>

</asp:Content>