using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web.Configuration;
using System.Web.UI;

namespace HomeSyncWebApp
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void signUp(object sender, EventArgs e)
        {
            // CLEAR PREVIOUS MESSAGES
            MessageLabel.Text = "";
            ExceptionLabel.Text = "";

            // GET THE CONNECTION STRING FROM THE CONFIGURATION FILE
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            // RETRIEVE USER INPUT FROM FORM FIELDS
            string usertype = TypeBox1.Text;
            string email = EmailBox.Text;
            string password = PasswordBox.Text;
            string first_name = FirstNameBox.Text;
            string last_name = LastNameBox.Text;
            DateTime birth_date;

            // LIST TO STORE VALIDATION ERRORS
            var validationErrors = new List<string>();

            // PERFORM VALIDATION CHECKS
            if (usertype.Length > 20)
                validationErrors.Add("EXCEEDED NUMBER OF CHARACTERS (20) (IN USERTYPE)");
            if (usertype.Length == 0)
                validationErrors.Add("USER TYPE WAS NOT ENTERED, PLEASE TRY AGAIN!");
            if (email.Length > 20)
                validationErrors.Add("EXCEEDED NUMBER OF CHARACTERS (20) (IN E-MAIL)");
            if (email.Length == 0)
                validationErrors.Add("THE EMAIL WAS NOT ENTERED, PLEASE TRY AGAIN!");
            if (password.Length > 10)
                validationErrors.Add("EXCEEDED NUMBER OF CHARACTERS (10) (IN PASSWORD)");
            if (password.Length == 0)
                validationErrors.Add("THE PASSWORD WAS NOT ENTERED, PLEASE TRY AGAIN!");
            if (first_name.Length > 20)
                validationErrors.Add("EXCEEDED NUMBER OF CHARACTERS (20) (IN FIRST NAME)");
            if (first_name.Length == 0)
                validationErrors.Add("THE FIRST NAME WAS NOT ENTERED, PLEASE TRY AGAIN!");
            if (last_name.Length > 20)
                validationErrors.Add("EXCEEDED NUMBER OF CHARACTERS (20) (IN LAST NAME)");
            if (last_name.Length == 0)
                validationErrors.Add("THE LAST NAME WAS NOT ENTERED, PLEASE TRY AGAIN!");
            if (!DateTime.TryParseExact(BirthDateBox.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out birth_date))
                validationErrors.Add("ERROR : INCORRECT DATE FORMAT");

            // IF THERE ARE VALIDATION ERRORS, DISPLAY THEM AND RETURN
            if (validationErrors.Any())
            {
                ExceptionLabel.Text = string.Join("<br />", validationErrors);
                return;
            }

            // CREATE A SQL COMMAND TO CALL THE STORED PROCEDURE FOR USER REGISTRATION
            SqlCommand UserRegister = new SqlCommand("UserRegister", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            UserRegister.Parameters.Add(new SqlParameter("@usertype", usertype));
            UserRegister.Parameters.Add(new SqlParameter("@email", email));
            UserRegister.Parameters.Add(new SqlParameter("@first_name", first_name));
            UserRegister.Parameters.Add(new SqlParameter("@last_name", last_name));
            UserRegister.Parameters.Add(new SqlParameter("@birth_date", birth_date));
            UserRegister.Parameters.Add(new SqlParameter("@password", password));
            SqlParameter user_id = new SqlParameter("@user_id", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };
            UserRegister.Parameters.Add(user_id);

            try
            {
                // OPEN THE CONNECTION AND EXECUTE THE COMMAND
                conn.Open();
                UserRegister.ExecuteNonQuery();
                Session["signUpId"] = user_id.Value;

                // CHECK THE RESULT OF THE STORED PROCEDURE
                if (user_id.Value.ToString().Equals("-1"))
                {
                    MessageLabel.Text = "A USER ALREADY HAS THIS E-MAIL. PLEASE TRY AGAIN!";
                }
                else
                {
                    MessageLabel.Text = "SIGN-UP SUCCESSFUL! YOUR USER ID IS : " + user_id.Value.ToString();
                    if (usertype.Equals("Admin"))
                        Response.Redirect("AdminSignUp.aspx");
                    else if (usertype.Equals("Guest"))
                        Response.Redirect("GuestSignUp.aspx");
                }
            }
            catch (SqlException sqlEx)
            {
                // HANDLE SQL EXCEPTIONS
                ExceptionLabel.Text += "ERROR : " + sqlEx.Message + "<br />";
            }
            catch (Exception ex)
            {
                // HANDLE GENERAL EXCEPTIONS
                ExceptionLabel.Text += "ERROR : " + ex.Message + "<br />";
            }
            finally
            {
                // CLOSE THE CONNECTION
                conn.Close();
            }
        }
    }
}

