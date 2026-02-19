using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class EditClass : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoards();

                if (Request.QueryString["id"] != null)
                {
                    int classId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadClass(classId);
                }
                else
                {
                    Response.Redirect("ManageClasses.aspx");
                }
            }
        }

        private void LoadBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoard.DataSource = dt;
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardId";
                ddlBoard.DataBind();
            }
        }

        private void LoadClass(int classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "SELECT * FROM Classes WHERE ClassId=@ClassId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ClassId", classId);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    hfClassId.Value = reader["ClassId"].ToString();
                    ddlBoard.SelectedValue = reader["BoardId"].ToString();
                    txtClassName.Text = reader["ClassName"].ToString();
                    txtDisplayOrder.Text = reader["DisplayOrder"].ToString();
                    chkIsActive.Checked = Convert.ToBoolean(reader["IsActive"]);
                }
                else
                {
                    Response.Redirect("ManageClasses.aspx");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int classId = Convert.ToInt32(hfClassId.Value);
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

                string query = @"UPDATE Classes
                                 SET BoardId=@BoardId,
                                     ClassName=@ClassName,
                                     DisplayOrder=@DisplayOrder,
                                     IsActive=@IsActive
                                 WHERE ClassId=@ClassId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ClassId", classId);
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

                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }
    }
}
