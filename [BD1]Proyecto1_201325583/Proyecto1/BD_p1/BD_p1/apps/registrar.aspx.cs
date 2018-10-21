using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BD_p1.apps
{
    public partial class registrar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");
        }

        protected void btn_registrar_Click(object sender, EventArgs e)
        {
            if (txt_nombre.Text.Equals(string.Empty) || txt_usuario.Text.Equals(string.Empty)
                || txt_dominio.Text.Equals(string.Empty) || txt_password.Text.Equals(string.Empty))
            {
                _default.MessageBox("Campos obligatorios: Nombre, Id de Usuario, Dominio, Password", Page, this.GetType());
            }
            else
            {
                bool usr_existe = Usuario.existe_usuario(this.txt_usuario.Text);
                if (!usr_existe)
                {
                    Usuario.crear_usuario(txt_nombre.Text, txt_empresa.Text, txt_usuario.Text, txt_dominio.Text, txt_password.Text);
                    //Session["usuario"] = txt_usuario.Text;
                    Session["cuenta"] = txt_usuario.Text + "@" + txt_dominio.Text + ".com";
                    Session["carpeta"] = "entrada";
                    Response.Redirect("usuario.aspx");
                }
                else
                {
                    _default.MessageBox("El identificador del usuario ya existe", Page, this.GetType());
                }
            }
        }
    }
}