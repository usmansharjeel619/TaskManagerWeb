<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTask.aspx.cs" Inherits="TaskManagerWeb.AddTask" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Task</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
        }
        table tr {
            margin-bottom: 15px;
        }
        table td {
            padding: 10px;
        }
        .center-align {
            text-align: center;
        }
        .submit-button {
            padding: 15px 30px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .submit-button:hover {
            background-color: #45a049;
        }
        .required-field-error {
            color: red;
            display: block;
            margin-top: 5px;
            text-align: center;
        }
    </style>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#<%= DueDateTextBox.ClientID %>").datepicker();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Add New Task</h2>
            <table>
                <tr>
                    <td>Title:</td>
                    <td><asp:TextBox ID="TitleTextBox" runat="server" Required="true"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td><asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Rows="4" Required="true"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Status:</td>
                    <td><asp:TextBox ID="StatusTextBox" runat="server" Required="true"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Due Date:</td>
                    <td><asp:TextBox ID="DueDateTextBox" runat="server" Required="true"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2" class="center-align">
                        <asp:Button ID="SubmitButton" runat="server" Text="Add Task" OnClick="SubmitButton_Click" CssClass="submit-button" />
                    </td>
                </tr>
            </table>
            <asp:RequiredFieldValidator ID="TitleRequiredValidator" runat="server" ControlToValidate="TitleTextBox"
                ErrorMessage="Title is required." ForeColor="Red" Display="Dynamic" CssClass="required-field-error"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="DescriptionRequiredValidator" runat="server" ControlToValidate="DescriptionTextBox"
                ErrorMessage="Description is required." ForeColor="Red" Display="Dynamic" CssClass="required-field-error"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="StatusRequiredValidator" runat="server" ControlToValidate="StatusTextBox"
                ErrorMessage="Status is required." ForeColor="Red" Display="Dynamic" CssClass="required-field-error"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="DueDateRequiredValidator" runat="server" ControlToValidate="DueDateTextBox"
                ErrorMessage="Due Date is required." ForeColor="Red" Display="Dynamic" CssClass="required-field-error"></asp:RequiredFieldValidator>
        </div>
    </form>
</body>
</html>
