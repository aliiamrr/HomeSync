<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDevice(Hussein).aspx.cs" Inherits="HomeSyncAppFinal.AdminDevice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add a New Device</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');
        *
        {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background-color: #27282c;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .btn-add-device,
        .btn-charge-devices {
            position: relative;
            background: #7ad407;
            color:#fff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 1em;
            letter-spacing: 0.1em;
            font-weight: 400;
            padding: 10px 30px;
            transition: 0.5s;
        }

        .btn-add-device:hover,
        .btn-charge-devices:hover {
            background: #7ad407;
            color: #27182c;
            letter-spacing: 0.25em;
            box-shadow: 0 0 35px #000;
        }

        .btn-add-device:before,
        .btn-charge-devices:before {
            position: absolute;
            inset: 2px;
        } 

        .container {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 auto;
        }

        .section {
        margin-bottom: 20px;
        width: 100%;
        }

        .divider {
            height: 1px;
            background-color: #ccc;
            margin: 20px 0;
        }

        h2 {
            color: #333;
        }

        .input-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        #GridView1,
        #GridView2 {
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="section">
                <asp:Label ID="devices" runat="server" Text="Choose device ID:"></asp:Label>
            </div>
            <div class="section">
                <asp:DropDownList ID="ddlDevices" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDevices_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="section">
                <asp:Label ID="lblBatteryStatus" runat="server" Text="Battery percentage:"></asp:Label>
            </div>

            <div class="divider"></div>

            <div class="section">
                <h2>Add a new device:</h2>
                <div class="input-group">
                    <asp:Label ID="Label1" runat="server" Text="Device ID:"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label2" runat="server" Text="Device status:"></asp:Label>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label3" runat="server" Text="Battery percentage:"></asp:Label>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label4" runat="server" Text="Device location:"></asp:Label>
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label5" runat="server" Text="Device type:"></asp:Label>
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="Button1" runat="server" Text="Add device" OnClick="Button1_Click" CssClass="btn-add-device" />
                <p>
                    <asp:Label ID="MessageLabelAdd" runat="server" Text=""></asp:Label>
                </p>
                <p>
                    <asp:Label ID="ExceptionLabelAdd" runat="server" Text=""></asp:Label>
                </p>
            </div>

            <div class="divider"></div>

            <div class="section">
                <h2>Rooms with an out-of-charge device</h2>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Room" HeaderText="Rooms with an out-of-charge device" />
                    </Columns>
                </asp:GridView>
                <asp:Button ID="Button2" runat="server" Text="Charge dead devices" OnClick="Button2_Click" CssClass="btn-charge-devices" />
            </div>

            <div class="divider"></div>

            <div class="section">
                <h2>Rooms with two or more out-of-charge devices</h2>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Room" HeaderText="Rooms with two or more out-of-charge devices" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>