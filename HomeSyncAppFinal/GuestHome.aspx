<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GuestHome.aspx.cs" Inherits="HomeSyncAppFinal.GuestHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            WELCOME TO HOMESYNC!</p>
        <p>
            GUEST PAGE</p>
        <p>
            &nbsp;</p>
        <p>
            HOMESYNC PAGES:</p>
        <p>
            &nbsp;</p>
        <p>
            ROOM:</p>
        <p>
            <asp:Button ID="RoomButton" runat="server" Height="75px" Text="Room" Width="300px" OnClick ="goToGuestRoom" />
&nbsp;&nbsp;&nbsp;&nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            TASKS:</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="TaskButton" runat="server" Height="75px" Text="Tasks" Width="300px" OnClick ="goToGuestTask" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            EVENTS:</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="EventButton" runat="server" Height="75px" Text="Events" Width="300px" OnClick="goToGuestEvent" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            DEVICES</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="DeviceButton" runat="server" Height="75px" Text="Devices"  Width="300px"  OnClick ="goToGuestDevice" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            FINANCANCE AND COMMUNICATION</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="FCButton" runat="server" Height="75px" Text="Finance And Communication"  Width="300px"  OnClick ="goToGuestFAndC"  />
                                                                               
            </p>
        <p>
            &nbsp;</p>
        <p>
            USER DETAILS:</p>
        <asp:GridView ID="UserProfileGridView" runat="server" Width="725px" AutoGenerateColumns ="true">
        </asp:GridView>
        <p>
    &nbsp;</p>
<p>
    <asp:Button ID="SignoutButton" runat="server" Text="Signout" Height="47px" Width="166px" OnClick ="signOut"/>
        </p>
<p>
    &nbsp;</p>
    <asp:Label ID="ExceptionLabel" runat="server" Text=""></asp:Label>
<p>
    &nbsp;</p>
    </form>
    </body>
</html>


    



