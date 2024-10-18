using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class Room : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr); ;

            SqlCommand cmd = new SqlCommand("ViewRoom", conn);

            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gridView.DataSource = dt;
            gridView.DataBind();
            
            SqlCommand dis = new SqlCommand("display", conn);
            int userId = Convert.ToInt32(Session["UserID"]);
            dis.CommandType = CommandType.StoredProcedure;
            dis.Parameters.Add(new SqlParameter("@user_id", userId));
            SqlDataAdapter db = new SqlDataAdapter(dis);
            DataTable de = new DataTable();
            db.Fill(de);
            gridView2.DataSource = de;
            gridView2.DataBind();
            
        }
        protected void DisplayAlert(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", script, true);
        }
        protected void Book(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);


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
                   gridView2.DataSource = de;
                   gridView2.DataBind();
                    DisplayAlert("ROOM BOOKED");
                    
                }
                catch
                {
                    DisplayAlert("ROOM ID OR USER ID INVALID OR ALREADY BOOKED");
                }
                finally
                {
                    conn.Close();
                }

            }
        }
        protected void sr(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            string userIdString = uid2.Text;
            string roomIdString = rid2.Text;
            string sdate = start.Text;
            string edate = end.Text;
            string act = action.Text;

            if (!int.TryParse(userIdString, out int id))
            {
                DisplayAlert("EVENT ID SHOULD BE A NUMBER");
            }
            else if (!int.TryParse(roomIdString, out int rid))
            {
                DisplayAlert("USER ID SHOULD BE A NUMBER");
            }
            else if (act.Length > 20)
            {
                DisplayAlert("NAME SHOULD BE LESS THAN 20 CHARACTERS");
            }
            else if (!DateTime.TryParseExact(sdate, "HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime s))
            {
                DisplayAlert("START TIME FORMAT SHOULD BE HH:mm:ss");
            }
            else if (!DateTime.TryParseExact(edate, "HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime en))
            {
                DisplayAlert("END TME FORMAT SHOULD BE HH:mm:ss");
            }
            else
            {

                SqlCommand sr = new SqlCommand("CreateSchedule", conn);
                sr.CommandType = CommandType.StoredProcedure;
                sr.Parameters.Add(new SqlParameter("@creator_id", id));
                sr.Parameters.Add(new SqlParameter("@room_id", rid));
                sr.Parameters.Add(new SqlParameter("@start_time", s));
                sr.Parameters.Add(new SqlParameter("@end_time", en));
                sr.Parameters.Add(new SqlParameter("@action", act));

                try
                {
                    conn.Open();
                    sr.ExecuteNonQuery();

                    DisplayAlert("SCHEDULE CREATED");
                }
                catch
                {
                    DisplayAlert("ROOM ID OR USER ID INVALID OR ALREADY SCHEDULED");
                }
                finally
                {
                    conn.Close();

                }



            }
        }
        protected void Change(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);


            string roomIdString = rid3.Text;
            string stat = status.Text;

             if (!int.TryParse(roomIdString, out int rid))
            {
                DisplayAlert("USER ID SHOULD BE A NUMBER");
            }
            else if (stat.Length > 40)
            {
                DisplayAlert("status SHOULD BE LESS THAN 40 CHARACTERS");
            }
            else {

                SqlCommand cr = new SqlCommand("RoomAvailability", conn);
                cr.CommandType = CommandType.StoredProcedure;
                cr.Parameters.Add(new SqlParameter("@location", rid));
                cr.Parameters.Add(new SqlParameter("@status", stat));
                try
                {
                    conn.Open();
                    cr.ExecuteNonQuery();

                    SqlCommand cmd2 = new SqlCommand("ViewRoom", conn);
                    cmd2.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
                    DataTable dt2 = new DataTable();
                    da2.Fill(dt2);
                    gridView.DataSource = dt2;
                    gridView.DataBind();
                    DisplayAlert("STATUS CHANGED");
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