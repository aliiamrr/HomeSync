<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="receiveTransaction(MAM).aspx.cs" Inherits="HomeSyncAppFinal.receiveTransaction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Receive Transaction</title>
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
            background-color: #2ecc71;
            color: #fff;
            border: none;
            border-radius: 5px;
        }

        .button:hover {
            background-color: #27ae60;
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
            <h2>Receive a Transaction</h2>
            <label for="senderID">ID of Sender:</label>
            <asp:TextBox ID="senderID" runat="server"></asp:TextBox>
            <br />

            <label for="type">Type:</label>
            <asp:TextBox ID="type" runat="server"></asp:TextBox>
            <br />

            <label for="amount">Amount:</label>
            <asp:TextBox ID="amount" runat="server"></asp:TextBox>
            <br />

            <label for="status">Status:</label>
            <asp:TextBox ID="status" runat="server"></asp:TextBox>
            <br />

            <label for="transactionDate">Date:</label>
            <asp:TextBox ID="transactionDate" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="receiveT" runat="server" CssClass="button" OnClick="ReceiveT" Text="Receive" />
            <br />

            <asp:Label ID="Message22" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>
