<%@ Page Title="Resources" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewResource.aspx.cs" Inherits="StudyIsleWeb.ViewResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .res-container { background: #f8fafc; padding: 40px 0; min-height: 85vh; }
        .resource-card { 
            background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; 
            padding: 20px; margin-bottom: 15px; display: flex; align-items: center; 
            justify-content: space-between; transition: 0.3s;
        }
        .resource-card:hover { border-color: #6366f1; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .icon-box { 
            width: 50px; height: 50px; border-radius: 10px; display: flex; 
            align-items: center; justify-content: center; font-size: 1.4rem; margin-right: 20px;
        }
        .bg-pdf { background: #fee2e2; color: #dc2626; }
        .bg-img { background: #fef9c3; color: #854d0e; }
        .bg-vid { background: #dbeafe; color: #2563eb; }
        .bg-gen { background: #f1f5f9; color: #475569; }
        .res-info h5 { margin: 0; font-weight: 700; color: #1e293b; }
        .res-info p { margin: 3px 0 0; font-size: 0.85rem; color: #64748b; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="res-container">
        <div class="container">
            <div class="col-lg-10 mx-auto">
                <h3 class="fw-bold mb-4">Study Materials</h3>
                
                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="resource-card">
                            <div class="d-flex align-items-center">
                                <div class='<%# "icon-box " + GetTheme(Eval("ContentType").ToString()) %>'>
                                    <i class='<%# GetIcon(Eval("ContentType").ToString()) %>'></i>
                                </div>
                                <div class="res-info">
                                    <h5><%# Eval("Title") %></h5>
                                    <p><%# Eval("Description") %></p>
                                </div>
                            </div>
                            <a href='<%# Eval("FilePath") %>' target="_blank" class="btn btn-primary rounded-pill px-4">Open</a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                    <div class="text-center py-5 border rounded-3 bg-white">
                        <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No resources found for this selection.</h5>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>
</asp:Content>