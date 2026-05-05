<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Blogs.aspx.cs" Inherits="StudyIsleWeb.Blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets\css\BlogSection.css" rel="stylesheet" />
    <style>
/* 🔹 Title clamp (2 lines) */
.clamp-title {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

/* 🔹 Description clamp (3 lines) */
.clamp-desc {
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
.card-title {
    min-height: 48px;
}

.card-text {
    min-height: 60px;
}
</style>
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

        <!-- 🔥 FULL CARD CLICKABLE -->
        <a href='BlogDetails.aspx?slug=<%# Eval("Slug") %>' 
           style="text-decoration:none; color:inherit; display:block;">

            <div class="card h-100 shadow-sm">

                <!-- Image -->
                <img src='<%# Eval("CoverImage") %>' 
                     class="card-img-top" 
                     style="height:200px; object-fit:cover;" />

                <div class="card-body">

                    <!-- Category Tag -->
                    <span class="badge bg-primary mb-2">
                        <%# Eval("CategoryName") %>
                    </span>

                    <!-- 🔥 Author + Date Row -->
                    <div class="d-flex align-items-center mb-2">

                        <!-- Author Image -->
                        <img src='<%# string.IsNullOrEmpty(Eval("AuthorImage").ToString()) ? "/uploads/default-user.png" : Eval("AuthorImage") %>'
     style="width:30px; height:30px; border-radius:50%; object-fit:cover; margin-right:8px;" />

                        <!-- Author Name -->
                        <small class="text-muted">
                            <%# Eval("AuthorName") %>
                        </small>

                    </div>

                    <!-- Title -->
                   <h5 class="card-title clamp-title">
                        <%# Eval("Title") %>
                    </h5>

                    <!-- Description -->
                   <p class="card-text text-muted clamp-desc">
                        <%# Eval("ShortDescription") %>
                    </p>

                </div>

                <div class="card-footer d-flex justify-content-between align-items-center">

                    <!-- 🔥 Dynamic Read Time -->
                    <small class="text-muted">
                        <%# Eval("ReadTime") %> min read
                    </small>

                    <!-- Actions -->
                    <div>
                        

                        <i class="fa fa-share" 
                           style="cursor:pointer;"
                           onclick="event.preventDefault(); event.stopPropagation(); shareBlog('<%# Eval("Slug") %>')">
                        </i>
                    </div>

                </div>

            </div>

        </a>

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