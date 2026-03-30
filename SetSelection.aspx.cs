using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb
{
    public partial class SetSelection : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sid = Request.QueryString["sid"];
                string res = Request.QueryString["res"];
                string yid = Request.QueryString["yid"];

                // Essential safety check
                if (string.IsNullOrEmpty(sid) || string.IsNullOrEmpty(res) || string.IsNullOrEmpty(yid))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadMetaData(sid, yid);
                BindSets(sid, res, yid);
            }
        }

        private void LoadMetaData(string sid, string yid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Pulling names for the UI header
                string sql = @"SELECT s.SubjectName, y.YearName 
                               FROM Subjects s, Years y 
                               WHERE s.SubjectId = @sid AND y.YearId = @yid";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@yid", yid);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litSubjectYear.Text = $"{dr["SubjectName"]} <span class='text-primary'>{dr["YearName"]}</span>";
                }
            }
        }

        private void BindSets(string sid, string res, string yid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // The most important query: Joins Sets with Resources to filter only RELEVANT sets
                string sql = @"SELECT DISTINCT s.SetId, s.SetName 
                               FROM Sets s
                               INNER JOIN Resources r ON s.SetId = r.SetId
                               INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                               WHERE r.SubjectId = @sid 
                               AND r.YearId = @yid 
                               AND rt.Slug = @res 
                               AND s.IsActive = 1";

                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@sid", sid);

                da.SelectCommand.Parameters.AddWithValue("@res", res);
                da.SelectCommand.Parameters.AddWithValue("@yid", yid);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSets.DataSource = dt;
                rptSets.DataBind();
            }
        }
    }
}