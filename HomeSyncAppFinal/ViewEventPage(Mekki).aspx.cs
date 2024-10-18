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
    public partial class ViewEventPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void viewEventBtn_Click(object sender, EventArgs e)
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
                SqlCommand viewEventProc = new SqlCommand("ViewEvent", conn);
                viewEventProc.CommandType = CommandType.StoredProcedure;

                if (eventIdText.Text != "")
                {
                    viewEventProc.Parameters.Add(new SqlParameter("@Event_id", eid));
                }
                else
                {
                    viewEventProc.Parameters.Add(new SqlParameter("@Event_id", 0));
                }

                viewEventProc.Parameters.Add(new SqlParameter("@User_id", uid));

                try
                {
                    conn.Open();

                    SqlDataReader rdr = viewEventProc.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        gridView.DataSource = rdr;
                        gridView.DataBind();
                    }
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