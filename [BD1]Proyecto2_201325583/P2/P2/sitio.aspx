<%@ Page Title="" Language="C#" MasterPageFile="~/sitio.Master" AutoEventWireup="true" CodeBehind="sitio.aspx.cs" Inherits="P2.sitio1" %>


      <asp:Content ID="Content1" runat="server" contentplaceholderid="ContentPlaceHolder1">
          <!--<a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
          <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
          <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a>
          -->
          <!--<asp:LinkButton CssClass="w3-bar-item w3-button" ID="LinkButton4" runat="server"><i></i></asp:LinkButton>-->
      </asp:Content>



<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <asp:LinkButton class="w3-bar-item w3-button w3-padding" ID="btn_registrar" runat="server" OnClick="btn_registrar_Click"><i class="fa fa-registered w3-text-blue fa-fw"></i>Registrar</asp:LinkButton>
    <asp:LinkButton class="w3-bar-item w3-button w3-padding" ID="btn_login" runat="server" OnClick="btn_login_Click"><i class="fa fa-lock w3-text-blue fa-fw"></i>Login</asp:LinkButton>


</asp:Content>




<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">
    <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-quarter">
      <div class="w3-container w3-red w3-padding-16">
        <div class="w3-left"><i class="fa fa-spinner w3-xxxlarge"></i></div>
        <div class="w3-right">
            <i class="fa fa-hand-grab-o w3-xxxlarge"></i>
            <!--<i class="fa fa-hand-lizard-o w3-xxlarge"></i>
            <i class="fa fa-hand-o-down w3-xxxlarge"></i>
            <i class="fa fa-hand-o-left w3-xxxlarge"></i>
            <i class="fa fa-hand-o-right w3-xxxlarge"></i>
            <i class="fa fa-hand-o-up w3-xxxlarge"></i>
            <i class="fa fa-hand-paper-o w3-xxxlarge"></i>
            <i class="fa fa-hand-peace-o w3-xxxlarge"></i>
            <i class="fa fa-hand-pointer-o w3-xxxlarge"></i>
            <i class="fa fa-hand-rock-o w3-xxxlarge"></i>
            <i class="fa fa-hand-scissors-o w3-xxxlarge"></i>
            <i class="fa fa-hand-spock-o w3-xxxlarge"></i>
            <i class="fa fa-hand-stop-o w3-xxxlarge"></i>
            <i class="fa fa-handshake-o w3-xxxlarge"></i>-->
          
        </div>
        <div class="w3-clear"></div>
        <h4>Equipos</h4>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-blue w3-padding-16">
        <div class="w3-left"><i class="fa fa-universal-access w3-xxxlarge"></i></div>
        <div class="w3-right">
          <i class="fa fa-hand-o-up w3-xxxlarge"></i>
        </div>
        <div class="w3-clear"></div>
        <h4>Jugadores</h4>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-teal w3-padding-16">
        <div class="w3-left"><i class="fa fa-group w3-xxxlarge"></i></div>
        <div class="w3-right">
          <i class="fa fa-hand-o-left w3-xxxlarge"></i>
        </div>
        <div class="w3-clear"></div>
        <h4>Grupos</h4>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-orange w3-text-white w3-padding-16">
        <div class="w3-left"><i class="fa fa-soccer-ball-o w3-xxxlarge"></i></div>
        <div class="w3-right">
          <i class="fa fa-handshake-o w3-xxxlarge"></i>
        </div>
        <div class="w3-clear"></div>
        <h4>Partidos</h4>
      </div>
    </div>
  </div>




    <div class="w3-panel">
    <div class="w3-row-padding" style="margin:0 -16px">
      <div>
        <h5>Regions</h5>
        <img src="img/region.png" style="width:100%" alt="Google Regional Map">
      </div>
    </div>
  </div>
</asp:Content>







