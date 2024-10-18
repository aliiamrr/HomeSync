<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateEventPage(Mekki).aspx.cs" Inherits="HomeSyncAppFinal.CreateEventPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Event ID"></asp:Label>
        </div>
        <asp:TextBox ID="eventIdText" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="User ID"></asp:Label>
        <br />
        <asp:TextBox ID="userIdText" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Name"></asp:Label>
        <br />
        <asp:TextBox ID="nameText" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Description"></asp:Label>
        <br />
        <asp:TextBox ID="descriptionText" runat="server" Height="50px" Width="392px"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Location"></asp:Label>
        <br />
        <asp:TextBox ID="locationText" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Reminder Date"></asp:Label>
        <br />
        <asp:TextBox ID="reminderDateText" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label7" runat="server" Text="Other User ID"></asp:Label>
        <br />
        <asp:TextBox ID="otherUserIdText" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="createEventBtn" runat="server" Text="Create Event" OnClick="createEventBtn_Click" />
        <br />
        <asp:Label ID="MessageLbl" runat="server" Text=""></asp:Label>
    </form>
</body>
</html>
