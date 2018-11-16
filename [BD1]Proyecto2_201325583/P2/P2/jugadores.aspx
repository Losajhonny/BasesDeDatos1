<%@ Page Title="" Language="C#" MasterPageFile="~/sitio.Master" AutoEventWireup="true" CodeBehind="jugadores.aspx.cs" Inherits="P2.jugadores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label13" runat="server" Text="Jugadores por Equipo"></asp:Label></b></h5>
    <asp:Panel style="margin-left: 40px" ID="panel13" runat="server">
        <asp:Label ID="Label14" runat="server" Text="Equipo"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList CssClass="dropdown-item" ID="droplist_equipo" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="droplist_equipo_SelectedIndexChanged">
        </asp:DropDownList>
   </asp:Panel>
    <br />
    <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <div class="w3-container">
                <asp:GridView  CssClass="w3-table-all" ID="grid_jugadores" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" HorizontalAlign="Left" EmptyDataText="Lista de Jugadores vacio">
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
