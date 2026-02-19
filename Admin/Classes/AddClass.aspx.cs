using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class AddClass : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT BoardId, BoardName 
                                 FROM Boards 
                                 WHERE IsActive = 1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();

                ddlBoard.Items.Insert(0, "-- Select Board --");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a board.";
                return;
            }

            int boardId = Convert.ToInt32(ddlBoard.SelectedValue);
            string className = txtClassName.Text.Trim();
            int displayOrder = Convert.ToInt32(txtDisplayOrder.Text);
            bool isActive = chkIsActive.Checked;

            if (!BoardSupportsClasses(boardId))
            {
                lblMessage.Text = "This board does not support class layer.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"INSERT INTO Classes
                                 (BoardId, ClassName, DisplayOrder, IsActive, CreatedAt)
                                 VALUES
                                 (@BoardId, @ClassName, @DisplayOrder, @IsActive, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);
                cmd.Parameters.AddWithValue("@ClassName", className);
                cmd.Parameters.AddWithValue("@DisplayOrder", displayOrder);
                cmd.Parameters.AddWithValue("@IsActive", isActive);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageClasses.aspx");
        }

        private bool BoardSupportsClasses(int boardId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT HasClassLayer FROM Boards WHERE BoardId=@BoardId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BoardId", boardId);

                bool hasClassLayer = Convert.ToBoolean(cmd.ExecuteScalar());

                return hasClassLayer;
            }
        }
    }
}
