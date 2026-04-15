using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudyIsleWeb.Flashcards
{
    public partial class FlashcardSetList : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["dbcs"].ConnectionString;

        protected int ChapterId
        {
            get { return ViewState["ChapterId"] != null ? Convert.ToInt32(ViewState["ChapterId"]) : 0; }
            set { ViewState["ChapterId"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["cid"] != null)
                {
                    ChapterId = Convert.ToInt32(Request.QueryString["cid"]);
                    LoadFlashcardSet();
                }
                else
                {
                    pnlFlashcard.Visible = false;
                    pnlNoFlashcards.Visible = true;
                }
            }
        }

        /// <summary>
        /// Loads chapter details and flashcard count.
        /// </summary>
        private void LoadFlashcardSet()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        c.ChapterName,
                        COUNT(f.FlashcardId) AS TotalFlashcards
                    FROM Chapters c
                    LEFT JOIN Flashcards f 
                        ON c.ChapterId = f.ChapterId AND f.IsActive = 1
                    WHERE c.ChapterId = @ChapterId
                    GROUP BY c.ChapterName";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ChapterId", ChapterId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblChapterName.Text = dr["ChapterName"].ToString();
                    int totalFlashcards = Convert.ToInt32(dr["TotalFlashcards"]);
                    lblTotalFlashcards.Text = totalFlashcards.ToString();

                    pnlFlashcard.Visible = totalFlashcards > 0;
                    pnlNoFlashcards.Visible = totalFlashcards == 0;
                }
                else
                {
                    pnlFlashcard.Visible = false;
                    pnlNoFlashcards.Visible = true;
                }
            }
        }

        /// <summary>
        /// Redirects user to FlashcardViewer page.
        /// </summary>
        protected void btnStartFlashcards_Click(object sender, EventArgs e)
        {
            // Check if the user is logged in
            if (Session["UserEmail"] == null)
            {
                // Store the current URL for redirection after login
                string returnUrl = Request.RawUrl;

                Response.Redirect("~/Login.aspx?ReturnUrl=" +
                                  Server.UrlEncode(returnUrl));
                return;
            }

            // Retrieve query string parameters
            string bid = Request.QueryString["bid"];
            string rid = Request.QueryString["rid"];
            string scid = Request.QueryString["scid"];
            string sid = Request.QueryString["sid"];
            string cid = Request.QueryString["cid"];

            // Redirect to Flashcard Viewer
            Response.Redirect(
                $"~/Flashcards/FlashcardViewer.aspx?bid={bid}&rid={rid}&scid={scid}&sid={sid}&cid={cid}");
        }
    }
}