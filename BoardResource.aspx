<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoardResource.aspx.cs" Inherits="StudyIsleWeb.BoardResource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Modern light purple and standard colors */
        :root { --si-purple: #4f46e5; --si-purple-light: #f5f3ff; --si-text-dark: #1e293b; --si-text-muted: #64748b; --si-border: #e2e8f0; }
        
        body { background-color: #fbfbfe; }
        
        /* Header styling */
        .page-header { text-align: center; margin-bottom: 3rem; padding-top: 20px; }
        .page-header h1 { font-weight: 800; font-size: 2.2rem; color: var(--si-text-dark); margin-bottom: 10px; }
        .page-header h1 span { color: var(--si-purple); }
        .page-header p { color: var(--si-text-muted); font-size: 1rem; max-width: 700px; margin: 0 auto; }

        /* Class Filter Tabs */
        .class-tabs { display: flex; gap: 10px; justify-content: center; margin-bottom: 40px; padding: 10px; }
        .class-btn { padding: 8px 22px; border-radius: 8px; border: 1px solid var(--si-border); background: white; text-decoration: none; color: var(--si-text-muted); font-weight: 600; font-size: 0.9rem; transition: 0.3s; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
        .class-btn:hover { border-color: var(--si-purple); color: var(--si-purple); }
        .class-btn.active { background: #1e293b; color: white; border-color: #1e293b; box-shadow: 0 4px 12px rgba(30, 41, 59, 0.2); }
        
        /* Subject Sections */
        .subject-group { margin-bottom: 50px; }
        .subject-header { border-left: 5px solid var(--si-purple); padding-left: 15px; font-weight: 700; font-size: 1.3rem; color: var(--si-text-dark); margin-bottom: 25px; }
        
        /* Resource Cards */
        .resource-card { background: white; border: 1px solid var(--si-border); border-radius: 12px; padding: 20px; display: flex; gap: 20px; transition: all 0.3s ease; height: 100%; position: relative; }
        .resource-card:hover { transform: translateY(-5px); box-shadow: 0 12px 24px -6px rgba(0, 0, 0, 0.08); border-color: var(--si-purple-light); }
        
        .resource-img { width: 75px; height: 95px; object-fit: contain; border-radius: 6px; border: 1px solid #f1f5f9; background: #fff; }
        
        .resource-info { flex-grow: 1; display: flex; flex-direction: column; }
        .cat-tag { font-size: 0.65rem; font-weight: 800; text-transform: uppercase; color: var(--si-purple); letter-spacing: 0.5px; margin-bottom: 6px; }
        .res-title { font-size: 1rem; font-weight: 700; color: var(--si-text-dark); line-height: 1.4; margin-bottom: 8px; }
        .latest-badge { font-size: 0.75rem; color: #059669; font-weight: 600; display: flex; align-items: center; gap: 5px; margin-bottom: 15px; }
        
        /* High Standard Purple Button */
        .btn-read { margin-top: auto; display: inline-block; background: var(--si-purple); color: white; padding: 8px 15px; border-radius: 6px; font-size: 0.85rem; font-weight: 700; text-decoration: none; width: 100%; text-align: center; transition: 0.2s; border: none; }
        .btn-read:hover { background: #4338ca; color: white; box-shadow: 0 4px 10px rgba(79, 70, 229, 0.3); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        
        <div class="page-header">
            <h1><asp:Literal ID="litPageTitle" runat="server"></asp:Literal></h1>
            <p><asp:Literal ID="litPageSubtitle" runat="server"></asp:Literal></p>
        </div>

        <div class="class-tabs">
            <asp:Repeater ID="rptClasses" runat="server">
                <ItemTemplate>
                    <a href='<%# "BoardResource.aspx?board=" + Request.QueryString["board"] + "&class=" + Eval("Slug") %>' 
                       class='<%# Eval("Slug").ToString() == Request.QueryString["class"] || (string.IsNullOrEmpty(Request.QueryString["class"]) && Eval("ClassName").ToString() == "Class 12") ? "class-btn active" : "class-btn" %>'>
                        <%# Eval("ClassName") %>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Repeater ID="rptSubjectGroups" runat="server" OnItemDataBound="rptSubjectGroups_ItemDataBound">
            <ItemTemplate>
                <div class="subject-group">
                    <div class="subject-header">
                        <%# Eval("SubjectName") %> <%# Request.QueryString["board"]?.ToUpper() %> Books
                    </div>
                    
                    <div class="row g-4">
                        <asp:Repeater ID="rptResources" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-4 col-md-6">
                                    <div class="resource-card">
                                        <img src='<%# "/Uploads/SubjectIcons/" + (Eval("IconImage") == DBNull.Value || string.IsNullOrEmpty(Eval("IconImage").ToString()) ? "default.png" : Eval("IconImage")) %>' class="resource-img" alt="Book Icon" />
                                        
                                        <div class="resource-info">
                                            <span class="cat-tag"><%# Eval("SubjectName") %></span>
                                            <h3 class="res-title"><%# Eval("Title") %></h3>
                                            <%--<div class="latest-badge">
                                                <i class="bi bi-check-circle-fill"></i> 2024-25 Latest Edition
                                            </div>--%>
                                            <a href='<%# "ViewResource.aspx?id=" + Eval("ResourceId") %>' class="btn-read">Read Online <i class="bi bi-box-arrow-up-right ms-1"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>