using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class sitio : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_equipos_Click(object sender, EventArgs e)
        {
            Response.Redirect("equipos.aspx");
        }

        protected void btn_jugadores_Click(object sender, EventArgs e)
        {
            Response.Redirect("jugadores.aspx");
        }

        protected void btn_grupo_Click(object sender, EventArgs e)
        {
            Response.Redirect("grupos.aspx");
        }

        protected void btn_partidos_Click(object sender, EventArgs e)
        {
            Response.Redirect("partidos.aspx");
        }

        protected void btn_estadistica_Click(object sender, EventArgs e)
        {
            Response.Redirect("goleadores.aspx");
        }

        protected void btn_participantes_Click(object sender, EventArgs e)
        {
            Response.Redirect("participantes.aspx");
        }

        protected void btn_image_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["rol"] != null)
            {
                if (Session["rol"].ToString().Equals("administrador"))
                {
                    Response.Redirect("administrador.aspx");
                }
                else
                {
                    Response.Redirect("usuario.aspx");
                }
            }
            else
            {
                Response.Redirect("sitio.aspx");
            }
        }

        protected void btn_ultimoreporte_Click(object sender, EventArgs e)
        {
            Response.Redirect("puntos_otor_equipos.aspx");
        }

        protected void btn_general_Click(object sender, EventArgs e)
        {
            Response.Redirect("posiciones_generales.aspx");
        }
    }
}