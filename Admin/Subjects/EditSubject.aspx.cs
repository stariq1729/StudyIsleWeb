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
                    BindBoards();
                    LoadSubjectDetails(Convert.ToInt32(Request.QueryString["id"]));
                }
                else
                {
                    Response.Redirect("ManageSubjects.aspx");
                }
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1 ORDER BY BoardName ASC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
                ddlBoard.Items.Insert(0, new ListItem("-- Select Board --", "0"));
            }
        }

        private void BindClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT ClassId, ClassName FROM Classes WHERE BoardId=@bid ORDER BY DisplayOrder ASC", con);
                cmd.Parameters.AddWithValue("@bid", boardId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("-- No Class (General) --", "0"));
            }
        }

        private void LoadSubjectDetails(int sid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Subjects WHERE SubjectId=@id", con);
                cmd.Parameters.AddWithValue("@id", sid);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtSubjectName.Text = dr["SubjectName"].ToString();
                    txtSlug.Text = dr["Slug"].ToString();
                    txtPageTitle.Text = dr["PageTitle"].ToString();
                    txtPageSubtitle.Text = dr["PageSubtitle"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    chkIsActive.Checked = Convert.ToBoolean(dr["IsActive"]);

                    string boardId = dr["BoardId"].ToString();
                    ddlBoard.SelectedValue = boardId;

                    BindClasses(Convert.ToInt32(boardId));
                    ddlClass.SelectedValue = dr["ClassId"] == DBNull.Value ? "0" : dr["ClassId"].ToString();

                    // Handle Image Preview
                    string imgFile = dr["IconImage"].ToString();
                    hfOldImage.Value = imgFile;
                    imgPreview.ImageUrl = !string.IsNullOrEmpty(imgFile) ? "~/Uploads/SubjectIcons/" + imgFile : "~/Uploads/SubjectIcons/Default-icon.png";
                }
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindClasses(Convert.ToInt32(ddlBoard.SelectedValue));
        }

        protected void txtSubjectName_TextChanged(object sender, EventArgs e)
        {
            txtSlug.Text = GenerateSlug(txtSubjectName.Text.Trim());
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int sid = Convert.ToInt32(Request.QueryString["id"]);
            string iconFileName = hfOldImage.Value;

            if (fuIcon.HasFile)
            {
                // Delete old file if it exists and isn't the default
                if (!string.IsNullOrEmpty(iconFileName) && iconFileName != "Default-icon.png")
                {
                    string oldPath = Server.MapPath("~/Uploads/SubjectIcons/" + iconFileName);
                    if (File.Exists(oldPath)) File.Delete(oldPath);
                }

                string extension = Path.GetExtension(fuIcon.FileName).ToLower();
                iconFileName = "subject_" + DateTime.Now.Ticks + extension;
                fuIcon.SaveAs(Path.Combine(Server.MapPath("~/Uploads/SubjectIcons/"), iconFileName));
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Subjects SET 
                                 BoardId=@bid, ClassId=@cid, SubjectName=@name, Slug=@slug, 
                                 IconImage=@img, PageTitle=@pt, PageSubtitle=@ps, 
                                 Description=@desc, IsActive=@active WHERE SubjectId=@sid";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@bid", ddlBoard.SelectedValue);
                cmd.Parameters.AddWithValue("@cid", ddlClass.SelectedValue == "0" ? (object)DBNull.Value : ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@name", txtSubjectName.Text.Trim());
                cmd.Parameters.AddWithValue("@slug", txtSlug.Text.Trim());
                cmd.Parameters.AddWithValue("@img", iconFileName);
                cmd.Parameters.AddWithValue("@pt", txtPageTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@ps", txtPageSubtitle.Text.Trim());
                cmd.Parameters.AddWithValue("@desc", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@active", chkIsActive.Checked);
                cmd.Parameters.AddWithValue("@sid", sid);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            Response.Redirect("ManageSubjects.aspx");
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