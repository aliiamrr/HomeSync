<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="createPayment(MAM).aspx.cs" Inherits="HomeSyncAppFinal.createPayment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Payment</title>
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
            <h2>Create a Payment</h2>
          
            <br />

            <label for="receiverID">Receiver ID:</label>
            <asp:TextBox ID="receiverID" runat="server"></asp:TextBox>
            <br />

            <label for="amountPayment">Amount:</label>
            <asp:TextBox ID="amountPayment" runat="server"></asp:TextBox>
            <br />

            <label for="paymentStatus">Status:</label>
            <asp:TextBox ID="paymentStatus" runat="server"></asp:TextBox>
            <br />

            <label for="paymentDate">Date:</label>
            <asp:TextBox ID="paymentDate" runat="server"></asp:TextBox>
            <br />

            <asp:Button ID="paymentB" runat="server" CssClass="button" OnClick="payment" Text="Make Payment" />
            <br />

            <asp:Label ID="Message11" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>
