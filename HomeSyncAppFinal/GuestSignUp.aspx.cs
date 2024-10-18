using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class GuestSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void signUpGuest(object sender, EventArgs e)
        {
            MessageLabel.Text = "";
            ExceptionLabel.Text = "";

            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            //Guest Parameters 
            string guest_of = AdminIDTextBox.Text;
            string adress = AdressTextBox.Text;
            DateTime arrival_Date;
            DateTime departure_date;
            string residential = ResidentialTextBox.Text;

            if (adress.Length == 0)
            { ExceptionLabel.Text += "The adress was not entered, Please try again" + "<br />"; }
            else if (adress.Length > 30)
            { ExceptionLabel.Text += "Exceeded Number of characters (30) (in address) " + "< br />"; }
            else if (!DateTime.TryParseExact(ArrivalDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out arrival_Date))
            { ExceptionLabel.Text += "ERROR : Incorrect Date Format (in Arrival Date)" + "<br />"; }
            else if (!DateTime.TryParseExact(ArrivalDateTextBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out departure_date))
            { ExceptionLabel.Text += "ERROR : Incorrect Date Format (in Departure Date)" + "<br />"; }
            else if (residential.Length == 0)
            { ExceptionLabel.Text += "The adress was not entered, Please try again" + "<br />"; }
            else if (residential.Length > 50)
            { ExceptionLabel.Text += "Exceeded Number of characters (30) (in address) " + "< br />"; }
            else
            {
                int id = Convert.ToInt32(Session["signUpId"]);

                SqlCommand addGuestInput = new SqlCommand("addGuestInput", conn);
                addGuestInput.CommandType = CommandType.StoredProcedure;
                addGuestInput.Parameters.Add(new SqlParameter("@guest_id", id));
                addGuestInput.Parameters.Add(new SqlParameter("@guest_of", Convert.ToInt32(guest_of)));
                addGuestInput.Parameters.Add(new SqlParameter("@adress", adress));
                addGuestInput.Parameters.Add(new SqlParameter("@arrival_date", arrival_Date));
                addGuestInput.Parameters.Add(new SqlParameter("@departure_date", departure_date));
                addGuestInput.Parameters.Add(new SqlParameter("@residential", residential));
                
                try
                {
                    conn.Open();
                
                        Response.Redirect("Login.aspx");
                   
                }

                catch (SqlException sqlEx)
                {
                    ExceptionLabel.Text += "ERROR : " + sqlEx.Message + "<br />";
                    return;
                }
                catch (Exception ex)
                {
                    ExceptionLabel.Text += "ERROR : " + ex.Message + "<br />";
                    return;
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}