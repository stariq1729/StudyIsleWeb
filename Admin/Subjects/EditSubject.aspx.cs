using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Subjects
{
    public partial class EditSubject : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    hfSubjectID.Value = id.ToString();
                    lblSubjectID.Text = "ID: " + id;

                    LoadBoards();
                    LoadSubjectDetails(id);
                }
                else { Response.Redirect("ManageSubjects.aspx"); }
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new ListItem("-- Select Board --", "0"));
            }
        }

        private void LoadClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ClassId, ClassName FROM Classes WHERE BoardId=@BID ORDER BY DisplayOrder", con);
                cmd.Parameters.AddWithValue("@BID", boardId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("-- General --", "0"));
            }
        }

        private void LoadSubjectDetails(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Subjects WHERE SubjectId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        txtSubjectName.Text = rdr["SubjectName"].ToString();
                        txtSlug.Text = rdr["Slug"].ToString();
                        txtPageTitle.Text = rdr["PageTitle"].ToString();
                        txtDescription.Text = rdr["Description"].ToString();
                        chkIsActive.Checked = Convert.ToBoolean(rdr["IsActive"]);
                        ViewState["OldIcon"] = rdr["IconImage"].ToString();
                        imgCurrentIcon.ImageUrl = "/Uploads/SubjectIcons/" + rdr["IconImage"].ToString();

                        ddlBoard.SelectedValue = rdr["BoardId"].ToString();
                        LoadClasses(Convert.ToInt32(rdr["BoardId"]));

                        // Handle potential NULL ClassId
                        string classId = rdr["ClassId"] != DBNull.Value ? rdr["ClassId"].ToString() : "0";
                        if (ddlClass.Items.FindByValue(classId) != null)
                            ddlClass.SelectedValue = classId;
                    }
                }
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadClasses(Convert.ToInt32(ddlBoard.SelectedValue));
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtSubjectName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string iconName = ViewState["OldIcon"].ToString();
            if (fuIcon.HasFile)
            {
                iconName = "sub_" + DateTime.Now.Ticks + Path.GetExtension(fuIcon.FileName);
                fuIcon.SaveAs(Server.MapPath("~/Uploads/SubjectIcons/") + iconName);
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = @"UPDATE Subjects SET BoardId=@BID, ClassId=@CID, SubjectName=@Name, Slug=@Slug, 
                               IconImage=@Icon, PageTitle=@PTitle, Description=@Desc, IsActive=@Active WHERE SubjectId=@Id";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@CID", ddlClass.SelectedValue == "0" ? (object)DBNull.Value : ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@Name", txtSubjectName.Text.Trim());
                cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                cmd.Parameters.AddWithValue("@Icon", iconName);
                cmd.Parameters.AddWithValue("@PTitle", txtPageTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@Active", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@Id", hfSubjectID.Value);

                con.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("ManageSubjects.aspx");
            }
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