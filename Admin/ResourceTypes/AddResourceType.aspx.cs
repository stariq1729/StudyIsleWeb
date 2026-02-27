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
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

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
                // Pulls all active boards dynamically
                string query = "SELECT BoardId, BoardName FROM Boards ORDER BY BoardName ASC";
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
                lblMessage.Text = "Type Name is required.";
                return;
            }

            string iconFileName = "Default-icon.png";
            if (fuIcon.HasFile)
            {
                string extension = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "resource_" + DateTime.Now.Ticks + extension;
                string folderPath = Server.MapPath("~/Uploads/ResourceIcons/Icon");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);
                fuIcon.SaveAs(Path.Combine(folderPath, iconFileName));
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                // Use Transaction to ensure both Resource and Mapping are saved correctly
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // 1. Insert Resource Type
                    string resQuery = @"INSERT INTO ResourceTypes 
                        (TypeName, Slug, Description, IconImage, IsPremium, IsActive, DisplayOrder, HasClass, HasSubject, HasChapter, HasYear) 
                        VALUES (@TypeName, @Slug, @Description, @IconImage, @IsPremium, @IsActive, @DisplayOrder, @HasClass, @HasSubject, @HasChapter, @HasYear);
                        SELECT SCOPE_IDENTITY();";

                    SqlCommand cmd = new SqlCommand(resQuery, con, trans);
                    cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@IconImage", iconFileName);
                    cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@DisplayOrder", int.Parse(txtDisplayOrder.Text));
                    cmd.Parameters.AddWithValue("@HasClass", chkHasClass.Checked);
                    cmd.Parameters.AddWithValue("@HasSubject", chkHasSubject.Checked);
                    cmd.Parameters.AddWithValue("@HasChapter", chkHasChapter.Checked);
                    cmd.Parameters.AddWithValue("@HasYear", chkHasYear.Checked);

                    // Get the ID of the resource we just created
                    int newResourceId = Convert.ToInt32(cmd.ExecuteScalar());

                    // 2. Loop through CheckBoxList and save Mappings
                    foreach (ListItem item in cblBoards.Items)
                    {
                        if (item.Selected)
                        {
                            string mapQuery = "INSERT INTO BoardResourceMapping (BoardId, ResourceTypeId) VALUES (@BID, @RID)";
                            SqlCommand cmdMap = new SqlCommand(mapQuery, con, trans);
                            cmdMap.Parameters.AddWithValue("@BID", item.Value);
                            cmdMap.Parameters.AddWithValue("@RID", newResourceId);
                            cmdMap.ExecuteNonQuery();
                        }
                    }

                    trans.Commit();
                    Response.Redirect("ManageResourceTypes.aspx");
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMessage.Text = "Error: " + ex.Message;
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