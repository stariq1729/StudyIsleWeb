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

        // Mode: "Subject" or "Year"
        protected string ViewMode
        {
            get { return ViewState["ViewMode"]?.ToString() ?? "Subject"; }
            set { ViewState["ViewMode"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string board = Request.QueryString["board"];
                string subcat = Request.QueryString["subcat"];
                string subject = Request.QueryString["subject"]; // Current selection if redirected back

                if (string.IsNullOrEmpty(board) || string.IsNullOrEmpty(subcat))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                HandleWaterfallLogic(board, subcat, subject);
            }
        }

        private void HandleWaterfallLogic(string bSlug, string scSlug, string sSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1. Fetch Basic Metadata for Header
                int boardId = 0, subCatId = 0;
                string metaSql = @"SELECT B.BoardId, B.BoardName, SC.SubCategoryId, SC.SubCategoryName 
                                   FROM Boards B 
                                   CROSS JOIN SubCategories SC 
                                   WHERE B.Slug=@b AND SC.Slug=@sc";

                SqlCommand cmdMeta = new SqlCommand(metaSql, con);
                cmdMeta.Parameters.AddWithValue("@b", bSlug);
                cmdMeta.Parameters.AddWithValue("@sc", scSlug);

                using (SqlDataReader dr = cmdMeta.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        boardId = (int)dr["BoardId"];
                        subCatId = (int)dr["SubCategoryId"];
                        litBoardName.Text = dr["BoardName"].ToString();
                        litSubCatName.Text = dr["SubCategoryName"].ToString();
                    }
                    else { Response.Redirect("Default.aspx"); return; }
                }

                // 2. WATERFALL STAGE 1: Check if we need to show Subjects list
                if (string.IsNullOrEmpty(sSlug))
                {
                    DataTable dtSubjects = GetDataTable(con, @"SELECT SubjectId, SubjectName as DisplayName, Slug, IconImage, Description 
                                                            FROM Subjects WHERE BoardId=@bid AND SubCategoryId=@scid AND IsActive=1", boardId, subCatId);

                    if (dtSubjects.Rows.Count > 0)
                    {
                        ViewMode = "Subject";
                        litViewType.Text = "Select Subject";
                        rptData.DataSource = dtSubjects;
                        rptData.DataBind();
                    }
                    else
                    {
                        // Skip directly to Year check if no subjects exist for this Board/SubCat
                        CheckForNextLogicalLevel(con, boardId, subCatId, 0, bSlug, scSlug, "");
                    }
                }
                else
                {
                    // 3. WATERFALL STAGE 2: Subject is already in URL, check for Years mapped to it
                    int subjectId = GetIdFromSlug(con, "Subjects", "SubjectId", sSlug);
                    CheckForNextLogicalLevel(con, boardId, subCatId, subjectId, bSlug, scSlug, sSlug);
                }
            }
        }

        private void CheckForNextLogicalLevel(SqlConnection con, int bid, int scid, int sid, string bSlug, string scSlug, string sSlug)
        {
            // A. Check for YearMappings specifically for this selection
            string yearSql = @"SELECT Y.YearName as DisplayName, Y.YearName as Slug, NULL as IconImage, 'Resources for ' + Y.YearName as Description 
                               FROM YearMappings YM INNER JOIN Years Y ON YM.YearId = Y.YearId 
                               WHERE YM.BoardId=@bid AND YM.SubCategoryId=@scid AND (YM.SubjectId=@sid OR YM.SubjectId IS NULL) AND YM.IsActive=1";

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
                // B. If no Years, check for Chapters
                string chapSql = "SELECT COUNT(*) FROM Chapters WHERE BoardId=@bid AND (SubjectId=@sid OR @sid=0)";
                SqlCommand cmdChap = new SqlCommand(chapSql, con);
                cmdChap.Parameters.AddWithValue("@bid", bid);
                cmdChap.Parameters.AddWithValue("@sid", sid);
                int chapCount = (int)cmdChap.ExecuteScalar();

                string res = Request.QueryString["res"];

                if (chapCount > 0)
                {
                    Response.Redirect($"Chapters.aspx?board={bSlug}&subcat={scSlug}&subject={sSlug}&res={res}");
                }
                else
                {
                    // C. Fallback: Direct to final resource view if no more choices are needed
                    Response.Redirect($"ViewResources.aspx?board={bSlug}&subcat={scSlug}&subject={sSlug}&res={res}");
                }
            }
        }

        // This method name MUST match the call in CompSubSelect.aspx (Screenshot 495 Line 39)
        protected string GetIcon(object icon)
        {
            if (ViewMode == "Year") return "/Uploads/Icons/calendar-icon.png";

            string iconName = (icon == DBNull.Value || string.IsNullOrEmpty(icon.ToString()))
                              ? "default-sub.png"
                              : icon.ToString();
            return "/Uploads/SubjectIcons/" + iconName;
        }

        protected string GetNavigationUrl(object slug)
        {
            string b = Request.QueryString["board"];
            string r = Request.QueryString["res"];
            string sc = Request.QueryString["subcat"];
            string s = Request.QueryString["subject"];

            if (ViewMode == "Subject")
                // Loop back to this page to check for Years after Subject is picked
                return $"CompSubSelect.aspx?board={b}&res={r}&subcat={sc}&subject={slug}";
            else
                // Navigate to Sets selection if Year is picked
                return $"Sets.aspx?board={b}&res={r}&subcat={sc}&subject={s}&year={slug}";
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

        private int GetIdFromSlug(SqlConnection con, string table, string idCol, string slug)
        {
            SqlCommand cmd = new SqlCommand($"SELECT {idCol} FROM {table} WHERE Slug=@s", con);
            cmd.Parameters.AddWithValue("@s", slug);
            object res = cmd.ExecuteScalar();
            return res != null ? (int)res : 0;
        }
    }
}