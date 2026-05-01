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
    <div class="block-option" onclick="addBlock('section')">Section</div>
</div>

<style>
.block-option { padding:8px; cursor:pointer; }
.block-option:hover { background:#f1f1f1; }
.block { border:1px solid #ddd; padding:15px; margin-bottom:10px; }
</style>

<script>

    let blogId = parseInt(new URLSearchParams(window.location.search).get("BlogId"));
    if (!blogId) {
        alert("Invalid BlogId in URL");
    }
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
            html = `
        <input type="file" class="form-control image-input" />
        <img class="preview-img" 
             src="${data?.Content || ''}" 
             style="max-width:200px;margin-top:10px; ${data?.Content ? '' : 'display:none;'}" />
    `;
        }

        if (type === "html") {
            html = `
            <p>html content with live preview:</p>
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

            // 🔥 Create normal headers
            let thead = headers.map((h, i) => `
    <th contenteditable="true" style="position:relative;">
        ${h}
        <button 
            type="button"
            onclick="deleteColumn(this)"
            style="position:absolute; top:2px; right:2px; font-size:10px;"
        >✖</button>
    </th>
`).join("");

            // 🔥 FIXED DELETE COLUMN (with identifier)
            thead += `<th class="delete-col" style="width:60px;"></th>`;

            let tbody = rows.map(r =>
                `<tr>
        ${r.map(c => `<td contenteditable="true">${c}</td>`).join("")}
       <td class="delete-col">
    <button class="btn btn-danger btn-sm" onclick="deleteThisRow(this)">✖</button>
</td>
    </tr>`
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

        /*this structure for the section*/
        /* ===== SECTION TYPE ===== */
        if (type === "section") {
            html = `
    <div class="section-block p-3 rounded" style="background:#f8f9fa;">
        
        <input 
            type="text" 
            class="form-control mb-2 section-title" 
            placeholder="Section Title..."
            value="${data?.Content || ''}"
        />

        <textarea 
            class="form-control section-desc" 
            placeholder="Section description..."
            rows="2"
        ></textarea>

    </div>
    `;
        }

        block.innerHTML = `
    <div class="d-flex gap-2 mb-2">
        <button type="button" class="btn btn-sm btn-secondary" onclick="moveUp(this)">⬆</button>
        <button type="button" class="btn btn-sm btn-secondary" onclick="moveDown(this)">⬇</button>
        <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.parentElement.remove()">Delete</button>
    </div>
    ${html}
`;

        container.appendChild(block);

        // ✅ ADD HERE
        if (type === "section" && data && data.ExtraData) {
            let textarea = block.querySelector(".section-desc");
            if (textarea) {
                textarea.value = data.ExtraData;
            }
        }

        // HTML live preview
        if (type === "html") {
            let textarea = block.querySelector(".html-input");
            let preview = block.querySelector(".preview");

            textarea.addEventListener("input", function () {
                preview.innerHTML = this.value;
            });
        }
        // ✅ IMAGE PREVIEW (CORRECT PLACE)
        if (type === "image") {
            let fileInput = block.querySelector(".image-input");
            let preview = block.querySelector(".preview-img");

            fileInput.addEventListener("change", function () {
                let file = this.files[0];
                if (file) {
                    let reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = "block";
                    };
                    reader.readAsDataURL(file);
                }
            });
        }

        let menu = document.getElementById("blockMenu");
        menu.style.display = "none";
        menuOpen = false;
    }

    // ================= TABLE FUNCTIONS =================
   

    function addRow(btn) {

        let block = btn.closest(".block");
        let table = block.querySelector("table");

        let tbody = table.querySelector("tbody");

        // ✅ Get only DATA columns (exclude delete column)
        let headers = table.querySelectorAll("thead th:not(.delete-col)");
        let dataColumnCount = headers.length;

        let tr = document.createElement("tr");

        // ✅ Add data cells
        for (let i = 0; i < dataColumnCount; i++) {
            let td = document.createElement("td");
            td.contentEditable = true;
            td.innerText = "New";
            tr.appendChild(td);
        }

        // ✅ Add delete column (always last)
        let tdDelete = document.createElement("td");
        tdDelete.className = "delete-col";
        tdDelete.innerHTML = `<button class="btn btn-danger btn-sm" onclick="deleteThisRow(this)">✖</button>`;
        tr.appendChild(tdDelete);

        tbody.appendChild(tr);
    }

    function addColumn(btn) {

        let block = btn.closest(".block");
        let table = block.querySelector("table");

        let theadRow = table.querySelector("thead tr");
        let rows = table.querySelectorAll("tbody tr");

        // ✅ Find delete column directly (no guessing)
        let deleteHeader = theadRow.querySelector(".delete-col");

        // ✅ Create new header
        let th = document.createElement("th");
        th.setAttribute("contenteditable", "true");
        th.style.position = "relative";

        th.innerHTML = `
    New Column
    <button 
        type="button"
        onclick="deleteColumn(this)"
        style="position:absolute; top:2px; right:2px; font-size:10px;"
    >✖</button>
`;

        // ✅ Insert BEFORE delete column
        theadRow.insertBefore(th, deleteHeader);

        // ✅ Add new cell in each row BEFORE delete column
        rows.forEach(tr => {
            let deleteCell = tr.querySelector(".delete-col");

            let td = document.createElement("td");
            td.contentEditable = true;
            td.innerText = "New";

            tr.insertBefore(td, deleteCell);
        });
    }

    // ================= Move buttons =================
    function moveUp(btn) {

        // 🔹 get the block div
        let block = btn.closest(".block");

        // 🔹 get previous block
        let prev = block.previousElementSibling;

        // 🔹 if exists → move up
        if (prev) {
            block.parentElement.insertBefore(block, prev);
        }
    }
    function moveDown(btn) {

        // 🔹 get the block div
        let block = btn.closest(".block");

        // 🔹 get next block
        let next = block.nextElementSibling;

        // 🔹 if exists → move down
        if (next) {
            block.parentElement.insertBefore(next, block);
        }
    }
    // ================= Delete Row =================
    function deleteThisRow(btn) {

        let row = btn.closest("tr");
        let tbody = row.parentElement;

        if (tbody.rows.length > 1) {
            row.remove();
        } else {
            alert("At least one row required");
        }
    }

    // ======== delete column button=========
    function deleteColumn(btn) {

        let th = btn.closest("th");
        let table = th.closest("table");

        let colIndex = Array.from(th.parentElement.children).indexOf(th);

        // ❌ Prevent deleting last data column
        let totalCols = table.querySelectorAll("thead th:not(.delete-col)").length;
        if (totalCols <= 1) {
            alert("At least one column required");
            return;
        }

        // Remove header
        th.remove();

        // Remove corresponding cell in each row
        table.querySelectorAll("tbody tr").forEach(tr => {
            tr.children[colIndex].remove();
        });
    }
    // ================= SAVE =================
    async function saveBlocks() {

        let blocks = [];

        let allBlocks = document.querySelectorAll(".block");

        for (let index = 0; index < allBlocks.length; index++) {

            let block = allBlocks[index];

            let type = block.getAttribute("data-type");

            let content = "";
            let extraData = null;

            // ===== TEXT TYPES =====
            if (type === "h1" || type === "h2") {
                content = block.querySelector("input").value;
            }

            if (type === "paragraph") {
                content = block.querySelector("textarea").value;
            }

            if (type === "html") {
                content = block.querySelector("textarea").value;
            }

            // ===== IMAGE TYPE =====
            // ===== IMAGE TYPE =====
            if (type === "image") {

                let fileInput = block.querySelector(".image-input");
                let file = fileInput.files[0];

                if (file) {
                    try {

                        let formData = new FormData();
                        formData.append("file", file);

                        let res = await fetch("/Admin/Blogs/UploadImageHandler.ashx", {
                            method: "POST",
                            body: formData
                        });

                        // 🔥 CHECK RESPONSE STATUS
                        if (!res.ok) {
                            let errorText = await res.text();
                            console.error("UPLOAD ERROR RAW:", errorText);
                            alert("Upload failed (server error)");
                            return;
                        }

                        let result = await res.json();

                        console.log("UPLOAD RESPONSE:", result);

                        // ❌ INVALID RESPONSE CHECK
                        if (!result || !result.path) {
                            alert("Invalid response from server");
                            return;
                        }

                        // ❌ BACKEND ERROR CHECK
                        if (result.error) {
                            alert(result.error);
                            return;
                        }

                        // ✅ SUCCESS
                        content = result.path;

                    } catch (err) {
                        console.error("UPLOAD EXCEPTION:", err);
                        alert("Upload exception occurred");
                        return;
                    }

                } else {
                    // Existing image (already saved URL)
                    content = block.querySelector(".preview-img").src;
                }
            }

            // ===== TABLE TYPE =====
            if (type === "table") {

                let table = block.querySelector("table");

                let headers = [];
                let rows = [];

                // ✅ FIX 1: Proper header extraction
                table.querySelectorAll("thead th:not(.delete-col)").forEach(th => {

                    // ✅ Clone header to remove button safely
                    let clone = th.cloneNode(true);

                    let btn = clone.querySelector("button");
                    if (btn) btn.remove();

                    headers.push(clone.innerText.trim());
                });

                // ✅ FIX 2: Proper row extraction (handles dynamic columns)
                table.querySelectorAll("tbody tr").forEach(tr => {

                    let row = [];

                    tr.querySelectorAll("td:not(.delete-col)").forEach(td => {
                        row.push(td.innerText.trim());
                    });

                    rows.push(row);
                });

                // ✅ FIX 3: Ensure column consistency (VERY IMPORTANT)
                let maxCols = headers.length;

                rows = rows.map(r => {
                    while (r.length < maxCols) {
                        r.push(""); // fill missing cells
                    }
                    return r;
                });

                extraData = JSON.stringify({
                    headers: headers,
                    rows: rows
                });
            }
            // ===== SECTION TYPE =====
            if (type === "section") {

                let title = block.querySelector(".section-title")?.value || "";
                let desc = block.querySelector(".section-desc")?.value || "";

                content = title;
                extraData = desc;  
            }

            blocks.push({
                BlockType: type,
                Content: content,
                ExtraData: extraData,
                DisplayOrder: index
            });
        }

        // ===== SAVE TO DATABASE =====
        try {
            let response = await fetch("EditBlogContent.aspx/SaveBlocks", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ blocks: blocks, blogId: blogId })
            });

            let data = await response.json();

            console.log("SAVE RESPONSE:", data);

            if (data.d === "success") {
                alert("Content Saved!");
            } else {
                alert("Error: " + data.d);
            }
        }
        catch (err) {
            console.error("SAVE ERROR:", err);
            alert("Something went wrong while saving.");
        }
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