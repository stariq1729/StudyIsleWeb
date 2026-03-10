using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.ResourceTypes
{
    public partial class ManageResourceTypes : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBoardsDropdown();
                BindGrid();
            }
        }

        private void LoadBoardsDropdown()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT BoardId, BoardName FROM Boards ORDER BY BoardName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoardFilter.DataSource = dt;
                ddlBoardFilter.DataBind();
                ddlBoardFilter.Items.Insert(0, new ListItem("--- Show All Boards ---", "0"));
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // SQL trick: STUFF/FOR XML PATH combines multiple board names into one column 'MappedBoards'
                string query = @"
                    SELECT rt.*, 
                    STUFF((SELECT ', ' + b.BoardName 
                           FROM BoardResourceMapping brm 
                           JOIN Boards b ON brm.BoardId = b.BoardId 
                           WHERE brm.ResourceTypeId = rt.ResourceTypeId 
                           FOR XML PATH('')), 1, 2, '') as MappedBoards
                    FROM ResourceTypes rt";

                if (ddlBoardFilter.SelectedValue != "0")
                {
                    query += @" WHERE rt.ResourceTypeId IN 
                                (SELECT ResourceTypeId FROM BoardResourceMapping WHERE BoardId = @BoardId)";
                }

                query += " ORDER BY rt.DisplayOrder ASC";

                SqlCommand cmd = new SqlCommand(query, con);
                if (ddlBoardFilter.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@BoardId", ddlBoardFilter.SelectedValue);
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                gvResourceTypes.DataSource = dt;
                gvResourceTypes.DataBind();
                lblCount.Text = "Total Types: " + dt.Rows.Count;
            }
        }

        protected void ddlBoardFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void gvResourceTypes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rtId = Convert.ToInt32(gvResourceTypes.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();
                try
                {
                    // 1. Delete Mappings first (Foreign Key constraint)
                    SqlCommand cmdMap = new SqlCommand("DELETE FROM BoardResourceMapping WHERE ResourceTypeId = @ID", con, trans);
                    cmdMap.Parameters.AddWithValue("@ID", rtId);
                    cmdMap.ExecuteNonQuery();

                    // 2. Delete the actual Resource Type
                    SqlCommand cmdRT = new SqlCommand("DELETE FROM ResourceTypes WHERE ResourceTypeId = @ID", con, trans);
                    cmdRT.Parameters.AddWithValue("@ID", rtId);
                    cmdRT.ExecuteNonQuery();

                    trans.Commit();
                    lblMessage.Text = "Resource Type and all its board mappings deleted successfully.";
                    BindGrid();
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}