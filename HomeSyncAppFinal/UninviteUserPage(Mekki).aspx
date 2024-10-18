<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UninviteUserPage(Mekki).aspx.cs" Inherits="HomeSyncAppFinal.UninviteUserPage" %>

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
            <asp:Label ID="Label2" runat="server" Text="Event ID"></asp:Label>
            <br />
            <asp:TextBox ID="eventIdText" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="uninviteUserBtn" runat="server" Text="Uninvite User" OnClick="uninviteUserBtn_Click" />
            <br />
            <asp:Label ID="MessageLbl" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
