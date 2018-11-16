using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class registrar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e){  }

        protected void btn_registrar_Click(object sender, EventArgs e)
        {
            if (droplist_pagado.SelectedValue.ToLower().Equals("pagar")) { Usuario.monto_pagado = true; }
            else { Usuario.monto_pagado = false; }
            string nombre = (txt_nombre.Text.Equals(string.Empty))?null:txt_nombre.Text;
            int edad = -1;
            try { edad = (txt_edad.Text.Equals(string.Empty)) ? -1 : Convert.ToInt32(txt_edad.Text); }
            catch (Exception ex) {  }
            string pais = (txt_pais.Text.Equals(string.Empty))?null:txt_pais.Text;

            if (nombre != null && edad != -1 && pais != null)
            {
                if (Usuario.insertar_participante(nombre, null, edad, Usuario.monto_pagado, false, pais))
                {
                    //redireccionar a otra pagina
                    txt_nombre.Text = "";
                    txt_edad.Text = "";
                    txt_pais.Text = "";
                    Usuario.monto_pagado = false;
                    Session["username"] = nombre;
                    Session["rol"] = "usuario";
                    Response.Redirect("usuario.aspx");
                }
                else
                {
                    string mensaje = "mensaje('','error','Error al registrar el usuario','" + login.TOP_END_BIG.ToString() + "')";
                    ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
                }
            }
            else
            {
                string mensaje = "mensaje('','info','Los campos son obligatorios','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            Usuario.monto_pagado = false;
            Response.Redirect("sitio.aspx");
        }

        protected void droplist_pagado_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (droplist_pagado.SelectedValue.ToLower().Equals("pagar"))
            {
                string mensaje = "mensaje('','info','Monto Pagado','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }
    }
}