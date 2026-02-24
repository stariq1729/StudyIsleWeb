using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class EditResourceType : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        private int resourceTypeId;

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
                string query = @"SELECT *
                                 FROM ResourceTypes
                                 WHERE ResourceTypeId=@Id";

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
                }
                else
                {
                    Response.Redirect("ManageResourceTypes.aspx");
                }
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
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
                string query = @"UPDATE ResourceTypes
                                 SET TypeName=@TypeName,
                                     Slug=@Slug,
                                     DisplayOrder=@DisplayOrder,
                                     IsPremium=@IsPremium,
                                     IsActive=@IsActive,
                                     HasClass=@HasClass,
                                     HasSubject=@HasSubject,
                                     HasChapter=@HasChapter,
                                     HasYear=@HasYear,
                                     HasSubCategory=@HasSubCategory
                                 WHERE ResourceTypeId=@Id";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", GenerateSlug(txtSlug.Text));
                cmd.Parameters.AddWithValue("@DisplayOrder", displayOrder);
                cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
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

        private string GenerateSlug(string text)
        {
            text = text.ToLower();
            text = Regex.Replace(text, @"[^a-z0-9\s-]", "");
            text = Regex.Replace(text, @"\s+", " ").Trim();
            return text.Replace(" ", "-");
        }
    }
}
