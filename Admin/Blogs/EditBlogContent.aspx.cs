using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class EditBlogContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        public class BlockModel
        {
            public string BlockType { get; set; }
            public string Content { get; set; }
            public string ExtraData { get; set; }
            public int DisplayOrder { get; set; }
        }

        [WebMethod]
        public static string SaveBlocks(object blocks, int blogId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
            var blockList = JsonConvert.DeserializeObject<List<BlockModel>>(blocks.ToString());

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Remove old
                SqlCommand del = new SqlCommand("DELETE FROM BlogBlocks WHERE BlogId=@BlogId", con);
                del.Parameters.AddWithValue("@BlogId", blogId);
                del.ExecuteNonQuery();

                foreach (var b in blockList)
                {
                    SqlCommand cmd = new SqlCommand(@"
                        INSERT INTO BlogBlocks (BlogId, BlockType, Content, ExtraData, DisplayOrder)
                        VALUES (@BlogId, @BlockType, @Content, @ExtraData, @DisplayOrder)", con);

                    cmd.Parameters.AddWithValue("@BlogId", blogId);
                    cmd.Parameters.AddWithValue("@BlockType", b.BlockType);
                    cmd.Parameters.AddWithValue("@Content", (object)b.Content ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@ExtraData", (object)b.ExtraData ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@DisplayOrder", b.DisplayOrder);

                    cmd.ExecuteNonQuery();
                }
            }

            return "success";
        }

        [WebMethod]
        public static object GetBlocks(int blogId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;
            var list = new List<BlockModel>();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT BlockType, Content, ExtraData, DisplayOrder FROM BlogBlocks WHERE BlogId=@BlogId ORDER BY DisplayOrder",
                    con);

                cmd.Parameters.AddWithValue("@BlogId", blogId);

                con.Open();
                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    list.Add(new BlockModel
                    {
                        BlockType = dr["BlockType"].ToString(),
                        Content = dr["Content"].ToString(),
                        ExtraData = dr["ExtraData"].ToString(),
                        DisplayOrder = Convert.ToInt32(dr["DisplayOrder"])
                    });
                }
            }

            return list;
        }
    }
}