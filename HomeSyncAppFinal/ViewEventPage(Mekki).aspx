<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewEventPage(Mekki).aspx.cs" Inherits="HomeSyncAppFinal.ViewEventPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="User ID"></asp:Label>
            <br />
            <asp:TextBox ID="userIdText" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Event ID (0 if you want to see all events assigned to the user)"></asp:Label>
            <br />
            <asp:TextBox ID="eventIdText" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="viewEventBtn" runat="server" Text="View Event" OnClick="viewEventBtn_Click" />
            <br />
            <asp:Label ID="MessageLbl" runat="server" Text=""></asp:Label>
            <br />
            <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </div>
    </form>
</body>
</html>
