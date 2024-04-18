<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="ASP_Ecommerce.Admin.Category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mb-4">
        <asp:Label ID="lblImg" runat="server"></asp:Label>
    </div>

    <div class="row">
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class-="card-title">Category</h4>
                    <hr />
                </div>

                <div class="form-body">
                    <label>Category Name</label>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Category Name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfCategoryName" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                    SafeFocusOnError="true" ErrorMessage="Category Name is required" ControlToValidate="txtCategoryName" runat="server" />
                            </div>
                        </div>
                    </div>

                    <label>Category Image</label>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="form-control" />
                                <asp:HiddenField ID="hfCategoryId" runat="server" Value="0"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:CheckBox ID="cbIsActive" Text="&nbsp; IsActive" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-actions pb-5">
                    <div class="text-left">
                        <asp:Button ID="btnAddOnUpdate" runat="server" CssClass="btn btn-info" Text="Add" OnClick="btnAddOnUpdate_Click"/>
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" />
                    </div>
                </div>

                <div>
                    <asp:Image ID="ImagePreview" runat="server" CssClass="img-thumbnail" AlternateText="" />
                </div>

            </div>
        </div>
 
        <div class="col-sm-12 col-md-4">
            <div class="card">
                 <div class="card-body">
                     <h4 class-="card-title">Category</h4>
                     <hr />
                 </div>
            </div>
        </div>
    </div>


  
</asp:Content>
