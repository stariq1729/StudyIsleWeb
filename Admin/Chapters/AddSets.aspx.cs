using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddSets : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInitialData();
            }
        }

        private void LoadInitialData()
        {
            BindDropDown("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
            BindDropDown("SELECT ClassId, ClassName FROM Classes WHERE IsActive=1", ddlClass, "ClassName", "ClassId");
            BindDropDown("SELECT YearId, YearName FROM Years ORDER BY YearName DESC", ddlYear, "YearName", "YearId");
            BindDropDown("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId");

            ddlSubject.Items.Insert(0, new ListItem("-- Select Context First --", "0"));
            ddlSubCategory.Items.Insert(0, new ListItem("-- Select Subject First --", "0"));
            ddlChapter.Items.Insert(0, new ListItem("-- Select Subject First --", "0"));
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex > 0)
            {
                string sql = "SELECT SubjectId, SubjectName FROM Subjects WHERE BoardId=@BID";
                BindDropDown(sql, ddlSubject, "SubjectName", "SubjectId", new SqlParameter("@BID", ddlBoard.SelectedValue));
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlClass.SelectedIndex > 0)
            {
                // Refine subject list if class is selected
                string sql = "SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=@CID";
                BindDropDown(sql, ddlSubject, "SubjectName", "SubjectId", new SqlParameter("@CID", ddlClass.SelectedValue));
            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedIndex > 0)
            {
                int subjectId = Convert.ToInt32(ddlSubject.SelectedValue);

                // Load SubCategories linked to this board/subject context
                string subSql = "SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId=@BID";
                BindDropDown(subSql, ddlSubCategory, "SubCategoryName", "SubCategoryId", new SqlParameter("@BID", ddlBoard.SelectedValue));

                // Load Chapters for this Subject
                LoadChapters(subjectId, 0);
            }
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedIndex > 0)
            {
                LoadChapters(Convert.ToInt32(ddlSubject.SelectedValue), Convert.ToInt32(ddlSubCategory.SelectedValue));
            }
        }

        private void LoadChapters(int subjectId, int subCatId)
        {
            string sql = "SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId=@SID";
            if (subCatId > 0) sql += " AND SubCategoryId=@SCID"; // Assuming SubCategoryId exists in Chapters

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@SID", subjectId);
                if (subCatId > 0) cmd.Parameters.AddWithValue("@SCID", subCatId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChapter.DataSource = dt;
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterId";
                ddlChapter.DataBind();
                ddlChapter.Items.Insert(0, new ListItem("-- Optional Chapter --", "0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtSetName.Text))
            {
                ShowMessage("Set Name is required.", "text-danger");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Sets (BoardId, ResourceTypeId, ClassId, SubjectId, SubCategoryId, ChapterId, YearId, SetName, DisplayOrder, IsActive)
                                 VALUES (@BID, @RTID, @CID, @SID, @SCID, @CHID, @YID, @Name, @Order, @Active)";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@BID", GetValueOrNull(ddlBoard));
                    cmd.Parameters.AddWithValue("@RTID", GetValueOrNull(ddlResourceType));
                    cmd.Parameters.AddWithValue("@CID", GetValueOrNull(ddlClass));
                    cmd.Parameters.AddWithValue("@SID", GetValueOrNull(ddlSubject));
                    cmd.Parameters.AddWithValue("@SCID", GetValueOrNull(ddlSubCategory));
                    cmd.Parameters.AddWithValue("@CHID", GetValueOrNull(ddlChapter));
                    cmd.Parameters.AddWithValue("@YID", GetValueOrNull(ddlYear));
                    cmd.Parameters.AddWithValue("@Name", txtSetName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Order", string.IsNullOrEmpty(txtDisplayOrder.Text) ? 0 : Convert.ToInt32(txtDisplayOrder.Text));
                    cmd.Parameters.AddWithValue("@Active", chkActive.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowMessage("Set successfully linked and saved!", "text-success");
                    ClearForm();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "text-danger");
            }
        }

        private object GetValueOrNull(DropDownList ddl)
        {
            return (ddl.SelectedIndex <= 0 || ddl.SelectedValue == "0") ? DBNull.Value : (object)ddl.SelectedValue;
        }

        private void BindDropDown(string sql, DropDownList ddl, string text, string value, SqlParameter param = null)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                if (param != null) cmd.Parameters.Add(param);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();
                ddl.Items.Insert(0, new ListItem("-- Optional --", "0"));
            }
        }

        private void ShowMessage(string msg, string cssClass)
        {
            lblMsg.Text = msg;
            lblMsg.CssClass = cssClass;
        }

        private void ClearForm()
        {
            txtSetName.Text = "";
            txtDisplayOrder.Text = "0";
        }
    }
}