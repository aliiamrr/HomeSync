<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoomGuest(MO).aspx.cs" Inherits="HomeSyncAppFinal.RoomGuest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Room Admin</title>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </div>
        <div style="height: 141px">
            <h1>Book Room:</h1><br />
            enter ID:<br />
            <asp:TextBox ID="uid" runat="server"></asp:TextBox>
            <br />
            entre the room ID:<br />
            <asp:TextBox ID="rid" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Submit2" runat="server" Text="Submit" OnClick="Book2" />
        </div>
        <br />
        
        
        <br />
        
    </form>
</body>
</html>
