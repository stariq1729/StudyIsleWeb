using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using System.Runtime.CompilerServices;

namespace StudyIsleWeb
{
    public partial class Default : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadBlogs(); // default = latest
            }
        }
        // 🔹 Load Categories (Tabs)
        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT CategoryId, CategoryName FROM BlogCategories WHERE IsActive=1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
        }

        // 🔹 Load Blogs (UPDATED - CORE CHANGE)
        private void LoadBlogs(int? categoryId = null)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                 SELECT TOP 3  
                    b.BlogId,
                    b.Slug,
                    b.AuthorName,
                    b.AuthorImage,
                    b.ReadTime,
                    c.CategoryName,

                    -- Title from blocks (H1)
                    ISNULL((
                        SELECT TOP 1 Content 
                        FROM BlogBlocks 
                        WHERE BlogId = b.BlogId AND BlockType = 'h1'
                        ORDER BY DisplayOrder
                    ), 'Untitled Blog') AS Title,

                    -- Image from blocks
                    ISNULL((
                        SELECT TOP 1 Content 
                        FROM BlogBlocks 
                        WHERE BlogId = b.BlogId AND BlockType = 'image'
                        ORDER BY DisplayOrder
                    ), '/uploads/default.jpg') AS CoverImage,

                    -- Description from blocks
                    ISNULL((
                        SELECT TOP 1 Content 
                        FROM BlogBlocks 
                        WHERE BlogId = b.BlogId AND BlockType = 'paragraph'
                        ORDER BY DisplayOrder
                    ), 'No description available') AS ShortDescription

                FROM Blogs b
                INNER JOIN BlogCategories c ON b.CategoryId = c.CategoryId
                WHERE b.IsActive = 1";

                // 🔹 Category Filter
                if (categoryId != null)
                {
                    query += " AND b.CategoryId = @CategoryId";
                }

                // 🔹 Latest First
                query += " ORDER BY b.CreatedDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                if (categoryId != null)
                {
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptBlogs.DataSource = dt;
                rptBlogs.DataBind();
            }
        }

        // 🔹 Latest Button
        protected void btnLatest_Click(object sender, EventArgs e)
        {
            LoadBlogs();
        }

        // 🔹 Category Click
        protected void Category_Click(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);
            LoadBlogs(categoryId);
        }


        //this button belongs to enquiry form
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string country = ddlCountry.SelectedValue;
                string grade = ddlGrade.SelectedValue;
                string board = ddlBoard.SelectedValue;
                string timeline = rblTimeline.SelectedValue;

                // Collect multiple selected subjects
                StringBuilder subjects = new StringBuilder();
                foreach (ListItem item in chkSubjects.Items)
                {
                    if (item.Selected)
                    {
                        subjects.Append(item.Value + ", ");
                    }
                }

                string subjectList = subjects.ToString().TrimEnd(',', ' ');

              

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Enquiries
                            (FullName, Email, Phone, Country, Grade, Board, Subjects, Timeline)
                            VALUES
                            (@FullName, @Email, @Phone, @Country, @Grade, @Board, @Subjects, @Timeline)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Country", country);
                        cmd.Parameters.AddWithValue("@Grade", grade);
                        cmd.Parameters.AddWithValue("@Board", board);
                        cmd.Parameters.AddWithValue("@Subjects", subjectList);
                        cmd.Parameters.AddWithValue("@Timeline", timeline);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                ClearForm();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert", "alert('Enquiry submitted successfully!');", true);
            }

        }
        private void ClearForm()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlCountry.SelectedIndex = 0;
            ddlGrade.SelectedIndex = 0;
            ddlBoard.SelectedIndex = 0;
            rblTimeline.ClearSelection();

            foreach (ListItem item in chkSubjects.Items)
            {
                item.Selected = false;
            }
        }


    }
}