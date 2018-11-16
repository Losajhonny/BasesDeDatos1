using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class partidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                grupos.mostrar_grupos(droplist_grupo2);
                mostrar_equipo(droplist_equipo1);
                mostrar_equipo(droplist_equipo);
                mostrar_jugador();
                mostrar_partido();

                mostrar_vista_resultados();
                mostrar_vista_partidos();
                if (Session["rol"] != null)
                {
                    if (Session["rol"].ToString().Equals("administrador"))
                    {
                        panel_administrador.Visible = true;
                    }
                    else
                    {
                        panel_administrador.Visible = false;
                    }
                }
            }
        }

        public void mostrar_equipo(DropDownList lista)
        {
            lista.DataSource = Equipo.vista_equipo();
            lista.DataTextField = "nombre";
            lista.DataValueField = "nombre";
            lista.DataBind();
        }

        public void mostrar_partido()
        {
            droplist_equipo_par1.DataSource = Partido.vista_partido();
            droplist_equipo_par1.DataTextField = "partido";
            droplist_equipo_par1.DataValueField = "partido";
            droplist_equipo_par1.DataBind();
        }

        public void mostrar_jugador()
        {
            if(droplist_equipo.SelectedIndex != -1){
                droplist_jugador.DataSource = Jugador.vista_jugador_equipo_camisola(droplist_equipo.SelectedValue);
                droplist_jugador.DataTextField = "NoCamisola";
                droplist_jugador.DataValueField = "NoCamisola";
                droplist_jugador.DataBind();
            }
        }

        public void mostrar_vista_resultados()
        {
            string equipo = (droplist_equipo1.Text != null) ? droplist_equipo1.SelectedValue : null;
            if (equipo != null)
            {
                grid_resultados.DataSource = Equipo.vista_resultados_equipo(equipo);
                grid_resultados.DataBind();
            }
        }

        public void mostrar_vista_partidos()
        {
            string grupo = (droplist_grupo2.Text != null) ? droplist_grupo2.SelectedValue : null;
            if (grupo != null)
            {
                grid_partidos.DataSource = Partido.vista_partidos_sjugar(grupo);
                grid_partidos.DataBind();
            }
        }

        protected void droplist_equipo2_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrar_vista_partidos();
        }

        protected void droplist_equipo1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (droplist_equipo1.SelectedIndex != -1)
            {
                mostrar_vista_resultados();
                string mensaje = "mensaje('','info','Resultados de: "+droplist_equipo1.SelectedValue+"','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        protected void droplist_abc_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (droplist_abc.SelectedIndex)
            {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    panel_marcador_real.Visible = true;
                    panel_registrar_pronostico.Visible = false;
                    panel_registro_goles.Visible = false;
                    break;
                case 4:
                    panel_marcador_real.Visible = false;
                    panel_registrar_pronostico.Visible = true;
                    panel_registro_goles.Visible = false;
                    break;
                case 5:
                    panel_marcador_real.Visible = false;
                    panel_registrar_pronostico.Visible = false;
                    panel_registro_goles.Visible = true;
                    break;
                default:
                    break;
            }
        }

        protected void droplist_equipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrar_jugador();
        }

        protected void btn_registrar_goles_Click(object sender, EventArgs e)
        {
            if (droplist_equipo.SelectedIndex != -1 && droplist_jugador.SelectedIndex != -1)
            {
                Jugador.actualizar_goles(droplist_equipo.SelectedValue, Convert.ToInt32(droplist_jugador.SelectedValue));
                string mensaje = "mensaje('','info','Gol de jugador actualizado','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        protected void droplist_equipo_pro1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void btn_registrar_par_Click(object sender, EventArgs e)
        {
            if (droplist_equipo_par1.SelectedIndex != -1 && !txt_mar1_par.Text.Equals("") && !txt_mar2_par.Text.Equals(""))
            {
                string[] delimit = { "vs" };
                string[] datos = droplist_equipo_par1.SelectedValue.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
                
                string equipo1 = datos[0].Replace(" ", "");
                string equipo2 = datos[1].Replace(" ", "");

                int mar1 = Convert.ToInt32(txt_mar1_par.Text);
                int mar2 = Convert.ToInt32(txt_mar2_par.Text);

                Partido.modificar_marcador_real(mar1, mar2, equipo1, equipo2);
                mostrar_vista_resultados();
                mostrar_vista_partidos();

                string m = equipo1 + " " + mar1.ToString() + " vs " + mar2.ToString() + " " + equipo2;
                string mensaje = "mensaje('','info','" + m + " actualizado','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }
    }
}