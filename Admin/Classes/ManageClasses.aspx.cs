using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudyIsleWeb.Admin.Classes
{
    public partial class ManageClasses : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClasses();
            }
        }

        private void LoadClasses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT c.ClassId,
                                        b.BoardName,
                                        c.ClassName,
                                        c.DisplayOrder,
                                        c.IsActive
                                 FROM Classes c
                                 INNER JOIN Boards b ON c.BoardId = b.BoardId";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvClasses.DataSource = dt;
                gvClasses.DataBind();
            }
        }

        protected void gvClasses_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int classId = Convert.ToInt32(e.CommandArgument);
                ToggleClassStatus(classId);
                LoadClasses();
            }
        }

        private void ToggleClassStatus(int classId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = "UPDATE Classes SET IsActive = ~IsActive WHERE ClassId=@ClassId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ClassId", classId);

                cmd.ExecuteNonQuery();
            }
        }
    }
}
