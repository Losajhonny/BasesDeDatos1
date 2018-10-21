<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registrar.aspx.cs" Inherits="BD_p1.apps.registrar" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Corusac - Registrar</title>
  <!--<link rel='stylesheet' href='http://codepen.io/assets/libs/fullpage/jquery-ui.css'>-->
  <link rel="stylesheet" href="login/style.css" media="screen" type="text/css" />
</head>
<body>

  <div class="login-card" id="logo">
      <h1>Registrar</h1><br> 
      <form id="form1" runat="server">
            <asp:TextBox ID="txt_nombre" runat="server" placeholder="&#128272; Nombre Completo"></asp:TextBox>
            <asp:TextBox ID="txt_empresa" runat="server" placeholder="&#128272; Nombre Empresa"></asp:TextBox>
            <asp:TextBox ID="txt_usuario" runat="server" placeholder="&#128272; Identificador Usuario"></asp:TextBox>
            <asp:TextBox ID="txt_dominio" runat="server" placeholder="&#128272; Dominio"></asp:TextBox>
            <asp:TextBox ID="txt_password" runat="server" type="password"  placeholder="&#128272; Password"></asp:TextBox>&nbsp;
            <asp:Button ID="btn_registrar" runat="server" Text="Registrar" OnClick="btn_registrar_Click" />&nbsp;
            <asp:Button ID="btn_login" runat="server" Text="Login" OnClick="btn_login_Click" />
      </form>

  <!--<div class="login-help">
    <a href="#">Register</a> • <a href="#">Forgot Password</a>
  </div>-->
</div>
  <!--<script src='http://codepen.io/assets/libs/fullpage/jquery_and_jqueryui.js'></script>-->
</body>
</html>