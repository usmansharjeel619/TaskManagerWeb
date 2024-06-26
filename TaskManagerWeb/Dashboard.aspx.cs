using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TaskManagerWeb
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
                LoadUserTasks();
            }
        }

        private void LoadUserProfile()
        {
            string username = User.Identity.Name;

            if (string.IsNullOrEmpty(username))
            {
                // Handle the case where the username is not available
                UsernameLabel.Text = "Guest";
                EmailLabel.Text = "N/A";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Email FROM Users WHERE Username=@Username";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        EmailLabel.Text = reader["Email"].ToString();
                        UsernameLabel.Text = username;
                    }
                    else
                    {
                        // Handle the case where no user was found
                        EmailLabel.Text = "N/A";
                        UsernameLabel.Text = "Unknown User";
                    }
                }
            }
        }

        protected void LoadUserTasks()
        {
            string username = User.Identity.Name;

            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT Tasks.TaskId, Tasks.Title, Tasks.Description, Tasks.Status, Tasks.DueDate 
            FROM Tasks 
            INNER JOIN Users ON Tasks.UserID = Users.UserID 
            WHERE Users.Username = @Username";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    TasksGridView.DataSource = dt;
                    TasksGridView.DataBind(); // Make sure DataBinding is done correctly
                }
            }
        }

        protected void AddTaskButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddTask.aspx");
        }

        protected void TasksGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            TasksGridView.EditIndex = e.NewEditIndex;
            LoadUserTasks();
        }

        protected void TasksGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = TasksGridView.Rows[e.RowIndex];
            int taskId = Convert.ToInt32(TasksGridView.DataKeys[e.RowIndex].Value);

            // Find the TextBox controls in the EditItemTemplate
            TextBox titleTextBox = row.FindControl("TitleTextBox") as TextBox;
            TextBox descriptionTextBox = row.FindControl("DescriptionTextBox") as TextBox;
            TextBox statusTextBox = row.FindControl("StatusTextBox") as TextBox;
            TextBox dueDateTextBox = row.FindControl("DueDateTextBox") as TextBox;

            // Retrieve values from TextBox controls
            string title = titleTextBox.Text;
            string description = descriptionTextBox.Text;
            string status = statusTextBox.Text;
            DateTime dueDate = DateTime.Parse(dueDateTextBox.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            UPDATE Tasks 
            SET Title=@Title, Description=@Description, Status=@Status, DueDate=@DueDate 
            WHERE TaskId=@TaskId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@DueDate", dueDate);
                    cmd.Parameters.AddWithValue("@TaskId", taskId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            TasksGridView.EditIndex = -1;
            LoadUserTasks();
        }


        protected void TasksGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            TasksGridView.EditIndex = -1;
            LoadUserTasks();
        }

        protected void TasksGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex >= 0 && e.RowIndex < TasksGridView.Rows.Count)
            {
                int taskId = Convert.ToInt32(TasksGridView.DataKeys[e.RowIndex].Value);
                string connectionString = ConfigurationManager.ConnectionStrings["TaskManagerDBConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Tasks WHERE TaskId=@TaskId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@TaskId", taskId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadUserTasks(); // Reload the tasks after deletion
            }
        }
    }
}
