using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Blogs
{
    public partial class AddCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string categoryName = txtCategoryName.Text.Trim();
            string type = ddlType.SelectedValue;

            string slug = categoryName.ToLower().Replace(" ", "-");

            string connStr = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO BlogCategories (CategoryName, Slug, Type)
                                 VALUES (@CategoryName, @Slug, @Type)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    cmd.Parameters.AddWithValue("@Slug", slug);
                    cmd.Parameters.AddWithValue("@Type", type);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            // feedback
            Response.Write("<script>alert('Category Added Successfully');</script>");

            // clear fields
            txtCategoryName.Text = "";
        }
    }
}