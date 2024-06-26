using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskManagerWeb
{
    public partial class AddTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: You can add initialization logic here
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string title = TitleTextBox.Text;
            string description = DescriptionTextBox.Text;
            string status = StatusTextBox.Text;
            DateTime dueDate;

            if (!DateTime.TryParse(DueDateTextBox.Text, out dueDate))
            {
                return;
            }

            string username = User.Identity.Name;
            int userId = GetUserIdByUsername(username);

            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO Tasks (UserID, Title, Description, Status, DueDate)
                    VALUES (@UserID, @Title, @Description, @Status, @DueDate)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@DueDate", dueDate);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Redirect to the dashboard after adding the task
            Response.Redirect("Dashboard.aspx");
        }

        private int GetUserIdByUsername(string username)
        {
            int userId = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID FROM Users WHERE Username=@Username";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        userId = Convert.ToInt32(result);
                    }
                }
            }

            return userId;
        }
    }
}