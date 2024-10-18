using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace HomeSyncAppFinal
{
    public partial class AdminSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signUpAdmin(object sender, EventArgs e)
        {
            MessageLabel.Text = "";
            ExceptionLabel.Text = "";

            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            //Admin Parameters

            //string no_of_guests_allowed = NumOfGuestsAllowedTextBox.Text;
            // string salary = SalaryTextBox.Text;
            int numOfGuestsIntForm;
            decimal salaryDecimalForm;

            //CHECK ADMIN PARAMETERS
            /*if (no_of_guests_allowed.Length == 0)
            { ExceptionLabel.Text += "The Number of Guests allowed was not entered, Please try again" + "<br />"; return; }
            else if (salary.Length == 0)
            { ExceptionLabel.Text += "The salary was not entered, Please try again " + " < br />"; return; }
            else if (salary.Length > 10)
            { ExceptionLabel.Text += "Exceeded Number limit (10) (in Salary)" + "<br />"; return; }
            else if (salary.Contains('.') && salary.Length - salary.IndexOf('.') > 3)
            { ExceptionLabel.Text += "Only 2 Decimal Places are allowed in Salary" + "<br />"; return; }
            */


            SqlCommand addAdmin = new SqlCommand("addAdmin", conn);
            addAdmin.CommandType = CommandType.StoredProcedure;


            if (int.TryParse(NumOfGuestsAllowedTextBox.Text, out numOfGuestsIntForm))
            {
                addAdmin.Parameters.Add(new SqlParameter("no_of_guests_allowed", numOfGuestsIntForm));
                Debug.WriteLine("I added the num of guests");
            }
            else
            {
                ExceptionLabel.Text += "Invalid value for Number of Guests Allowed.(INT)" + "<br />";
                return;
            }
            if (decimal.TryParse(SalaryTextBox.Text, out salaryDecimalForm))
            {
                if (GetDecimalPlaces(salaryDecimalForm) > 2)
                {
                    ExceptionLabel.Text += "Invalid value for Salary (Decimal(10,2))." + "<br />";
                    return;
                }
                else
                {

                    addAdmin.Parameters.Add(new SqlParameter("@salary", salaryDecimalForm));
                    Debug.WriteLine("I added the salary");
                }

            }
            else
            {
                ExceptionLabel.Text += "Invalid value for Salary (Decimal(10,2))." + "<br />";
                return;
            }


             int id = (int)Session["signUpId"];
             addAdmin.Parameters.Add(new SqlParameter("@admin_id", id));
            

            try
            {
                conn.Open();
                addAdmin.ExecuteNonQuery();
                Response.Redirect("Login.aspx");
            }

            catch (SqlException sqlEx)
            {
                Debug.WriteLine("SQL Exception: " + sqlEx.Message);
                ExceptionLabel.Text += "ERROR : " + sqlEx.Message + "<br />";

            }
            catch (Exception ex)
            {
                Debug.WriteLine("General Exception: " + ex.Message);
                ExceptionLabel.Text += "ERROR : " + ex.Message + "<br />";
            }
            finally
            {
                conn.Close();
            }
        }

        //check the number of decimal places
        public static int GetDecimalPlaces(decimal value)
        {
            decimal fractionalPart = value - decimal.Truncate(value);
            int decimalPlaces = BitConverter.GetBytes(decimal.GetBits(fractionalPart)[3])[2];
            return decimalPlaces;
        }

    }
}