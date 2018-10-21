<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="BD_p1.apps._default" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Corusac - Log-in</title>
    <script type="text/javascript">
        function alerta(mensaje) {
            alert(mensaje);
        }

        function AlertBox(msgtitle, message, controlToFocus) {
            $("#msgDialogAlert").dialog({
                autoOpen: false,
                modal: true,
                title: msgtitle,
                closeOnEscape: true,
                buttons: [{
                    text: "Ok",
                    click: function () {
                        $(this).dialog("close");
                        if (controlToFocus != null)
                            controlToFocus.focus();
                    }
                }],
                close: function () {
                    $("#operationMsgAlert").html("");
                    if (controlToFocus != null)
                        controlToFocus.focus();
                },
                show: { effect: "clip", duration: 200 }
            });
            $("#operationMsgAlert").html(message);
            $("#msgDialogAlert").dialog("open");
        };
  </script>
  <!--<link rel='stylesheet' href='http://codepen.io/assets/libs/fullpage/jquery-ui.css'>-->
  <link rel="stylesheet" href="login/style.css" media="screen" type="text/css" />
</head>
<body>

  <div class="login-card" id="logo">
      <h1>Log-in</h1><br> 

      <form id="form1" runat="server">
            <asp:TextBox ID="txt_usuario" runat="server" placeholder="&#128272; Usuario"></asp:TextBox>
            <asp:TextBox ID="txt_password" runat="server" type="password"  placeholder="&#128272; Password"></asp:TextBox>&nbsp;
            <asp:Button ID="btn_login" runat="server" Text="Login" OnClick="btn_login_Click" />&nbsp;
            <asp:Button ID="btn_registrar" runat="server" Text="Registrar" OnClick="btn_registrar_Click" />
      </form>

  <!--<div class="login-help">
    <a href="#">Register</a> • <a href="#">Forgot Password</a>
  </div>-->
</div>
  <!--<script src='http://codepen.io/assets/libs/fullpage/jquery_and_jqueryui.js'></script>-->
</body>
</html>