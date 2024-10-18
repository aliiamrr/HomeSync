<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GuestHomePage(Mekki).aspx.cs" Inherits="HomeSyncAppFinal.GuestHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="CreateEventBtn" runat="server" Text="Create Event" OnClick="CreateEventBtn_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="ViewEventBtn" runat="server" Text="View Events" OnClick="ViewEventBtn_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="AssignUserBtn" runat="server" Text="Assign User" OnClick="AssignUserBtn_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="UninviteUserBtn" runat="server" Text="Uninvite User" OnClick="UninviteUserBtn_Click" />
        </div>
    </form>
</body>
</html>
