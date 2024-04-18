<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="ASP_Ecommerce.Admin.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>

    
    <div class="col">
        <div class="row-md-12 p-5">
            <div class="card">
                <div class="card-body">
                    <h4 class-="card-title">User</h4>
                    <hr />
                
                    <div class="form-body pb-5">
                        <label>Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfName" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                        SafeFocusOnError="true" ErrorMessage="Name is required" ControlToValidate="txtName" runat="server" />
                                </div>
                            </div>
                        </div>

                        <label>User Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="User Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfUserName" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                        SafeFocusOnError="true" ErrorMessage="Username is required" ControlToValidate="txtUserName" runat="server" />
                                </div>
                            </div>
                        </div>

                        <label>Email</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtEmail" TextMode="Email" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfEmail" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                        SafeFocusOnError="true" ErrorMessage="Email is required" ControlToValidate="txtEmail" runat="server" />
                                </div>
                            </div>
                        </div>

                        <label>Mobile phone</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Phone number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfMobile" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                        SafeFocusOnError="true" ErrorMessage="Phone number is required" ControlToValidate="txtMobile" runat="server" />
                                </div>
                            </div>
                        </div>

                        <label>Password</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="Your password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfPassword" ForeColor="Red" Font-Size="Small" Display="Dynamic"
                                        SafeFocusOnError="true" ErrorMessage="Phone number is required" ControlToValidate="txtMobile" runat="server" />
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
                </div>
            </div>
        </div>

        <div class="row-sm-12 row-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class-="card-title">User List</h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rUser" runat="server" OnItemCommand="rUser_ItemCommand">

                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                            <tr>
                                                <th class="table-plus">Name</th>
                                                <th>Username</th>
                                                <th>Email</th>
                                                <th>Mobile</th>
                                                <th>Password</th>
                                                <th>CreatedDate</th>
                                                <th class="datatable-nosort">Action</th>
                                            </tr>
                                    </thead>
                                    <tbody>

                            </HeaderTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td class="table-plus"> <%# Eval("Name") %></td>
                                    <td> <%# Eval("UserName") %></td>
                                    <td> <%# Eval("Email") %></td>
                                    <td> <%# Eval("Mobile") %></td>
                                    <td> <%# Eval("Password") %></td>
                                    <td> <%# Eval("CreatedDate") %></td>

                                    <td>
                                        <asp:LinkButton ID="lbEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                            CommandAgrument='<%# Eval("UserId") %>' CommandName="edit" CausesValidation="false">
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lbDelete" Text="Delete" runat="server" CssClass="badge badge-danger"
                                            CommandAgrument='<%# Eval("UserId") %>' CommandName="delete" CausesValidation="false">>
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
