using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class abcjugadores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mostrar_equipo(droplist_equipo);
                mostrar_equipo(droplist_mod_equipo);
                mostrar_equipo(droplist_eli_equipo);
                actualizar_grid_jugador();
                mostrar_drop_jugador();
                string mensaje = "mensaje('','info','ABC Jugadores','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        public void actualizar_grid_jugador()
        {
            string equipo = droplist_eli_equipo.Text;
            grid_jugador_equipo.DataSource = Jugador.vista_jugador_equipo(equipo);
            grid_jugador_equipo.DataBind();
        }

        public void mostrar_drop_jugador()
        {
            string equipo = droplist_mod_equipo.Text;
            droplist_mod_jugador.DataSource = Jugador.vista_jugador_equipo2(equipo);
            droplist_mod_jugador.DataTextField = "nocamisola";
            droplist_mod_jugador.DataValueField = "nocamisola";
            droplist_mod_jugador.DataBind();
        }

        public static void mostrar_equipo(DropDownList lista)
        {
            lista.DataSource = Equipo.vista_equipo();
            lista.DataTextField = "nombre";
            lista.DataValueField = "nombre";
            lista.DataBind();
        }

        protected void droplist_eli_equipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            actualizar_grid_jugador();
        }

        protected void droplist_mod_equipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrar_drop_jugador();
        }

        protected void btn_modificar_Click(object sender, EventArgs e)
        {

        }

        protected void btn_registrar_Click(object sender, EventArgs e)
        {

        }

        protected void btn_eliminar_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imb = sender as ImageButton;
            GridViewRow gvr = (GridViewRow)imb.NamingContainer;
            int index = gvr.RowIndex;

            int nocamisola = Convert.ToInt32(grid_jugador_equipo.Rows[index].Cells[1].Text); //no camisola
        }
    }
}