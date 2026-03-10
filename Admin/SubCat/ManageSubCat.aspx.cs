using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.SubCat
{
    public partial class ManageSubCat : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFilters();
                BindGrid();
            }
        }

        private void BindFilters()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Boards Filter
                SqlDataAdapter daB = new SqlDataAdapter("SELECT BoardId, BoardName FROM Boards ORDER BY BoardName", con);
                DataTable dtB = new DataTable();
                daB.Fill(dtB);
                ddlBoardFilter.DataSource = dtB;
                ddlBoardFilter.DataBind();
                ddlBoardFilter.Items.Insert(0, new ListItem("-- All Boards --", "0"));

                // Resource Types Filter
                SqlDataAdapter daR = new SqlDataAdapter("SELECT ResourceTypeId, TypeName FROM ResourceTypes ORDER BY TypeName", con);
                DataTable dtR = new DataTable();
                daR.Fill(dtR);
                ddlTypeFilter.DataSource = dtR;
                ddlTypeFilter.DataBind();
                ddlTypeFilter.Items.Insert(0, new ListItem("-- All Resource Types --", "0"));
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // We pull BoardName and TypeName for the UI
                string query = @"SELECT s.*, b.BoardName, r.TypeName 
                               FROM SubCategories s
                               INNER JOIN Boards b ON s.BoardId = b.BoardId
                               LEFT JOIN ResourceTypes r ON s.ResourceTypeId = r.ResourceTypeId
                               WHERE 1=1";

                if (ddlBoardFilter.SelectedValue != "0")
                    query += " AND s.BoardId = @BID";

                if (ddlTypeFilter.SelectedValue != "0")
                    query += " AND s.ResourceTypeId = @RTID";

                query += " ORDER BY s.SubCategoryId DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BID", ddlBoardFilter.SelectedValue);
                cmd.Parameters.AddWithValue("@RTID", ddlTypeFilter.SelectedValue);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                gvSubCats.DataSource = dt;
                gvSubCats.DataBind();
                lblCount.Text = "Total: " + dt.Rows.Count;
            }
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void gvSubCats_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvSubCats.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM SubCategories WHERE SubCategoryId = @ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
                BindGrid();
            }
        }
    }
}