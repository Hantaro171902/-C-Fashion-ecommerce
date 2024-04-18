﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="ASP_Ecommerce.Admin.Category" %>
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
 
        <div class="col-sm-12 col-md-8">
            <div class="card">
                 <div class="card-body">
                     <h4 class-="card-title">Category List</h4>
                     <hr />
                     <div class="table-responsive">
                         <asp:Repeater ID="rCategory" runat="server">

                             <HeaderTemplate>
                                 <table class="table data-table-export table-hover nowrap">
                                     <thead>
                                            <tr>
                                                <th class="table-plus">Name</th>
                                                <th>Image</th>
                                                <th>IsActive</th>
                                                <th>CreatedDate</th>
                                                <th class="datatable-nosort">Action</th>
                                            </tr>
                                     </thead>
                                     <tbody>

                                     </tbody>
                                 </table>
                             </HeaderTemplate>

                             <ItemTemplate>
                                 <tr>
                                     <td class="table-plus"> <%# Eval("CategoryName") %></td>
                                     <td> 
                                         <img width="40" src="<%# ASP_Ecommerce.Utils.getImageUrl( Eval("CategoryImageUrl")) %>" alt="image" />
                                     </td>

                                     <td>
                                         <asp:Label ID="lblIsActive" 
                                                    Text='<%# (bool)Eval("IsActive") == true ? "Active" : "In-Active" %>'
                                                    CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>'
                                                    runat="server" >
                                         </asp:Label>
                                     </td>

                                     <td> <%# Eval("CreatedDate") != DBNull.Value ? Eval("CreatedDate") : "N/A" %></td>
                                     <td>
                                         <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary">
                                             <i class="fas fa-edit"></i>
                                         </asp:LinkButton>
                                         <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger">
                                             <i class="fas fa-trash-alt"></i>
                                         </asp:LinkButton>
                                     </td>
                                 </tr>
                             </ItemTemplate>

                             <FooterTemplate></FooterTemplate>
                         </asp:Repeater>
                     </div>
                 </div>
            </div>
        </div>
    </div>


  
</asp:Content>
