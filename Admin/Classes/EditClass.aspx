<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditClass.aspx.cs" Inherits="StudyIsleWeb.Admin.Classes.EditClass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="form-card shadow-sm">

        <h4 class="form-title">Edit Class</h4>

        <asp:HiddenField ID="hfClassId" runat="server" />

        <div class="mb-3">
            <label class="form-label">Select Board</label>
            <asp:DropDownList ID="ddlBoard" runat="server"
                CssClass="form-select">
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <label class="form-label">Class Name</label>
            <asp:TextBox ID="txtClassName" runat="server"
                CssClass="form-control">
            </asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label">Display Order</label>
            <asp:TextBox ID="txtDisplayOrder" runat="server"
                CssClass="form-control"
                TextMode="Number">
            </asp:TextBox>
        </div>

        <div class="form-check mb-3">
            <asp:CheckBox ID="chkIsActive" runat="server"
                CssClass="form-check-input" />
            <label class="form-check-label">Is Active</label>
        </div>

        <asp:Button ID="btnUpdate" runat="server"
            Text="Update Class"
            CssClass="btn btn-primary"
            OnClick="btnUpdate_Click" />

        <asp:Label ID="lblMessage" runat="server"
            CssClass="text-danger d-block mt-3">
        </asp:Label>

    </div>
</asp:Content>
