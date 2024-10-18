using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class CreateEventPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void createEventBtn_Click(object sender, EventArgs e)
        {
            MessageLbl.Text = "";

            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            string eventIdString = eventIdText.Text;
            string userIdString = userIdText.Text;
            string otherUserIdString = otherUserIdText.Text;
            string name = nameText.Text;
            string desc = descriptionText.Text;
            string loc = locationText.Text;
            string reminder = reminderDateText.Text;

            if (!int.TryParse(eventIdString, out int eid))
            {
                MessageLbl.Text += "EVENT ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (!int.TryParse(userIdString, out int uid))
            {
                MessageLbl.Text += "USER ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (!int.TryParse(otherUserIdString, out int ouid))
            {
                MessageLbl.Text += "OTHER USER ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (name.Length >20)
            {
                MessageLbl.Text += "NAME SHOULD BE LESS THAN 20 CHARACTERS" + "<br />";
            }
            else if (desc.Length > 200)
            {
                MessageLbl.Text += "DESCRIPTION SHOULD BE LESS THAN 200 CHARACTERS" + "<br />";
            }
            else if (loc.Length > 200)
            {
                MessageLbl.Text += "LOCATION SHOULD BE LESS THAN 40 CHARACTERS" + "<br />";
            }
            else if (!DateTime.TryParseExact(reminder, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime reminder_time))
            {
                MessageLbl.Text += "REMINDER DATE FORMAT SHOULD BE dd-MM-yyyy HH:mm:ss" + "<br />";
            }
            else
            {
                SqlCommand createEventProc = new SqlCommand("CreateEvent", conn);
                createEventProc.CommandType = CommandType.StoredProcedure;

                createEventProc.Parameters.Add(new SqlParameter("@event_id", eid));
                createEventProc.Parameters.Add(new SqlParameter("@user_id", uid));
                createEventProc.Parameters.Add(new SqlParameter("@name", name));
                createEventProc.Parameters.Add(new SqlParameter("@description", desc));
                createEventProc.Parameters.Add(new SqlParameter("@location", loc));
                createEventProc.Parameters.Add(new SqlParameter("@reminder_date", reminder_time));
                createEventProc.Parameters.Add(new SqlParameter("@other_user_id", ouid));

                try
                {
                    conn.Open();
                    createEventProc.ExecuteNonQuery();

                    Response.Write("EVENT CREATED");
                }
                catch (SqlException sqlEx)
                {
                    MessageLbl.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    MessageLbl.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}