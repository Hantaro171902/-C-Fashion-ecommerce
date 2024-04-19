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
    public partial class Product : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["breadCumbTitle"] = "Manage Product";
            Session["breadCumbPage"] = "Product";
            getProducts();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            Utils.CloseConnection(); // Close the connection when the page unloads
        }

        void getProducts()
        {
            Utils.OpenConnection();

            con = Utils.GetConnection();
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETALL");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProduct.DataSource = dt;
            rProduct.DataBind();
        }

        // void PopulateCategoriesDropdown()
        // {
        //     // Establish connection
        //     Utils.OpenConnection();

        //     con = Utils.GetConnection();
        //     // SQL query to retrieve categories
        //     string query = "SELECT CategoryId FROM Category";

        //     cmd = new SqlCommand(query, con);

        //     // Execute the command and bind results to the dropdown
        //     dr = cmd.ExecuteReader();
        //     ddCategoryId.DataSource = dr;
        //     // ddCategoryId.DataTextField = "CategoryName";
        //     ddCategoryId.DataValueField = "CategoryId";
        //     ddCategoryId.DataBind();

        //     // Close the reader and connection
        //     dr.Close();
        //     Utils.CloseConnection();
        //     }
        // }

        protected void btnAddOnUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidtoExecute = false;
            int productId = Convert.ToInt32(hfProductId.Value);         

            Utils.OpenConnection();

            con = Utils.GetConnection();
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", productId == 0 ? "INSERT" : "UPDATE");   
            cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@Discount", txtDiscount.Text);
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text);
            cmd.Parameters.AddWithValue("@Size", txtSize.Text.Trim());
            cmd.Parameters.AddWithValue("@Color", txtColor.Text.Trim());
            cmd.Parameters.AddWithValue("@CategoryId", ddCategoryId.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

            if (fuProductImage.HasFile)
            {
                if (Utils.isValidExtension(fuProductImage.FileName))
                {
                    string newImageName = Utils.getUniqueId();
                    fileExtension = Path.GetExtension(fuProductImage.FileName);
                    imagePath = "Images/Product/" + newImageName.ToString() + fileExtension;
                    fuProductImage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + newImageName.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ProductImageUrl", imagePath);
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
                    actionName = productId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product " + actionName + " successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getProducts();
                    clear();

                    Debug.Print("Insert success");

                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Failed to insert product: " + ex.Message;
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
            txtProductName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtDiscount.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtSize.Text = string.Empty;
            txtColor.Text = string.Empty;
            hfProductId.Value = "0";
            btnAddOnUpdate.Text = "Add";
            imagePreview.ImageUrl = string.Empty;
        }

        public void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "edit")
            {
                // int productId = Convert.ToInt32(e.CommandArgument);
                Utils.OpenConnection();

                con = Utils.GetConnection();
                cmd = new SqlCommand("Product_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                txtDescription.Text = dt.Rows[0]["Description"].ToString();
                txtPrice.Text = dt.Rows[0]["Price"].ToString();
                txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                txtSize.Text = dt.Rows[0]["Size"].ToString();
                txtColor.Text = dt.Rows[0]["Color"].ToString();
                ddCategoryId.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                
                imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ProductImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["ProductImageUrl"].ToString();
                imagePreview.Height = 200;
                imagePreview.Width = 200;
                hfProductId.Value = dt.Rows[0]["ProductId"].ToString();
                btnAddOnUpdate.Text = "Update";
            }
            else if (e.CommandName == "delete")
            {
                // int productId = Convert.ToInt32(e.CommandArgument);
                Utils.OpenConnection();

                con = Utils.GetConnection();
                cmd = new SqlCommand("Product_Crud", con);
                cmd.Parameters.AddWithValue("@Action","DELETE");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                txtDescription.Text = dt.Rows[0]["Description"].ToString();
                txtPrice.Text = dt.Rows[0]["Price"].ToString();
                txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                txtSize.Text = dt.Rows[0]["Size"].ToString();
                txtColor.Text = dt.Rows[0]["Color"].ToString();
                ddCategoryId.SelectedValue = dt.Rows[0]["CategoryId"].ToString();

                imagePreview.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ProductImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["ProductImageUrl"].ToString();
                rProduct.DataSource = dt;
                rProduct.DataBind();
                try
                {
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product deleted successfully";
                    lblMsg.CssClass = "alert alert-success";
                    getProducts();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Failed to delete product: " + ex.Message;
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