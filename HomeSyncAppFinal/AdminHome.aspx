<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="HomeSyncAppFinal.AdminHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <p>
            WELCOME TO HOMESYNC!</p>
        <p>
            ADMIN PAGE</p>
        <p>
            &nbsp;</p>
        <p>
            HOMESYNC PAGES:</p>
        <p>
            &nbsp;</p>
        <p>
            ROOM:</p>
        <p>
            <asp:Button ID="RoomButton" runat="server" Height="75px" Text="Room" Width="300px"  OnClick ="goToAdminRoom" />
&nbsp;&nbsp;&nbsp;&nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            TASKS:</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="TaskButton" runat="server" Height="75px" Text="Tasks" Width="300px" OnClick ="goToAdminTask" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            EVENTS:</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="EventButton" runat="server" Height="75px" Text="Events" Width="300px"  OnClick ="goToAdminEvent"/>
        </p>
        <p>
            &nbsp;</p>
        <p>
            DEVICES</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="DeviceButton" runat="server" Height="75px" Text="Devices"  Width="300px" OnClick ="goToAdminDevice" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            FINANCANCE AND COMMUNICATION</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="FCButton" runat="server" Height="75px" Text="Finance And Communication"  Width="300px" OnClick ="goToAdminFAndC"  />
                                                                               
            </p>
        <p>
            &nbsp;</p>
        <p>
            USER DETAILS:</p>
        <asp:GridView ID="UserProfileGridView" runat="server" Width="725px" AutoGenerateColumns ="true">
        </asp:GridView>
        <p>
            &nbsp;</p>
        
        
        <p>
            ADD GUEST:</p>
        <p>
            &nbsp;</p>
        Email: 
        <br />
        <br />
        <asp:TextBox ID="emailGuest1" runat="server"></asp:TextBox> 
        <br />
        <br />
        First name : 
        <br />
        <br />
         <asp:TextBox ID="firstName1" runat="server"></asp:TextBox> 
        <br />
        <br />
        Address: 
        <br />
        <br />
         <asp:TextBox ID="addressGuest1" runat="server"></asp:TextBox> 
        <br />
        <br />
        Password: 
        <br />
        <br />
        <asp:TextBox ID="passwordGuest1" runat="server"></asp:TextBox> 
        <br />
        <br />
        Guest of: 
        <br />
        <br />
        <asp:TextBox ID="adminIDGuest1" runat="server"></asp:TextBox> 
        <br />
        <br />
        Room ID: 
        <br />
        <br />
         <asp:TextBox ID="roomIDGuest1" runat="server"></asp:TextBox> 
        <br />
        <br />
          <asp:Button ID="addGuest1" runat="server" CssClass="button" OnClick="addGuest123" Text="Add Guest" /> 
        <br />
        <br />
        <asp:Label ID="MessageAddGuestR" runat="server" CssClass="message"></asp:Label> 
        <br />
        <br />
         <asp:Label ID="ErrorMessagesAddGuest" runat="server" CssClass="message"></asp:Label> 
        <br />
        <br />
        <br />
        Admin ID: <br />
        <asp:TextBox ID="adminID221" runat="server"></asp:TextBox> 
        <br />
        <br />
        <asp:Button ID="noOfGuests1" runat="server" CssClass="button" OnClick="NumberOfGuests1" Text="Show number of guests" /> 
        <br />
        <br />
        <br />
        <br />
          <asp:Label ID="noOfGuests12" runat="server" CssClass="message"></asp:Label> 
        <br />
        <br />
        <br />
   <asp:Label ID="ErrorMessagesNoOfGuests" runat="server" CssClass="message"></asp:Label> 
        <br />
        <br />
        <br />
        <br />
        REMOVE GUEST:<br />
        <br />
        <br />
         <div style="margin-bottom: 0px">
            <asp:Label ID="Label1" runat="server" Text="Remove Guest"></asp:Label>
             <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Guest ID"></asp:Label>
            <br />
            <asp:TextBox ID="guestIdRemove" runat="server"></asp:TextBox>
             <br />
             <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Admin ID"></asp:Label>
             <br />
            <br />
            <asp:TextBox ID="adminIdRemove" runat="server"></asp:TextBox>
             <br />
             <br />
            <br />
            <asp:Button ID="removeGuestBtn" runat="server" Text="Remove Guest" OnClick="removeGuestBtn_Click" />
             <br />
            <br />
            <asp:Label ID="MessageLbl" runat="server" Text=""></asp:Label>
             <br />
             <br />
             <br />
       
        </div>
           <div>
       <asp:Label ID="Label4" runat="server" Text="Set the number of allowed guests for an admin:"></asp:Label>
       <br />
       <br />
       <asp:Label ID="Label5" runat="server" Text="Admin's ID"></asp:Label>
               <br />
       <br />
       <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
               <br />
       <br />
       <asp:Label ID="Label6" runat="server" Text="Number of guests allowed:"></asp:Label>
               <br />
       <br />
       <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
               <br />
       <br />
       <asp:Button ID="Button1" runat="server" Text="Confirm" OnClick="setGuests"/>
               <br />
       <br />
       <asp:Label ID="MessageLabel" runat="server" Text=""></asp:Label>
               <br />
   </div>
        <p>
            <asp:Button ID="SignoutButton" runat="server" Text="Signout" Height="47px" Width="166px" OnClick ="signOut"/>
        </p>
    </form>
</body>
</html>
