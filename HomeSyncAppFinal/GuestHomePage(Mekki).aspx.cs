using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class GuestHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateEventBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateEventPage.aspx");
        }

        protected void ViewEventBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewEventPage.aspx");
        }

        protected void AssignUserBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("AssignUserPage.aspx");
        }

        protected void UninviteUserBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("UninviteUserPage.aspx");
        }
    }
}