using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class EditResourceType : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        // Using a property to safely manage the ResourceID from QueryString
        private int ResourceID
        {
            get { return Convert.ToInt32(Request.QueryString["id"] ?? "0"); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (ResourceID == 0)
            {
                Response.Redirect("ManageResourceTypes.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindBoards(); // 1. Load the list of boards
                LoadResourceType(); // 2. Load the resource details
                MarkExistingMappings(); // 3. Pre-check the boards already saved
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards ORDER BY BoardName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                cblBoards.DataSource = dt;
                cblBoards.DataBind();
            }
        }

        private void LoadResourceType()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM ResourceTypes WHERE ResourceTypeId = @Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", ResourceID);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtName.Text = dr["TypeName"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    txtSlug.Text = dr["Slug"].ToString();
                    txtDisplayOrder.Text = dr["DisplayOrder"].ToString();
                    chkIsPremium.Checked = Convert.ToBoolean(dr["IsPremium"]);
                    chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);
                    chkHasClass.Checked = Convert.ToBoolean(dr["HasClass"]);
                    chkHasSubject.Checked = Convert.ToBoolean(dr["HasSubject"]);
                    chkHasChapter.Checked = Convert.ToBoolean(dr["HasChapter"]);
                    chkHasYear.Checked = Convert.ToBoolean(dr["HasYear"]);
                    chkHasSubCategory.Checked = Convert.ToBoolean(dr["HasSubCategory"]);

                    string imgName = dr["IconImage"].ToString();
                    hfCurrentImg.Value = imgName;
                    imgCurrent.ImageUrl = "~/Uploads/ResourceIcons/" + (string.IsNullOrEmpty(imgName) ? "default-icon.png" : imgName);
                }
            }
        }

        private void MarkExistingMappings()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // This fetches which boards are currently assigned to this resource
                string query = "SELECT BoardId FROM BoardResourceMapping WHERE ResourceTypeId = @RID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RID", ResourceID);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    string boardId = dr["BoardId"].ToString();
                    ListItem item = cblBoards.Items.FindByValue(boardId);
                    if (item != null) item.Selected = true;
                }
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtName.Text);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string iconFileName = hfCurrentImg.Value;

            if (fuIcon.HasFile)
            {
                string extension = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "resource_" + DateTime.Now.Ticks + extension;
                fuIcon.SaveAs(Server.MapPath("~/Uploads/ResourceIcons/") + iconFileName);
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // 1. Update Resource Details
                    string query = @"UPDATE ResourceTypes SET 
                        TypeName=@TypeName, Slug=@Slug, Description=@Description, IconImage=@IconImage, 
                        IsPremium=@IsPremium, IsActive=@IsActive, DisplayOrder=@DisplayOrder,
                        HasClass=@HasClass, HasSubject=@HasSubject, HasChapter=@HasChapter, 
                        HasYear=@HasYear, HasSubCategory=@HasSubCategory
                        WHERE ResourceTypeId=@Id";

                    SqlCommand cmd = new SqlCommand(query, con, trans);
                    cmd.Parameters.AddWithValue("@TypeName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@IconImage", iconFileName);
                    cmd.Parameters.AddWithValue("@IsPremium", chkIsPremium.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@DisplayOrder", txtDisplayOrder.Text);
                    cmd.Parameters.AddWithValue("@HasClass", chkHasClass.Checked);
                    cmd.Parameters.AddWithValue("@HasSubject", chkHasSubject.Checked);
                    cmd.Parameters.AddWithValue("@HasChapter", chkHasChapter.Checked);
                    cmd.Parameters.AddWithValue("@HasYear", chkHasYear.Checked);
                    cmd.Parameters.AddWithValue("@HasSubCategory", chkHasSubCategory.Checked);
                    cmd.Parameters.AddWithValue("@Id", ResourceID);
                    cmd.ExecuteNonQuery();

                    // 2. Delete old board mappings
                    string delQuery = "DELETE FROM BoardResourceMapping WHERE ResourceTypeId = @RID";
                    SqlCommand delCmd = new SqlCommand(delQuery, con, trans);
                    delCmd.Parameters.AddWithValue("@RID", ResourceID);
                    delCmd.ExecuteNonQuery();

                    // 3. Insert new board mappings from CheckBoxList
                    foreach (ListItem item in cblBoards.Items)
                    {
                        if (item.Selected)
                        {
                            string insQuery = "INSERT INTO BoardResourceMapping (BoardId, ResourceTypeId) VALUES (@BID, @RID)";
                            SqlCommand insCmd = new SqlCommand(insQuery, con, trans);
                            insCmd.Parameters.AddWithValue("@BID", item.Value);
                            insCmd.Parameters.AddWithValue("@RID", ResourceID);
                            insCmd.ExecuteNonQuery();
                        }
                    }

                    trans.Commit();
                    Response.Redirect("ManageResourceTypes.aspx");
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMessage.Text = "Update failed: " + ex.Message;
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