using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class GuestHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            int userId = Convert.ToInt32(Session["UserID"]);
            SqlCommand ViewProfile = new SqlCommand("ViewProfile", conn);
            ViewProfile.CommandType = System.Data.CommandType.StoredProcedure;
            ViewProfile.Parameters.Add(new SqlParameter("@user_id", userId));
            try
            {
                conn.Open();
                SqlDataReader reader = ViewProfile.ExecuteReader();
                if (reader.HasRows)
                {
                    UserProfileGridView.DataSource = reader;
                    UserProfileGridView.DataBind();
                }
            }
            catch (SqlException sqlEx)
            {
                ExceptionLabel.Text += "ERROR : " + sqlEx.Message + "<br />";
            }
            catch (Exception ex)
            {
                ExceptionLabel.Text += "ERROR : " + ex.Message + "<br />";
            }
            finally { conn.Close(); }

        }


        //MO GAD
        protected void goToGuestRoom(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMMISSION
            Response.Redirect("RoomGuest(MO).aspx");

        }
        protected void goToGuestTask(object sender, EventArgs e)
        {
            Response.Redirect("Tasks.aspx");
        }
        //MEKKI
        protected void goToGuestEvent(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMMISSION
            Response.Redirect("GuestHomePage(Mekki).aspx");
        }
        //HUSSEIN
        protected void goToGuestDevice(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMMISSION
            Response.Redirect("Device(HUSS).aspx");
        }

        //MAMDOUH
        protected void goToGuestFAndC(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMMISSION
            Response.Redirect("main page(MAM).aspx");
        }

        protected void signOut(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

    }
}
