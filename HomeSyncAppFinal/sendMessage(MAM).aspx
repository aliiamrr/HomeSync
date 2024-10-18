<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sendMessage(MAM).aspx.cs" Inherits="HomeSyncAppFinal.sendMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send Message</title>
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
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
        }

        .button:hover {
            background-color: #2980b9;
        }

        .message {
            margin-top: 10px;
            display: block;
            color: #ff0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Send a Message</h2>
           
            <br />

            <label for="receiverIDMsg">ID of Receiver:</label>
            <asp:TextBox ID="receiverIDMsg" runat="server"></asp:TextBox>
            <br />

            <label for="titleMsg">Title:</label>
            <asp:TextBox ID="titleMsg" runat="server"></asp:TextBox>
            <br />

            <label for="contentMsg">Content:</label>
            <asp:TextBox ID="contentMsg" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="sendMsg" runat="server" CssClass="button" OnClick="SendMsg" Text="Send" />
            <br />

            <asp:Label ID="Message33" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>
