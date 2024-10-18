using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class RemoveEventPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RemoveEventBtn_Click(object sender, EventArgs e)
        {
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            MessageLbl.Text = "";

            string eventIdString = eventIdText.Text;
            string userIdString = userIdText.Text;

            if (!int.TryParse(eventIdString, out int eid))
            {
                MessageLbl.Text += "EVENT ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (!int.TryParse(userIdString, out int uid))
            {
                MessageLbl.Text += "USER ID SHOULD BE A NUMBER" + "<br />";
            }
            else
            {
                SqlCommand removeEventProc = new SqlCommand("RemoveEvent", conn);
                removeEventProc.CommandType = CommandType.StoredProcedure;

                removeEventProc.Parameters.Add(new SqlParameter("@event_id", eid));
                removeEventProc.Parameters.Add(new SqlParameter("@user_id", uid));

                try
                {
                    conn.Open();
                    removeEventProc.ExecuteNonQuery();

                    MessageLbl.Text = "EVENT REMOVED";
                }
                catch (SqlException sqlEx)
                {
                    MessageLbl.Text += "ERROR: " + sqlEx.Message + "<br />";
                }
                catch (Exception Ex)
                {
                    MessageLbl.Text += "ERROR: " + Ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}