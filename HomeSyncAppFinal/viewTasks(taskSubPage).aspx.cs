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
    public partial class viewTasks_taskSubPage_ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

         

            int userId = Convert.ToInt32(Session["UserID"]);
            SqlCommand ViewTask = new SqlCommand("ViewMyTask", conn);
            ViewTask.CommandType = System.Data.CommandType.StoredProcedure;
            ViewTask.Parameters.Add(new SqlParameter("@user_id", userId));
          

            try
            {
                conn.Open();
                SqlDataReader reader = ViewTask.ExecuteReader();
                if (reader.HasRows)
                {
                    TaskGridView.DataSource = reader;
                    TaskGridView.DataBind();
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
