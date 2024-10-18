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
    public partial class AdminDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!IsPostBack)
            {
                BindDropDownList();
                DisplayTwoOutOfBattery();
                DisplayOutOfBatteryDevices();
            }
        }

        protected void BindDropDownList()
        {
            // NEW CONNECTION
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            using (SqlConnection connection = new SqlConnection(connstr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT device_id FROM Device", connection))
                {
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        // BIND DATA TO DROPDOWN LIST
                        ddlDevices.DataSource = reader;
                        ddlDevices.DataTextField = "device_id";
                        ddlDevices.DataValueField = "device_id";
                        ddlDevices.DataBind();
                    }
                    catch (SqlException sqlEx)
                    {
                        // HANDLE SQL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + sqlEx.Message + "<br />";
                    }
                    catch (Exception ex)
                    {
                        // HANDLE GENERAL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        // CLOSE CONNECTION
                        connection.Close();
                    }
                }
            }
        }

        protected void ddlDevices_SelectedIndexChanged(object sender, EventArgs e)
        {
            // NEW CONNECTION
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("ViewMyDeviceCharge", connection))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        int deviceId = Convert.ToInt32(ddlDevices.SelectedValue);
                        cmd.Parameters.AddWithValue("@device_id", deviceId);

                        // OUTPUT PARAMETERS
                        SqlParameter chargeParam = new SqlParameter("@charge", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(chargeParam);

                        SqlParameter locationParam = new SqlParameter("@loction", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(locationParam);

                        connection.Open();
                        cmd.ExecuteNonQuery();

                        // DISPLAY BATTERY STATUS
                        int charge = Convert.ToInt32(cmd.Parameters["@charge"].Value);
                        lblBatteryStatus.Text = "Battery percentage: " + charge;
                    }
                    catch (SqlException sqlEx)
                    {
                        // HANDLE SQL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + sqlEx.Message + "<br />";
                    }
                    catch (Exception ex)
                    {
                        // HANDLE GENERAL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        // CLOSE CONNECTION
                        connection.Close();
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // CLEAR PREVIOUS MESSAGES
            MessageLabelAdd.Text = "";
            ExceptionLabelAdd.Text = "";

            // NEW CONNECTION
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            // RETRIEVE USER INPUT FROM FORM FIELDS
            string deviceIdString = TextBox1.Text;
            string batteryStatusString = TextBox3.Text;
            string deviceLocationString = TextBox4.Text;
            string status = TextBox2.Text;
            string deviceType = TextBox5.Text;

            // VALIDATION CHECKS
            if (deviceIdString == "")
            {
                ExceptionLabelAdd.Text += "Please enter a device ID!" + "<br />";
            }
            else if (batteryStatusString == "")
            {
                ExceptionLabelAdd.Text += "Please enter the device's battery!" + "<br />";
            }
            else if (deviceLocationString == "")
            {
                ExceptionLabelAdd.Text += "Please enter the device's location!" + "<br />";
            }
            else if (status == "")
            {
                ExceptionLabelAdd.Text += "Please enter the device's status!" + "<br />";
            }
            else if (deviceType == "")
            {
                ExceptionLabelAdd.Text += "Please enter the device's type!" + "<br />";
            }
            else if (!int.TryParse(deviceIdString, out int r))
            {
                ExceptionLabelAdd.Text += "Device ID should be a number!" + "<br />";
            }
            else if (!int.TryParse(batteryStatusString, out r))
            {
                ExceptionLabelAdd.Text += "Battery status should be a number!" + "<br />";
            }
            else if (!int.TryParse(deviceLocationString, out r))
            {
                ExceptionLabelAdd.Text += "Device location should be a number!" + "<br />";
            }
            else if (status.Length > 20)
            {
                ExceptionLabelAdd.Text += "Exceeded number of characters (20) (in status)" + "<br />";
            }
            else if (deviceType.Length > 20)
            {
                ExceptionLabelAdd.Text += "Exceeded number of characters (20) (in device type)" + "<br />";
            }
            else
            {
                int deviceId = Convert.ToInt32(deviceIdString);
                int batteryStatus = Convert.ToInt32(batteryStatusString);
                int location = Convert.ToInt32(deviceLocationString);
                int existingDeviceCount = 0;
                int existingRoomCount = 0;

                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    try
                    {
                        connection.Open();

                        // CHECK IF DEVICE ID ALREADY EXISTS
                        using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Device WHERE device_id = @device_id", connection))
                        {
                            checkCmd.Parameters.AddWithValue("@device_id", deviceId);
                            existingDeviceCount = (int)checkCmd.ExecuteScalar();
                        }

                        // CHECK IF ROOM EXISTS
                        using (SqlCommand checkRoom = new SqlCommand("SELECT COUNT(*) FROM Room WHERE room_id = @location", connection))
                        {
                            checkRoom.Parameters.AddWithValue("@location", location);
                            existingRoomCount = (int)checkRoom.ExecuteScalar();
                        }

                        if (existingDeviceCount > 0)
                        {
                            MessageLabelAdd.Text += "This device ID already exists, please use another one.";
                        }
                        else if (existingRoomCount == 0)
                        {
                            MessageLabelAdd.Text += "This location does not exist, please enter a valid one.";
                        }
                        else
                        {
                            // ADD NEW DEVICE
                            using (SqlCommand cmd = new SqlCommand("AddDevice", connection))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.AddWithValue("@device_id", deviceId);
                                cmd.Parameters.AddWithValue("@status", status);
                                cmd.Parameters.AddWithValue("@battery", batteryStatus);
                                cmd.Parameters.AddWithValue("@location", location);
                                cmd.Parameters.AddWithValue("@type", deviceType);

                                cmd.ExecuteNonQuery();

                                MessageLabelAdd.Text = "Device added!";
                            }
                        }
                    }
                    catch (SqlException sqlEx)
                    {
                        // HANDLE SQL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + sqlEx.Message + "<br />";
                    }
                    catch (Exception ex)
                    {
                        // HANDLE GENERAL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        // CLOSE CONNECTION
                        connection.Close();
                    }
                }
            }
        }

        protected void DisplayOutOfBatteryDevices()
        {
            // NEW CONNECTION
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            using (SqlConnection connection = new SqlConnection(connstr))
            {
                using (SqlCommand cmd = new SqlCommand("OutOfBattery", connection))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        connection.Open();

                        // DISPLAY OUT OF BATTERY DEVICES
                        SqlDataReader reader = cmd.ExecuteReader();

                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    catch (SqlException sqlEx)
                    {
                        // HANDLE SQL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + sqlEx.Message + "<br />";
                    }
                    catch (Exception ex)
                    {
                        // HANDLE GENERAL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        // CLOSE CONNECTION
                        connection.Close();
                    }
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // NEW CONNECTION
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            using (SqlConnection connection = new SqlConnection(connstr))
            {
                using (SqlCommand cmd = new SqlCommand("Charging", connection))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        connection.Open();
                        cmd.ExecuteNonQuery();

                        Response.Write("Charging devices!");
                    }
                    catch (SqlException sqlEx)
                    {
                        // HANDLE SQL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + sqlEx.Message + "<br />";
                    }
                    catch (Exception ex)
                    {
                        // HANDLE GENERAL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        // CLOSE CONNECTION
                        connection.Close();
                    }
                }
            }
        }

        protected void DisplayTwoOutOfBattery()
        {
            // NEW CONNECTION
            string connstr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            using (SqlConnection connection = new SqlConnection(connstr))
            {
                using (SqlCommand cmd = new SqlCommand("NeedCharge", connection))
                {
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        connection.Open();

                        // DISPLAY DEVICES THAT NEED CHARGING
                        SqlDataReader reader = cmd.ExecuteReader();

                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                    }
                    catch (SqlException sqlEx)
                    {
                        // HANDLE SQL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + sqlEx.Message + "<br />";
                    }
                    catch (Exception ex)
                    {
                        // HANDLE GENERAL EXCEPTIONS
                        ExceptionLabelAdd.Text += "ERROR : " + ex.Message + "<br />";
                    }
                    finally
                    {
                        // CLOSE CONNECTION
                        connection.Close();
                    }
                }
            }
        }
    }
}
