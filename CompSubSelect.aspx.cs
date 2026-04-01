using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace StudyIsleWeb
{
    public partial class CompSubSelect : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected string ViewMode { get { return ViewState["ViewMode"]?.ToString() ?? "Subject"; } set { ViewState["ViewMode"] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string board = Request.QueryString["board"];
                string res = Request.QueryString["res"];
                string subcat = Request.QueryString["subcat"];

                if (string.IsNullOrEmpty(board) || string.IsNullOrEmpty(subcat))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                LoadData(board, subcat, res);
            }
        }

        private void LoadData(string bSlug, string sSlug, string rSlug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1. Get metadata for the header
                int boardId = 0, subCatId = 0;
                string metaSql = "SELECT B.BoardId, B.BoardName, SC.SubCategoryId, SC.SubCategoryName FROM Boards B, SubCategories SC WHERE B.Slug=@b AND SC.Slug=@s";
                SqlCommand cmdMeta = new SqlCommand(metaSql, con);
                cmdMeta.Parameters.AddWithValue("@b", bSlug);
                cmdMeta.Parameters.AddWithValue("@s", sSlug);

                using (SqlDataReader dr = cmdMeta.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        litBoardName.Text = dr["BoardName"].ToString();
                        litSubCatName.Text = dr["SubCategoryName"].ToString();
                        boardId = (int)dr["BoardId"];
                        subCatId = (int)dr["SubCategoryId"];
                    }
                    else { Response.Redirect("Default.aspx"); return; }
                }

                // 2. PRIORITY 1: Check for Subjects
                DataTable dt = GetData(con, @"SELECT SubjectName as DisplayName, Slug, IconImage, Description 
                                              FROM Subjects 
                                              WHERE BoardId=@bid AND SubCategoryId=@scid AND IsActive=1 
                                              ORDER BY SubjectName ASC", boardId, subCatId);

                if (dt.Rows.Count > 0)
                {
                    ViewMode = "Subject";
                    litViewType.Text = "Subjects";
                    BindRepeater(dt);
                }
                else
                {
                    // 3. PRIORITY 2: Check YearMappings table
                    // We join YearMappings with Years to get the YearName
                    dt = GetData(con, @"SELECT Y.YearName as DisplayName, Y.YearName as Slug, 
                                        NULL as IconImage, 'Resources for ' + Y.YearName as Description 
                                        FROM YearMappings YM
                                        INNER JOIN Years Y ON YM.YearId = Y.YearId
                                        WHERE YM.BoardId=@bid AND YM.SubCategoryId=@scid AND YM.IsActive=1
                                        ORDER BY Y.DisplayOrder ASC", boardId, subCatId);

                    if (dt.Rows.Count > 0)
                    {
                        ViewMode = "Year";
                        litViewType.Text = "Exam Years";
                        BindRepeater(dt);
                    }
                    else
                    {
                        // 4. PRIORITY 3: Redirect to Chapters
                        Response.Redirect($"Chapters.aspx?board={bSlug}&res={rSlug}&subcat={sSlug}");
                    }
                }
            }
        }

        private DataTable GetData(SqlConnection con, string sql, int bid, int scid)
        {
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@bid", bid);
            cmd.Parameters.AddWithValue("@scid", scid);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        private void BindRepeater(DataTable dt)
        {
            rptData.DataSource = dt;
            rptData.DataBind();
        }

        protected string GetIcon(object icon)
        {
            if (ViewMode == "Year") return "/Uploads/Icons/calendar-icon.png";
            return "/Uploads/SubjectIcons/" + (icon == DBNull.Value ? "default-sub.png" : icon.ToString());
        }

        protected string GetNavigationUrl(object slug)
        {
            string b = Request.QueryString["board"];
            string r = Request.QueryString["res"];
            string s = Request.QueryString["subcat"];

            if (ViewMode == "Subject")
                return $"Chapters.aspx?board={b}&res={r}&subcat={s}&subject={slug}";
            else
                return $"Sets.aspx?board={b}&res={r}&subcat={s}&year={slug}";
        }
    }
}