using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
                string connStr = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

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
                // 🔥 return empty list instead of breaking UI
                return new List<BlockModel>();
            }

            return list;
        }
    }
}