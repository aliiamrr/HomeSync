<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="deleteMsg(MAM).aspx.cs" Inherits="HomeSyncAppFinal.deleteMsg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delete Message</title>
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
            margin-top: 10px;
            cursor: pointer;
            background-color: #e74c3c;
            color: #fff;
            border: none;
            border-radius: 5px;
        }

        .button:hover {
            background-color: #c0392b;
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
            <h2>Delete Last Message Sent</h2>
            <asp:Button ID="deleteMessage" runat="server" CssClass="button" OnClick="DeleteMessage" Text="Delete Last Message Sent" />
            <br />

            <asp:Label ID="Message55" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>
