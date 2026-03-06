using StudyIsleWeb.Admin.Classes;
using StudyIsleWeb.Admin.ResourceTypes;
using StudyIsleWeb.Admin.SubCat;
using StudyIsleWeb.Admin.Subjects;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Chapters
{
    public partial class AddSets : System.Web.UI.Page
    {

        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadResourceTypes();
                LoadClasses();
                LoadYears();
            }
        }

        void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT BoardId,BoardName FROM Boards", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();

                ddlBoard.Items.Insert(0, "-- Optional --");
            }
        }

        void LoadResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT ResourceTypeId,TypeName FROM ResourceTypes", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlResourceType.DataSource = dt;
                ddlResourceType.DataTextField = "TypeName";
                ddlResourceType.DataValueField = "ResourceTypeId";
                ddlResourceType.DataBind();

                ddlResourceType.Items.Insert(0, "-- Optional --");
            }
        }

        void LoadClasses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT ClassId,ClassName FROM Classes", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();

                ddlClass.Items.Insert(0, "-- Optional --");
            }
        }

        void LoadYears()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT YearId,YearName FROM Years", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlYear.DataSource = dt;
                ddlYear.DataTextField = "YearName";
                ddlYear.DataValueField = "YearId";
                ddlYear.DataBind();

                ddlYear.Items.Insert(0, "-- Optional --");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT SubjectId,SubjectName FROM Subjects WHERE BoardId=@BoardId", con);

                da.SelectCommand.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, "-- Optional --");
            }
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT SubjectId,SubjectName FROM Subjects WHERE ClassId=@ClassId", con);

                da.SelectCommand.Parameters.AddWithValue("@ClassId", ddlClass.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, "-- Optional --");
            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                "SELECT ChapterId,ChapterName FROM Chapters WHERE SubjectId=@SubjectId", con);

                da.SelectCommand.Parameters.AddWithValue("@SubjectId", ddlSubject.SelectedValue);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChapter.DataSource = dt;
                ddlChapter.DataTextField = "ChapterName";
                ddlChapter.DataValueField = "ChapterId";
                ddlChapter.DataBind();

                ddlChapter.Items.Insert(0, "-- Optional --");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(cs))
            {

                SqlCommand cmd = new SqlCommand(

                @"INSERT INTO Sets
                (BoardId,ResourceTypeId,ClassId,SubjectId,SubCategoryId,ChapterId,YearId,
                 SetName,DisplayOrder,IsActive)

                 VALUES
                (@BoardId,@ResourceTypeId,@ClassId,@SubjectId,@SubCategoryId,@ChapterId,
                 @YearId,@SetName,@DisplayOrder,@IsActive)", con);


                cmd.Parameters.AddWithValue("@BoardId",
                ddlBoard.SelectedIndex == 0 ? (object)DBNull.Value : ddlBoard.SelectedValue);

                cmd.Parameters.AddWithValue("@ResourceTypeId",
                ddlResourceType.SelectedIndex == 0 ? (object)DBNull.Value : ddlResourceType.SelectedValue);

                cmd.Parameters.AddWithValue("@ClassId",
                ddlClass.SelectedIndex == 0 ? (object)DBNull.Value : ddlClass.SelectedValue);

                cmd.Parameters.AddWithValue("@SubjectId",
                ddlSubject.SelectedIndex == 0 ? (object)DBNull.Value : ddlSubject.SelectedValue);

                cmd.Parameters.AddWithValue("@SubCategoryId",
                ddlSubCategory.SelectedIndex == 0 ? (object)DBNull.Value : ddlSubCategory.SelectedValue);

                cmd.Parameters.AddWithValue("@ChapterId",
                ddlChapter.SelectedIndex == 0 ? (object)DBNull.Value : ddlChapter.SelectedValue);

                cmd.Parameters.AddWithValue("@YearId",
                ddlYear.SelectedIndex == 0 ? (object)DBNull.Value : ddlYear.SelectedValue);

                cmd.Parameters.AddWithValue("@SetName", txtSetName.Text.Trim());

                cmd.Parameters.AddWithValue("@DisplayOrder",
                Convert.ToInt32(txtDisplayOrder.Text));

                cmd.Parameters.AddWithValue("@IsActive", chkActive.Checked);

                con.Open();
                cmd.ExecuteNonQuery();

                lblMsg.Text = "Set added successfully";

            }

        }
    }
}