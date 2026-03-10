using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class EditResourceType : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int rtId = Convert.ToInt32(Request.QueryString["id"]);
                    hfRTID.Value = rtId.ToString();
                    BindBoards();
                    LoadData(rtId);
                }
                else { Response.Redirect("ManageResourceTypes.aspx"); }
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                cblBoards.DataSource = dt;
                cblBoards.DataBind();
            }
        }

        private void LoadData(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                // 1. Load Main Details
                SqlCommand cmd = new SqlCommand("SELECT * FROM ResourceTypes WHERE ResourceTypeId=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {

                        txtName.Text = rdr["TypeName"].ToString();
                        txtSlug.Text = rdr["Slug"].ToString();
                        imgCurrentIcon.ImageUrl = "/Uploads/Icons/" + rdr["IconImage"].ToString();
                        // Use the 'as' keyword or a null check to safely cast
                        chkHasClass.Checked = (rdr["HasClass"] as bool?) ?? false;
                        chkHasSubject.Checked = (rdr["HasSubject"] as bool?) ?? false;
                        chkHasChapter.Checked = (rdr["HasChapter"] as bool?) ?? false;
                        chkHasSubCategory.Checked = (rdr["HasSubCategory"] as bool?) ?? false;
                        chkHasYear.Checked = (rdr["HasYear"] as bool?) ?? false;
                        chkHasSets.Checked = (rdr["HasSets"] as bool?) ?? false;
                    }
                }

                // 2. Pre-select checkboxes based on existing Mapping
                SqlCommand cmdMap = new SqlCommand("SELECT BoardId FROM BoardResourceMapping WHERE ResourceTypeId=@ID", con);
                cmdMap.Parameters.AddWithValue("@ID", id);
                using (SqlDataReader rdrMap = cmdMap.ExecuteReader())
                {
                    while (rdrMap.Read())
                    {
                        string bID = rdrMap["BoardId"].ToString();
                        ListItem li = cblBoards.Items.FindByValue(bID);
                        if (li != null) li.Selected = true;
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int rtId = int.Parse(hfRTID.Value);
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();
                try
                {
                    // Optional: Handle New Icon Upload
                    string iconUpdateQuery = "";
                    if (fuIcon.HasFile)
                    {
                        string ext = Path.GetExtension(fuIcon.FileName).ToLower();
                        string fileName = "res_" + Guid.NewGuid().ToString().Substring(0, 5) + ext;
                        fuIcon.SaveAs(Server.MapPath("~/Uploads/Icons/") + fileName);
                        iconUpdateQuery = ", IconImage='" + fileName + "'";
                    }

                    // 1. Update Resource Type
                    string sql = $@"UPDATE ResourceTypes SET TypeName=@Name, Slug=@Slug, HasClass=@C, 
                                   HasSubject=@S, HasChapter=@Ch, HasSubCategory=@Sc, HasYear=@Y, 
                                   HasSets=@St {iconUpdateQuery} WHERE ResourceTypeId=@ID";

                    SqlCommand cmd = new SqlCommand(sql, con, trans);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text);
                    cmd.Parameters.AddWithValue("@C", chkHasClass.Checked);
                    cmd.Parameters.AddWithValue("@S", chkHasSubject.Checked);
                    cmd.Parameters.AddWithValue("@Ch", chkHasChapter.Checked);
                    cmd.Parameters.AddWithValue("@Sc", chkHasSubCategory.Checked);
                    cmd.Parameters.AddWithValue("@Y", chkHasYear.Checked);
                    cmd.Parameters.AddWithValue("@St", chkHasSets.Checked);
                    cmd.Parameters.AddWithValue("@ID", rtId);
                    cmd.ExecuteNonQuery();

                    // 2. Update Mappings: Delete existing and add new
                    new SqlCommand("DELETE FROM BoardResourceMapping WHERE ResourceTypeId=" + rtId, con, trans).ExecuteNonQuery();
                    foreach (ListItem item in cblBoards.Items)
                    {
                        if (item.Selected)
                        {
                            SqlCommand mapCmd = new SqlCommand("INSERT INTO BoardResourceMapping (BoardId, ResourceTypeId) VALUES (@BID, @RID)", con, trans);
                            mapCmd.Parameters.AddWithValue("@BID", item.Value);
                            mapCmd.Parameters.AddWithValue("@RID", rtId);
                            mapCmd.ExecuteNonQuery();
                        }
                    }

                    trans.Commit();
                    Response.Redirect("ManageResourceTypes.aspx");
                }
                catch (Exception ex) { trans.Rollback(); lblMessage.Text = "Error: " + ex.Message; }
            }
        }
    }
}