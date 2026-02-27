using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class ManageClasses : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
                LoadClasses();
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive=1";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoardFilter.DataSource = dt;
                ddlBoardFilter.DataTextField = "BoardName";
                ddlBoardFilter.DataValueField = "BoardId";
                ddlBoardFilter.DataBind();
                ddlBoardFilter.Items.Insert(0, new ListItem("-- All Boards --", "0"));
            }
        }

        private void LoadClasses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT c.ClassId, b.BoardName, c.ClassName, c.Slug, 
                                c.DisplayOrder, c.IsActive, c.CreatedAt, c.PageTitle
                         FROM Classes c
                         INNER JOIN Boards b ON c.BoardId = b.BoardId";

                if (ddlBoardFilter.SelectedValue != "0")
                {
                    query += " WHERE c.BoardId = @BoardId";
                }
                query += " ORDER BY c.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                if (ddlBoardFilter.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoardFilter.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvClasses.DataSource = dt;
                gvClasses.DataBind();
            }
        }

        protected void ddlBoardFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadClasses();
        }

        protected void gvClasses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int classId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"UPDATE Classes 
                                     SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END 
                                     WHERE ClassId = @ClassId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ClassId", classId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadClasses();
            }
        }
    }
}