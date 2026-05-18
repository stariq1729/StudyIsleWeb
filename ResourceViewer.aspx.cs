using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class ResourceViewer : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResource();
            }
        }

        private void LoadResource()
        {
            string id = Request.QueryString["id"];

            // =========================
            // VALIDATION
            // =========================

            if (string.IsNullOrEmpty(id))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

SELECT
    r.Title,
    r.Description,
    r.FilePath,
    r.ContentType,

    s.SubjectName,

    rt.TypeName

FROM Resources r

LEFT JOIN Subjects s
    ON r.SubjectId = s.SubjectId

LEFT JOIN ResourceTypes rt
    ON r.ResourceTypeId = rt.ResourceTypeId

WHERE r.ResourceId = @id
AND r.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@id", Convert.ToInt32(id));

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // =========================
                    // DATA
                    // =========================

                    string title =
                        dr["Title"].ToString();

                    string filePath =
                        ResolveUrl(dr["FilePath"].ToString());

                    string contentType =
                        dr["ContentType"].ToString().ToLower();

                    string subject =
                        dr["SubjectName"] != DBNull.Value
                        ? dr["SubjectName"].ToString()
                        : "Subject";

                    string resourceType =
    dr["TypeName"] != DBNull.Value
    ? dr["TypeName"].ToString()
    : "Resources";

                    // =========================
                    // HEADER
                    // =========================

                    litTitle.Text = title;

                    litSubject.Text = subject;

                    litCategory.Text = resourceType;

                    // =========================
                    // VIEWER LABEL
                    // =========================

                    if (contentType.Contains("pdf"))
                    {
                        litViewerType.Text = "PDF Document Viewer";
                        litResourceType.Text = "PDF Viewer";
                    }
                    else if (
                        contentType.Contains("image") ||
                        contentType.Contains("mindmap"))
                    {
                        litViewerType.Text = "Image Viewer";
                        litResourceType.Text = "Image Viewer";
                    }
                    else if (contentType.Contains("video"))
                    {
                        litViewerType.Text = "Video Viewer";
                        litResourceType.Text = "Video Viewer";
                    }
                    else
                    {
                        litViewerType.Text = "Resource Viewer";
                        litResourceType.Text = "Resource Viewer";
                    }

                    // =========================
                    // PDF
                    // =========================

                    if (contentType.Contains("pdf"))
                    {
                        phPdf.Visible = true;

                        pdfViewer.Attributes["src"] =
                            filePath +
                            "#toolbar=0&navpanes=0&scrollbar=1";
                    }

                    // =========================
                    // IMAGE / MINDMAP
                    // =========================

                    else if (
                        contentType.Contains("image") ||
                        contentType.Contains("mindmap"))
                    {
                        phImage.Visible = true;

                        zoomImage.Src = filePath;
                    }

                    // =========================
                    // VIDEO
                    // =========================

                    else if (contentType.Contains("video"))
                    {
                        phVideo.Visible = true;

                        videoPlayer.Attributes["src"] = filePath;

                        videoPlayer.Attributes["controls"] = "controls";

                        videoPlayer.Attributes["controlsList"] =
                            "nodownload noplaybackrate";
                    }

                    // =========================
                    // FALLBACK
                    // =========================

                    else
                    {
                        phPdf.Visible = true;

                        pdfViewer.Attributes["src"] = filePath;
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }

                dr.Close();
            }
        }
    }
}