using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class AddResourceType : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Auto generate slug when name changes
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

            int displayOrder = 0;
            int.TryParse(txtDisplayOrder.Text, out displayOrder);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO ResourceTypes
                                (TypeName, Slug, IsPremium, IsActive,
                                 DisplayOrder, CreatedAt,
                                 HasClass, HasSubject, HasChapter,
                                 HasYear, HasSubCategory)
                                 VALUES
                                (@TypeName, @Slug, @IsPremium, @IsActive,
                                 @DisplayOrder, GETDATE(),
                                 @HasClass, @HasSubject, @HasChapter,
                                 @HasYear, @HasSubCategory)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", GenerateSlug(txtSlug.Text));
                cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@DisplayOrder", displayOrder);
                cmd.Parameters.AddWithValue("@HasClass", chkHasClass.Checked);
                cmd.Parameters.AddWithValue("@HasSubject", chkHasSubject.Checked);
                cmd.Parameters.AddWithValue("@HasChapter", chkHasChapter.Checked);
                cmd.Parameters.AddWithValue("@HasYear", chkHasYear.Checked);
                cmd.Parameters.AddWithValue("@HasSubCategory", chkHasSubCategory.Checked);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageResourceTypes.aspx");
        }

        private string GenerateSlug(string input)
        {
            return input.Trim().ToLower().Replace(" ", "-");
        }
    }
}
