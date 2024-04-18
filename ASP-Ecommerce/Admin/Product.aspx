<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="ASP_Ecommerce.Admin.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>

    <div class="row">
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Product</h4>
                    <hr />
                
                    <div class="form-body pb-5">
                        <label>Product Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Product Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfProductName" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                        SafeFocusOnError="true" ErrorMessage="Product Name is required" ControlToValidate="txtProductName" runat="server" />
                                </div>
                            </div>
                        </div>

                        <label>Product Image</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control"
                                        onchange="ImagePreview(this);"/>
                                    <asp:HiddenField ID="hfProductId" runat="server" Value="0"/>
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
                        <asp:Image ID="imagePreview" runat="server" CssClass="img-thumbnail" AlternateText="image" />
                    </div>
                </div>
            </div>
        </div>
 
        <div class="col-sm-12 col-md-8">
            <div class="card">
                 <div class="card-body">
                     <h4 class-="card-title">Product List</h4>
                     <hr />
                     <div class="table-responsive">
                         <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand">

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

                             </HeaderTemplate>

                             <ItemTemplate>
                                 <tr>
                                     <td class="table-plus"> <%# Eval("ProductName") %></td>
                                     <td> 
                                         <img width="40" src="<%# ASP_Ecommerce.Utils.getImageUrl( Eval("ProductImageUrl")) %>" alt="image" />
                                     </td>

                                     <td>
                                         <asp:Label ID="lblIsActive" 
                                                    Text='<%# (bool)Eval("IsActive") == true ? "Active" : "In-Active" %>'
                                                    CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>'
                                                    runat="server" >
                                         </asp:Label>
                                     </td>

                                     <td> <%# Eval("CreatedDate") %></td>

                                     <td>
                                         <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                             CommandAgrument='<%# Eval("ProductId") %>' CommandName="edit" CausesValidation="false">
                                             <i class="fas fa-edit"></i>
                                         </asp:LinkButton>
                                         <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                                             CommandAgrument='<%# Eval("ProductId") %>' CommandName="delete" CausesValidation="false">>
                                             <i class="fas fa-trash-alt"></i>
                                         </asp:LinkButton>
                                     </td>

                                 </tr>
                             </ItemTemplate>

                             <FooterTemplate>
                                 </tbody>
                                 </table>
                             </FooterTemplate>
                         </asp:Repeater>
                     </div>
                 </div>
            </div>
        </div>
    </div>
</asp:Content>
