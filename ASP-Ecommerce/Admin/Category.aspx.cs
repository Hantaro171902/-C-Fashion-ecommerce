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

namespace ASP_Ecommerce.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblImg.Visible = false;
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
            cmd.Parameters.AddWithValue("@CategoryName", txtCategoryName.Text);
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

                }
                else
                {
                    lblImg.Visible = false;
                    lblImg.Text = "Please select .jpg .png or .gif image";
                    lblImg.CssClass = "alert alert-danger";
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
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = categoryId == 0 ? "inserted" : "Successful";
                    lblImg.Visible = true;
                    lblImg.Text = "Category " + actionName + " successfully";
                    lblImg.CssClass = "alert alert-success";
                }
                catch(Exception ex)
                {
                    lblImg.Visible = true;
                    lblImg.Text = "Failed to insert category: " + ex.Message;
                    lblImg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }   
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }


        void  clear()
        {
            txtCategoryName.Text = string.Empty;
            cbIsActive.Checked = false;
            hfCategoryId.Value = "0";
            btnAddOnUpdate.Text = "Add";
            ImagePreview.ImageUrl = string.Empty;
        }
    }
}