<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddSubject.aspx.cs" Inherits="StudyIsleWeb.Admin.Subjects.AddSubject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-card shadow-sm">

        <h4 class="form-title">Add New Subject</h4>

        <div class="mb-3">
            <label class="form-label">Select Board</label>
            <asp:DropDownList ID="ddlBoard" runat="server"
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div class="mb-3" id="classContainer" runat="server">
            <label class="form-label">Select Class</label>
            <asp:DropDownList ID="ddlClass" runat="server"
                CssClass="form-select">
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <label class="form-label">Subject Name</label>
            <asp:TextBox ID="txtSubjectName" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label">Slug</label>
            <asp:TextBox ID="txtSlug" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <asp:TextBox ID="txtDescription" runat="server"
                CssClass="form-control"
                TextMode="MultiLine">
            </asp:TextBox>
        </div>

        <div class="form-check mb-3">
            <asp:CheckBox ID="chkIsActive" runat="server"
                CssClass="form-check-input"
                Checked="true" />
            <label class="form-check-label">Is Active</label>
        </div>

        <asp:Button ID="btnSave" runat="server"
            Text="Save Subject"
            CssClass="btn btn-primary"
            OnClick="btnSave_Click" />

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger d-block mt-3">
        </asp:Label>

    </div>
</asp:Content>
