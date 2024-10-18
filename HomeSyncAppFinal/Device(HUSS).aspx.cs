using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace HomeSyncAppFinal
{
    public partial class Device : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindDropDownList();
        }

        protected void BindDropDownList()
        {
            if (!IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
                using (SqlConnection connection = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT device_id FROM Device", connection))
                    {
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        ddlDevices.DataSource = reader;
                        ddlDevices.DataTextField = "device_id";
                        ddlDevices.DataValueField = "device_id";
                        ddlDevices.DataBind();
                    }
                }
            }
        }

        protected void ddlDevices_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("ViewMyDeviceCharge", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Convert ddlDevices.SelectedValue to the appropriate data type (e.g., int)
                    int deviceId;
                    if (int.TryParse(ddlDevices.SelectedValue, out deviceId))
                    {
                        // Add the @device_id parameter
                        cmd.Parameters.AddWithValue("@device_id", deviceId);

                        // Add the @charge output parameter
                        SqlParameter chargeParam = new SqlParameter("@charge", SqlDbType.Int);
                        chargeParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(chargeParam);

                        // Add the @location output parameter
                        SqlParameter locationParam = new SqlParameter("@loction", SqlDbType.Int);
                        locationParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(locationParam);

                        connection.Open();
                        cmd.ExecuteNonQuery();

                        // Retrieve the value of the output parameter @charge
                        int charge = Convert.ToInt32(cmd.Parameters["@charge"].Value);

                        lblBatteryStatus.Text = "Battery percentage: " + charge;

                        connection.Close();
                    }
                    else
                    {
                        // Handle the case where ddlDevices.SelectedValue is not a valid integer
                        lblBatteryStatus.Text = "Invalid device selection.";
                    }
                }
            }
        }
    }
}