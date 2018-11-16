using System;
using Datos;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class equiposadmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Obtener lista de Confederacion1
                mostrar_confederacion(droplist_confede1);
                //Obtener lista de Confederacion2
                mostrar_confederacion(droplist_confede2);
                //Obtener lista de Equipos
                mostrar_equipo();
                //Obtener lista de Equipos a eliminar
                mostrar_equipos_eliminar();
                string mensaje = "mensaje('','info','ABC Equipos','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        public void mostrar_equipos_eliminar()
        {
            grid_equipos.DataSource = Equipo.vista_confede_y_equipo();
            grid_equipos.DataBind();
        }

        public void mostrar_confederacion(DropDownList lista)
        {
            lista.DataSource = Equipo.vista_confederacion();
            lista.DataTextField = "nombre";
            lista.DataValueField = "nombre";
            lista.DataBind();
        }

        public void mostrar_equipo()
        {
            droplist_equipo.DataSource = Equipo.vista_equipo();
            droplist_equipo.DataTextField = "nombre";
            droplist_equipo.DataValueField = "nombre";
            droplist_equipo.DataBind();
        }

        protected void Check_select_con_CheckedChanged(object sender, EventArgs e)
        {
            if (check_select_con.Checked)
            {
                Label5.Visible = true;
                droplist_confede1.Visible = true;
                Label4.Enabled = false;
                txt_registrar_confede.Enabled = false;

            }
            else
            {
                Label5.Visible = false;
                droplist_confede1.Visible = false;
                Label4.Enabled = true;
                txt_registrar_confede.Enabled = true;
            }
        }

        protected void check_modequipo_CheckedChanged(object sender, EventArgs e)
        {
            if (check_modequipo.Checked)
            {
                Label9.Visible = true;
                droplist_confede2.Visible = true;
                Label8.Enabled = false;
                txt_modificar_confede.Enabled = false;
            }
            else
            {
                Label9.Visible = false;
                droplist_confede2.Visible = false;
                Label8.Enabled = true;
                txt_modificar_confede.Enabled = true;
            }
        }

        protected void btn_eliminar_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imb = sender as ImageButton;
            GridViewRow gvr = (GridViewRow)imb.NamingContainer;
            int index = gvr.RowIndex;
            string equipo = grid_equipos.Rows[index].Cells[2].Text;
            bool correcto = Equipo.eliminar_equipo(equipo);

            string mensaje;
            if (correcto)
            {
                mensaje = "mensaje('','success','" + equipo + " eliminado','" + login.TOP_END_BIG.ToString() + "')";
                mostrar_equipos_eliminar();
                mostrar_equipo();
                mostrar_confederacion(droplist_confede2);
                mostrar_confederacion(droplist_confede1);
            }
            else
            {
                mensaje = "mensaje('','error','Error al eliminar a " + equipo + "','" + login.TOP_END_BIG.ToString() + "')";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
        }

        protected void btn_modificar_Click(object sender, EventArgs e)
        {
            string equipo = droplist_equipo.SelectedValue;
            string confederacion = (check_modequipo.Checked) ? droplist_confede2.SelectedValue : txt_modificar_confede.Text;
            confederacion = (confederacion.Equals("")) ? null : confederacion;
            string nequipo = (txt_modificar_nombre.Text.Equals("")) ? null : txt_modificar_nombre.Text;
            string mensaje;
            if (confederacion != null && nequipo != null)
            {
                int codigo = Equipo.buscar_equipo(equipo);
                bool correcto = Equipo.modificar_equipo(codigo, nequipo, confederacion);

                if (correcto)
                {
                    mensaje = "mensaje('','success','Modificacion con exito','" + login.TOP_END_BIG.ToString() + "')";
                    mostrar_equipo();
                    mostrar_confederacion(droplist_confede2);
                    mostrar_confederacion(droplist_confede1);
                    txt_modificar_confede.Text = "";
                    txt_modificar_nombre.Text = "";
                }
                else
                {
                    mensaje = "mensaje('','error','No se logro modificar el equipo','" + login.TOP_END_BIG.ToString() + "')";
                }
            }
            else
            {
                mensaje = "mensaje('','info','Debe llenar todos los campos de Modificar','" + login.TOP_END_BIG.ToString() + "')";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
        }

        protected void btn_registrar_Click(object sender, EventArgs e)
        {
            string confederacion = (check_select_con.Checked) ? droplist_confede1.SelectedValue : txt_registrar_confede.Text;
            confederacion = (confederacion.Equals("")) ? null : confederacion;
            string equipo = (txt_registrar_nombre.Text.Equals("")) ? null : txt_registrar_nombre.Text;
            string mensaje = "";
            if (confederacion != null && equipo != null)
            {
                bool correcto = Equipo.insertar_equipo(equipo, confederacion);
                if (correcto)
                {
                    mensaje = "mensaje('','success','Equipo agregado con exito','" + login.TOP_END_BIG.ToString() + "')";
                    mostrar_equipo();
                    mostrar_confederacion(droplist_confede2);
                    mostrar_confederacion(droplist_confede1);
                    txt_registrar_confede.Text = "";
                    txt_registrar_nombre.Text = "";
                }
                else
                {
                    mensaje = "mensaje('','error','No se pudo agregar un nuevo Equipo','" + login.TOP_END_BIG.ToString() + "')";
                }
            }
            else
            {
                mensaje = "mensaje('','info','Debe llenar todos los campos de Modificar','" + login.TOP_END_BIG.ToString() + "')";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
        }

        protected void droplist_confede1_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_registrar_confede.Text = droplist_confede1.SelectedValue;
        }

        protected void droplist_confede2_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_modificar_confede.Text = droplist_confede2.SelectedValue;
        }

        protected void droplist_equipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_modificar_nombre.Text = droplist_equipo.SelectedValue;
        }
    }
}