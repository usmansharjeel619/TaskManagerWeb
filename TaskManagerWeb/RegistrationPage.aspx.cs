using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskManagerWeb
{
    public partial class RegistrationPage : System.Web.UI.Page
    {
        protected void Reg_Click(object sender, EventArgs e)
        {
            string username = Login.Text;
            string password = Password.Text;
            string confirmPassword = ConfirmPassword.Text;
            string email = Email.Text;

            if (password != confirmPassword)
            {
                // Show error message
                return;
            }

            string passwordHash = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Users (Username, PasswordHash, Email) VALUES (@Username, @PasswordHash, @Email)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Optionally, redirect to login page after successful registration
            Response.Redirect("LoginPage.aspx");
        }
    }
}