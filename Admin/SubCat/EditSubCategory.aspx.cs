using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace StudyIsleWeb.Admin.SubCat
{
    public partial class EditSubCategory : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    hfSubCatId.Value = Request.QueryString["id"];

                    BindBoards();
                    LoadSubCategory();
                }
                else
                {
                    Response.Redirect("ManageSubCat.aspx");
                }
            }
        }

        private void BindBoards()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query =
                    "SELECT BoardId, BoardName FROM Boards WHERE IsActive = 1 ORDER BY BoardName";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlBoards.DataSource = dt;
                ddlBoards.DataTextField = "BoardName";
                ddlBoards.DataValueField = "BoardId";
                ddlBoards.DataBind();

                ddlBoards.Items.Insert(0,
                    new ListItem("-- Select Board --", "0"));
            }
        }

        private void RefreshResourceTypes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                ddlResourceTypes.Items.Clear();

                int boardId =
                    Convert.ToInt32(ddlBoards.SelectedValue);

                if (boardId == 0)
                {
                    ddlResourceTypes.Items.Insert(0,
                        new ListItem(
                            "-- Select Resource Type --",
                            "0"));

                    return;
                }

                string query = @"
                    SELECT
                        rt.ResourceTypeId,
                        rt.TypeName
                    FROM ResourceTypes rt
                    INNER JOIN BoardResourceMapping brm
                        ON rt.ResourceTypeId = brm.ResourceTypeId
                    WHERE brm.BoardId = @BoardId
                    AND rt.IsActive = 1
                    ORDER BY rt.TypeName";

                SqlDataAdapter da =
                    new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue(
                    "@BoardId",
                    boardId);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlResourceTypes.DataSource = dt;
                ddlResourceTypes.DataTextField = "TypeName";
                ddlResourceTypes.DataValueField = "ResourceTypeId";
                ddlResourceTypes.DataBind();

                ddlResourceTypes.Items.Insert(0,
                    new ListItem(
                        "-- Select Resource Type --",
                        "0"));
            }
        }

        protected void ddlBoards_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            RefreshResourceTypes();
        }

        private void LoadSubCategory()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query =
                    "SELECT * FROM SubCategories WHERE SubCategoryId=@ID";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@ID",
                    hfSubCatId.Value);

                con.Open();

                string boardId = "";
                string resourceTypeId = "";

                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        lblId.Text =
                            "ID : " +
                            rdr["SubCategoryId"].ToString();

                        boardId =
                            rdr["BoardId"].ToString();

                        if (rdr["ResourceTypeId"] != DBNull.Value)
                        {
                            resourceTypeId =
                                rdr["ResourceTypeId"].ToString();
                        }

                        txtName.Text =
                            rdr["SubCategoryName"].ToString();

                        txtSlug.Text =
                            rdr["Slug"].ToString();

                        txtDescription.Text =
                            rdr["Description"].ToString();

                        chkIsCompetitive.Checked =
                            rdr["IsCompetitiveFlow"] != DBNull.Value &&
                            Convert.ToBoolean(rdr["IsCompetitiveFlow"]);

                        chkIsActive.Checked =
                            rdr["IsActive"] != DBNull.Value &&
                            Convert.ToBoolean(rdr["IsActive"]);

                        imgPreview.ImageUrl =
                            "~/Uploads/SubCategoryIcons/" +
                            rdr["IconImage"].ToString();
                    }
                }

                // IMPORTANT:
                // reader closed before rebinding dropdown

                ddlBoards.SelectedValue = boardId;

                RefreshResourceTypes();

                if (!string.IsNullOrEmpty(resourceTypeId))
                {
                    ListItem item =
                        ddlResourceTypes.Items.FindByValue(resourceTypeId);

                    if (item != null)
                    {
                        ddlResourceTypes.SelectedValue =
                            resourceTypeId;
                    }
                }
            }
        }

        protected void txtName_TextChanged(
            object sender,
            EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtName.Text))
            {
                string slug =
                    txtName.Text
                    .ToLower()
                    .Trim();

                slug =
                    Regex.Replace(
                        slug,
                        @"[^a-z0-9\s-]",
                        "");

                slug =
                    Regex.Replace(
                        slug,
                        @"\s+",
                        " ")
                    .Trim();

                slug =
                    slug.Replace(" ", "-");

                txtSlug.Text = slug;
            }
        }

        protected void btnUpdate_Click(
            object sender,
            EventArgs e)
        {
            if (ddlBoards.SelectedValue == "0")
            {
                ShowMessage(
                    "Please select a valid board.",
                    false);

                return;
            }

            string iconName = "";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlTransaction trans =
                    con.BeginTransaction();

                try
                {
                    // OLD IMAGE
                    SqlCommand oldCmd =
                        new SqlCommand(
                            "SELECT IconImage FROM SubCategories WHERE SubCategoryId=@ID",
                            con,
                            trans);

                    oldCmd.Parameters.AddWithValue(
                        "@ID",
                        hfSubCatId.Value);

                    object existingIcon =
                        oldCmd.ExecuteScalar();

                    iconName =
                        existingIcon != null
                        ? existingIcon.ToString()
                        : "default-sub.png";

                    // NEW IMAGE
                    if (fuIcon.HasFile)
                    {
                        string ext =
                            Path.GetExtension(fuIcon.FileName)
                            .ToLower();

                        iconName =
                            "subcat_" +
                            Guid.NewGuid()
                            .ToString()
                            .Substring(0, 8) +
                            ext;

                        string path =
                            Server.MapPath(
                                "~/Uploads/SubCategoryIcons/");

                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);
                        }

                        fuIcon.SaveAs(
                            Path.Combine(path, iconName));
                    }

                    string sql = @"
                        UPDATE SubCategories
                        SET
                            BoardId = @BID,
                            ResourceTypeId = @RTID,
                            SubCategoryName = @Name,
                            Slug = @Slug,
                            IconImage = @Icon,
                            Description = @Desc,
                            IsCompetitiveFlow = @Comp,
                            IsActive = @Active
                        WHERE SubCategoryId = @ID";

                    SqlCommand cmd =
                        new SqlCommand(sql, con, trans);

                    cmd.Parameters.AddWithValue(
                        "@BID",
                        ddlBoards.SelectedValue);

                    if (ddlResourceTypes.SelectedValue == "0")
                    {
                        cmd.Parameters.AddWithValue(
                            "@RTID",
                            DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue(
                            "@RTID",
                            ddlResourceTypes.SelectedValue);
                    }

                    cmd.Parameters.AddWithValue(
                        "@Name",
                        txtName.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@Slug",
                        txtSlug.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@Icon",
                        iconName);

                    cmd.Parameters.AddWithValue(
                        "@Desc",
                        txtDescription.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@Comp",
                        chkIsCompetitive.Checked);

                    cmd.Parameters.AddWithValue(
                        "@Active",
                        chkIsActive.Checked);

                    cmd.Parameters.AddWithValue(
                        "@ID",
                        hfSubCatId.Value);

                    cmd.ExecuteNonQuery();

                    trans.Commit();

                    Response.Redirect("ManageSubCat.aspx");
                }
                catch (Exception ex)
                {
                    trans.Rollback();

                    ShowMessage(
                        "Update Error: " + ex.Message,
                        false);
                }
            }
        }

        private void ShowMessage(
            string msg,
            bool isSuccess)
        {
            lblMessage.Text = msg;

            lblMessage.CssClass =
                isSuccess
                ? "alert alert-success d-block"
                : "alert alert-danger d-block";
        }
    }
}