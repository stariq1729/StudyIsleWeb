<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Blogs.aspx.cs" Inherits="StudyIsleWeb.Blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <!-- 🔷 HEADER -->
    <div class="text-center mb-4">
        <h2 class="fw-bold">Student Success Hub</h2>
        <p class="text-muted">
            High-impact strategies, resources, and expert tips to ace 
            <b>CBSE</b>, <b>JEE</b>, and <b>NEET</b> exams.
        </p>
    </div>

    <!-- 🔷 CATEGORY TABS -->
    <div class="text-center mb-4">

        <!-- Latest -->
        <asp:LinkButton ID="btnLatest" runat="server" CssClass="btn btn-primary me-2"
            OnClick="btnLatest_Click">Latest</asp:LinkButton>

        <!-- Dynamic Categories -->
        <asp:Repeater ID="rptCategories" runat="server">
            <ItemTemplate>
                <asp:LinkButton runat="server"
                    CssClass="btn btn-outline-secondary me-2"
                    CommandArgument='<%# Eval("CategoryId") %>'
                    OnCommand="Category_Click">
                    <%# Eval("CategoryName") %>
                </asp:LinkButton>
            </ItemTemplate>
        </asp:Repeater>

    </div>

    <!-- 🔷 BLOG CARDS -->
    <div class="row">

        <asp:Repeater ID="rptBlogs" runat="server">
            <ItemTemplate>

                <div class="col-md-4 mb-4">

                    <div class="card h-100 shadow-sm">

                        <!-- Image -->
                        <img src='<%# Eval("CoverImage") %>' class="card-img-top" style="height:200px; object-fit:cover;" />

                        <div class="card-body">

                            <!-- Category Tag -->
                            <span class="badge bg-primary mb-2">
                                <%# Eval("CategoryName") %>
                            </span>

                            <!-- Title -->
                            <h5 class="card-title">
                                <a href='BlogDetails.aspx?slug=<%# Eval("Slug") %>' style="text-decoration:none;">
                                    <%# Eval("Title") %>
                                </a>
                            </h5>

                            <!-- Description -->
                            <p class="card-text text-muted">
                                <%# Eval("ShortDescription") %>
                            </p>

                        </div>

                        <div class="card-footer d-flex justify-content-between align-items-center">

                            <!-- Read Time -->
                            <small class="text-muted">5 min read</small>

                            <!-- Actions -->
                            <div>
                                <i class="fa fa-bookmark me-2" style="cursor:pointer;"></i>
                                <i class="fa fa-share" style="cursor:pointer;"
                                   onclick="shareBlog('<%# Eval("Slug") %>')"></i>
                            </div>

                        </div>

                    </div>

                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>

</div>

<script>
function shareBlog(slug) {
    let url = window.location.origin + "/BlogDetails.aspx?slug=" + slug;

    if (navigator.share) {
        navigator.share({
            title: 'Check this blog',
            url: url
        });
    } else {
        navigator.clipboard.writeText(url);
        alert("Link copied!");
    }
}
</script>

</asp:Content>