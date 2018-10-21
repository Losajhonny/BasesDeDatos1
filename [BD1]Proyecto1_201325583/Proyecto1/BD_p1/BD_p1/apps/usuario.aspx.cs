using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BD_p1.apps
{
    public partial class usuario1 : System.Web.UI.Page
    {
        private string username = "";
        private string nombre_carpeta = "";
        //private int cod_carpeta = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["usuario"] != null)
            if (Session["cuenta"] != null)
            {
                //username = Session["usuario"].ToString();
                //et_titulo.Text = "Corusac Username: " + Session["usuario"].ToString();
                string[] credencial = redactar.obtener_credencial(Session["cuenta"].ToString());
                username = credencial[0];
                nombre_carpeta = Session["carpeta"].ToString();
                et_titulo.Text = "";
                int carpeta = Carpeta.obtener_carpeta(nombre_carpeta, credencial[0], null, 0);
                if (!Page.IsPostBack)
                {
                    mostrarGrid(carpeta);
                }
                List<string[]> lista = Usuario.vista_correos(carpeta);
                for (int i = 0; i < grid_correos.Rows.Count; i++)
                {
                    if (lista.Count > 0)
                    {
                        CheckBox ch = (CheckBox)grid_correos.Rows[i].FindControl("CheckBox1");
                        if (Convert.ToInt32(lista[i][1]) == 0)
                        {
                            ch.Checked = false;
                            ch.Text = "No leido";
                        }
                        else
                        {
                            ch.Checked = true;
                            ch.Text = "Leido";
                        }
                    }
                }
            }
            else
            {
                //Si el usuario no inicio secion regresar a la pagina de login
                //Response.Redirect("default.aspx");
            }
        }
        
        public void mostrarGrid(int carpeta)
        {
            List<string[]> lista = Usuario.vista_correos(carpeta);

            System.Data.DataTable d = new System.Data.DataTable();
            //d.Columns.Add("Estado", typeof(string));
            d.Columns.Add("Nombre", typeof(string));
            d.Columns.Add("Asunto", typeof(string));
            d.Columns.Add("Fecha", typeof(string));

            for (int i = 0; i < lista.Count; i++)
            {
                System.Data.DataRow dr = d.NewRow();
                dr[0] = lista[i][2];
                dr[1] = lista[i][3];
                dr[2] = lista[i][4];
                d.Rows.Add(dr);
            }

            grid_correos.DataSource = d;
            grid_correos.DataBind();
        }

        protected void lb_entrada_Click(object sender, EventArgs e)
        {
            //int codigo = Carpeta.obtener_carpeta("Entrada", username, "", 0);
            //ahora buscar todos los mensajes de esta carpeta del usuario
            
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["cuenta"] != null)
            {
                ImageButton imb = sender as ImageButton;
                GridViewRow gvr = (GridViewRow)imb.NamingContainer;
                int index = gvr.RowIndex;

                string[] credencial = redactar.obtener_credencial(Session["cuenta"].ToString());
                int carpeta = Carpeta.obtener_carpeta(Session["carpeta"].ToString(), credencial[0], null, 0);
                List<string[]> lista = Usuario.vista_correos(carpeta);

                Session["msg"] = lista[index];
                Response.Redirect("vista_correo.aspx");
                //seleccionamos la fila
                //grid_correos.SelectedIndex = i;
            }
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["cuenta"] != null)
            {
                ImageButton imb = sender as ImageButton;
                GridViewRow gvr = (GridViewRow)imb.NamingContainer;
                int index = gvr.RowIndex;
                //obteniendo credenciales
                int carpeta = Carpeta.obtener_carpeta(nombre_carpeta, username, null, 0);
                List<string[]> lista = Usuario.vista_correos(carpeta);

                if (!nombre_carpeta.Equals("eliminados"))
                {//Si se desea eliminar correo de una carpeta que no sea de la carpeta de eliminados
                    //mover a la carpeta de eliminar
                    Mensaje.mover_aEliminar(username, Convert.ToInt32(lista[index][0]));
                }
                else
                {
                    //eliminar correo en la carpeta eliminados
                    Mensaje.eliminar_msg(Convert.ToInt32(lista[index][0]));
                }
                Response.Redirect("usuario.aspx");
            }
        }

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (Session["cuenta"] != null)
            {
                CheckBox imb = sender as CheckBox;
                GridViewRow gvr = (GridViewRow)imb.NamingContainer;
                int index = gvr.RowIndex;
                //obteniendo la cuenta
                int carpeta = Carpeta.obtener_carpeta(nombre_carpeta, username, null, 0);
                List<string[]> lista = Usuario.vista_correos(carpeta);

                if (Convert.ToInt32(lista[index][1]) == 0)
                {
                    Mensaje.cambiarEstado(1, Convert.ToInt32(lista[index][0]));
                }
                else
                {
                    Mensaje.cambiarEstado(0, Convert.ToInt32(lista[index][0]));
                }

                lista = Usuario.vista_correos(carpeta);
                if (Convert.ToInt32(lista[index][1]) == 0)
                {
                    imb.Checked = false;
                    imb.Text = "No leido";
                }
                else
                {
                    imb.Checked = true;
                    imb.Text = "Leido";
                }
            }
        }
    }
}