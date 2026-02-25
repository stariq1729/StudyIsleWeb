using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class EditResource : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        int resourceId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out resourceId))
            {
                Response.Redirect("ManageResources.aspx");
                return;
            }

            if (!IsPostBack)
            {
                hfResourceId.Value = resourceId.ToString();
                LoadBoards();
                LoadResourceTypes();
                LoadResourceData();
            }
        }

        #region Load Methods

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
            }
        }

        private void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();
            }
        }

        private void LoadResourceData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM Resources WHERE ResourceId=@Id", con);
                cmd.Parameters.AddWithValue("@Id", resourceId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    ddlBoard.SelectedValue = dr["BoardId"].ToString();
                    ddlResourceType.SelectedValue = dr["ResourceTypeId"].ToString();

                    txtTitle.Text = dr["Title"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    chkIsPremium.Checked = Convert.ToBoolean(dr["IsPremium"]);
                }
            }

            ddlResourceType_SelectedIndexChanged(null, null);

            // Load dependent dropdowns
            ddlBoard_SelectedIndexChanged(null, null);
            ddlClass_SelectedIndexChanged(null, null);
            ddlSubject_SelectedIndexChanged(null, null);

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM Resources WHERE ResourceId=@Id", con);
                cmd.Parameters.AddWithValue("@Id", resourceId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    if (dr["ClassId"] != DBNull.Value)
                        ddlClass.SelectedValue = dr["ClassId"].ToString();

                    if (dr["SubjectId"] != DBNull.Value)
                        ddlSubject.SelectedValue = dr["SubjectId"].ToString();

                    if (dr["ChapterId"] != DBNull.Value)
                        ddlChapter.SelectedValue = dr["ChapterId"].ToString();

                    if (dr["YearId"] != DBNull.Value)
                        ddlYear.SelectedValue = dr["YearId"].ToString();

                    if (dr["SubCategoryId"] != DBNull.Value)
                        ddlSubCategory.SelectedValue = dr["SubCategoryId"].ToString();
                }
            }
        }

        #endregion

        #region Dropdown Events

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BoardId", con);
                cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("-- Select Class --", "0"));
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT SubjectId, SubjectName FROM Subjects WHERE ClassId=@ClassId", con);
                cmd.Parameters.AddWithValue("@ClassId", ddlClass.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();
                ddlSubject.Items.Insert(0, new ListItem("-- Select Subject --", "0"));
            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ChapterId, ChapterName FROM Chapters WHERE SubjectId=@SubjectId", con);
                cmd.Parameters.AddWithValue("@SubjectId", ddlSubject.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChapter.DataSource = dt;
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterId";
                ddlChapter.DataBind();
                ddlChapter.Items.Insert(0, new ListItem("-- Select Chapter --", "0"));
            }
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT HasClass, HasSubject, HasChapter, HasYear, HasSubCategory
                      FROM ResourceTypes WHERE ResourceTypeId=@Id", con);
                cmd.Parameters.AddWithValue("@Id", ddlResourceType.SelectedValue);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    pnlClass.Visible = Convert.ToBoolean(dr["HasClass"]);
                    pnlSubject.Visible = Convert.ToBoolean(dr["HasSubject"]);
                    pnlChapter.Visible = Convert.ToBoolean(dr["HasChapter"]);
                    pnlYear.Visible = Convert.ToBoolean(dr["HasYear"]);
                    pnlSubCategory.Visible = Convert.ToBoolean(dr["HasSubCategory"]);
                }
            }
        }

        #endregion

        #region Update

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string filePath = null;
            string contentType = null;

            if (fuFile.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fileName = Guid.NewGuid() + Path.GetExtension(fuFile.FileName);
                fuFile.SaveAs(folder + fileName);

                filePath = "/Uploads/" + fileName;
                contentType = fuFile.PostedFile.ContentType;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Resources SET
                                BoardId=@BoardId,
                                ResourceTypeId=@TypeId,
                                ClassId=@ClassId,
                                SubjectId=@SubjectId,
                                ChapterId=@ChapterId,
                                YearId=@YearId,
                                SubCategoryId=@SubCategoryId,
                                Title=@Title,
                                Description=@Description,
                                IsPremium=@IsPremium"
                                + (filePath != null ? ", FilePath=@FilePath, ContentType=@ContentType" : "")
                                + " WHERE ResourceId=@Id";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@TypeId", ddlResourceType.SelectedValue);
                cmd.Parameters.AddWithValue("@ClassId", ddlClass.SelectedIndex > 0 ? (object)ddlClass.SelectedValue : DBNull.Value);
                cmd.Parameters.AddWithValue("@SubjectId", ddlSubject.SelectedIndex > 0 ? (object)ddlSubject.SelectedValue : DBNull.Value);
                cmd.Parameters.AddWithValue("@ChapterId", ddlChapter.SelectedIndex > 0 ? (object)ddlChapter.SelectedValue : DBNull.Value);
                cmd.Parameters.AddWithValue("@YearId", ddlYear.SelectedIndex > 0 ? (object)ddlYear.SelectedValue : DBNull.Value);
                cmd.Parameters.AddWithValue("@SubCategoryId", ddlSubCategory.SelectedIndex > 0 ? (object)ddlSubCategory.SelectedValue : DBNull.Value);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                cmd.Parameters.AddWithValue("@Id", resourceId);

                if (filePath != null)
                {
                    cmd.Parameters.AddWithValue("@FilePath", filePath);
                    cmd.Parameters.AddWithValue("@ContentType", contentType);
                }

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageResources.aspx");
        }

        #endregion
    }
}