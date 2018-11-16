<%@ Page Title="" Language="C#" MasterPageFile="~/sitio.Master" AutoEventWireup="true" CodeBehind="partidos.aspx.cs" Inherits="P2.partidos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    

    <!--OPCIONES DE ADMINISTRADOR-->
    <asp:Panel ID="panel_administrador" runat="server" Visible="false">

        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label11" runat="server" Text="Administrar Equipos"></asp:Label></b></h5>
        <asp:Panel style="margin-left: 40px" ID="panel6" runat="server">
            <asp:Label ID="Label12" runat="server" Text="ABC: "></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="droplist_abc" runat="server" AutoPostBack="True" Width="250px" OnSelectedIndexChanged="droplist_abc_SelectedIndexChanged">
                <asp:ListItem>Registrar Partido</asp:ListItem>
                <asp:ListItem>Modificar Partido</asp:ListItem>
                <asp:ListItem>Eliminar Partido</asp:ListItem>
                <asp:ListItem>Registrar Marcador Real</asp:ListItem>
                <asp:ListItem>Registrar Pronostico</asp:ListItem>
                <asp:ListItem>Registrar Goles</asp:ListItem>
            </asp:DropDownList>
        </asp:Panel>
        <br />

        <asp:Panel ID="panel_marcador_real" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label9" runat="server" Text="Registrar Marcador Real"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel5" runat="server">
                <asp:Label ID="Label14" runat="server" Text="Partido"></asp:Label>
            &nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_equipo_par1" runat="server" Width="250px" AutoPostBack="True">
                </asp:DropDownList>
            </asp:Panel>
            <asp:Panel style="margin-left: 40px" ID="panel1" runat="server">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_mar1_par" TextMode="Number" runat="server" Width="40px">0</asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_mar2_par" TextMode="Number" runat="server" Width="40px">0</asp:TextBox>
                </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel9" runat="server">
                <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar_par" runat="server" OnClick="btn_registrar_par_Click">Registrar</asp:LinkButton>
            </asp:Panel>
        </asp:Panel>

        <asp:Panel ID="panel_registrar_pronostico" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label5" runat="server" Text="Registrar Pronostico"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel4" runat="server">
                <asp:Label ID="Label8" runat="server" Text="Local"></asp:Label>
            &nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_equipo_pro1" runat="server" Width="150px" AutoPostBack="True" OnSelectedIndexChanged="droplist_equipo_pro1_SelectedIndexChanged">
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_mar1_pro" TextMode="Number" runat="server" Width="40px">0</asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_mar2_pro" TextMode="Number" runat="server" Width="40px">0</asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_equipo_pro2" runat="server" Width="150px" AutoPostBack="True">
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Text="Visitante"></asp:Label>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel8" runat="server">
                <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar_pro" runat="server">Registrar</asp:LinkButton>
            </asp:Panel>
        </asp:Panel>

        <asp:Panel ID="panel_registro_goles" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label10" runat="server" Text="Registrar Goles"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel7" runat="server">
                <asp:Label ID="Label7" runat="server" Text="Equipo"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_equipo" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="droplist_equipo_SelectedIndexChanged">
                </asp:DropDownList>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel2" runat="server">
                <asp:Label ID="Label2" runat="server" Text="Jugador"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_jugador" runat="server" Width="180px" AutoPostBack="True">
                </asp:DropDownList>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel12" runat="server">
                <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar_goles" runat="server" OnClick="btn_registrar_goles_Click">Registrar</asp:LinkButton>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>





    <!--OPCIONES DE USUARIO-->
    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label1" runat="server" Text="Resultados de Equipos"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label3" runat="server" Text="Equipo: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_equipo1" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_equipo1_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <div class="w3-container">
        <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <asp:GridView CssClass="w3-table-all" ID="grid_resultados" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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

    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label4" runat="server" Text="Partidos de Equipos Sin Jugar"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label6" runat="server" Text="Grupo: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_grupo2" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_equipo2_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <div class="w3-container">
        <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <asp:GridView CssClass="w3-table-all" ID="grid_partidos" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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
