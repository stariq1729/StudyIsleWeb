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
        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshResourceTypes();
        }
        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshPathHierarchy();
        }
        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshCompSubjects();
        }
        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshSchoolSubjects();
        }
        private void LoadMasterData()
        {
            BindDropDown("SELECT YearId, YearName FROM Years WHERE IsActive=1", ddlYear, "YearName", "YearId");
            BindDropDown("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId");
            BindDropDown("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId");

            DataTable dt = GetData("SELECT YearName FROM Years ORDER BY YearName DESC");
            rptMasterYears.DataSource = dt;
            rptMasterYears.DataBind();
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

                    // Path A: School Logic
                    cmd.Parameters.AddWithValue("@CID", phSchoolPath.Visible ? (object)ddlClass.SelectedValue : DBNull.Value);

                    // Unified Subject Logic: Pick from Path A or Path B
                    object finalSubjectId = DBNull.Value;
                    if (phSchoolPath.Visible && ddlSubject.SelectedValue != "0")
                        finalSubjectId = ddlSubject.SelectedValue;
                    else if (phCompPath.Visible && ddlCompSubject.SelectedValue != "0")
                        finalSubjectId = ddlCompSubject.SelectedValue;

                    cmd.Parameters.AddWithValue("@SID", finalSubjectId);

                    // Path B: Competitive Logic
                    cmd.Parameters.AddWithValue("@SCID", phCompPath.Visible ? (object)ddlSubCategory.SelectedValue : DBNull.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "Year linked successfully with Subject mapping!";
                    lblMsg.CssClass = "alert alert-success d-block";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger d-block";
            }
        }

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
            ddl.DataTextField = text;
            ddl.DataValueField = value;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("-- Select --", "0"));
        }
        private void ResetDDL(DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem("-- Select --", "0"));
        }
        private void RefreshResourceTypes()
        {
            // Reset everything below Board
            ResetDDL(ddlResourceType);

            ResetDDL(ddlClass);
            ResetDDL(ddlSubject);

            ResetDDL(ddlSubCategory);
            ResetDDL(ddlCompSubject);

            // Hide both paths initially
            phSchoolPath.Visible = false;
            phCompPath.Visible = false;

            // Stop if no board selected
            if (ddlBoard.SelectedValue == "0")
                return;

            string query = @"
        SELECT DISTINCT rt.ResourceTypeId, rt.TypeName
        FROM ResourceTypes rt
        INNER JOIN BoardResourceMapping brm
            ON rt.ResourceTypeId = brm.ResourceTypeId
        WHERE brm.BoardId = @BoardId
        AND rt.IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();

                ddlResourceType.Items.Insert(0,
                    new ListItem("-- Select --", "0"));
            }
        }
        private void RefreshPathHierarchy()
        {
            // Reset lower hierarchy first
            ResetDDL(ddlClass);
            ResetDDL(ddlSubject);

            ResetDDL(ddlSubCategory);
            ResetDDL(ddlCompSubject);

            phSchoolPath.Visible = false;
            phCompPath.Visible = false;

            // Stop if no resource type selected
            if (ddlResourceType.SelectedValue == "0")
                return;

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);

            bool isComp = CheckIfCompetitive(boardId);

            // =========================
            // COMPETITIVE FLOW
            // =========================
            if (isComp)
            {
                string subQuery = @"
            SELECT SubCategoryId, SubCategoryName
            FROM SubCategories
            WHERE BoardId = @BoardId
            AND ResourceTypeId = @ResourceTypeId
            AND IsActive = 1";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter(subQuery, con);

                    da.SelectCommand.Parameters.AddWithValue("@BoardId",
                        ddlBoard.SelectedValue);

                    da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                        ddlResourceType.SelectedValue);

                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Show path only if subcategories exist
                    if (dt.Rows.Count > 0)
                    {
                        phCompPath.Visible = true;

                        ddlSubCategory.DataSource = dt;
                        ddlSubCategory.DataTextField = "SubCategoryName";
                        ddlSubCategory.DataValueField = "SubCategoryId";
                        ddlSubCategory.DataBind();

                        ddlSubCategory.Items.Insert(0,
                            new ListItem("-- Select --", "0"));
                    }
                }
            }

            // =========================
            // SCHOOL FLOW
            // =========================
            else
            {
                string classQuery = @"
            SELECT ClassId, ClassName
            FROM Classes
            WHERE BoardId = @BoardId
            AND ResourceTypeId = @ResourceTypeId
            AND IsActive = 1";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter(classQuery, con);

                    da.SelectCommand.Parameters.AddWithValue("@BoardId",
                        ddlBoard.SelectedValue);

                    da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                        ddlResourceType.SelectedValue);

                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Show path only if classes exist
                    if (dt.Rows.Count > 0)
                    {
                        phSchoolPath.Visible = true;

                        ddlClass.DataSource = dt;
                        ddlClass.DataTextField = "ClassName";
                        ddlClass.DataValueField = "ClassId";
                        ddlClass.DataBind();

                        ddlClass.Items.Insert(0,
                            new ListItem("-- Select --", "0"));
                    }
                }
            }
        }
        private void RefreshSchoolSubjects()
        {
            ResetDDL(ddlSubject);

            // Stop if no class selected
            if (ddlClass.SelectedValue == "0")
                return;

            string query = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId
        AND ClassId = @ClassId
        AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ClassId",
                    ddlClass.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0,
                    new ListItem("-- Select --", "0"));
            }
        }
        private void RefreshCompSubjects()
        {
            ResetDDL(ddlCompSubject);

            // Stop if no subcategory selected
            if (ddlSubCategory.SelectedValue == "0")
                return;

            string query = @"
        SELECT SubjectId, SubjectName
        FROM Subjects
        WHERE BoardId = @BoardId
        AND ResourceTypeId = @ResourceTypeId
        AND SubCategoryId = @SubCategoryId
        AND IsActive = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId",
                    ddlBoard.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@ResourceTypeId",
                    ddlResourceType.SelectedValue);

                da.SelectCommand.Parameters.AddWithValue("@SubCategoryId",
                    ddlSubCategory.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCompSubject.DataSource = dt;
                ddlCompSubject.DataTextField = "SubjectName";
                ddlCompSubject.DataValueField = "SubjectId";
                ddlCompSubject.DataBind();

                ddlCompSubject.Items.Insert(0,
                    new ListItem("-- Select --", "0"));
            }
        }
        private DataTable GetData(string sql)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}