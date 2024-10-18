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
    public partial class taskStatus_taskSubPage_ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ExceptionLabel.Text = "";

            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            int creatorId = Convert.ToInt32(Session["taskCreatorID"]);
            int userID= Convert.ToInt32(Session["UserID"]);

            SqlCommand ViewTask = new SqlCommand("ViewTask", conn);
            ViewTask.CommandType = System.Data.CommandType.StoredProcedure;
             
            ViewTask.Parameters.Add(new SqlParameter("@creator", creatorId));
            ViewTask.Parameters.Add(new SqlParameter("@user_id", userID));
            try
            {
                conn.Open();
                SqlDataReader reader = ViewTask.ExecuteReader();
                if (reader.Read())
                {
                    taskStatusGridView.DataSource = reader;
                    taskStatusGridView.DataBind();

                }
            }
            catch (SqlException sqlEx)
            {
                ExceptionLabel.Text += "ERROR : " + sqlEx.Message + "<br />";
            }
            catch (Exception ex)
            {
                ExceptionLabel.Text += "ERROR : " + ex.Message + "<br />";
            }
            finally
            {
                conn.Close();
            }

        }
        protected void returnBack(object sender, EventArgs e)
        {
            Response.Redirect("Tasks.aspx");
        }

    }
}
