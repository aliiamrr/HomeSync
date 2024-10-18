using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace HomeSyncAppFinal
{
    public partial class createPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void payment(object sender, EventArgs e)
        {
            Message11.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            int senderID = Convert.ToInt32(Session["UserID"]);
          
            String recIDString = receiverID.Text;
            String amount2String = amountPayment.Text;
            String status2 = paymentStatus.Text;
            String date2String = paymentDate.Text;
          
             if (!int.TryParse(recIDString, out int recID))
            {
                Message11.Text += "RECEIVER ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (!Double.TryParse(amount2String, out Double amount2))
            {
                Message11.Text += "AMOUNT SHOULD BE A NUMBER" + "<br />";
            }
            else if (status2.Length > 10)
            {
                Message11.Text += "STATUS SHOULD BE LESS THAN 10 CHARACTERS" + "<br />";
            }
            else if (status2.Length == 0)
            {
                Message11.Text += "STATUS FIELD IS EMPTY" + "<br />";
            }
            else if (!DateTime.TryParseExact(date2String, "dd-MM-yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime date2))
            {
                Message11.Text += "DEADLINE DATE FORMAT SHOULD BE dd-MM-yyyy" + "<br />";
            }
            else
            {
                
                SqlCommand makePaymentproc = new SqlCommand("PlanPayment", conn);
                makePaymentproc.CommandType = System.Data.CommandType.StoredProcedure;
                makePaymentproc.Parameters.Add(new SqlParameter("@sender_id", senderID));
                makePaymentproc.Parameters.Add(new SqlParameter("@receiver_id", recID));
                makePaymentproc.Parameters.Add(new SqlParameter("@amount", amount2));
                makePaymentproc.Parameters.Add(new SqlParameter("@status", status2));
                makePaymentproc.Parameters.Add(new SqlParameter("@deadline", date2));
                try
                {
                    conn.Open();
                    makePaymentproc.ExecuteNonQuery();
                    Response.Write("Payment Planned Successfully");
                }
                catch (SqlException sqlEx)
                {
                    Message11.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    Message11.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }
               
                
            }
        }
    }
}