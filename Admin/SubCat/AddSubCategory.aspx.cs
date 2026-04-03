using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.SubCat
{
    public partial class AddSubCategory : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

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
            if (!string.IsNullOrEmpty(txtName.Text))
            {
                string slug = txtName.Text.ToLower().Trim();
                slug = Regex.Replace(slug, @"[^a-z0-9\s-]", "");
                slug = Regex.Replace(slug, @"\s+", " ").Trim();
                slug = slug.Replace(" ", "-");
                txtSlug.Text = slug;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoards.SelectedValue == "0")
            {
                ShowMessage("Please select a valid board.", false);
                return;
            }

            string iconName = "default-sub.png";
            if (fuIcon.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuIcon.FileName).ToLower();
                    iconName = "subcat_" + Guid.NewGuid().ToString().Substring(0, 8) + ext;
                    string path = Server.MapPath("~/Uploads/SubCategoryIcons/");
                    if (!Directory.Exists(path)) Directory.CreateDirectory(path);
                    fuIcon.SaveAs(path + iconName);
                }
                catch (Exception ex)
                {
                    ShowMessage("File upload error: " + ex.Message, false);
                    return;
                }
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                // Note: We use IsCompetitiveFlow as bit and ResourceTypeId as nullable
                string sql = @"INSERT INTO SubCategories 
                             (BoardId, ResourceTypeId, SubCategoryName, Slug, IconImage, Description, IsCompetitiveFlow, IsActive) 
                             VALUES (@BID, @RTID, @Name, @Slug, @Icon, @Desc, @IsComp, 1)";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoards.SelectedValue);

                // Handle Nullable ResourceTypeId
                if (ddlResourceTypes.SelectedValue == "0")
                    cmd.Parameters.AddWithValue("@RTID", DBNull.Value);
                else
                    cmd.Parameters.AddWithValue("@RTID", ddlResourceTypes.SelectedValue);

                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                cmd.Parameters.AddWithValue("@Icon", iconName);
                cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@IsComp", chkIsCompetitive.Checked);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("ManageSubCat.aspx");
                }
                catch (Exception ex)
                {
                    ShowMessage("Database error: " + ex.Message, false);
                }
            }
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = isSuccess ? "alert alert-success d-block" : "alert alert-danger d-block";
        }
    }
}