<%@ Page Title="" Language="C#" MasterPageFile="~/administrador.master" AutoEventWireup="true" CodeBehind="abcgrupos.aspx.cs" Inherits="P2.abcgrupos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder9" runat="server">
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label2" runat="server" Text="Registrar Grupo"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label3" runat="server" Text="Nombre Grupo:"></asp:Label>
        &nbsp;
        <asp:TextBox ID="txt_nombre_grupo" runat="server" Width="180px"></asp:TextBox>
        &nbsp;&nbsp;<asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_registrar" runat="server" OnClick="btn_registrar_Click">Registrar</asp:LinkButton>
    </p>
    <br />
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label4" runat="server" Text="Agregar Equipo a un Grupo"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label5" runat="server" Text="Grupo: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_grupo" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_grupo_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p style="margin-left: 40px">
        <asp:Label ID="Label6" runat="server" Text="Equipo:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_equipo" runat="server" AutoPostBack="True" Width="180px" OnSelectedIndexChanged="droplist_equipo_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p style="margin-left: 40px">
        <asp:LinkButton class="w3-bar-item w3-button w3-padding w3-blue" ID="btn_asignar" runat="server" OnClick="btn_asignar_Click">Asignar</asp:LinkButton>
    </p>
    <p style="margin-left: 40px">
        &nbsp;</p>
    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><asp:Label ID="Label1" runat="server" Text="Eliminar un Equipo de un Grupo"></asp:Label></b></h5>
    <p style="margin-left: 40px">
        <asp:Label ID="Label7" runat="server" Text="Grupo:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="droplist_grupo_eliminar" runat="server" AutoPostBack="True" OnSelectedIndexChanged="droplist_grupo_eliminar_SelectedIndexChanged" Width="180px">
        </asp:DropDownList>
    </p>
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
</asp:Content>
