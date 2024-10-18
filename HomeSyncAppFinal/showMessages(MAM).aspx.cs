using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class showMessages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ShowMsgs(object sender, EventArgs e)
        {
            Message44.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            int id1 = Convert.ToInt32(Session["UserID"]);
            SqlConnection conn = new SqlConnection(connstr);
            
            String id2String = senderID2.Text;
           
             if (!int.TryParse(id2String, out int id2))
            {
                Message44.Text += "Sender ID SHOULD BE A NUMBER" + "<br />";
            }
            else
            {
                SqlCommand showMsgproc = new SqlCommand("ShowMessages", conn);
                showMsgproc.CommandType = System.Data.CommandType.StoredProcedure;
                
                showMsgproc.Parameters.Add(new SqlParameter("@user_id", id1));
                showMsgproc.Parameters.Add(new SqlParameter("@sender_id", id2));
                DataTable dtMessages = new DataTable();
                try
                {
                    conn.Open();
                    using (SqlDataReader reader = showMsgproc.ExecuteReader())
                    {
                        dtMessages.Load(reader);
                    }
                    gridViewMessages.DataSource = dtMessages;
                    gridViewMessages.DataBind();
                }
                catch (SqlException sqlEx)
                {
                    Message44.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    Message44.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }


            }
        }
    }
}
