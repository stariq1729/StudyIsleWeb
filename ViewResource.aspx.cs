using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class ViewResource : System.Web.UI.Page
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
            string bid = Request.QueryString["bid"];
            string rid = Request.QueryString["rid"];
            string scid = Request.QueryString["scid"];
            string sid = Request.QueryString["sid"];
            string cid = Request.QueryString["cid"];
            string yid = Request.QueryString["yid"];
            string setid = Request.QueryString["setid"];

            if (string.IsNullOrEmpty(bid))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"
       SELECT r.ResourceId, r.Title, r.Description, r.FilePath, r.ContentType,
       CASE 
           WHEN b.BookmarkId IS NOT NULL THEN 1 
           ELSE 0 
       END AS IsBookmarked
FROM Resources r
LEFT JOIN Bookmarks b 
    ON r.ResourceId = b.ItemId 
    AND b.ItemType = 'Resource'
    AND b.UserId = @uid
WHERE r.IsActive = 1
AND r.BoardId = @bid";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.Parameters.AddWithValue("@bid", Convert.ToInt32(bid));
                cmd.Parameters.AddWithValue("@uid", Session["UserId"] ?? 0);

                // =====================================================
                // 🔥 CONTEXT BASED FILTERING (REAL FIX)
                // =====================================================

                // ✅ 1. SET
                if (!string.IsNullOrEmpty(setid))
                {
                    sql += " AND r.SetId = @setid";
                    cmd.Parameters.AddWithValue("@setid", Convert.ToInt32(setid));
                }

                // ✅ 2. YEAR (DO NOT FORCE SUBCAT OR SUBJECT)
                else if (!string.IsNullOrEmpty(yid))
                {
                    sql += " AND r.YearId = @yid";
                    cmd.Parameters.AddWithValue("@yid", Convert.ToInt32(yid));
                }

                // ✅ 3. CHAPTER
                else if (!string.IsNullOrEmpty(cid))
                {
                    sql += " AND r.ChapterId = @cid";
                    cmd.Parameters.AddWithValue("@cid", Convert.ToInt32(cid));
                }

                // ✅ 4. SUBJECT
                else if (!string.IsNullOrEmpty(sid))
                {
                    sql += " AND r.SubjectId = @sid";
                    cmd.Parameters.AddWithValue("@sid", Convert.ToInt32(sid));
                }

                // ✅ 5. SUBCATEGORY (ONLY IF NOTHING ELSE)
                else if (!string.IsNullOrEmpty(scid))
                {
                    sql += " AND r.SubCategoryId = @scid";
                    cmd.Parameters.AddWithValue("@scid", Convert.ToInt32(scid));
                }

                // ✅ Resource Type
                if (!string.IsNullOrEmpty(rid))
                {
                    sql += " AND r.ResourceTypeId = @rid";
                    cmd.Parameters.AddWithValue("@rid", Convert.ToInt32(rid));
                }

                cmd.CommandText = sql;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                con.Open();
                da.Fill(dt);

                rptResources.DataSource = dt;
                rptResources.DataBind();

                phEmpty.Visible = (dt.Rows.Count == 0);
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
        // UI helpers (unchanged)
        protected string GetTheme(string type)
        {
            string t = type.ToLower();
            if (t.Contains("pdf")) return "bg-pdf";
            if (t.Contains("image")) return "bg-img";
            if (t.Contains("video")) return "bg-vid";
            return "bg-gen";
        }

        protected string GetIcon(string type)
        {
            string t = type.ToLower();
            if (t.Contains("pdf")) return "fas fa-file-pdf";
            if (t.Contains("image")) return "fas fa-file-image";
            if (t.Contains("video")) return "fas fa-play-circle";
            return "fas fa-file-alt";
        }
    }
}