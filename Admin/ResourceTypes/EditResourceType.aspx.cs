using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class EditResourceType : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        int resourceTypeId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out resourceTypeId))
            {
                Response.Redirect("ManageResourceTypes.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadResourceType();
            }
        }

        private void LoadResourceType()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM ResourceTypes WHERE ResourceTypeId = @Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", resourceTypeId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtName.Text = dr["TypeName"].ToString();
                    txtSlug.Text = dr["Slug"].ToString();
                    txtDisplayOrder.Text = dr["DisplayOrder"].ToString();
                    chkIsPremium.Checked = Convert.ToBoolean(dr["IsPremium"]);
                    chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);
                    chkHasClass.Checked = Convert.ToBoolean(dr["HasClass"]);
                    chkHasSubject.Checked = Convert.ToBoolean(dr["HasSubject"]);
                    chkHasChapter.Checked = Convert.ToBoolean(dr["HasChapter"]);
                    chkHasYear.Checked = Convert.ToBoolean(dr["HasYear"]);
                    chkHasSubCategory.Checked = Convert.ToBoolean(dr["HasSubCategory"]);

                    // Handle Image Preview
                    string imgName = dr["IconImage"].ToString();
                    hfCurrentImg.Value = imgName;
                    imgCurrent.ImageUrl = "~/Uploads/ResourceIcons/" + (string.IsNullOrEmpty(imgName) ? "default-icon.png" : imgName);
                }
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string iconFileName = hfCurrentImg.Value; // Keep existing by default

            if (fuIcon.HasFile)
            {
                string extension = Path.GetExtension(fuIcon.FileName).ToLower();
                string[] allowed = { ".png", ".jpg", ".jpeg", ".svg", ".webp" };

                if (Array.Exists(allowed, ext => ext == extension))
                {
                    iconFileName = "resource_" + DateTime.Now.Ticks + extension;
                    string folderPath = Server.MapPath("~/Uploads/ResourceIcons/");
                    fuIcon.SaveAs(Path.Combine(folderPath, iconFileName));

                    // Optional: Delete the old file from server if it wasn't the default icon
                    // if(hfCurrentImg.Value != "default-icon.png") { File.Delete(...) }
                }
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE ResourceTypes SET 
                                    TypeName=@TypeName, Slug=@Slug, IconImage=@IconImage, 
                                    IsPremium=@IsPremium, IsActive=@IsActive, DisplayOrder=@DisplayOrder,
                                    HasClass=@HasClass, HasSubject=@HasSubject, HasChapter=@HasChapter, 
                                    HasYear=@HasYear, HasSubCategory=@HasSubCategory
                                    WHERE ResourceTypeId=@Id";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", GenerateSlug(txtSlug.Text));
                    cmd.Parameters.AddWithValue("@IconImage", iconFileName);
                    cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@DisplayOrder", txtDisplayOrder.Text);
                    cmd.Parameters.AddWithValue("@HasClass", chkHasClass.Checked);
                    cmd.Parameters.AddWithValue("@HasSubject", chkHasSubject.Checked);
                    cmd.Parameters.AddWithValue("@HasChapter", chkHasChapter.Checked);
                    cmd.Parameters.AddWithValue("@HasYear", chkHasYear.Checked);
                    cmd.Parameters.AddWithValue("@HasSubCategory", chkHasSubCategory.Checked);
                    cmd.Parameters.AddWithValue("@Id", resourceTypeId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                Response.Redirect("ManageResourceTypes.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Update failed: " + ex.Message;
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