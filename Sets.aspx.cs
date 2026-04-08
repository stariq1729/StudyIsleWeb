using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class Sets : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bid = Request.QueryString["bid"];
                string rid = Request.QueryString["rid"];
                string scid = Request.QueryString["scid"];
                string yid = Request.QueryString["yid"];
                string cid = Request.QueryString["cid"];

                if (string.IsNullOrEmpty(bid) || string.IsNullOrEmpty(scid))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadSets(
                    Convert.ToInt32(bid),
                    rid,
                    Convert.ToInt32(scid),
                    yid,
                    cid
                );
            }
        }

        private void LoadSets(int boardId, string rId, int subCatId, string yIdStr, string cIdStr)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string sql = "SELECT SetName, SetId FROM Sets WHERE IsActive = 1";

                if (!string.IsNullOrEmpty(cIdStr))
                {
                    sql += " AND ChapterId = @cid";
                }
                else if (!string.IsNullOrEmpty(yIdStr))
                {
                    sql += " AND YearId = @yid";
                }

                sql += " AND SubCategoryId = @scid";

                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@scid", subCatId);

                if (!string.IsNullOrEmpty(cIdStr))
                    cmd.Parameters.AddWithValue("@cid", Convert.ToInt32(cIdStr));

                if (!string.IsNullOrEmpty(yIdStr))
                    cmd.Parameters.AddWithValue("@yid", Convert.ToInt32(yIdStr));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptSets.DataSource = dt;
                    rptSets.DataBind();
                }
                else
                {
                    string redirectUrl = $"ViewResource.aspx?bid={boardId}&rid={rId}&scid={subCatId}";

                    if (!string.IsNullOrEmpty(yIdStr))
                        redirectUrl += $"&yid={yIdStr}";

                    if (!string.IsNullOrEmpty(cIdStr))
                        redirectUrl += $"&cid={cIdStr}";

                    Response.Redirect(redirectUrl);
                }
            }
        }

        protected string GetResourceUrl(object setId)
        {
            string bid = Request.QueryString["bid"];
            string rid = Request.QueryString["rid"];
            string scid = Request.QueryString["scid"];
            string yid = Request.QueryString["yid"];
            string cid = Request.QueryString["cid"];

            string url = $"ViewResource.aspx?bid={bid}&rid={rid}&scid={scid}&setid={setId}";

            if (!string.IsNullOrEmpty(yid))
                url += $"&yid={yid}";

            if (!string.IsNullOrEmpty(cid))
                url += $"&cid={cid}";

            return url;
        }
    }
}