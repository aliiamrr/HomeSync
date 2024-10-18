using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class Tasks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void viewTasks(object sender, EventArgs e)
        {
            Response.Redirect("viewTasks(taskSubPage).aspx");
        }
        protected void finishTask(object sender, EventArgs e)
        {

            ExceptionLabel1.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            String title = TitleBox.Text;
            if (title.Length > 50)
                ExceptionLabel1.Text += "Exceeded Number of characters (50) (in Title)" + "<br />";
            else if (title.Length == 0)
                ExceptionLabel1.Text = "The title was not entered , Please try again" + "<br />";

            else
            {
                //REMOVE TO RETRIEVE THE USER ID FROM LOGIN WHEN TESTING
                 int userId = Convert.ToInt32(Session["UserID"]);
                SqlCommand FinishMyTask = new SqlCommand("FinishMyTask", conn);
                FinishMyTask.CommandType = System.Data.CommandType.StoredProcedure;
                
                FinishMyTask.Parameters.Add(new SqlParameter("@user_id", userId));
                FinishMyTask.Parameters.Add(new SqlParameter("@title", title));
                try
                {
                    //execution
                    conn.Open();
                    FinishMyTask.ExecuteNonQuery();
                }
                catch (SqlException sqlEx)
                {
                    ExceptionLabel1.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    ExceptionLabel1.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }
            }

        }

        protected void viewStatus(object sender, EventArgs e)
        {
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            string creatorId = CreatorBox.Text;
            //REMOVE TO ADD  THE CREATOR ID AS AN INPPUT WHEN TESTING
               if (creatorId.Length ==0)
                   ExceptionLabel4.Text = "The creator Id was not entered , Please try again"+  "<br />";
               else {
                   Session["taskCreatorID"] = creatorId;
                   Response.Redirect("taskStatus(taskSubPage).aspx");
               }
            

          ;

        }

        protected void addReminder(object sender, EventArgs e)
        {
          
            ExceptionLabel2.Text = "";
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            string format = "MM/dd/yyyy hh:mm:ss tt";

            // int task_id = Convert.ToInt32(ReminderTaskIDBox1.Text);


            string task_id = ReminderTaskIDBox1.Text;
            DateTime reminder;
            if (task_id.Length == 0)
            { ExceptionLabel2.Text += "the Task ID was not entered , Please try again" + "<br />"; }
            /* else if (!DateTime.TryParseExact(DeadlineBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out reminder))
             { ExceptionLabel2.Text += "ERROR : Incorrect Date Format" + "<br />"; }
             //else if (!DateTime.TryParse(DeadlineBox.Text, out reminder))
             // { ExceptionLabel3.Text += "ERROR : Incorrect Date Format" + "<br />"; }

            /* else if (!DateTime.TryParseExact(DeadlineBox.Text, "MM/dd/yyyy hh:mm:ss tt", CultureInfo.InvariantCulture, DateTimeStyles.None, out reminder))
             {
                 ExceptionLabel3.Text += "ERROR: Incorrect Date Format" + "<br />";
             }*/
            else if (!DateTime.TryParseExact(DeadlineBox.Text, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out reminder))
            {
                ExceptionLabel3.Text += "ERROR: Incorrect Date Format. Please enter the date in the format MM/dd/yyyy hh:mm:ss AM/PM" + "<br />";
            }
            else
            {
                SqlCommand AddReminder = new SqlCommand("AddReminder", conn);
                AddReminder.CommandType = System.Data.CommandType.StoredProcedure;
                AddReminder.Parameters.Add(new SqlParameter("@task_id", Convert.ToInt32(task_id)));
                AddReminder.Parameters.Add(new SqlParameter("@reminder", reminder));
                try
                {
                    //execution
                    conn.Open();
                    AddReminder.ExecuteNonQuery();
                }
                catch (SqlException sqlEx)
                {
                    ExceptionLabel2.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    ExceptionLabel2.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }

            }


        }

        protected void updateDeadline(object sender, EventArgs e)
        {

            ExceptionLabel3.Text = "";
           
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);
            string format = "MM/dd/yyyy hh:mm:ss tt";
            // task_id =Convert.ToInt32( DeadlineTaskIdBox2.Text);
            string task_id = DeadlineTaskIdBox2.Text;
            DateTime deadline;
            if (task_id.Length == 0)
            { ExceptionLabel3.Text += "the Task ID was not entered , Please try again" + "<br />"; }
            /*  else if (!DateTime.TryParseExact(DeadlineBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out deadline))
              { ExceptionLabel3.Text += "ERROR : Incorrect Date Format" + "<br />"; }
              */

            /*else if (!DateTime.TryParse(DeadlineBox.Text, out deadline))
             { ExceptionLabel3.Text += "ERROR : Incorrect Date Format" + "<br />"; }
            */
            /*    else if (!DateTime.TryParseExact(DeadlineBox.Text, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out deadline))

                    ExceptionLabel3.Text += "ERROR: Incorrect Date Format" + "<br />";
                }
            */
            else if (!DateTime.TryParseExact(DeadlineBox.Text, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out deadline))
            {
                ExceptionLabel3.Text += "ERROR: Incorrect Date Format. Please enter the date in the format MM/dd/yyyy hh:mm:ss AM/PM" + "<br />";
            }
            else
            {
               
                SqlCommand UpdateTaskDeadline = new SqlCommand("UpdateTaskDeadline", conn);
                UpdateTaskDeadline.CommandType = System.Data.CommandType.StoredProcedure;
                UpdateTaskDeadline.Parameters.Add(new SqlParameter("@deadline", deadline));
                UpdateTaskDeadline.Parameters.Add(new SqlParameter("@task_id", Convert.ToInt32(task_id)));

                try
                {
                    //execution
                    conn.Open();
                    UpdateTaskDeadline.ExecuteNonQuery();
                }
                catch (SqlException sqlEx)
                {
                    ExceptionLabel3.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    ExceptionLabel3.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }

            }
        }

    }
}