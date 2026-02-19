using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class EditResourceType : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["StudyIsleDB"].ConnectionString;
        int resourceTypeId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out resourceTypeId))
            {
                Response.Redirect("ManageResourceTypes.aspx");
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
                string query = "SELECT * FROM ResourceTypes WHERE ResourceTypeId=@Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", resourceTypeId);
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        txtName.Text = dr["Name"].ToString();
                        txtSlug.Text = dr["Slug"].ToString();
                        chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);
                    }
                    else
                    {
                        Response.Redirect("ManageResourceTypes.aspx");
                    }
                }
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string slug = txtSlug.Text.Trim();
            bool isActive = chkIsActive.Checked;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(slug))
            {
                lblMessage.Text = "Name and Slug are required.";
                return;
            }

            if (IsSlugExists(slug))
            {
                lblMessage.Text = "Slug already exists.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE ResourceTypes 
                                SET Name=@Name,
                                    Slug=@Slug,
                                    IsActive=@IsActive
                                WHERE ResourceTypeId=@Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@IsActive", isActive);
                    cmd.Parameters.AddWithValue("@Id", resourceTypeId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("ManageResourceTypes.aspx");
        }

        private bool IsSlugExists(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT COUNT(*) 
                                 FROM ResourceTypes 
                                 WHERE Slug=@Slug 
                                 AND ResourceTypeId<>@Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@Id", resourceTypeId);

                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private string GenerateSlug(string text)
        {
            text = text.ToLower();
            text = Regex.Replace(text, @"[^]()
