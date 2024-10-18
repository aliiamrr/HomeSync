using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncAppFinal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {
            ExceptionLabel.Text = "";
            MessageLabel.Text = "";

            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            //input
            string email = EmailBox.Text;
            string password = PasswordBox.Text;

            //Handling the insertion errors

            if (email.Length > 20)
            { ExceptionLabel.Text += "Exceeded Number of characters (20) (in E-Mail)" + "<br />"; }

            else if (email.Length == 0)
            { ExceptionLabel.Text += "The Email was not entered, Please try again! " + "<br />"; }

            else if (password.Length > 10)
            { ExceptionLabel.Text += "Exceeded Number of characters (10) (in Password)" + "<br />"; }

            else if (password.Length == 0)
            { ExceptionLabel.Text += "The Password was not entered,Please try again! " + "<br />"; }

            else
            {
                //procedure declaration

                //Login
                SqlCommand UserLogin = new SqlCommand("UserLogin", conn);
                UserLogin.CommandType = CommandType.StoredProcedure;
                UserLogin.Parameters.Add(new SqlParameter("@email", email));
                UserLogin.Parameters.Add(new SqlParameter("@password", password));
                SqlParameter success = new SqlParameter("@success", SqlDbType.Bit);
                SqlParameter id = new SqlParameter("@user_id", SqlDbType.Int);
                UserLogin.Parameters.Add(id);
                UserLogin.Parameters.Add(success);
                success.Direction = ParameterDirection.Output;
                id.Direction = ParameterDirection.Output;

                //get type

                SqlCommand getUserType = new SqlCommand("getUserType", conn);
                getUserType.CommandType = CommandType.StoredProcedure;
                getUserType.Parameters.Add(new SqlParameter("@email", email));
                getUserType.Parameters.Add(new SqlParameter("@password", password));
                SqlParameter type = new SqlParameter("@usertype", SqlDbType.VarChar, 20);
                type.Direction = ParameterDirection.Output;
                getUserType.Parameters.Add(type);




                try
                {
                    conn.Open();
                    UserLogin.ExecuteNonQuery();
                    //success.Value.ToString() == "1"
                    if (success.Value.ToString().Equals("True"))
                    {

                        getUserType.ExecuteNonQuery();

                        MessageLabel.Text = "LOGIN SUCCESSFUL : WELCOME TO HOMESYNC!";
                        //save the user id for later use


                        //check if its an admin/Guest for redirection
                        if (type.Value.ToString() == ("Guest"))
                        {
                            Session["UserID"] = Convert.ToInt32(id.Value);
                            Response.Redirect("GuestHome.aspx");
                        }
                        else if (type.Value.ToString() == ("Admin"))
                        {
                            Session["UserID"] = Convert.ToInt32(id.Value);
                            Response.Redirect("AdminHome.aspx");
                        }
                    }
                    else if (id.Value.ToString() == "-1")
                    {
                        MessageLabel.Text = "THIS USER IS DELETED FROM THE SYSTEM";

                    }
                    else
                    {
                        MessageLabel.Text = "LOGIN FAILED(THE EMAIL OR PASSWORD IS INCORRECT)";
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
                finally { conn.Close(); }
            }

        }

        protected void signUpRed(object sender, EventArgs e)
        {
            Response.Redirect("SignUp.aspx");
        }

        protected void EmailBox_TextChanged(object sender, EventArgs e)
        {

        }
    }
}