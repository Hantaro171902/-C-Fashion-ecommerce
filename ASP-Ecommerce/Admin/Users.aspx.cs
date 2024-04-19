using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration.Internal;
using System.Drawing;
using System.Diagnostics;


namespace ASP_Ecommerce.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCumbTitle"] = "Manage User";
            Session["breadCumbPage"] = "User";
            getUsers();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {  
            Utils.CloseConnection(); // Close the connection when the page unloads
        }
        
        void getUsers()
        {
            Utils.OpenConnection();

            con = Utils.GetConnection();
            cmd = new SqlCommand("Users_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETALL");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rUser.DataSource = dt;
            rUser.DataBind();
        }

        protected void ValidateUsername(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;
            // Check if the username already exists in the DataTable
            DataRow[] rows = dt.Select("UserName = '" + username + "'");
            args.IsValid = rows.Length == 0;
        }

        protected void btnAddOnUpdate_Click(object sender, EventArgs e)
        {
            bool isValidtoExecute = true;
            int userId = Convert.ToInt32(hfUserID.Value);
            int roleId = 2; // This mean user role = customer
            string actionName = string.Empty;

            Utils.OpenConnection();

            con = Utils.GetConnection();
            cmd = new SqlCommand("Users_Crud", con);
            cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
            cmd.Parameters.AddWithValue("@RoleId", roleId);


            if (isValidtoExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    // con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = userId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "User " + actionName + " successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getUsers();
                    clear();

                    Debug.Print("Insert success");

                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Failed to insert user: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";

                    Debug.Print("Insert failed: " + ex.Message);

                }
                finally
                {
                    Utils.CloseConnection(); // Close the connection managed by Utils
                }   
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        void clear()
        {
            txtName.Text = string.Empty;
            txtUserName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtPassword.Text = string.Empty;
            btnAddOnUpdate.Text = "Add";
            
        }

        public void rUser_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                // int userId = Convert.ToInt32(e.CommandArgument);

                Utils.OpenConnection();

                con = Utils.GetConnection();
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                txtMobile.Text = dt.Rows[0]["Mobile"].ToString();
                txtPassword.Text = dt.Rows[0]["Password"].ToString();

                btnAddOnUpdate.Text = "Update";
            }
            else if (e.CommandName == "delete")
            {
                // int userId = Convert.ToInt32(e.CommandArgument);
                Utils.OpenConnection();

                con = Utils.GetConnection();
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action","DELETE");
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                txtMobile.Text = dt.Rows[0]["Mobile"].ToString();
                txtPassword.Text = dt.Rows[0]["Password"].ToString();

                rUser.DataSource = dt;
                rUser.DataBind();
                try
                {
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "User deleted successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getUsers();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Failed to delete category: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    Utils.CloseConnection(); // Close the connection managed by Utils
                }
            }           
        }
    }
}