using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class AddResourceType : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBoards();
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // We show whether it's Competitive or Standard in the list for admin clarity
                string query = "SELECT BoardId, BoardName + (CASE WHEN IsCompetitive = 1 THEN ' (Competitive)' ELSE ' (Standard)' END) as BoardName FROM Boards ORDER BY IsCompetitive, BoardName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                cblBoards.DataSource = dt;
                cblBoards.DataBind();
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblMessage.Text = "Resource Type Name is required.";
                return;
            }

            // Handle Icon Upload
            string iconFileName = "default-resource.png";
            if (fuIcon.HasFile)
            {
                string ext = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "res_" + Guid.NewGuid().ToString().Substring(0, 8) + ext;
                string path = Server.MapPath("~/Uploads/Icons/");
                if (!Directory.Exists(path)) Directory.CreateDirectory(path);
                fuIcon.SaveAs(path + iconFileName);
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // 1. Insert the Resource Type with Flow Toggles
                    string resQuery = @"INSERT INTO ResourceTypes 
                        (TypeName, Slug, IconImage, IsPremium, IsActive, DisplayOrder, 
                         HasClass, HasSubject, HasChapter, HasSubCategory, HasYear, HasSets, CreatedAt) 
                        VALUES 
                        (@TypeName, @Slug, @IconImage, @IsPremium, @IsActive, @DisplayOrder, 
                         @HasClass, @HasSubject, @HasChapter, @HasSubCategory, @HasYear, @HasSets, GETDATE());
                        SELECT SCOPE_IDENTITY();";

                    SqlCommand cmd = new SqlCommand(resQuery, con, trans);
                    cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@IconImage", iconFileName);
                    cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@DisplayOrder", string.IsNullOrEmpty(txtDisplayOrder.Text) ? 0 : int.Parse(txtDisplayOrder.Text));
                    cmd.Parameters.AddWithValue("@HasClass", chkHasClass.Checked);
                    cmd.Parameters.AddWithValue("@HasSubject", chkHasSubject.Checked);
                    cmd.Parameters.AddWithValue("@HasChapter", chkHasChapter.Checked);
                    cmd.Parameters.AddWithValue("@HasSubCategory", chkHasSubCategory.Checked);
                    cmd.Parameters.AddWithValue("@HasYear", chkHasYear.Checked);
                    cmd.Parameters.AddWithValue("@HasSets", chkHasSets.Checked);

                    int newResourceTypeId = Convert.ToInt32(cmd.ExecuteScalar());

                    // 2. Map this Resource Type to selected Boards
                    foreach (ListItem item in cblBoards.Items)
                    {
                        if (item.Selected)
                        {
                            string mapQuery = "INSERT INTO BoardResourceMapping (BoardId, ResourceTypeId) VALUES (@BID, @RID)";
                            SqlCommand cmdMap = new SqlCommand(mapQuery, con, trans);
                            cmdMap.Parameters.AddWithValue("@BID", item.Value);
                            cmdMap.Parameters.AddWithValue("@RID", newResourceTypeId);
                            cmdMap.ExecuteNonQuery();
                        }
                    }

                    trans.Commit();
                    Response.Redirect("ManageResourceTypes.aspx");
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMessage.Text = "Error saving resource type: " + ex.Message;
                }
            }
        }

        private string GenerateSlug(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            slug = slug.Replace(" ", "-");
            return slug;
        }
    }
}