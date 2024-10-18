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
    public partial class AdminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            int userId = Convert.ToInt32(Session["UserID"]);
            SqlCommand ViewProfile = new SqlCommand("ViewProfile", conn);
            ViewProfile.CommandType = System.Data.CommandType.StoredProcedure;
            ViewProfile.Parameters.Add(new SqlParameter("@user_id", userId));

            conn.Open();
            SqlDataReader reader = ViewProfile.ExecuteReader();
            if (reader.HasRows)
            {
                UserProfileGridView.DataSource = reader;
                UserProfileGridView.DataBind();
            }

            conn.Close();
        }

        //MO GAD
        protected void goToAdminRoom(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMISSION
            Response.Redirect("Room(MO).aspx");

        }
        protected void goToAdminTask(object sender, EventArgs e)
        {
            Response.Redirect("Tasks.aspx");
        }
        //MEKKI
        protected void goToAdminEvent(object sender, EventArgs e)
        {
            //Response.Redirect("your page");
            // ADDED AFTER SUBMISSION
            Response.Redirect("AdminHomePageEvents(Mekki).aspx");
        }
        //HUSSEIN
        protected void goToAdminDevice(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMISSION
            Response.Redirect("AdminDevice(Hussein).aspx");
        }

        //MAMDOUH
        protected void goToAdminFAndC(object sender, EventArgs e)
        {
            //Response.Redirect("your page");

            //ADDED AFTER SUBMISSION
            Response.Redirect("adminCommFin(MAM).aspx");

        }

        //signout
        protected void signOut(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void removeGuestBtn_Click(object sender, EventArgs e)
        {
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);


            MessageLbl.Text = "";

            string guestID = guestIdRemove.Text;
            string adminID = adminIdRemove.Text;

            if (!int.TryParse(adminID, out int aid))
            {
                MessageLbl.Text += "ADMIN ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (!int.TryParse(guestID, out int gid))
            {
                MessageLbl.Text += "GUEST ID SHOULD BE A NUMBER" + "<br />";
            }
            else
            {
                SqlCommand guestRemoveProc = new SqlCommand("GuestRemove", conn);
                guestRemoveProc.CommandType = CommandType.StoredProcedure;

                guestRemoveProc.Parameters.Add(new SqlParameter("@admin_id", aid));
                guestRemoveProc.Parameters.Add(new SqlParameter("@guest_id", gid));

                SqlParameter no_of_guests_allowed = new SqlParameter("@number_of_allowed_guests", SqlDbType.Int);

                no_of_guests_allowed.Direction = ParameterDirection.Output;

                guestRemoveProc.Parameters.Add(no_of_guests_allowed);

                try
                {
                    conn.Open();
                    guestRemoveProc.ExecuteNonQuery();

                    int output = (int)no_of_guests_allowed.Value;
                    MessageLbl.Text = "Number of guests allowed: " + output;
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


        protected void addGuest123(object sender, EventArgs e)
        {
            ErrorMessagesAddGuest.Text = "";
            MessageAddGuestR.Text = "";

            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            String emailGuest11 = emailGuest1.Text;
            String addressGuest11 = addressGuest1.Text;
            String passwordGuest11 = passwordGuest1.Text;
            String firstName11 = firstName1.Text;
            string adminIDGuest11String = adminIDGuest1.Text;
            string roomIDGuest11String = roomIDGuest1.Text;
            if (!int.TryParse(adminIDGuest11String, out int adminIDGuest11))
            {
                ErrorMessagesAddGuest.Text += "GUEST OF ID SHOULD BE A NUMBER" + "<br />";
            }
            else if (!int.TryParse(roomIDGuest11String, out int roomIDGuest11))
            {
                ErrorMessagesAddGuest.Text += "ROOM ID SHOULD BE A NUMBER" + "<br />";
            }

            else if (emailGuest11.Length > 30)
            {
                ErrorMessagesAddGuest.Text += "EMAIL SHOULD BE LESS THAN 30 CHARACTERS" + "<br />";
            }
            else if (firstName11.Length > 10)
            {
                ErrorMessagesAddGuest.Text += "FIRST NAME SHOULD BE LESS THAN 10 CHARACTERS" + "<br />";
            }
            else if (addressGuest11.Length > 30)
            {
                ErrorMessagesAddGuest.Text += "ADDRESS SHOULD BE LESS THAN 30 CHARACTERS" + "<br />";
            }
            else if (passwordGuest11.Length > 30)
            {
                ErrorMessagesAddGuest.Text += "PASSWORD SHOULD BE LESS THAN 30 CHARACTERS" + "<br />";
            }
            else if (emailGuest11.Length == 0)
            {
                ErrorMessagesAddGuest.Text += "EMAIL FIELD IS EMPTY" + "<br />";
            }
            else if (firstName11.Length == 0)
            {
                ErrorMessagesAddGuest.Text += "FIRST NAME FIELD IS EMPTY" + "<br />";
            }
            else if (addressGuest11.Length == 0)
            {
                ErrorMessagesAddGuest.Text += "ADDRESS FIELD IS EMPTY" + "<br />";
            }
            else if (passwordGuest11.Length == 0)
            {
                ErrorMessagesAddGuest.Text += "PASSWORD FIELD IS EMPTY" + "<br />";
            }
            else
            {

                SqlCommand addGuestProc = new SqlCommand("AddGuest", conn);
                addGuestProc.CommandType = System.Data.CommandType.StoredProcedure;
                addGuestProc.Parameters.Add(new SqlParameter("@email", emailGuest11));
                addGuestProc.Parameters.Add(new SqlParameter("@first_name", firstName11));
                addGuestProc.Parameters.Add(new SqlParameter("@address", addressGuest11));
                addGuestProc.Parameters.Add(new SqlParameter("@password", passwordGuest11));
                addGuestProc.Parameters.Add(new SqlParameter("@guest_of", adminIDGuest11));
                addGuestProc.Parameters.Add(new SqlParameter("@room_id", roomIDGuest11));
                SqlParameter no_of_guests_allowed = new SqlParameter("@number_of_allowed_guests", SqlDbType.Int);

                no_of_guests_allowed.Direction = ParameterDirection.Output;

                addGuestProc.Parameters.Add(no_of_guests_allowed);

                try
                {
                    conn.Open();
                    addGuestProc.ExecuteNonQuery();
                    Response.Write("Guest Added Successfully");
                    int output = (int)no_of_guests_allowed.Value;
                    MessageAddGuestR.Text += "Number of Guests allowed is: " + output;
                }
                catch (SqlException sqlEx)
                {
                    ErrorMessagesAddGuest.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    ErrorMessagesAddGuest.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }


            }

        }



            protected void setGuests(object sender, EventArgs e)
        {
            MessageLabel.Text = "";

            //new connection
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
           // SqlConnection conn = new SqlConnection(connstr);
            string adminIdString = TextBox1.Text;
            string numberGuestsString = TextBox2.Text;

            if (adminIdString.Length == 0)
            {
                MessageLabel.Text += "Please enter the admin's ID!" + "<br />";
            }
            else if (!int.TryParse(adminIdString, out int adminId))
            {
                MessageLabel.Text += "Admin's ID should be a number!" + "<br />";
            }
            else if (numberGuestsString.Length == 0)
            {
                MessageLabel.Text += "Please enter the number of guests allowed!" + "<br />";
            }
            else if (!int.TryParse(numberGuestsString, out int numberGuests))
            {
                MessageLabel.Text += "Number of guests allowed should be a number!" + "<br />";
            }
            else if (numberGuests < 0)
            {
                MessageLabel.Text += "Please enter a valid number!" + "<br />";
            }
            else
            {
                int existingAdminCount = 0;
                using (SqlConnection conn = new SqlConnection(connstr))
                {
                    try
                    {
                        conn.Open();

                        using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Admin WHERE admin_id = @adminID", conn))
                        {
                            checkCmd.Parameters.AddWithValue("@adminID", adminId);
                            existingAdminCount = (int)checkCmd.ExecuteScalar();
                        }

                        if (existingAdminCount < 1)
                        {
                            MessageLabel.Text += "This admin does not exist!" + "<br />";
                        }
                        else
                        {
                            using (SqlCommand checkCmd = new SqlCommand("GuestsAllowed", conn))
                            {
                                checkCmd.CommandType = CommandType.StoredProcedure;

                                checkCmd.Parameters.AddWithValue("@admin_id", adminId);
                                checkCmd.Parameters.AddWithValue("@number_of_guests", numberGuests);

                                checkCmd.ExecuteNonQuery();

                                MessageLabel.Text += "Number of guests allowed for this admin is set!";
                            }
                        }
                    }
                    catch (SqlException sqlEx)
                    {
                        MessageLabel.Text += "ERROR: " + sqlEx.Message + " <br />";
                    }
                    catch (Exception ex)
                    {
                        MessageLabel.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }



        protected void NumberOfGuests1(object sender, EventArgs e)
        {
            ErrorMessagesNoOfGuests.Text = "";
            noOfGuests12.Text = "";

            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connstr);

            String adminID221String = adminID221.Text;

            if (!int.TryParse(adminID221String, out int adminID2211))
            {
                ErrorMessagesNoOfGuests.Text += "ADMIN ID SHOULD BE A NUMBER" + "<br />";
            }

            else
            {

                SqlCommand guestNoProc = new SqlCommand("GuestNumber", conn);
                guestNoProc.CommandType = System.Data.CommandType.StoredProcedure;
                guestNoProc.Parameters.Add(new SqlParameter("@admin_id", adminID2211));

                SqlParameter no_of_guests = new SqlParameter("@no_of_guests", SqlDbType.Int);

                no_of_guests.Direction = ParameterDirection.Output;

                guestNoProc.Parameters.Add(no_of_guests);

                try
                {
                    conn.Open();
                    guestNoProc.ExecuteNonQuery();

                    int output1 = (int)no_of_guests.Value;
                    noOfGuests12.Text += "Number of Guests assigned to this admin is: " + output1;
                }
                catch (SqlException sqlEx)
                {
                    ErrorMessagesNoOfGuests.Text += "ERROR : " + sqlEx.Message + "<br />";
                }
                catch (Exception ex)
                {
                    ErrorMessagesNoOfGuests.Text += "ERROR : " + ex.Message + "<br />";
                }
                finally
                {
                    conn.Close();
                }


            }
        }

    }
}
