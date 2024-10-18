<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main page(MAM).aspx.cs" Inherits="HomeSyncAppFinal.main_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Finance and Communication</title>
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
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            margin: 10px;
            cursor: pointer;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
        }

        .button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <form id="main" runat="server">
        <div>
            <asp:Button ID="receiveTransaction" runat="server" CssClass="button" OnClick="ReceiveTransaction" Text="Receive a Transaction" />
            <br />
            <asp:Button ID="createPayment" runat="server" CssClass="button" OnClick="CreatePayment" Text="Create a payment on a specific date" />
            <br />
            <asp:Button ID="sendMessage" runat="server" CssClass="button" OnClick="SendMessage" Text="Send a message to a user" />
            <br />
            <asp:Button ID="showMessages" runat="server" CssClass="button" OnClick="ShowMessages" Text="Show all messages received from a specific user" />
            <br />
        </div>
    </form>
</body>
</html>
