<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HomeSyncAppFinal.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 275px">
    <form id="form1" runat="server">
        <div>
            Please Log in:</div>
        <p>
            Email:</p>
        <p>
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <asp:TextBox ID="EmailBox" runat="server" Height="24px" Width="318px"></asp:TextBox>
        </p>
        <p runat="server" text="Label">
            Password: </p>
        <p runat="server" text="Label">
            <asp:TextBox ID="PasswordBox" runat="server" Height="28px" Width="327px"></asp:TextBox>
        </p>
        <p runat="server" text="Label">
            &nbsp;</p>
        <p runat="server" text="Label">
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick ="login" Height="58px" Width="268px" />
        </p>
        <p runat="server" text="Label">
            &nbsp;</p>
        <p runat="server" text="Label">
            Press Here to sign up if you do not have an account:</p>
        <p runat="server" text="Label">
            <asp:Button ID="Button2" runat="server"   Height   ="54px" Text="Sign - Up" Width="256px"  OnClick="signUpRed"/>
        </p>
        <p runat="server" text="Label">
            &nbsp;</p>
        <p runat="server" text="Label">
            <asp:Label ID="MessageLabel" runat="server" Text=""></asp:Label>
        </p>
        <p runat="server" text="Label">
            <asp:Label ID="ExceptionLabel" runat="server" Text=""></asp:Label>
        </p>
        <p runat="server" text="Label">
            &nbsp;</p>
    </form>
</body>
</html>

