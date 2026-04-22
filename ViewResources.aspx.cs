using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class ViewResources : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindResources();
            }
        }

        private void BindResources()
        {
            // Get all possible routing IDs from the URL
            string sid = Request.QueryString["sid"];
            string res = Request.QueryString["res"];
            string yid = Request.QueryString["yid"];
            string setid = Request.QueryString["setid"];
            string cid = Request.QueryString["cid"];

            //this id get add later for jee type boards
            // =============== string scid = Request.QueryString["scid"];================

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Notice the 'r.' prefix added to Title, Description, and CreatedAt
                string sql = @"SELECT 
        r.ResourceId,
        r.Title, 
        r.Description, 
        r.FilePath, 
        r.ContentType, 
        r.CreatedAt,
        CASE 
            WHEN b.BookmarkId IS NOT NULL THEN 1 
            ELSE 0 
        END AS IsBookmarked
       FROM Resources r 
       LEFT JOIN Bookmarks b 
            ON r.ResourceId = b.ItemId 
            AND b.ItemType = 'Resource'
            AND b.UserId = @uid
       INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId 
       WHERE r.IsActive = 1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@uid", Session["UserId"] ?? 0);

                //========= this section is Added for filterring later for both boards =============


                //// 2. Updated Path filtering logic
                //if (!string.IsNullOrEmpty(cid))
                //{
                //    // Chapter Specific Flow (Standard/Notes)
                //    sql += " AND r.ChapterId = @cid";
                //    cmd.Parameters.AddWithValue("@cid", cid);
                //}
                //else if (!string.IsNullOrEmpty(setid))
                //{
                //    // Set/Paper Specific Flow (PYQ/Assignments)
                //    sql += " AND r.SetId = @setid";
                //    cmd.Parameters.AddWithValue("@setid", setid);
                //}
                //else if (!string.IsNullOrEmpty(scid))
                //{
                //    // General SubCategory Flow (Syllabus or "Skip" scenarios)
                //    // This catches everything under a SubCat if more specific filters aren't used
                //    sql += " AND r.SubCategoryId = @scid";
                //    cmd.Parameters.AddWithValue("@scid", scid);
                //}
                //else if (!string.IsNullOrEmpty(sid))
                //{
                //    // Subject level fallback
                //    sql += " AND r.SubjectId = @sid AND rt.Slug = @res";
                //    cmd.Parameters.AddWithValue("@sid", sid);
                //    cmd.Parameters.AddWithValue("@res", res);
                //}



                // Path filtering logic
                if (!string.IsNullOrEmpty(cid))
                {
                    sql += " AND r.ChapterId = @cid";
                    cmd.Parameters.AddWithValue("@cid", cid);
                }
                else if (!string.IsNullOrEmpty(setid))
                {
                    sql += " AND r.SetId = @setid AND r.SubjectId = @sid AND r.YearId = @yid";
                    cmd.Parameters.AddWithValue("@setid", setid);
                    cmd.Parameters.AddWithValue("@sid", sid);
                    cmd.Parameters.AddWithValue("@yid", yid);
                }
                else if (!string.IsNullOrEmpty(sid))
                {
                    sql += " AND r.SubjectId = @sid AND rt.Slug = @res";
                    cmd.Parameters.AddWithValue("@sid", sid);
                    cmd.Parameters.AddWithValue("@res", res);
                }

                cmd.CommandText = sql;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt); // This should now work without the red error!

                if (dt.Rows.Count > 0)
                {
                    rptResources.DataSource = dt;
                    rptResources.DataBind();
                }
                else
                {
                    phNoData.Visible = true;
                }
            }
        }
        protected void rptResources_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Bookmark")
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);
                int resourceId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    string checkQuery = @"SELECT COUNT(*) FROM Bookmarks 
                                 WHERE UserId=@uid AND ItemId=@iid AND ItemType='Resource'";

                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@uid", userId);
                    checkCmd.Parameters.AddWithValue("@iid", resourceId);

                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        string deleteQuery = @"DELETE FROM Bookmarks 
                                      WHERE UserId=@uid AND ItemId=@iid AND ItemType='Resource'";

                        SqlCommand delCmd = new SqlCommand(deleteQuery, con);
                        delCmd.Parameters.AddWithValue("@uid", userId);
                        delCmd.Parameters.AddWithValue("@iid", resourceId);
                        delCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        string insertQuery = @"INSERT INTO Bookmarks (UserId, ItemId, ItemType)
                                      VALUES (@uid, @iid, 'Resource')";

                        SqlCommand insCmd = new SqlCommand(insertQuery, con);
                        insCmd.Parameters.AddWithValue("@uid", userId);
                        insCmd.Parameters.AddWithValue("@iid", resourceId);
                        insCmd.ExecuteNonQuery();
                    }
                }

                BindResources();
            }
        }
        // Logic to show different icons for PDF vs Flashcards/Mindmaps (Images)
        protected string GetStatusClass(string type)
        {
            if (type.Contains("pdf")) return "bg-pdf";
            if (type.Contains("image")) return "bg-image";
            return "bg-default";
        }

        protected string GetIcon(string type)
        {
            if (type.Contains("pdf")) return "fas fa-file-pdf";
            if (type.Contains("image")) return "fas fa-file-image";
            return "fas fa-file-alt";
        }
    }
}