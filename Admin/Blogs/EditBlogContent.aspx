<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditBlogContent.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.EditBlogContent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <h3>Edit Blog Content</h3>

    <!-- Add Block Button -->
    <button type="button" class="btn btn-primary mb-3" onclick="openBlockMenu()">+ Add Block</button>

    <!-- Block Container -->
    <div id="blockContainer"></div>

    <!-- Save Button -->
    <button class="btn btn-success mt-3" onclick="saveBlocks()">Save Content</button>

</div>

<!-- Block Menu -->
<div id="blockMenu" style="display:none; position:absolute; background:#fff; border:1px solid #ccc; padding:10px;">
    <div onclick="addBlock('h1')">H1</div>
    <div onclick="addBlock('h2')">H2</div>
    <div onclick="addBlock('paragraph')">Paragraph</div>
    <div onclick="addBlock('image')">Image</div>
    <div onclick="addBlock('html')">HTML</div>
    <div onclick="addBlock('divider')">Divider</div>
</div>

<script>

let blogId = new URLSearchParams(window.location.search).get("BlogId");

// Open menu
function openBlockMenu() {
    document.getElementById("blockMenu").style.display = "block";
}

// Add block
function addBlock(type) {

    let container = document.getElementById("blockContainer");

    let block = document.createElement("div");
    block.className = "block mb-3 p-3 border";
    block.setAttribute("data-type", type);

    let html = "";

    if (type === "h1") {
        html = `<input class="form-control" placeholder="Heading (H1)" />`;
    }

    if (type === "h2") {
        html = `<input class="form-control" placeholder="Subheading (H2)" />`;
    }

    if (type === "paragraph") {
        html = `<textarea class="form-control" rows="3" placeholder="Write content..."></textarea>`;
    }

    if (type === "image") {
        html = `<input type="file" class="form-control" />`;
    }

    if (type === "html") {
        html = `
            <textarea class="form-control html-input" rows="3" placeholder="Write HTML..."></textarea>
            <div class="preview mt-2 p-2 border"></div>
        `;
    }

    if (type === "divider") {
        html = `<hr />`;
    }

    block.innerHTML = html + `<button class="btn btn-danger btn-sm mt-2" onclick="this.parentElement.remove()">Delete</button>`;

    container.appendChild(block);

    // Live preview for HTML
    if (type === "html") {
        let textarea = block.querySelector(".html-input");
        let preview = block.querySelector(".preview");

        textarea.addEventListener("input", function () {
            preview.innerHTML = this.value;
        });
    }

    document.getElementById("blockMenu").style.display = "none";
}

// Save blocks
function saveBlocks() {

    let blocks = [];

    document.querySelectorAll(".block").forEach((block, index) => {

        let type = block.getAttribute("data-type");

        let content = "";
        let image = "";

        if (type === "h1" || type === "h2") {
            content = block.querySelector("input").value;
        }

        if (type === "paragraph") {
            content = block.querySelector("textarea").value;
        }

        if (type === "html") {
            content = block.querySelector("textarea").value;
        }

        // image handling later (phase 2)

        blocks.push({
            BlockType: type,
            Content: content,
            DisplayOrder: index
        });
    });

    fetch("EditBlogContent.aspx/SaveBlocks", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ blocks: blocks, blogId: blogId })
    })
    .then(res => res.json())
    .then(res => {
        alert("Content Saved!");
    });
}

</script>

</asp:Content>