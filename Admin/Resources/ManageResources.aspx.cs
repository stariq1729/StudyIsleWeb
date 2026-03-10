using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.Resources
{
    public partial class ManageResources : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFilters();
                LoadResources();
            }
        }

        private void BindFilters()
        {
            BindDDL("SELECT BoardId, BoardName FROM Boards WHERE IsActive=1", ddlFilterBoard, "BoardName", "BoardId");
            BindDDL("SELECT ResourceTypeId, TypeName FROM ResourceTypes WHERE IsActive=1", ddlFilterType, "TypeName", "ResourceTypeId");
            BindDDL("SELECT ClassId, ClassName FROM Classes", ddlFilterClass, "ClassName", "ClassId");
            BindDDL("SELECT SubjectId, SubjectName FROM Subjects", ddlFilterSubject, "SubjectName", "SubjectId");
        }

        private void BindDDL(string sql, DropDownList ddl, string text, string value)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl.DataSource = dt;
                ddl.DataTextField = text;
                ddl.DataValueField = value;
                ddl.DataBind();
                ddl.Items.Insert(0, new ListItem("All " + ddl.ID.Replace("ddlFilter", ""), "0"));
            }
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            gvResources.PageIndex = 0; // Reset to page 1 on search
            LoadResources();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlFilterBoard.SelectedIndex = 0;
            ddlFilterType.SelectedIndex = 0;
            ddlFilterClass.SelectedIndex = 0;
            ddlFilterSubject.SelectedIndex = 0;
            LoadResources();
        }

        private void LoadResources()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Dynamic Query Construction
                string query = @"
                    SELECT r.ResourceId, b.BoardName, c.ClassName, s.SubjectName, ch.ChapterName, 
                           rt.TypeName, r.Title, r.FilePath, r.IsPremium, r.IsActive, r.DownloadCount
                    FROM Resources r
                    INNER JOIN Boards b ON r.BoardId = b.BoardId
                    INNER JOIN ResourceTypes rt ON r.ResourceTypeId = rt.ResourceTypeId
                    LEFT JOIN Classes c ON r.ClassId = c.ClassId
                    LEFT JOIN Subjects s ON r.SubjectId = s.SubjectId
                    LEFT JOIN Chapters ch ON r.ChapterId = ch.ChapterId
                    WHERE 1=1"; // Dummy true to allow easy appending of AND clauses

                if (ddlFilterBoard.SelectedIndex > 0) query += " AND r.BoardId = " + ddlFilterBoard.SelectedValue;
                if (ddlFilterType.SelectedIndex > 0) query += " AND r.ResourceTypeId = " + ddlFilterType.SelectedValue;
                if (ddlFilterClass.SelectedIndex > 0) query += " AND r.ClassId = " + ddlFilterClass.SelectedValue;
                if (ddlFilterSubject.SelectedIndex > 0) query += " AND r.SubjectId = " + ddlFilterSubject.SelectedValue;

                query += " ORDER BY r.CreatedAt DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResources.DataSource = dt;
                gvResources.DataBind();
            }
        }

        protected void gvResources_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvResources.PageIndex = e.NewPageIndex;
            LoadResources();
        }

        protected void gvResources_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Toggle")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    // Using bitwise NOT (~) for instant toggle
                    string query = "UPDATE Resources SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END WHERE ResourceId=@Id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadResources();
            }
            else if (e.CommandName == "EditItem")
            {
                Response.Redirect("EditResource.aspx?id=" + id);
            }
        }
    }
}