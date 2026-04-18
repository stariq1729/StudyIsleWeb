using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace StudyIsleWeb
{
    public partial class CompSubSelect : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected string ViewMode
        {
            get { return ViewState["ViewMode"]?.ToString() ?? "Subject"; }
            set { ViewState["ViewMode"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bid = Request.QueryString["bid"];
                string scid = Request.QueryString["scid"];
                string sid = Request.QueryString["sid"]; // optional

                if (string.IsNullOrEmpty(bid) || string.IsNullOrEmpty(scid))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                HandleWaterfallLogic(Convert.ToInt32(bid), Convert.ToInt32(scid), sid);
            }
        }

        private void HandleWaterfallLogic(int boardId, int subCatId, string sIdStr)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 🔹 1. Metadata (Added Description)
                string metaSql = @"SELECT B.BoardName, SC.SubCategoryName, SC.Description 
                           FROM Boards B 
                           INNER JOIN SubCategories SC ON SC.SubCategoryId = @scid
                           WHERE B.BoardId = @bid";

                SqlCommand cmdMeta = new SqlCommand(metaSql, con);
                cmdMeta.Parameters.AddWithValue("@bid", boardId);
                cmdMeta.Parameters.AddWithValue("@scid", subCatId);

                using (SqlDataReader dr = cmdMeta.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        litBoardName.Text = dr["BoardName"].ToString();
                        litSubCatName.Text = dr["SubCategoryName"].ToString();
                        // Bind description, fallback to empty string if null
                        litSubCatDesc.Text = dr["Description"] != DBNull.Value ? dr["Description"].ToString() : "";
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                        return;
                    }
                }

                int subjectId = string.IsNullOrEmpty(sIdStr) ? 0 : Convert.ToInt32(sIdStr);

                // 🔹 2. SUBJECT STAGE
                if (subjectId == 0)
                {
                    // Fetching PageTitle as well
                    DataTable dtSubjects = GetDataTable(con, @"SELECT SubjectId, SubjectName as DisplayName, SubjectId as Id, IconImage, 
                                                       ISNULL(PageTitle, '') as PageTitle 
                                                       FROM Subjects 
                                                       WHERE BoardId=@bid AND SubCategoryId=@scid AND IsActive=1",
                                                     boardId, subCatId);

                    if (dtSubjects.Rows.Count > 0)
                    {
                        ViewMode = "Subject";
                        litViewType.Text = "Select Subject";
                        rptData.DataSource = dtSubjects;
                        rptData.DataBind();
                    }
                    else
                    {
                        CheckForNextLogicalLevel(con, boardId, subCatId, 0);
                    }
                }
                else
                {
                    CheckForNextLogicalLevel(con, boardId, subCatId, subjectId);
                }
            }
        }

        private void CheckForNextLogicalLevel(SqlConnection con, int bid, int scid, int sid)
        {
            // 🔹 YEAR CHECK
            string yearSql = @"SELECT 
                                Y.YearName as DisplayName, 
                                Y.YearId as Id, 
                                NULL as IconImage, 
                                'Resources for ' + Y.YearName as Description 
                               FROM YearMappings YM 
                               INNER JOIN Years Y ON YM.YearId = Y.YearId 
                               WHERE YM.BoardId=@bid 
                               AND YM.SubCategoryId=@scid 
                               AND (YM.SubjectId=@sid OR YM.SubjectId IS NULL) 
                               AND YM.IsActive=1";

            DataTable dtYears = GetDataTable(con, yearSql, bid, scid, sid);

            if (dtYears.Rows.Count > 0)
            {
                ViewMode = "Year";
                litViewType.Text = (sid > 0) ? "Select Year" : "Exam Years";
                rptData.DataSource = dtYears;
                rptData.DataBind();
            }
            else
            {
                // 🔹 CHAPTER CHECK
                string chapSql = "SELECT COUNT(*) FROM Chapters WHERE BoardId=@bid AND (SubjectId=@sid OR @sid=0)";
                SqlCommand cmdChap = new SqlCommand(chapSql, con);
                cmdChap.Parameters.AddWithValue("@bid", bid);
                cmdChap.Parameters.AddWithValue("@sid", sid);

                int chapCount = (int)cmdChap.ExecuteScalar();

                string rid = Request.QueryString["rid"];

                if (chapCount > 0)
                {
                    Response.Redirect($"Chapters.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}");
                }
                else
                {
                    Response.Redirect($"ViewResource.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}");
                }
            }
        }

        protected string GetIcon(object icon)
        {
            if (ViewMode == "Year") return "/Uploads/Icons/calendar-icon.png";

            string iconName = (icon == DBNull.Value || string.IsNullOrEmpty(icon.ToString()))
                              ? "default-sub.png"
                              : icon.ToString();
            return "/Uploads/SubjectIcons/" + iconName;
        }

        protected string GetNavigationUrl(object id)
        {
            string bid = Request.QueryString["bid"];
            string rid = Request.QueryString["rid"];
            string scid = Request.QueryString["scid"];
            string sid = Request.QueryString["sid"];

            if (ViewMode == "Subject")
            {
                return $"CompSubSelect.aspx?bid={bid}&rid={rid}&scid={scid}&sid={id}";
            }
            else
            {
                return $"Sets.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}&yid={id}";
            }
        }

        private DataTable GetDataTable(SqlConnection con, string sql, int bid, int scid, int sid = 0)
        {
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@bid", bid);
            cmd.Parameters.AddWithValue("@scid", scid);
            cmd.Parameters.AddWithValue("@sid", sid);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            return dt;
        }
    }
}