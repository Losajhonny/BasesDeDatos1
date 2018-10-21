<%@ Page Title="" Language="C#" MasterPageFile="~/apps/usuario.Master" AutoEventWireup="true" CodeBehind="usuario.aspx.cs" Inherits="BD_p1.apps.usuario1" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="cont_titulo_pag">
    <asp:Label ID="et_titulo" runat="server" Text="Label"></asp:Label>
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="cont_cuerpo">
    <asp:GridView ID="grid_correos" runat="server" CellPadding="4" Font-Size="10pt" Font-Strikeout="False" ForeColor="#333333" GridLines="None" Width="778px">
    <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/img/leer.png" OnClick="ImageButton1_Click" ToolTip="Leer" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/img/eliminar.png" OnClick="ImageButton2_Click" ToolTip="Eliminar" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/img/mover.png" OnClick="ImageButton3_Click" ToolTip="Mover" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" ToolTip="Estado" Text="No leido" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
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
</asp:Content>




