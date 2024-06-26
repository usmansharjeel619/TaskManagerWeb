<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TaskManagerWeb.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            overflow: hidden; 
        }
        .welcome-message {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-info {
            float: left;
            width: 25%;
            padding: 20px;
            box-sizing: border-box;
        }
        .tasks-table {
            float: left;
            width: 70%;
            padding: 20px;
            box-sizing: border-box;
            overflow-x: auto; 
            white-space: nowrap; 
        }
        .tasks-table table {
            min-width: 100%; 
            table-layout: auto; 
        }

        .tasks-table th, .tasks-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        .tasks-table th {
            background-color: #f2f2f2;
        }
        .tasks-table h2 {
            margin-top: 0;
            margin-bottom: 20px;
        }
        .add-task {
            clear: both;
            text-align: right;
            margin-top: 20px;
        }
        .add-task {
           padding: 15px 30px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .add-task:hover {
            background-color: #45a049;
        }
        
        .tasks-table table {
            width: 100%;
            border-collapse: collapse;
        }
        .tasks-table th, .tasks-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        .tasks-table th {
            background-color: #f2f2f2;
        }
        .tasks-table .edit-button {
            background-color: #f44336;
            color: white;
            margin:10px;
            border : none;
            width:90px;
            height:20px;
        }
        .tasks-table .edit-button:hover {
            background-color: #da190b;
        }




        .tasks-table .delete-button {
            background-color: #555555;
            color: white;
            margin-left : 10px;
            border : none;
            width:90px;
            height:20px;
        }
        .tasks-table .delete-button:hover {
            background-color: #333333;
        }




         .update-button {
     background-color: #555555;
     color: white;
     margin-left : 10px;
     border : none;
     width:90px;
     height:20px;
 }
 .up-button:hover {
     background-color: #333333;
 }






            .cencel-button {
            background-color: #f44336;
            color: white;
            margin:10px;
            border : none;
            width:90px;
            height:20px;
        }
        .cencel-button:hover {
            background-color: #da190b;
        }
                .tasks-table .description-cell {
            max-width: 15px; /* Adjust the max-width as per your design */
            word-wrap: break-word;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="welcome-message">
                <h1>Welcome, <asp:Label ID="UsernameLabel" runat="server"></asp:Label>!</h1>
            </div>
            <div class="profile-info">
                <h2>Your Profile Information</h2>
                <p>Email: <asp:Label ID="EmailLabel" runat="server"></asp:Label></p>
            </div>
            <div class="tasks-table">
                <h2>Your Tasks</h2>
                <asp:GridView ID="TasksGridView" runat="server" AutoGenerateColumns="false"
                    DataKeyNames="TaskId" OnRowDeleting="TasksGridView_RowDeleting" OnRowEditing="TasksGridView_RowEditing"
                    OnRowUpdating="TasksGridView_RowUpdating" OnRowCancelingEdit="TasksGridView_RowCancelingEdit">
                    <Columns>
                        <asp:TemplateField HeaderText="Title">
                            <ItemTemplate>
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>' CssClass="description-cell"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Rows="4"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="StatusLabel" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="StatusTextBox" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Due Date">
                            <ItemTemplate>
                                <asp:Label ID="DueDateLabel" runat="server" Text='<%# Bind("DueDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="DueDateTextBox" runat="server" Text='<%# Bind("DueDate", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="edit-button" />
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="delete-button" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="update-button"/>
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="cencel-button"/>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div class="add-task-btn">
                    <asp:Button ID="AddTaskButton" runat="server" Text="Add Task" OnClick="AddTaskButton_Click" CssClass="add-task" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
