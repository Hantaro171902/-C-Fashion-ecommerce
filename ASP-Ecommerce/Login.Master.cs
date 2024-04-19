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
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string username = Request.Form["username"];
                string password = Request.Form["password"];

                Utils.OpenConnection();

                con = Utils.GetConnection();
                 
                string query = "SELECT COUNT(1) FROM Users WHERE UserName=@username AND Password=@password";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                     cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@password", password);

                        int count = Convert.ToInt32(cmd.ExecuteScalar());
                        if (count == 1)
                        {
                            Session["username"] = username;
                            Response.Redirect("HomePage.aspx"); // Redirect to the home page
                        }
                        else
                        {
                            Response.Write("<script>alert('Invalid username or password');</script>");
                        }
                    }
                
            }
        }
    }

}
