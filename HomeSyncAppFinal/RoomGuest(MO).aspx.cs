using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class RoomGuest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //new connection
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand dis = new SqlCommand("display", conn);
            int userId = Convert.ToInt32(Session["UserID"]);
            dis.CommandType = CommandType.StoredProcedure;
            dis.Parameters.Add(new SqlParameter("@user_id", userId));
            SqlDataAdapter db = new SqlDataAdapter(dis);
            DataTable de = new DataTable();
            db.Fill(de);
            gridView.DataSource = de;
            gridView.DataBind();



        }
        protected void DisplayAlert(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", script, true);
        }
        protected void Book2(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            string userIdString = uid.Text;
            string roomIdString = rid.Text;

            if (!int.TryParse(userIdString, out int id))
            {
                DisplayAlert("EVENT ID SHOULD BE A NUMBER");
            }
            else if (!int.TryParse(roomIdString, out int id2))
            {
                DisplayAlert("USER ID SHOULD BE A NUMBER");
            }
            else
            {


                SqlCommand bookroom = new SqlCommand("AssignRoom", conn);
                bookroom.CommandType = CommandType.StoredProcedure;
                bookroom.Parameters.Add(new SqlParameter("@user_id", id));
                bookroom.Parameters.Add(new SqlParameter("@room_id", id2));
                try
                {
                    conn.Open();
                    bookroom.ExecuteNonQuery();
                    SqlCommand dis = new SqlCommand("display", conn);
                    int userId = Convert.ToInt32(Session["UserID"]);
                    dis.CommandType = CommandType.StoredProcedure;
                    dis.Parameters.Add(new SqlParameter("@user_id", userId));
                    SqlDataAdapter db = new SqlDataAdapter(dis);
                    DataTable de = new DataTable();
                    db.Fill(de);
                    gridView.DataSource = de;
                    gridView.DataBind();
                    DisplayAlert("ROOM BOOKED");
                }
                catch
                {
                    DisplayAlert("ROOM ID OR USER ID INVALID");
                }
                finally
                {
                    conn.Close();
                }

            }
        }

    }
}