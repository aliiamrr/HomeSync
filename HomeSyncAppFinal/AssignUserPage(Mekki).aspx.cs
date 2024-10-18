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
    public partial class AssignUserPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AssignUserBtn_Click(object sender, EventArgs e)
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
                SqlCommand assignUserProc = new SqlCommand("AssignUser", conn);
                assignUserProc.CommandType = CommandType.StoredProcedure;

                assignUserProc.Parameters.Add(new SqlParameter("@Event_id", eid));
                assignUserProc.Parameters.Add(new SqlParameter("@User_id", uid));

                SqlParameter users_id = new SqlParameter("@users_id", SqlDbType.Int);

                users_id.Direction = ParameterDirection.Output;

                assignUserProc.Parameters.Add(users_id);

                try
                {
                    conn.Open();

                    SqlDataReader rdr = assignUserProc.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        gridView.DataSource = rdr;
                        gridView.DataBind();
                    }
                    MessageLbl.Text = "USER ASSIGNED";
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