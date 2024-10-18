using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class sendMessage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SendMsg(object sender, EventArgs e)
        {
            Message33.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            int senderMsgId = Convert.ToInt32(Session["UserID"]);
            String receiverMsgIdString = receiverIDMsg.Text;
            String title1 = titleMsg.Text;
            String content1 = contentMsg.Text;
            DateTime timeSent = DateTime.Now;
            DateTime timeReceived = DateTime.Now;
          
             if (!int.TryParse(receiverMsgIdString, out int receiverMsgId))
            {
                Message33.Text += "RECEIVER ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (title1.Length > 30)
            {
                Message33.Text += "TITLE SHOULD BE LESS THAN 30 CHARACTERS" + "<br />";
            }
            else if (title1.Length == 0)
            {
                Message33.Text += "TITLE FIELD IS EMPTY" + "<br />";
            }
            else if (content1.Length > 200)
            {
                Message33.Text += "CONTENT SHOULD BE LESS THAN 200 CHARACTERS" + "<br />";
            }
            else if (content1.Length ==0)
            {
                Message33.Text += "CONTENT FIELD IS EMPTY" + "<br />";
            }
            else
            {
                SqlCommand sendMsgproc = new SqlCommand("SendMessage", conn);
                sendMsgproc.CommandType = System.Data.CommandType.StoredProcedure;
                sendMsgproc.Parameters.Add(new SqlParameter("@sender_id", senderMsgId));
                sendMsgproc.Parameters.Add(new SqlParameter("@receiver_id", receiverMsgId));
                sendMsgproc.Parameters.Add(new SqlParameter("@title", title1));
                sendMsgproc.Parameters.Add(new SqlParameter("@content", content1));
                sendMsgproc.Parameters.Add(new SqlParameter("@timesent", timeSent));
                sendMsgproc.Parameters.Add(new SqlParameter("@timereceived", timeReceived));
                try
                {
                    conn.Open();
                    sendMsgproc.ExecuteNonQuery();
                    Response.Write("Message Sent Successfully");
                }
                catch (SqlException sqlEx)
                {
                    Message33.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    Message33.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }

              

                
            }
        }
    }
}