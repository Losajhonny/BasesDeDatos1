using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class grupos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mostrar_grupos(droplist_grupo);
                mostrar_equipos_grupo();

                //para administrador
                mostrar_equipo();
                mostrar_grupos(droplist_grupo2);
                mostrar_grupos(droplist_grupo_eliminar);
                mostrar_equipos_grupos();
                administrar();

                if(Session["rol"] != null)
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

        public static void mostrar_grupos(DropDownList lista)
        {
            lista.DataSource = Grupo.vista_grupo();
            lista.DataTextField = "nombre";
            lista.DataValueField = "nombre";
            lista.DataBind();
        }

        public void mostrar_equipos_grupo()
        {
            string grupo = (droplist_grupo.Text != null) ? droplist_grupo.SelectedValue : null;
            if (grupo != null)
            {
                Grupo.actualizar_puntos_grupo();
                grid_grupos.DataSource = Grupo.vista_equipo_por_grupo(grupo);
                grid_grupos.DataBind();
            }
        }

        protected void droplist_grupo_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrar_equipos_grupo();
        }

        
        public void mostrar_equipo()
        {
            droplist_equipo.DataSource = Equipo.vista_equipo();
            droplist_equipo.DataTextField = "nombre";
            droplist_equipo.DataValueField = "nombre";
            droplist_equipo.DataBind();
        }

        public void mostrar_equipos_grupos()
        {
            string grupo = droplist_grupo_eliminar.SelectedValue;
            grid_equipos.DataSource = Grupo.vista_equipo_grupo(grupo);
            grid_equipos.DataBind();
        }

        protected void btn_registrar_Click(object sender, EventArgs e)
        {
            string nombre = (txt_nombre_grupo.Text.Equals("")) ? null : txt_nombre_grupo.Text;
            string mensaje;
            if (nombre != null)
            {
                nombre = nombre.Replace(" ", "").ToUpper();
                bool correcto = Grupo.insertar_grupo(nombre);
                if (correcto)
                {
                    mostrar_grupos(droplist_grupo);
                    mostrar_grupos(droplist_grupo_eliminar);
                    mensaje = "mensaje('','success','Grupo: " + nombre + " agregado con exito','" + login.TOP_END_BIG.ToString() + "')";
                    txt_nombre_grupo.Text = "";
                    //registro con exito
                }
                else
                {
                    mensaje = "mensaje('','error','El Grupo: " + nombre + " ya existe','" + login.TOP_END_BIG.ToString() + "')";
                    //error al registrar ya existe el usuario
                }
            }
            else
            {
                mensaje = "mensaje('','info','Debe llenar el campo Nombre Grupo','" + login.TOP_END_BIG.ToString() + "')";
                //parametros obligatorios
            }
            ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
        }

        protected void btn_asignar_Click(object sender, EventArgs e)
        {
            string equipo = droplist_equipo.SelectedValue;
            string grupo = droplist_grupo.SelectedValue;
            bool correcto = Grupo.asignar_grupo(equipo, grupo);
            string mensaje;
            if (correcto)
            {
                mostrar_equipos_grupos();
                mensaje = "mensaje('','success','Equipo: " + equipo + " asignado al Grupo: " + grupo + "','" + login.TOP_END_BIG.ToString() + "')";
            }
            else
            {
                mensaje = "mensaje('','error','El Equipo: " + equipo + " ya existe en el Grupo: " + grupo + "','" + login.TOP_END_BIG.ToString() + "')";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
        }

        protected void btn_eliminar_asignacion_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imb = sender as ImageButton;
            GridViewRow gvr = (GridViewRow)imb.NamingContainer;
            int index = gvr.RowIndex;

            string equipo = grid_equipos.Rows[index].Cells[1].Text;
            string grupo = droplist_grupo_eliminar.SelectedValue;

            bool correcto = Grupo.eliminar_asignacion_grupo(equipo, grupo);
            string mensaje;
            if (correcto)
            {
                mostrar_equipos_grupos();
                mensaje = "mensaje('','success','Equipo: " + equipo + " eliminado','" + login.TOP_END_BIG.ToString() + "')";
            }
            else
            {
                mensaje = "mensaje('','error','Error al eliminar el equipo','" + login.TOP_END_BIG.ToString() + "')";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
        }

        protected void droplist_grupo_eliminar_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrar_equipos_grupos();
        }

        protected void droplist_abc_SelectedIndexChanged(object sender, EventArgs e)
        {
            administrar();
        }

        public void administrar()
        {
            if (droplist_abc.SelectedIndex == 0)
            {
                panel_registrar_grupo.Visible = true;
                panel_agregar_equipo.Visible = false;
                panel_eliminar_equipo.Visible = false;
            }
            else if (droplist_abc.SelectedIndex == 1)
            {
                panel_registrar_grupo.Visible = false;
                panel_agregar_equipo.Visible = true;
                panel_eliminar_equipo.Visible = false;
            }
            else
            {
                panel_registrar_grupo.Visible = false;
                panel_agregar_equipo.Visible = false;
                panel_eliminar_equipo.Visible = true;
            }
        }
    }
}