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
    public partial class receiveTransaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ReceiveT(object sender, EventArgs e)
        {
            Message22.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            String idString = senderID.Text;
            String typeT = type.Text;
            String amount1String = amount.Text;
            String status1 = status.Text;
            String dateString = transactionDate.Text;
            if (!int.TryParse(idString, out int id))
            {
                Message22.Text += "SENDER ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (typeT.Length > 30)
            {
                Message22.Text += "TYPE SHOULD BE LESS THAN 30 CHARACTERS" + "<br />";
            }
            else if (typeT.Length ==0)
            {
                Message22.Text += "TYPE FIELD IS EMPTY" + "<br />";
            }
            else if (!Double.TryParse(amount1String, out Double amount1))
            {
                Message22.Text += "AMOUNT SHOULD BE A NUMBER" + "<br />";
            }
            else if (status1.Length > 10)
            {
                Message22.Text += "STATUS SHOULD BE LESS THAN 10 CHARACTERS" + "<br />";
            }
            else if (status1.Length ==0)
            {
                Message22.Text += "STATUS FIELD IS EMPTY" + "<br />";
            }
            else if (!DateTime.TryParseExact(dateString, "dd-MM-yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime date))
            {
                Message22.Text += "DATE FORMAT SHOULD BE dd-MM-yyyy" + "<br />";
            }
            else
            {
                SqlCommand receiveTproc = new SqlCommand("ReceiveMoney", conn);
                receiveTproc.CommandType = System.Data.CommandType.StoredProcedure;
                receiveTproc.Parameters.Add(new SqlParameter("@receiver_id", id));
                receiveTproc.Parameters.Add(new SqlParameter("@type", typeT));
                receiveTproc.Parameters.Add(new SqlParameter("@amount", amount1));
                receiveTproc.Parameters.Add(new SqlParameter("@status", status1));
                receiveTproc.Parameters.Add(new SqlParameter("@date", date));
                try
                {
                    conn.Open();
                    receiveTproc.ExecuteNonQuery();
                    Response.Write("Transaction Received Successfully");
                    conn.Close();
                }
                catch (SqlException sqlEx)
                {
                    Message22.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    Message22.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }

            }
        }
    }
}