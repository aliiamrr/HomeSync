<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="showMessages(MAM).aspx.cs" Inherits="HomeSyncAppFinal.showMessages" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Messages</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
        }

        div {
            text-align: center;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            background-color: #e67e22;
            color: #fff;
            border: none;
            border-radius: 5px;
        }

        .button:hover {
            background-color: #d35400;
        }

        .message {
            margin-top: 10px;
            display: block;
            color: #ff0000;
        }

        #gridViewMessages {
            margin: 0 auto; /* Center the GridView */
            width: 100%;
            border-collapse: collapse;
        }

        #gridViewMessages th, #gridViewMessages td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        #gridViewMessages th {
            background-color: #3498db;
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Show all messages received from a specific user</h2>
            
            <br />

            <label for="senderID2">Sender ID:</label>
            <asp:TextBox ID="senderID2" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="showMsg" runat="server" CssClass="button" OnClick="ShowMsgs" Text="Show" />
            <br />

            <asp:Label ID="Message44" runat="server" CssClass="message"></asp:Label>

            <asp:GridView ID="gridViewMessages" runat="server" AutoGenerateColumns="True" CssClass="grid-view">
            </asp:GridView>
        </div>
    </form>
</body>
</html>
