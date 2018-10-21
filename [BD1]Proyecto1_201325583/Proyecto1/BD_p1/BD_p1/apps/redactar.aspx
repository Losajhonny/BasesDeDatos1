<%@ Page Title="" Language="C#" MasterPageFile="~/apps/usuario.Master" AutoEventWireup="true" CodeBehind="redactar.aspx.cs" Inherits="BD_p1.apps.redactar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cont_titulo_pag" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cont_cuerpo" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Label ID="Label2" runat="server" Text="Mensaje Nuevo"></asp:Label>
</asp:Content>
<asp:Content ID="Content4" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <asp:Label ID="Label4" runat="server" Text="Para:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txt_para" runat="server" Width="706px" AutoCompleteType="Disabled"></asp:TextBox>
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="ContentPlaceHolder3">
    <asp:Label ID="Label5" runat="server" Text="cc:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txt_cc" runat="server" Width="706px" AutoCompleteType="Disabled"></asp:TextBox>
</asp:Content>
<asp:Content ID="Content6" runat="server" contentplaceholderid="ContentPlaceHolder4">
    <asp:Label ID="Label6" runat="server" Text="Bcc:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txt_bcc" runat="server" Width="706px" AutoCompleteType="Disabled"></asp:TextBox>
</asp:Content>
<asp:Content ID="Content7" runat="server" contentplaceholderid="ContentPlaceHolder5">
    <asp:Label ID="Label7" runat="server" Text="Asunto:"></asp:Label>
&nbsp;<asp:TextBox ID="txt_asunto" runat="server" Width="706px" AutoCompleteType="Disabled"></asp:TextBox>
</asp:Content>
<asp:Content ID="Content8" runat="server" contentplaceholderid="ContentPlaceHolder6">
    <asp:TextBox ID="txt_texto" runat="server" AutoPostBack="True" Height="256px" TextMode="MultiLine" Width="756px" AutoCompleteType="Disabled"></asp:TextBox>
    <asp:Label ID="Label8" runat="server" Font-Size="10pt" Text="Maximo 256"></asp:Label>
</asp:Content>
<asp:Content ID="Content9" runat="server" contentplaceholderid="ContentPlaceHolder7">
    <asp:LinkButton ID="lb_enviar" runat="server" OnClick="lb_enviar_Click">Enviar</asp:LinkButton>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lb_guardar" runat="server" OnClick="lb_guardar_Click">Guardar</asp:LinkButton>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="adjuntar" runat="server" AllowMultiple="True" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</asp:Content>
