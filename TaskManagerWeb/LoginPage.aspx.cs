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
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Log_Click(object sender, EventArgs e)
        {
            string username = Login.Text;
            string password = Password.Text;
            string passwordHash = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");

            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM Users WHERE Username=@Username AND PasswordHash=@PasswordHash";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count == 1)
                    {
                        FormsAuthentication.SetAuthCookie(username, true); // Set authentication cookie
                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        InvalidLoginMessage.Text = "Invalid username or password.";
                        InvalidLoginMessage.Visible = true;
                    }
                }
            }
        }

    }
}