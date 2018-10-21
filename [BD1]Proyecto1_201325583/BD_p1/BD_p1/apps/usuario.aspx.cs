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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                username = Session["usuario"].ToString();
                et_titulo.Text = "Corusac Username: " + Session["usuario"].ToString();
            }
            else
            {
                //Si el usuario no inicio secion regresar a la pagina de login
                //Response.Redirect("default.aspx");
            }
        }
        
        public void mostrarGrid()
        {
            System.Data.DataTable d = new System.Data.DataTable();
            d.Columns.Add("Col1", typeof(int));
            d.Columns.Add("Col2", typeof(string));
            d.Columns.Add("Col3", typeof(string));

            System.Data.DataRow dr = d.NewRow();
            dr[0] = 1;
            dr[1] = "hola";
            dr[2] = "ho1";
            d.Rows.Add(dr);

            grid_correos.DataSource = d;
            grid_correos.DataBind();
        }

        protected void lb_entrada_Click(object sender, EventArgs e)
        {
            int codigo = Usuario.buscar_carpeta("Entrada", username, "", 0);
            //ahora buscar todos los mensajes de esta carpeta del usuario
        }
    }
}