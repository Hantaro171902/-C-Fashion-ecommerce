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
    public partial class Category : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCumbTitle"] = "Manage Category";
            Session["breadCumbPage"] = "Category";
            getCategories();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            Utils.CloseConnection(); // Close the connection when the page unloads
        }

        void getCategories()
        {
            Utils.OpenConnection();

            con = Utils.GetConnection();
            cmd = new SqlCommand("Category_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETALL");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCategory.DataSource = dt;
            rCategory.DataBind();
        }   

        protected void btnAddOnUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidtoExecute = false;
            int categoryId = Convert.ToInt32(hfCategoryId.Value);

            Utils.OpenConnection();

            con = Utils.GetConnection();
            cmd = new SqlCommand("Category_Crud", con);
            cmd.Parameters.AddWithValue("@Action", categoryId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@CategoryId", categoryId);
            cmd.Parameters.AddWithValue("@CategoryName", txtCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

            if (fuCategoryImage.HasFile)
            {
                if (Utils.isValidExtension(fuCategoryImage.FileName))
                {
                    string newImageName = Utils.getUniqueId();
                    fileExtension = Path.GetExtension(fuCategoryImage.FileName);
                    imagePath = "Images/Category/" + newImageName.ToString() + fileExtension;
                    fuCategoryImage.PostedFile.SaveAs(Server.MapPath("~/Images/Category/") + newImageName.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@CategoryImageUrl", imagePath);
                    isValidtoExecute = true;
                }
                else
                {
                    lblMsg.Visible = false;
                    lblMsg.Text = "Please select .jpg .png or .gif image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidtoExecute = false;
                }
            }
            else
            {
                isValidtoExecute = true;
            }

            if (isValidtoExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    // con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = categoryId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Category " + actionName + " successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();
                    clear();

                    Debug.Print("Insert success");

                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Failed to insert category: " + ex.Message;
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
            txtCategoryName.Text = string.Empty;
            cbIsActive.Checked = false;
            hfCategoryId.Value = "0";
            btnAddOnUpdate.Text = "Add";
            imagePreview.ImageUrl = string.Empty;
        }

        public void rCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                // int categoryId = Convert.ToInt32(e.CommandArgument);

                Utils.OpenConnection();

                con = Utils.GetConnection();
                cmd = new SqlCommand("Category_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtCategoryName.Text = dt.Rows[0]["CategoryName"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["CategoryImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["CategoryImageUrl"].ToString();
                imagePreview.Height = 200;
                imagePreview.Width = 200;
                hfCategoryId.Value = dt.Rows[0]["CategoryId"].ToString();
                btnAddOnUpdate.Text = "Update";
            }
            else if (e.CommandName == "delete")
            {
                // int categoryId = Convert.ToInt32(e.CommandArgument);
                Utils.OpenConnection();

                con = Utils.GetConnection();
                cmd = new SqlCommand("Category_Crud", con);
                cmd.Parameters.AddWithValue("@Action","DELETE");
                cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtCategoryName.Text = dt.Rows[0]["CategoryName"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["CategoryImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["CategoryImageUrl"].ToString();
                rCategory.DataSource = dt;
                rCategory.DataBind();
                try
                {
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Category deleted successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();
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