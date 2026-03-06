using StudyIsleWeb.Admin.Boards;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace StudyIsleWeb.Admin.SubCat
{
    public partial class AddSubCategory : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdowns();
            }
        }

        private void BindDropdowns()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                // Bind Boards
                SqlDataAdapter daB = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1", con);
                DataTable dtB = new DataTable();
                daB.Fill(dtB);
                ddlBoards.DataSource = dtB;
                ddlBoards.DataBind();
                ddlBoards.Items.Insert(0, new ListItem("-- Select Board --", "0"));

                // Bind Resource Types
                SqlDataAdapter daR = new SqlDataAdapter("SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive = 1", con);
                DataTable dtR = new DataTable();
                daR.Fill(dtR);
                ddlResourceTypes.DataSource = dtR;
                ddlResourceTypes.DataBind();
                ddlResourceTypes.Items.Insert(0, new ListItem("-- Select Resource Type (Optional) --", "0"));
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoards.SelectedValue == "0") { lblMessage.Text = "Please select a Board."; return; }

            string iconFileName = "default-sub.png";
            if (fuIcon.HasFile)
            {
                string ext = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "subcat_" + DateTime.Now.Ticks + ext;
                string folder = Server.MapPath("~/Uploads/SubCategoryIcons/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                fuIcon.SaveAs(Path.Combine(folder, iconFileName));
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                // - Matching your table structure with new columns
                string query = @"INSERT INTO SubCategories 
                                (BoardId, ResourceTypeId, SubCategoryName, Slug, IconImage, Description, IsCompetitiveFlow, IsActive) 
                                VALUES (@BID, @RTID, @Name, @Slug, @Icon, @Desc, @IsComp, 1)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoards.SelectedValue);
                cmd.Parameters.AddWithValue("@RTID", ddlResourceTypes.SelectedValue == "0" ? (object)DBNull.Value : ddlResourceTypes.SelectedValue);
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                cmd.Parameters.AddWithValue("@Icon", iconFileName);
                cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@IsComp", chkIsCompetitive.Checked);

                con.Open();
                cmd.ExecuteNonQuery();

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "SubCategory successfully created!";
                ClearForm();
            }
        }

        private void ClearForm()
        {
            txtName.Text = txtSlug.Text = txtDescription.Text = "";
            ddlBoards.SelectedIndex = ddlResourceTypes.SelectedIndex = 0;
            chkIsCompetitive.Checked = false;
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