using StudyIsleWeb.Admin.ResourceTypes;
using StudyIsleWeb.Admin.SubCat;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.AccessControl;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class AddClass : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlBoard, "BoardName", "BoardId", "-- Select Board --");
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            phResourceType.Visible = phSubCategory.Visible = false;
            if (ddlBoard.SelectedValue != "0")
            {
                phResourceType.Visible = true;
                BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes", ddlResourceType, "TypeName", "ResourceTypeId", "-- Select Resource Type --");
            }
        }

        protected void ddlResourceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlResourceType.SelectedValue != "0")
            {
                phSubCategory.Visible = true;
                int boardId = int.Parse(ddlBoard.SelectedValue);
                // Only show subcategories belonging to this board
                BindDDL($"SELECT SubCategoryId, SubCategoryName FROM SubCategories WHERE BoardId={boardId}", ddlSubCategory, "SubCategoryName", "SubCategoryId", "-- No Sub-Category (Optional) --");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedValue == "0" || ddlResourceType.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtClassName.Text))
            {
                ShowError("Board, Resource Type, and Class Name are mandatory.");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"INSERT INTO Classes 
(BoardId, ResourceTypeId, SubCategoryId, ClassName, Slug, DisplayOrder, IsActive, PageTitle, PageSubtitle, CreatedAt) 
VALUES (@BID, @RTID, @SCID, @Name, @Slug, @Order, 1, @Title, @Subtitle, GETDATE())";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@SCID", ddlSubCategory.SelectedValue == "0" ? (object)DBNull.Value : ddlSubCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@Name", txtClassName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@Order", txtDisplayOrder.Text);
                    cmd.Parameters.AddWithValue("@Title", string.IsNullOrWhiteSpace(txtPageTitle.Text) ? (object)DBNull.Value : txtPageTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Subtitle", string.IsNullOrWhiteSpace(txtPageSubtitle.Text) ? (object)DBNull.Value : txtPageSubtitle.Text.Trim());


                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageClasses.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        private void BindDDL(string sql, DropDownList ddl, string text, string value, string defaultText)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt; ddl.DataTextField = text; ddl.DataValueField = value; ddl.DataBind();
                ddl.Items.Insert(0, new ListItem(defaultText, "0"));
            }
        }

        protected void txtClassName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = Regex.Replace(txtClassName.Text.ToLower(), @"[^a-z0-9]", "-").Trim('-');
        }

        private void ShowError(string msg)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = "alert alert-danger d-block";
        }
    }
}