using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP_Ecommerce.Admin
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd;
            SqlDataReader dr;
            SqlDataAdapter sda;
            DataTable dt;

            if (IsPostBack)
            {
                string name = Request.Form["name"];
                string username = Request.Form["username"];
                string email = Request.Form["email"];
                string mobile = Request.Form["mobile"];
                string password = Request.Form["password"]; // Consider hashing the password

                using (SqlConnection conn = new SqlConnection("Server=YOUR_SERVER_NAME; Database=EC_FashionStore; Integrated Security=True;"))
                {
                    conn.Open();
                    string query = "INSERT INTO Users (Name, UserName, Email, Mobile, Password, RoleId, CreatedDate) VALUES (@name, @username, @email, @mobile, @password, 2, GETDATE())";  // Assuming RoleId '2' is for regular users
                    cmd = new SqlCommand(query, conn);
                    
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@mobile", mobile);
                        cmd.Parameters.AddWithValue("@password", password);  // Consider using parameterized queries to avoid SQL injection

                        int result = cmd.ExecuteNonQuery();
                        if (result > 0)
                        {
                            Response.Redirect("Login.aspx"); // Redirect to login page after successful registration
                        }
                        else
                        {
                            Response.Write("<script>alert('Registration failed. Please try again.');</script>");
                        }
                }
                
            }
        }
    }
}
