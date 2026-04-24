<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditBlogContent.aspx.cs" Inherits="StudyIsleWeb.Admin.Blogs.EditBlogContent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
.block-option {
    padding:8px;
    cursor:pointer;
}
.block-option:hover {
    background:#f1f1f1;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <h3>Edit Blog Content</h3>

    <!-- Add Block Button -->
  <button type="button" onclick="openBlockMenu(event)" class="btn btn-primary">+ Add Block</button>

    <!-- Block Container -->
    <div id="blockContainer"></div>

    <!-- Save -->
    <button type="button" class="btn btn-success mt-3" onclick="saveBlocks()">Save Content</button>

</div>

<!-- Block Menu -->
<div id="blockMenu" class="card p-2" 
     style="display:none; position:absolute; z-index:1000; width:200px;">
    <div class="block-option" onclick="addBlock('h1')">H1</div>
    <div class="block-option" onclick="addBlock('h2')">H2</div>
    <div class="block-option" onclick="addBlock('paragraph')">Paragraph</div>
    <div class="block-option" onclick="addBlock('image')">Image</div>
    <div class="block-option" onclick="addBlock('html')">HTML</div>
    <div class="block-option" onclick="addBlock('divider')">Divider</div>
    <div class="block-option" onclick="addBlock('table')">Table</div>
</div>

<style>
.block-option { padding:8px; cursor:pointer; }
.block-option:hover { background:#f1f1f1; }
.block { border:1px solid #ddd; padding:15px; margin-bottom:10px; }
</style>

<script>

    let blogId = new URLSearchParams(window.location.search).get("BlogId");
    let menuOpen = false;

    // ================= MENU =================
    function openBlockMenu(event) {
        event.preventDefault();
        event.stopPropagation();

        let menu = document.getElementById("blockMenu");

        if (menuOpen) {
            menu.style.display = "none";
            menuOpen = false;
        } else {
            menu.style.display = "block";

            // FIXED POSITION (not cursor-based)
            let btn = event.target;
            let rect = btn.getBoundingClientRect();

            menu.style.top = (rect.bottom + window.scrollY) + "px";
            menu.style.left = (rect.left + window.scrollX) + "px";

            menuOpen = true;
        }
    }

    // ================= ADD BLOCK =================
    function addBlock(type, data = null) {

        let container = document.getElementById("blockContainer");

        let block = document.createElement("div");
        block.className = "block";
        block.setAttribute("data-type", type);

        let html = "";

        if (type === "h1") {
            html = `<input class="form-control" placeholder="Heading" value="${data?.Content || ''}" />`;
        }

        if (type === "h2") {
            html = `<input class="form-control" placeholder="Subheading" value="${data?.Content || ''}" />`;
        }

        if (type === "paragraph") {
            html = `<textarea class="form-control">${data?.Content || ''}</textarea>`;
        }

        if (type === "image") {
            html = `<input type="file" class="form-control" />
                ${data?.Content ? `<img src="${data.Content}" style="max-width:200px;margin-top:10px;">` : ''}`;
        }

        if (type === "html") {
            html = `
            <textarea class="form-control html-input">${data?.Content || ''}</textarea>
            <div class="preview border p-2 mt-2">${data?.Content || ''}</div>
        `;
        }

        if (type === "divider") {
            html = `<hr />`;
        }

        if (type === "table") {
            let tableData = data?.ExtraData ? JSON.parse(data.ExtraData) : null;

            let headers = tableData?.headers || ["Column 1", "Column 2"];
            let rows = tableData?.rows || [["Data", "Data"]];

            let thead = headers.map(h => `<th contenteditable="true">${h}</th>`).join("");

            let tbody = rows.map(r =>
                `<tr>${r.map(c => `<td contenteditable="true">${c}</td>`).join("")}</tr>`
            ).join("");

            html = `
            <table class="table table-bordered">
                <thead><tr>${thead}</tr></thead>
                <tbody>${tbody}</tbody>
            </table>
            <button type="button" onclick="addRow(this)" class="btn btn-sm btn-secondary">+ Row</button>
<button type="button" onclick="addColumn(this)" class="btn btn-sm btn-secondary">+ Column</button>
        `;
        }

        block.innerHTML = html + `
        <button type="button" class="btn btn-danger btn-sm mt-2" onclick="this.parentElement.remove()">Delete</button>
    `;

        container.appendChild(block);

        // HTML live preview
        if (type === "html") {
            let textarea = block.querySelector(".html-input");
            let preview = block.querySelector(".preview");

            textarea.addEventListener("input", function () {
                preview.innerHTML = this.value;
            });
        }

        let menu = document.getElementById("blockMenu");
        menu.style.display = "none";
        menuOpen = false;
    }

    // ================= TABLE FUNCTIONS =================
    function addRow(btn) {
        let table = btn.parentElement.querySelector("table");
        let cols = table.rows[0].cells.length;
        let row = table.insertRow();

        for (let i = 0; i < cols; i++) {
            let cell = row.insertCell();
            cell.contentEditable = true;
            cell.innerText = "New";
        }
    }

    function addColumn(btn) {
        let table = btn.parentElement.querySelector("table");

        for (let row of table.rows) {
            let cell = row.insertCell();
            cell.contentEditable = true;
            cell.innerText = "New";
        }
    }

    // ================= SAVE =================
    function saveBlocks() {

        let blocks = [];

        document.querySelectorAll(".block").forEach((block, index) => {

            let type = block.getAttribute("data-type");

            let content = "";
            let extraData = null;

            if (type === "h1" || type === "h2") {
                content = block.querySelector("input").value;
            }

            if (type === "paragraph") {
                content = block.querySelector("textarea").value;
            }

            if (type === "html") {
                content = block.querySelector("textarea").value;
            }

            if (type === "image") {
                let file = block.querySelector("input").files[0];
                content = file ? file.name : "";
            }

            if (type === "table") {
                let table = block.querySelector("table");

                let headers = [];
                let rows = [];

                table.querySelectorAll("thead th").forEach(th => headers.push(th.innerText));

                table.querySelectorAll("tbody tr").forEach(tr => {
                    let row = [];
                    tr.querySelectorAll("td").forEach(td => row.push(td.innerText));
                    rows.push(row);
                });

                extraData = JSON.stringify({ headers, rows });
            }

            blocks.push({
                BlockType: type,
                Content: content,
                ExtraData: extraData,
                DisplayOrder: index
            });
        });

        fetch("EditBlogContent.aspx/SaveBlocks", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ blocks: blocks, blogId: blogId })
        })
            .then(res => res.json())
            .then(() => alert("Content Saved!"));
    }

    // ================= LOAD =================
    window.onload = function () {

        // 🔹 Existing load blocks code (keep this if already present)
        fetch("EditBlogContent.aspx/GetBlocks", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ blogId: blogId })
        })
            .then(res => res.json())
            .then(data => {
                let blocks = data.d;
                blocks.forEach(b => addBlock(b.BlockType, b));
            });

        // 🔥 ADD THESE HERE

        // Prevent menu click from closing
        document.getElementById("blockMenu").addEventListener("click", function (e) {
            e.stopPropagation();
        });

        // Close menu when clicking outside
        document.addEventListener("click", function () {
            let menu = document.getElementById("blockMenu");

            if (menuOpen) {
                menu.style.display = "none";
                menuOpen = false;
            }
        });

    };

</script>

</asp:Content>