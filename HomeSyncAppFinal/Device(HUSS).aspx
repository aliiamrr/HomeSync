<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Device(HUSS).aspx.cs" Inherits="HomeSyncAppFinal.Device" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="devices" runat="server" Text="Choose device ID:"></asp:Label>
        </div>
        <br />
        <asp:DropDownList ID="ddlDevices" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDevices_SelectedIndexChanged">
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="lblBatteryStatus" runat="server" Text="Battery percentage:"></asp:Label>
        <br />
    </form>
</body>
</html>
