<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="AddGallery.aspx.cs"
    Inherits="StudyIsleWeb.Admin.AddGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

        .gallery-page {
            padding: 40px;
            background: #f4f7fb;
            min-height: 100vh;
        }

        .gallery-card {
            max-width: 980px;
            margin: auto;
            background: #ffffff;
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.08);
        }

        .gallery-header {
            padding: 28px 35px 22px;
            border-bottom: 1px solid #edf0f5;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .gallery-title {
            font-size: 32px;
            font-weight: 700;
            color: #172033;
            margin-bottom: 6px;
        }

        .gallery-subtitle {
            font-size: 15px;
            color: #7d879c;
        }

        .close-btn {
            font-size: 28px;
            color: #9aa3b5;
            background: none;
            border: none;
            cursor: pointer;
        }

        .gallery-body {
            padding: 35px;
        }

        .gallery-flex {
            display: flex;
            gap: 35px;
            flex-wrap: wrap;
        }

        .upload-box {
            width: 320px;
            height: 320px;
            border: 2px dashed #d9deea;
            border-radius: 24px;
            background: #fafbff;
            position: relative;
            overflow: hidden;
        }

        .upload-box label {
            width: 100%;
            height: 100%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .upload-content {
            text-align: center;
        }

        .upload-icon {
            width: 75px;
            height: 75px;
            border-radius: 20px;
            background: #ffffff;
            margin: auto auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
            font-size: 32px;
            color: #6c63ff;
        }

        .upload-title {
            font-size: 24px;
            font-weight: 700;
            color: #1c2333;
            margin-bottom: 8px;
        }

        .upload-subtitle {
            font-size: 13px;
            color: #97a0b3;
            font-weight: 600;
        }

        .image-preview {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .gallery-form {
            flex: 1;
            min-width: 300px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: #8c94a7;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .custom-input,
        .custom-textarea,
        .custom-date {
            width: 100%;
            border: none;
            background: #f5f7fb;
            border-radius: 16px;
            padding: 18px 20px;
            font-size: 16px;
            color: #1d2433;
            outline: none;
        }

        .custom-input:focus,
        .custom-textarea:focus,
        .custom-date:focus {
            background: #eef2ff;
        }

        .custom-textarea {
            min-height: 140px;
            resize: none;
        }

        .gallery-footer {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cancel-btn {
            background: none;
            border: none;
            color: #8b95a8;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
        }

        .publish-btn {
            background: #cfc8ff;
            border: none;
            color: #ffffff;
            padding: 18px 60px;
            border-radius: 16px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .publish-btn:hover {
            background: #b9afff;
        }

        .success-message {
            background: #e7f8ec;
            color: #198754;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .error-message {
            background: #ffe7e7;
            color: #dc3545;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 600;
        }

        @media(max-width:900px) {

            .gallery-body {
                padding: 25px;
            }

            .gallery-flex {
                flex-direction: column;
            }

            .upload-box {
                width: 100%;
            }

            .gallery-footer {
                flex-direction: column;
                gap: 20px;
            }

            .publish-btn {
                width: 100%;
            }
        }

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="gallery-page">

        <div class="gallery-card">

            <!-- HEADER -->
            <div class="gallery-header">

                <div>
                    <div class="gallery-title">
                        Post New Moment
                    </div>

                    <div class="gallery-subtitle">
                        Capture excellence for parents and students to see.
                    </div>
                </div>

                <button type="button" class="close-btn">
                    ×
                </button>

            </div>

            <!-- BODY -->
            <div class="gallery-body">

                <!-- MESSAGE -->
                <asp:Label ID="lblMessage"
                    runat="server"
                    Visible="false">
                </asp:Label>
                <asp:HiddenField ID="hfGalleryId"
    runat="server" />

<asp:HiddenField ID="hfOldImagePath"
    runat="server" />

                <div class="gallery-flex">

                    <!-- IMAGE UPLOAD -->
                    <div class="upload-box">

                        <div onclick="document.getElementById('<%= fuGalleryImage.ClientID %>').click();"
                            style="width:100%; height:100%; cursor:pointer;">

                            <!-- IMAGE PREVIEW -->
                            <asp:Image ID="imgPreview"
                                runat="server"
                                CssClass="image-preview"
                                ClientIDMode="Static" />

                            <!-- PLACEHOLDER -->
                           <div class="upload-content"
    id="uploadContent"
    runat="server">

                                <div class="upload-icon">
                                    🖼
                                </div>

                                <div class="upload-title">
                                    Select Photo
                                </div>

                                <div class="upload-subtitle">
                                    RAW, JPG OR PNG
                                </div>

                            </div>

                        </div>

                        <!-- FILEUPLOAD -->
                        <asp:FileUpload ID="fuGalleryImage"
                            runat="server"
                            ClientIDMode="Static"
                            Style="display:none;"
                            accept=".jpg,.jpeg,.png" />

                    </div>

                    <!-- FORM -->
                    <div class="gallery-form">

                        <!-- TITLE -->
                        <div class="form-group">

                            <label class="form-label">
                                Title
                            </label>

                            <asp:TextBox ID="txtTitle"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="custom-input"
                                placeholder="e.g. Science Fair Highlights">
                            </asp:TextBox>

                        </div>

                        <!-- DATE -->
                        <div class="form-group">

                            <label class="form-label">
                                Date
                            </label>

                            <asp:TextBox ID="txtDate"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="custom-date"
                                TextMode="Date">
                            </asp:TextBox>

                        </div>

                        <!-- DESCRIPTION -->
                        <div class="form-group">

                            <label class="form-label">
                                Story / Description
                            </label>

                            <asp:TextBox ID="txtDescription"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="custom-textarea"
                                TextMode="MultiLine"
                                placeholder="Add a heart-warming caption...">
                            </asp:TextBox>

                        </div>

                    </div>

                </div>

                <!-- FOOTER -->
                <div class="gallery-footer">

                    <button type="button"
                        class="cancel-btn"
                        onclick="clearForm()">
                        Cancel
                    </button>

                    <asp:Button ID="btnPublish"
                        runat="server"
                        Text="PUBLISH NOW"
                        CssClass="publish-btn"
                        OnClick="btnPublish_Click" />

                </div>

            </div>

        </div>

    </div>

    <!-- IMAGE PREVIEW SCRIPT -->
    <script>

        window.onload = function () {

            const fileUpload =
                document.getElementById('fuGalleryImage');

            const imagePreview =
                document.getElementById('imgPreview');

            const uploadContent =
                document.getElementById('uploadContent');

            if (fileUpload) {

                fileUpload.addEventListener('change', function () {

                    const file = this.files[0];

                    if (file) {

                        const reader = new FileReader();

                        reader.onload = function (e) {

                            imagePreview.style.display = 'block';

                            imagePreview.src = e.target.result;

                            uploadContent.style.display = 'none';
                        };

                        reader.readAsDataURL(file);
                    }

                });

            }

        };

        function clearForm() {

            document.getElementById('txtTitle').value = '';

            document.getElementById('txtDescription').value = '';

            document.getElementById('txtDate').value = '';

            document.getElementById('fuGalleryImage').value = '';

            const imagePreview =
                document.getElementById('imgPreview');

            const uploadContent =
                document.getElementById('uploadContent');

            imagePreview.style.display = 'none';

            imagePreview.src = '';

            uploadContent.style.display = 'block';
        }

    </script>

</asp:Content>