using System;
using System.IO;
using System.Web;

public class UploadImageHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Request.Files.Count == 0)
            {
                context.Response.Write("{\"error\":\"No file uploaded\"}");
                return;
            }

            var file = context.Request.Files[0];

            string folderPath = context.Server.MapPath("~/Uploads/blog/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string fileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
            string fullPath = Path.Combine(folderPath, fileName);

            file.SaveAs(fullPath);

            context.Response.ContentType = "application/json";
            context.Response.Write("{\"path\":\"/Uploads/blog/" + fileName + "\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":\"" + ex.Message + "\"}");
        }
    }

    public bool IsReusable => false;
}