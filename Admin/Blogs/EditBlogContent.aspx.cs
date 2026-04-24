using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class EditBlogContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class BlockModel
        {
            public string BlockType { get; set; }
            public string Content { get; set; }
            public int DisplayOrder { get; set; }
        }

        [WebMethod]
        public static string SaveBlocks(object blocks, int blogId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            var blockList = JsonConvert.DeserializeObject<BlockModel[]>(blocks.ToString());

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // 🔴 Remove old blocks (important)
                string deleteQuery = "DELETE FROM BlogBlocks WHERE BlogId=@BlogId";
                SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);
                deleteCmd.Parameters.AddWithValue("@BlogId", blogId);
                deleteCmd.ExecuteNonQuery();

                foreach (var block in blockList)
                {
                    string insertQuery = @"INSERT INTO BlogBlocks 
                        (BlogId, BlockType, Content, DisplayOrder)
                        VALUES (@BlogId, @BlockType, @Content, @DisplayOrder)";

                    SqlCommand cmd = new SqlCommand(insertQuery, con);

                    cmd.Parameters.AddWithValue("@BlogId", blogId);
                    cmd.Parameters.AddWithValue("@BlockType", block.BlockType);
                    cmd.Parameters.AddWithValue("@Content", block.Content ?? "");
                    cmd.Parameters.AddWithValue("@DisplayOrder", block.DisplayOrder);

                    cmd.ExecuteNonQuery();
                }

                con.Close();
            }

            return "success";
        }
    }
}