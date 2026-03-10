using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Boards
{
    public partial class EditBoard : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int boardId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadBoardData(boardId);
                }
                else
                {
                    Response.Redirect("ManageBoards.aspx");
                }
            }
        }

        private void LoadBoardData(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Boards WHERE BoardId = @BoardId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", id);
                con.Open();

                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        hfBoardId.Value = rdr["BoardId"].ToString();
                        lblIdDisplay.Text = "ID: " + rdr["BoardId"].ToString();
                        txtBoardName.Text = rdr["BoardName"].ToString();
                        txtSlug.Text = rdr["Slug"].ToString();
                        txtHeroTitle.Text = rdr["HeroTitle"].ToString();
                        txtHeroSubtitle.Text = rdr["HeroSubtitle"].ToString();

                        // Handling DBNull for the bit columns
                        chkIsCompetitive.Checked = rdr["IsCompetitive"] != DBNull.Value && Convert.ToBoolean(rdr["IsCompetitive"]);
                        chkHasClassLayer.Checked = rdr["HasClassLayer"] != DBNull.Value && Convert.ToBoolean(rdr["HasClassLayer"]);
                        chkIsActive.Checked = rdr["IsActive"] != DBNull.Value && Convert.ToBoolean(rdr["IsActive"]);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE Boards SET 
                                    BoardName = @BoardName, Slug = @Slug, HeroTitle = @HeroTitle, 
                                    HeroSubtitle = @HeroSubtitle, IsCompetitive = @IsCompetitive, 
                                    HasClassLayer = @HasClassLayer, IsActive = @IsActive 
                                    WHERE BoardId = @BoardId";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BoardName", txtBoardName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim());
                    cmd.Parameters.AddWithValue("@HeroTitle", txtHeroTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@HeroSubtitle", txtHeroSubtitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@IsCompetitive", chkIsCompetitive.Checked);
                    cmd.Parameters.AddWithValue("@HasClassLayer", chkHasClassLayer.Checked);
                    cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@BoardId", hfBoardId.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                Response.Redirect("ManageBoards.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Update Error: " + ex.Message;
            }
        }
    }
}