using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class ManageResourceTypes : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindResourceTypes();
            }
        }

        private void BindResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // This query groups board names so we can see them in the grid
                string query = @"
                    SELECT RT.*, 
                    (SELECT STRING_AGG(B.BoardName, ', ') 
                     FROM BoardResourceMapping BRM 
                     JOIN Boards B ON BRM.BoardId = B.BoardId 
                     WHERE BRM.ResourceTypeId = RT.ResourceTypeId) as MappedBoards
                    FROM ResourceTypes RT
                    WHERE (RT.TypeName LIKE '%' + @search + '%' OR RT.Slug LIKE '%' + @search + '%')";

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                {
                    query += " AND RT.IsActive = @status";
                }

                query += " ORDER BY RT.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@search", txtSearch.Text.Trim());
                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                    cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResourceTypes.DataSource = dt;
                gvResourceTypes.DataBind();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindResourceTypes();
        }

        protected void gvResourceTypes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ToggleStatus(id);
                BindResourceTypes();
            }
        }

        private void ToggleStatus(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE ResourceTypes SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE ResourceTypeId = @ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Helper method for the Frontend to render board badges
        public string GetBoardBadges(object boards)
        {
            if (boards == null || string.IsNullOrEmpty(boards.ToString()))
                return "<span class='text-danger small'>Not Mapped</span>";

            string[] boardList = boards.ToString().Split(',');
            string html = "";
            foreach (var b in boardList)
            {
                html += $"<span class='badge badge-board'>{b.Trim()}</span>";
            }
            return html;
        }

        // Helper method to show the hierarchy summary
        public string GetFlowSummary(object cls, object sub, object chp)
        {
            string summary = "";
            if (Convert.ToBoolean(cls)) summary += "Class > ";
            if (Convert.ToBoolean(sub)) summary += "Subject > ";
            if (Convert.ToBoolean(chp)) summary += "Chapter";
            return summary.TrimEnd(' ', '>');
        }
    }
}