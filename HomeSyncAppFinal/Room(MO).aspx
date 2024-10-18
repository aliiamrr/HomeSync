<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Room(MO).aspx.cs" Inherits="HomeSyncAppFinal.Room" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Room Admin</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </div>
        <br />
        <div>
            <asp:GridView ID="gridView2" runat="server" AutoGenerateColumns="true"></asp:GridView>
            <br />
        </div>
        <div style="height: 141px">
            Book Room:<br />
            enter ID:<br />
            <asp:TextBox ID="uid" runat="server"></asp:TextBox>
            <br />
            entre the room ID:<br />
            <asp:TextBox ID="rid" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Book" />
        </div>
        <br />
        <div style="height: 285px">

            Create a schedule:<br />
            enter id:<br />
            <asp:TextBox ID="uid2" runat="server"></asp:TextBox>
            <br />
            room id:<br />
            <asp:TextBox ID="rid2" runat="server"></asp:TextBox>
            <br />
            Start time:<br />
            <asp:TextBox ID="start" runat="server"></asp:TextBox>
            <br />
            End time:<br />
            <asp:TextBox ID="end" runat="server"></asp:TextBox>
            <br />
            Action:<br />
            <asp:TextBox ID="action" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="button" runat="server" Text="create" OnClick="sr" />

        </div>
        <div>

            Change status:<br />
            enter room ID:<br />
            <asp:TextBox ID="rid3" runat="server"></asp:TextBox>
            <br />
            status:<br />
            <asp:TextBox ID="status" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="dk" runat="server" Text="Change" OnClick="Change" />
        </div>
        <br />
        
    </form>
</body>
</html>
