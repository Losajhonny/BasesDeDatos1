<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registrar.aspx.cs" Inherits="P2.registrar" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Registrar</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="Login/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="Login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="Login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="Login/css/util.css">
	<link rel="stylesheet" type="text/css" href="Login/css/main.css">
<!--===============================================================================================-->
    <script src="Sweet/sweetalert.js" type="text/javascript"></script>
    <script>
        function mensaje(titulo, tipo, mensaje, forma) {
            if (forma == 0) {
                const toast = swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000
                });

                toast({
                    type: tipo,
                    title: mensaje
                })
            } else if (forma == 1) {
                swal({
                    position: 'top-end',
                    type: tipo,
                    title: mensaje,
                    showConfirmButton: false,
                    timer: 3000
                })
            } else {
                swal({
                    type: tipo,
                    title: titulo,
                    text: mensaje
                })
            }
        }
    </script>
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form id="form1" runat="server">
					<span class="login100-form-title p-b-51">
						Registrar
					</span>

                    <div class="wrap-input100 validate-input m-b-16" data-validate="Nombre is required">
                        <asp:TextBox CssClass="input100" type="text" name="nombre" placeholder="Nombre" ID="txt_nombre" runat="server"></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>

                    <div class="wrap-input100 validate-input m-b-16" data-validate="Edad is required">
                        <asp:TextBox CssClass="input100" type="text" name="edad" placeholder="Edad" ID="txt_edad" runat="server"></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>

                    <div class="wrap-input100 validate-input m-b-16" data-validate="Pais is required">
                        <asp:TextBox CssClass="input100" type="text" name="pais" placeholder="pais" ID="txt_pais" runat="server"></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>					
					
                    <div class="container-login100-form-btn m-t-17">
                        <asp:DropDownList CssClass="login100-form-btn" ID="droplist_pagado" runat="server" OnSelectedIndexChanged="droplist_pagado_SelectedIndexChanged" AutoPostBack="True">
                            <asp:ListItem>Sin Pagar</asp:ListItem>
                            <asp:ListItem>Pagar</asp:ListItem>
                        </asp:DropDownList>
                    </div>

					<div class="container-login100-form-btn m-t-17">
						<!--<button class="login100-form-btn">Login</button>-->
					    <asp:Button CssClass="login100-form-btn" ID="btn_registrar" runat="server" Text="Registrar" OnClick="btn_registrar_Click"/>
					</div>
                    <div class="container-login100-form-btn m-t-17">						
					    <asp:Button CssClass="login100-form-btn" ID="btn_back" runat="server" Text="Back" OnClick="btn_back_Click"/>
					</div>
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="Login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="Login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="Login/vendor/bootstrap/js/popper.js"></script>
	<script src="Login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="Login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="Login/vendor/daterangepicker/moment.min.js"></script>
	<script src="Login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="Login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="Login/js/main.js"></script>

</body>
</html>