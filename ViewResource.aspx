<%@ Page Title="Resources" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewResource.aspx.cs" Inherits="StudyIsleWeb.ViewResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .resource-card { 
            background: #fff; border: 1px solid #e5e7eb; border-radius: 12px; 
            padding: 20px; margin-bottom: 16px; transition: all 0.3s ease;
            display: flex; align-items: center; justify-content: space-between;
        }
        .resource-card:hover { border-color: #6366f1; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .icon-box { 
            width: 50px; height: 50px; border-radius: 10px; 
            display: flex; align-items: center; justify-content: center; font-size: 1.4rem; margin-right: 20px;
        }
        .bg-pdf { background: #fee2e2; color: #dc2626; }
        .bg-image { background: #fef9c3; color: #854d0e; }
        .bg-video { background: #dcfce7; color: #16a34a; }
        .bg-default { background: #f3f4f6; color: #374151; }
        
        .res-info h5 { margin: 0; font-weight: 700; color: #111827; }
        .res-info p { margin: 0; font-size: 0.9rem; color: #6b7280; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <h2 class="fw-bold mb-4">Study Materials</h2>
                
                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="resource-card">
                            <div class="d-flex align-items-center">
                                <div class='<%# "icon-box " + GetStatusClass(Eval("ContentType").ToString()) %>'>
                                    <i class='<%# GetIcon(Eval("ContentType").ToString()) %>'></i>
                                </div>
                                <div class="res-info">
                                    <h5><%# Eval("Title") %></h5>
                                    <p><%# Eval("Description") %></p>
                                    <small class="text-muted"><%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></small>
                                </div>
                            </div>
                            <div>
                                <a href='<%# Eval("FilePath") %>' target="_blank" class="btn btn-primary rounded-pill px-4">
                                    <i class="fas fa-external-link-alt me-2"></i> View
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:PlaceHolder ID="phNoData" runat="server" Visible="false">
                    <div class="text-center py-5">
                        <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">No resources available for this selection.</h4>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>
</asp:Content>