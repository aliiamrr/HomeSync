<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GuestSignUp.aspx.cs" Inherits="HomeSyncAppFinal.GuestSignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        If you are a Guest, please fill in the following credentials:<br /><br /><br />

        ID of Admin:<p>
            <asp:TextBox ID="AdminIDTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
        </p>

        <p>&nbsp;</p>

        <p>&nbsp;Address:</p>
        <p>
            <asp:TextBox ID="AdressTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
        </p>

        <p>&nbsp;</p>

        <p>&nbsp;Arrival Date: (yyyy-MM-dd)</p>
        <p>
            <asp:TextBox ID="ArrivalDateTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
        </p>

        <p>&nbsp;</p>

        <p>Departure Date: (yyyy-MM-dd)</p>
        <p>
            <asp:TextBox ID="DepartureDateTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
        </p>

        <p>&nbsp;</p>

        <p>Residential:</p>
        <p>
            <asp:TextBox ID="ResidentialTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
        </p>

        <p>&nbsp;</p>

        <asp:Button ID="Button1" runat="server" Text="SignUp" OnClick="signUpGuest" Width="255px" Height="52px" style="margin-top: 0px" />
        
        <p>&nbsp;</p>
        <p>&nbsp;</p>

        <asp:Label ID="MessageLabel" runat="server" Text=""></asp:Label>

        <p>&nbsp;</p>

        <asp:Label ID="ExceptionLabel" runat="server" Text=""></asp:Label>
    </form>
</body>
</html>

