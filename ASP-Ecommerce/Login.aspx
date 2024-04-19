<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ASP_Ecommerce.Login1" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<style>
    body { font-family: Arial, sans-serif; }
    .login-container { width: 300px; margin: 100px auto; padding: 20px; border: 1px solid #ccc; }
    input[type="text"], input[type="password"] { width: 100%; padding: 10px; margin: 10px 0; }
    input[type="submit"] { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; cursor: pointer; }
    input[type="submit"]:hover { background-color: #0056b3; }
</style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="LoginHandler.aspx" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Login">
    </form>
</div>
</body>
</html>

