<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationPage.aspx.cs" Inherits="TaskManagerWeb.RegistrationPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Page</title>
    <style type="text/css">
        body {
            background-color: #f0f0f0; 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background-color: #ffffff; 
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .form-table {
            width: 100%;
            margin-bottom: 20px;
        }
        .form-table td {
            text-align: center;
            padding: 8px;
        }
        .form-table .form-label {
            font-weight: bold;
        }
        .form-table .form-input {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }
        .form-table .submit-button {
            background-color: #4CAF50; /* Primary color */
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-table .submit-button:hover {
            background-color: #45a049; /* Darker primary color */
        }
        .form-table .login-link {
            text-decoration: none;
            color: #1e90ff; /* Secondary color */
        }
        .form-table .login-link:hover {
            text-decoration: underline;
        }
        .form-table .error-message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <table class="form-table">
                <tr>
                    <td colspan="3" class="form-label">User Name:</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:TextBox ID="Login" runat="server" CssClass="form-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Login" ErrorMessage="Required Field" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="form-label">Password:</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Password" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="form-label">Confirm Password:</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="form-label">Email:</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:TextBox ID="Email" runat="server" CssClass="form-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Email" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="Reg" runat="server" Text="Register" OnClick="Reg_Click" CssClass="submit-button" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/LoginPage.aspx" CssClass="login-link">Login</asp:HyperLink>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
