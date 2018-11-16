<%@ Page Title="" Language="C#" MasterPageFile="~/sitio.Master" AutoEventWireup="true" CodeBehind="grupos.aspx.cs" Inherits="P2.grupos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:Panel ID="panel_administrador" runat="server" Visible="False">
        <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label1" runat="server" Text="Administrar Grupos"></asp:Label>
            </b></h5>
        <asp:Panel style="margin-left: 40px" ID="panel6" runat="server">
            <asp:Label ID="Label3" runat="server" Text="ABC: "></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="droplist_abc" runat="server" AutoPostBack="True" Width="250px" OnSelectedIndexChanged="droplist_abc_SelectedIndexChanged">
                <asp:ListItem>Registrar Grupo</asp:ListItem>
                <asp:ListItem>Agregar Equipo a un Grupo</asp:ListItem>
                <asp:ListItem>Eliminar Equipo de un Grupo</asp:ListItem>
            </asp:DropDownList>
        </asp:Panel>
            <br />
        <!--================== PANEL DE REGISTRAR GRUPO =================================================-->
            <asp:Panel ID="panel_registrar_grupo" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label4" runat="server" Text="Registrar Grupo"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel1" runat="server">
        
                <asp:Label ID="Label6" runat="server" Text="Nombre Grupo:"></asp:Label>
                &nbsp;
                <asp:TextBox ID="txt_nombre_grupo" runat="server" Width="180px"></asp:TextBox>
                &nbsp;&nbsp;<asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar" runat="server" OnClick="btn_registrar_Click">Registrar</asp:LinkButton>
    
            </asp:Panel>
            </asp:Panel>
        <!--================== PANEL DE REGISTRAR GRUPO =================================================-->
    
        <!--================== PANEL DE AGREGAR EQUIPO A UN GRUPO =================================================-->
            <asp:Panel ID="panel_agregar_equipo" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label7" runat="server" Text="Agregar Equipo a un Grupo"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel2" runat="server">
    
                <asp:Label ID="Label8" runat="server" Text="Grupo: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="droplist_grupo2" runat="server" AutoPostBack="True" Width="180px">
                </asp:DropDownList>
        
            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel3" runat="server">

                <asp:Label ID="Label9" runat="server" Text="Equipo:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="droplist_equipo" runat="server" AutoPostBack="True" Width="180px">
                </asp:DropDownList>

            </asp:Panel>
            <br />
            <asp:Panel style="margin-left: 40px" ID="panel4" runat="server">
                <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_asignar" runat="server" OnClick="btn_asignar_Click">Asignar</asp:LinkButton>
            </asp:Panel>
            </asp:Panel>
        <!--================== PANEL DE AGREGAR EQUIPO A UN GRUPO =================================================-->

        <!--================== PANEL DE ELIMINAR EQUIPO DE UN GRUPO =================================================-->
            <asp:Panel ID="panel_eliminar_equipo" runat="server" Visible="False">
            <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label10" runat="server" Text="Eliminar un Equipo de un Grupo"></asp:Label></b></h5>
            <asp:Panel style="margin-left: 40px" ID="panel5" runat="server">
                <asp:Label ID="Label11" runat="server" Text="Grupo:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="droplist_grupo_eliminar" runat="server" AutoPostBack="True" OnSelectedIndexChanged="droplist_grupo_eliminar_SelectedIndexChanged" Width="180px">
                </asp:DropDownList>
            </asp:Panel>
            <br />
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <div class="w3-container">
                            <div class="w3-container">
                        
                                <asp:GridView  CssClass="w3-table-all" ID="grid_equipos" runat="server" CellPadding="4" EmptyDataText="Lista de Grupos vacio" ForeColor="#333333" GridLines="None">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btn_eliminar_asignacion" runat="server" ImageUrl="~/img/salir.png" OnClick="btn_eliminar_asignacion_Click" />
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
        <!--================== PANEL DE ELIMINAR EQUIPO DE UN GRUPO =================================================-->
    </asp:Panel>













    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label2" runat="server" Text="Equipos por Grupos"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label5" runat="server" Text="Grupo: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_grupo" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_grupo_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <div class="w3-container">
        <div class="w3-container">
            <div class="w3-container">
                <div class="w3-container">
                    <div class="w3-container">
                        <asp:GridView CssClass="w3-table-all" ID="grid_grupos" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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
