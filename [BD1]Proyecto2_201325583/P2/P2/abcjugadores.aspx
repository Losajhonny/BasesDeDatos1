<%@ Page Title="" Language="C#" MasterPageFile="~/administrador.master" AutoEventWireup="true" CodeBehind="abcjugadores.aspx.cs" Inherits="P2.abcjugadores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder9" runat="server">
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label2" runat="server" Text="Registrar Jugador"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label6" runat="server" Text="Equipo:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_equipo" runat="server" AutoPostBack="True" Width="180px">
        </asp:DropDownList>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label7" runat="server" Text="No Camisola:"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_reg_camisola" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label1" runat="server" Text="Posicion:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_reg_posicion" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label3" runat="server" Text="Nombre:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_reg_nombre" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label5" runat="server" Text="Estatura:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_reg_estatura" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label8" runat="server" Text="Peso:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_reg_peso" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar" runat="server" OnClick="btn_registrar_Click">Registrar</asp:LinkButton>
    </p>

    <br />


    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label9" runat="server" Text="Modificar Jugador"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label10" runat="server" Text="Equipo:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_mod_equipo" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_mod_equipo_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label4" runat="server" Text="Jugador:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_mod_jugador" runat="server" AutoPostBack="True" Width="180px">
        </asp:DropDownList>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label11" runat="server" Text="No Camisola:"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_mod_camisola" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label12" runat="server" Text="Posicion:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_mod_posicion" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label13" runat="server" Text="Nombre:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_mod_nombre" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label15" runat="server" Text="Estatura:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_mod_estatura" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label16" runat="server" Text="Peso:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txt_mod_peso" runat="server" Width="180px"></asp:TextBox>
    </p>
    <p style="margin-left: 40px">
        <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_modificar" runat="server" OnClick="btn_modificar_Click">Modificar</asp:LinkButton>
    </p>

    <br />


    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label14" runat="server" Text="Eliminar Jugador"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label17" runat="server" Text="Equipo:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_eli_equipo" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_eli_equipo_SelectedIndexChanged">
        </asp:DropDownList>
    </p>

    <div class="w3-container">
        <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        
                        
                        
                        <asp:GridView  CssClass="w3-table-all" ID="grid_jugador_equipo" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btn_eliminar" runat="server" ImageUrl="~/img/salir.png" OnClick="btn_eliminar_Click" />
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
                        
                        
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
