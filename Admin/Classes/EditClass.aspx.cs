using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class EditClass : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        private int classId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out classId))
            {
                Response.Redirect("ManageClasses.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBoards();
                LoadClass();
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT BoardId, BoardName FROM Boards", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
            }
        }

        private void LoadClass()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Classes WHERE ClassId=@Id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", classId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    ddlBoard.SelectedValue = dr["BoardId"].ToString();
                    txtClassName.Text = dr["ClassName"].ToString();
                    txtSlug.Text = dr["Slug"].ToString();
                    txtDisplayOrder.Text = dr["DisplayOrder"].ToString();
                    chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);
                }
            }
        }

        protected void txtClassName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtClassName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string slug = GenerateSlug(txtSlug.Text.Trim());

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Classes
                                 SET BoardId=@BoardId,
                                     ClassName=@ClassName,
                                     Slug=@Slug,
                                     DisplayOrder=@DisplayOrder,
                                     IsActive=@IsActive
                                 WHERE ClassId=@Id";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@BoardId", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@ClassName", txtClassName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", slug);
                cmd.Parameters.AddWithValue("@DisplayOrder", txtDisplayOrder.Text);
                cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@Id", classId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageClasses.aspx");
        }

        private string GenerateSlug(string input)
        {
            string slug = input.ToLower();
            slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
            slug = Regex.Replace(slug, @"\s+", " ").Trim();
            return slug.Replace(" ", "-");
        }
    }
}