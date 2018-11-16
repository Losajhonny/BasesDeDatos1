using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class jugadores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                abcjugadores.mostrar_equipo(droplist_equipo);
                grid_jugador();
            }
        }

        protected void droplist_equipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            grid_jugador();
        }

        public void grid_jugador()
        {
            string equipo = droplist_equipo.Text;
            grid_jugadores.DataSource = Jugador.vista_jugador_equipo(equipo);
            grid_jugadores.DataBind();
        }
    }
}