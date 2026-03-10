using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class EditClass : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    hfClassID.Value = id.ToString();
                    lblClassID.Text = "ID: " + id;

                    LoadBoards();
                    LoadClassDetails(id);
                }
                else
                {
                    Response.Redirect("ManageClasses.aspx");
                }
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
            }
        }

        private void LoadClassDetails(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Classes WHERE ClassId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        txtClassName.Text = rdr["ClassName"].ToString();
                        txtSlug.Text = rdr["Slug"].ToString();
                        txtDisplayOrder.Text = rdr["DisplayOrder"].ToString();
                        ddlBoard.SelectedValue = rdr["BoardId"].ToString();
                        chkIsActive.Checked = Convert.ToBoolean(rdr["IsActive"]);

                        // Handle potential NULLs for SEO fields
                        txtPageTitle.Text = rdr["PageTitle"] != DBNull.Value ? rdr["PageTitle"].ToString() : "";
                        txtPageSubtitle.Text = rdr["PageSubtitle"] != DBNull.Value ? rdr["PageSubtitle"].ToString() : "";
                    }
                }
            }
        }

        protected void txtClassName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtClassName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(hfClassID.Value);
            string slug = GenerateSlug(txtSlug.Text.Trim());

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Classes SET 
                                BoardId = @BoardId, 
                                ClassName = @Name, 
                                Slug = @Slug, 
                                DisplayOrder = @Order, 
                                IsActive = @IsActive, 
                                PageTitle = @PTitle, 
                                PageSubtitle = @PSubtitle 
                                WHERE ClassId = @Id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@Name", txtClassName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@Order", int.Parse(txtDisplayOrder.Text));
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@Id", id);

                // Safe handling for optional fields
                cmd.Parameters.AddWithValue("@PTitle", string.IsNullOrWhiteSpace(txtPageTitle.Text) ? (object)DBNull.Value : txtPageTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@PSubtitle", string.IsNullOrWhiteSpace(txtPageSubtitle.Text) ? (object)DBNull.Value : txtPageSubtitle.Text.Trim());

                con.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    Response.Redirect("ManageClasses.aspx");
                }
                else
                {
                    lblMessage.Text = "Update failed. Please try again.";
                    lblMessage.CssClass = "alert alert-danger d-block";
                }
            }
        }

        private string GenerateSlug(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            return slug.Replace(" ", "-");
        }
    }
}