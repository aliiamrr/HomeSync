<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="HomeSyncAppFinal.Tasks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

        </div>
        <p>
            Click this button to view all tasks:</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="ViewTask"  runat="server" Text="View Tasks" Height="60px" Width="200px" OnClick ="viewTasks"  />

        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            Finish a specific task:</p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the title of the task:</p>
        <p>
            <asp:TextBox ID="TitleBox" runat="server" Height="20px" Width="279px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="FinishButton" runat="server" Height="60px" Text="Finish Task" Width="200px" style="margin-bottom: 6px" OnClick ="finishTask" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="ExceptionLabel1" runat="server" Text=""></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            View Status of Task:</p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the id of the creator of the task:</p>
        <p>
            <asp:TextBox ID="CreatorBox" runat="server" Width="294px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="ViewStatus" runat="server" Height="60px" Text="View Status of Task" Width="200px" OnClick ="viewStatus" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="ExceptionLabel4" runat="server" Text=""></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            Add a Reminder to a Task:</p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the Task ID:</p>
        <p>
            <asp:TextBox ID="ReminderTaskIDBox1" runat="server" Width="243px" ></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the date of your Reminder : &quot;"MM/dd/yyyy hh:mm:ss tt";</p>
        <p>
            <asp:TextBox ID="ReminderDateBox" runat="server" Width="246px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="AddReminder" runat="server" Height="60px" Text="Add Reminder to a Task" Width="200px" OnClick ="addReminder" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="ExceptionLabel2" runat="server" Text=""></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            Update the deadline of a Task:</p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the new Deadline:&nbsp; &quot;"MM/dd/yyyy hh:mm:ss tt"&quot;</p>
        <p>
            <asp:TextBox ID="DeadlineBox" runat="server" Width="239px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            Please enter the Task ID:</p>
        <p>
            <asp:TextBox ID="DeadlineTaskIdBox2" runat="server" Width="240px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="UpdateDeadline" runat="server" Height="60px"  Text="Update Deadline of a Task"  Width="200px" OnClick ="updateDeadline" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="ExceptionLabel3" runat="server" Text=""></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
<a href="Web.config">Web.config</a>