using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudyIsleWeb
{
    public partial class CompSubCategory : System.Web.UI.Page
    {
        // Using "dbcs" as per your BoardResourceTypes code
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get slug from URL: CompSubCategory.aspx?board=jee
                string boardSlug = Request.QueryString["board"];

                if (!string.IsNullOrEmpty(boardSlug))
                {
                    LoadPageData(boardSlug);
                }
                else
                {
                    // Fallback to avoid empty page
                    LoadPageData("jee");
                }
            }
        }

        private void LoadPageData(string slug)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // One query to get Board details AND all its SubCategories
                string sql = @"
                    -- Get Board Info
                    SELECT BoardId, BoardName, HeroSubtitle FROM Boards WHERE Slug = @slug;

                    -- Get SubCategories linked to this Board
                    SELECT SubCategoryId, SubCategoryName, IconImage, [Description] 
                    FROM SubCategories 
                    WHERE BoardId = (SELECT BoardId FROM Boards WHERE Slug = @slug) 
                    AND IsActive = 1;";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@slug", slug);

                try
                {
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        // 1. Bind Hero Data
                        if (dr.Read())
                        {
                            litBoardName.Text = dr["BoardName"].ToString();
                            // If HeroSubtitle is NULL in DB, use a default fallback
                            string subtitle = dr["HeroSubtitle"].ToString();
                            litHeroSubtitle.Text = string.IsNullOrEmpty(subtitle)
                                ? "Access the most comprehensive study materials, notes, and previous year questions."
                                : subtitle;
                        }

                        // 2. Bind SubCategory Cards
                        if (dr.NextResult())
                        {
                            rptSubCategories.DataSource = dr;
                            rptSubCategories.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // For debugging: display error if DB fails
                    // Response.Write("Error: " + ex.Message);
                }
            }
        }

        protected void lnkSubCat_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string scid = btn.CommandArgument;

            // Navigate to the Resource Selection page (Next Stage)
            Response.Redirect($"CompResource.aspx?scid={scid}");
        }
    }
}