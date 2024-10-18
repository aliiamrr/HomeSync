using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class main_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ReceiveTransaction(object sender, EventArgs e)
        {
            string redirectUrl = "~/receiveTransaction(MAM).aspx";

           
            Response.Redirect(redirectUrl);
        }
        protected void CreatePayment(object sender, EventArgs e)
        {
            string redirectUrl = "~/createPayment(MAM).aspx";


            Response.Redirect(redirectUrl);
        }
        protected void SendMessage(object sender, EventArgs e)
        {
            string redirectUrl = "~/sendMessage(MAM).aspx";


            Response.Redirect(redirectUrl);
        }
        protected void ShowMessages(object sender, EventArgs e)
        {
            string redirectUrl = "~/showMessages(MAM).aspx";


            Response.Redirect(redirectUrl);
        }
    }
}