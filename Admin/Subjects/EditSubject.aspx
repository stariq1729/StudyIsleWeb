<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditSubject.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.EditSubject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-card shadow-sm">

        <h4 class="form-title">Edit Subject</h4>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger d-block mb-3"></asp:Label>

        <!-- Board -->
        <div class="mb-3">
            <label>Select Board</label>
            <asp:DropDownList ID="ddlBoard" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <!-- Class -->
        <div class="mb-3">
            <label>Select Class (Optional)</label>
            <asp:DropDownList ID="ddlClass" runat="server"
                CssClass="form-control">
            </asp:DropDownList>
        </div>

        <!-- Subject Name -->
        <div class="mb-3">
            <label>Subject Name</label>
            <asp:TextBox ID="txtSubjectName" runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnTextChanged="txtSubjectName_TextChanged">
            </asp:TextBox>
        </div>

        <!-- Slug -->
        <div class="mb-3">
            <label>Slug</label>
            <asp:TextBox ID="txtSlug" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label>Description</label>
            <asp:TextBox ID="txtDescription" runat="server"
                CssClass="form-control"
                TextMode="MultiLine"
                Rows="4">
            </asp:TextBox>
        </div>

        <!-- Active -->
        <div class="form-check mb-3">
            <asp:CheckBox ID="chkIsActive"
                runat="server"
                CssClass="form-check-input" />
            <label class="form-check-label">Is Active</label>
        </div>

        <asp:Button ID="btnUpdate" runat="server"
            Text="Update Subject"
            CssClass="btn btn-success"
            OnClick="btnUpdate_Click" />

        <a href="ManageSubjects.aspx"
            class="btn btn-secondary ms-2">
            Cancel
        </a>

    </div>

</asp:Content>