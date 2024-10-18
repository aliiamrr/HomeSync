using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class deleteMsg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void DeleteMessage(object sender, EventArgs e)
        {
            Message55.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            SqlCommand deleteMsgproc = new SqlCommand("DeleteMsg", conn);
            deleteMsgproc.CommandType = System.Data.CommandType.StoredProcedure;
            try
            {


                conn.Open();
                deleteMsgproc.ExecuteNonQuery();
                Response.Write("Last Message was Successfully Deleted");
            }
            catch (SqlException sqlEx)
            {
                Message55.Text += "ERROR : " + sqlEx.Message + "<br />";
            }
            catch (Exception ex)
            {
                Message55.Text += "ERROR : " + ex.Message + "<br />";
            }
            finally
            {
                conn.Close();
            }
            
            
        }
    }
}