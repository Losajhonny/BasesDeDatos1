<%@ Page Title="" Language="C#" MasterPageFile="~/administrador.master" AutoEventWireup="true" CodeBehind="carga.aspx.cs" Inherits="P2.carga" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder9" runat="server">
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label2" runat="server" Text="Carga de Jugadores, Equipos y Catologo Partidos"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:FileUpload ID="upload_jecp" runat="server" BorderStyle="None" />
    </p>
    <p style="margin-left: 40px">        
        <asp:LinkButton ID="btn_jecp" runat="server" BorderStyle="None" class="w3-bar-item w3-button w3-padding w3-blue" OnClick="btn_jecp_Click">Cargar Archivo</asp:LinkButton>
    </p>

    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label1" runat="server" Text="Carga de Usuarios, Pronosticos y Marcadores Reales"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:FileUpload ID="upload_upmr" runat="server" BorderStyle="None" />
    </p>
    <p style="margin-left: 40px">        
        <asp:LinkButton ID="btn_upmr" runat="server" BorderStyle="None" class="w3-bar-item w3-button w3-padding w3-blue" OnClick="btn_upmr_Click">Cargar Archivo</asp:LinkButton>
    </p>
</asp:Content>
