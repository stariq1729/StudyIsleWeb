using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddYear : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMasterData();
            }
        }

        private void LoadMasterData()
        {
            BindDropDown("SELECT YearId, YearName FROM Years WHERE IsActive=1", ddlYear, "YearName", "YearId");
            BindDropDown("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
            BindDropDown("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId");

            // For the side-bar list
            DataTable dt = GetData("SELECT YearName FROM Years ORDER BY YearName DESC");
            rptMasterYears.DataSource = dt;
            rptMasterYears.DataBind();
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            if (boardId == 0) return;

            bool isComp = CheckIfCompetitive(boardId);
            phCompPath.Visible = isComp;
            phSchoolPath.Visible = !isComp;

            if (isComp)
            {
                BindDropDown("SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId=" + boardId, ddlSubCategory, "SubCategoryName", "SubCategoryId");
            }
            else
            {
                BindDropDown("SELECT ClassId, ClassName FROM Classes WHERE BoardId=" + boardId, ddlClass, "ClassName", "ClassId");
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDropDown("SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=" + ddlClass.SelectedValue, ddlSubject, "SubjectName", "SubjectId");
        }

        protected void btnSaveMapping_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO YearMappings (YearId, BoardId, ResourceTypeId, ClassId, SubjectId, SubCategoryId) 
                                   VALUES (@YID, @BID, @RTID, @CID, @SID, @SCID)";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@YID", ddlYear.SelectedValue);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);

                    // Logic to handle NULLs for Path A vs Path B
                    cmd.Parameters.AddWithValue("@CID", phSchoolPath.Visible ? (object)ddlClass.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@SID", phSchoolPath.Visible ? (object)ddlSubject.SelectedValue : DBNull.Value);
                    cmd.Parameters.AddWithValue("@SCID", phCompPath.Visible ? (object)ddlSubCategory.SelectedValue : DBNull.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "Year linked successfully!";
                    lblMsg.CssClass = "alert alert-success d-block";
                }
            }
            catch (Exception ex) { lblMsg.Text = "Error: " + ex.Message; lblMsg.CssClass = "alert alert-danger d-block"; }
        }

        // Helper Methods
        private bool CheckIfCompetitive(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ISNULL(IsCompetitive, 0) FROM Boards WHERE BoardId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", boardId);
                con.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        private void BindDropDown(string sql, DropDownList ddl, string text, string value)
        {
            DataTable dt = GetData(sql);
            ddl.DataSource = dt;
            ddl.DataTextField = text; ddl.DataValueField = value;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-- Select --", "0"));
        }

        private DataTable GetData(string sql)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable(); da.Fill(dt); return dt;
            }
        }
    }
}