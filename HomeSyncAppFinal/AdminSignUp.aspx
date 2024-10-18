<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSignUp.aspx.cs" Inherits="HomeSyncAppFinal.AdminSignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>If you are an Admin, please fill the following credentials:</p>
            <p>&nbsp;</p>
            <p>Number of guests Allowed:</p>
            <p>
                <asp:TextBox ID="NumOfGuestsAllowedTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
            </p>
            <p>&nbsp;</p>
            <p>Salary: "Max = 8 figures with 2 decimal places"</p>
            <p>
                <asp:TextBox ID="SalaryTextBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
            </p>
            <p>&nbsp;</p>
            <asp:Button ID="Button2" runat="server" Text="SignUp" OnClick="signUpAdmin" Width="255px" Height="52px" style="margin-top: 0px" />
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <asp:Label ID="MessageLabel" runat="server" Text=""></asp:Label>
            <p>&nbsp;</p>
            <asp:Label ID="ExceptionLabel" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>

