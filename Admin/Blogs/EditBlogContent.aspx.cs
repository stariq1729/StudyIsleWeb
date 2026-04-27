using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class EditBlogContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        // 🔹 Model
        public class BlockModel
        {
            public string BlockType { get; set; }
            public string Content { get; set; }
            public string ExtraData { get; set; }
            public int DisplayOrder { get; set; }
        }

        // ================= SAVE =================
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveBlocks(List<BlockModel> blocks, int blogId)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    // Delete old blocks
                    SqlCommand del = new SqlCommand("DELETE FROM BlogBlocks WHERE BlogId=@BlogId", con);
                    del.Parameters.AddWithValue("@BlogId", blogId);
                    del.ExecuteNonQuery();

                    // Insert new blocks
                    foreach (var b in blocks)
                    {
                        SqlCommand cmd = new SqlCommand(@"
                            INSERT INTO BlogBlocks (BlogId, BlockType, Content, ExtraData, DisplayOrder)
                            VALUES (@BlogId, @BlockType, @Content, @ExtraData, @DisplayOrder)", con);

                        cmd.Parameters.AddWithValue("@BlogId", blogId);
                        cmd.Parameters.AddWithValue("@BlockType", b.BlockType ?? "");
                        cmd.Parameters.AddWithValue("@Content", string.IsNullOrEmpty(b.Content) ? (object)DBNull.Value : b.Content);
                        cmd.Parameters.AddWithValue("@ExtraData", string.IsNullOrEmpty(b.ExtraData) ? (object)DBNull.Value : b.ExtraData);
                        cmd.Parameters.AddWithValue("@DisplayOrder", b.DisplayOrder);

                        cmd.ExecuteNonQuery();
                    }
                }

                return "success";
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message; // 🔥 will show in console
            }
        }

        // ================= GET =================
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<BlockModel> GetBlocks(int blogId)
        {
            List<BlockModel> list = new List<BlockModel>();

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT BlockType, Content, ExtraData, DisplayOrder FROM BlogBlocks WHERE BlogId=@BlogId ORDER BY DisplayOrder",
                        con);

                    cmd.Parameters.AddWithValue("@BlogId", blogId);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        list.Add(new BlockModel
                        {
                            BlockType = dr["BlockType"] == DBNull.Value ? "" : dr["BlockType"].ToString(),
                            Content = dr["Content"] == DBNull.Value ? "" : dr["Content"].ToString(),
                            ExtraData = dr["ExtraData"] == DBNull.Value ? "" : dr["ExtraData"].ToString(),
                            DisplayOrder = dr["DisplayOrder"] == DBNull.Value ? 0 : Convert.ToInt32(dr["DisplayOrder"])
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("GetBlocks Error: " + ex.Message);
            }

            return list;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string UploadImage(string base64Image, string fileName)
        {
            try
            {
                if (string.IsNullOrEmpty(base64Image))
                    return "ERROR: Base64 string is empty";

                if (string.IsNullOrEmpty(fileName))
                    return "ERROR: File name is empty";

                // 📁 Correct folder path
                string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/blog/");

                // Ensure folder exists
                if (!System.IO.Directory.Exists(folderPath))
                {
                    System.IO.Directory.CreateDirectory(folderPath);
                }

                // ✅ Extract extension safely
                string ext = System.IO.Path.GetExtension(fileName);
                if (string.IsNullOrEmpty(ext))
                    ext = ".png";

                string newFileName = Guid.NewGuid().ToString() + ext;

                // ✅ Proper path combine (IMPORTANT FIX)
                string fullPath = System.IO.Path.Combine(folderPath, newFileName);

                // ✅ Clean base64 string
                string base64Data = base64Image.Contains(",")
                    ? base64Image.Split(',')[1]
                    : base64Image;

                byte[] imageBytes = Convert.FromBase64String(base64Data);

                // Save file
                System.IO.File.WriteAllBytes(fullPath, imageBytes);

                // Return relative path
                return "/Uploads/blog/" + newFileName;
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.ToString();
            }
        }
    }
}