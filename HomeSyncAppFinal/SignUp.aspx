<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="HomeSyncWebApp.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please Sign up:<br />
            <br />
            Type:<br />
        </div>
        <asp:TextBox ID="TypeBox1" runat="server" Height="23px" Width="241px"></asp:TextBox>
        <br />
        <br />
        <p>
            Email:</p>
        <p>
            <asp:TextBox ID="EmailBox" runat="server" Height="22px" Width="235px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            First Name:</p>
        <p>
            <asp:TextBox ID="FirstNameBox" runat="server" Height="30px" Width="250px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Last Name:</p>
        <p>
            <asp:TextBox ID="LastNameBox" runat="server"  Height="30px" Width="250px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Birth Date: (yyyy-MM-dd)</p>
        <p>
            <asp:TextBox ID="BirthDateBox" runat="server"  Height="30px" Width="250px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Password:</p>
        <p>
            <asp:TextBox ID="PasswordBox" runat="server"  Height="30px" Width="250px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
          <p>
    <asp:Button ID="Button1" runat="server" Text="SignUp" OnClick ="signUp" Width="255px" Height="52px" style="margin-top: 0px" />
    <p>
        &nbsp;<p>
    &nbsp;<p>
    <asp:Label ID="MessageLabel" runat="server" Text=""></asp:Label>
</p>
<p>
    &nbsp;</p>
<p>
    <asp:Label ID="ExceptionLabel" runat="server" Text=""></asp:Label>
</p>
    </form>
</body>
</html>
