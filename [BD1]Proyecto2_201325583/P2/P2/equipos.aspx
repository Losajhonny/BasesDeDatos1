<%@ Page Title="" Language="C#" MasterPageFile="~/sitio.Master" AutoEventWireup="true" CodeBehind="equipos.aspx.cs" Inherits="P2.equipos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:Panel ID="panel_administrador" runat="server" Visible="False">
        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label11" runat="server" Text="Administrar Equipos"></asp:Label></b></h5>
        <asp:Panel style="margin-left: 40px" ID="panel6" runat="server">
            <asp:Label ID="Label12" runat="server" Text="ABC: "></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="droplist_abc" runat="server" AutoPostBack="True" Width="250px" OnSelectedIndexChanged="droplist_abc_SelectedIndexChanged">
                <asp:ListItem>Registrar</asp:ListItem>
                <asp:ListItem>Modificar</asp:ListItem>
                <asp:ListItem>Eliminar</asp:ListItem>
            </asp:DropDownList>
        </asp:Panel>
        <br />

        <!--================== PANEL DE REGISTRAR =================================================-->
        <asp:Panel ID="panel_registrar" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label2" runat="server" Text="Registrar Equipo"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel1" runat="server">
                <asp:Label ID="Label3" runat="server" Text="Nombre"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_registrar_nombre" runat="server" Width="180px"></asp:TextBox>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel2" runat="server">
                <asp:Label ID="Label4" runat="server" Text="Confederacion"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_registrar_confede" runat="server" Width="180px"></asp:TextBox>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel3" runat="server">
                <asp:CheckBox ID="check_select_con" runat="server" Text="     Seleccionar Confederacion" AutoPostBack="True" OnCheckedChanged="Check_select_con_CheckedChanged" />
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel4" runat="server">
                <asp:Label ID="Label5" runat="server" Text="Confederacion" Visible="False"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_confede1" runat="server" Visible="False" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="droplist_confede1_SelectedIndexChanged">
                    <asp:ListItem>CONMEBOL</asp:ListItem>
                </asp:DropDownList>
            </asp:Panel>
            <asp:Panel style="margin-left: 40px" ID="panel5" runat="server">
                <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar" runat="server" OnClick="btn_registrar_Click">Registrar</asp:LinkButton>
            </asp:Panel>
        </asp:Panel>
        <!--================== PANEL DE REGISTRAR =================================================-->

        <!--================== PANEL DE MODIFICAR =================================================-->
        <asp:Panel ID="panel_modificar" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label6" runat="server" Text="Modificar Equipo"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel7" runat="server">
                <asp:Label ID="Label7" runat="server" Text="Equipo"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_equipo" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="droplist_equipo_SelectedIndexChanged">
                </asp:DropDownList>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel8" runat="server">
                <asp:Label ID="Label1" runat="server" Text="Nombre"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_modificar_nombre" runat="server" Width="180px"></asp:TextBox>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel9" runat="server">
                <asp:Label ID="Label8" runat="server" Text="Confederacion"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_modificar_confede" runat="server" Width="180px"></asp:TextBox>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel10" runat="server">
                <asp:CheckBox ID="check_modequipo" runat="server" Text="     Seleccionar Confederacion" AutoPostBack="True" OnCheckedChanged="check_modequipo_CheckedChanged"/>
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel11" runat="server">
                <asp:Label ID="Label9" runat="server" Text="Confederacion" Visible="False"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList CssClass="dropdown-item" ID="droplist_confede2" runat="server" Width="180px" AutoPostBack="True" Visible="False" OnSelectedIndexChanged="droplist_confede2_SelectedIndexChanged">
                    <asp:ListItem>CONMEBOL</asp:ListItem>
                </asp:DropDownList>
            </asp:Panel>
            <asp:Panel style="margin-left: 40px" ID="panel12" runat="server">
                <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_modificar" runat="server" OnClick="btn_modificar_Click">Modificar</asp:LinkButton>
            </asp:Panel>
        </asp:Panel>
        <!--================== PANEL DE MODIFICAR =================================================-->

        <!--================== PANEL DE ELIMINAR =================================================-->
        <asp:Panel ID="panel_eliminar" runat="server" Visible="False">
        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label10" runat="server" Text="Eliminar Equipo"></asp:Label></b></h5>
        
        <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <div class="w3-container">
                <asp:GridView  CssClass="w3-table-all" ID="grid_equipos" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" HorizontalAlign="Left" EmptyDataText="Lista de Equipos vacio">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="btn_eliminar" runat="server" ImageUrl="~/img/salir.png" OnClick="btn_eliminar_Click" Width="25px" />
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
        </asp:Panel>
        <!--================== PANEL DE ELIMINAR =================================================-->
    </asp:Panel>

    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label13" runat="server" Text="Selecciones por Grupos"></asp:Label></b></h5>
    <asp:Panel style="margin-left: 40px" ID="panel13" runat="server">
        <asp:Label ID="Label14" runat="server" Text="Grupo"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList CssClass="dropdown-item" ID="droplist_seleccion" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="droplist_seleccion_SelectedIndexChanged">
        </asp:DropDownList>
   </asp:Panel>
    <br />
    <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <div class="w3-container">
                <asp:GridView  CssClass="w3-table-all" ID="grid_seleccion" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" HorizontalAlign="Left" EmptyDataText="Lista de Equipos vacio">
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
