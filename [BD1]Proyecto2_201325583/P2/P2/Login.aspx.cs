using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class login : System.Web.UI.Page
    {
        public static int TOP_END_LITTLE = 0;
        public static int TOP_END_BIG = 1;
        public static int NORMAL = 2;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string username = (txt_usuario.Text.Equals(string.Empty)) ? null : txt_usuario.Text;
            string mensaje = "";
            if (username != null)
            {
                bool existe = Usuario.loguear(username, droplist.SelectedValue);
                if (existe)
                {
                    txt_usuario.Text = "";
                    //mensaje = "mensaje('Usuario correcto','success','Usuario valido','"+NORMAL.ToString()+"')";
                    //ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
                    Session["username"] = username;
                    if (droplist.SelectedValue.ToLower().Equals("administrador"))
                    {
                        Session["rol"] = "administrador";
                        Response.Redirect("administrador.aspx");
                    }
                    else
                    {
                        Session["rol"] = "usuario";
                        Response.Redirect("usuario.aspx");
                    }
                }
                else
                {
                    //error de loguear
                    mensaje = "mensaje('','error','Usuario incorrecto','" + TOP_END_BIG.ToString() + "')";
                    ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
                }
            }
            else
            {
                mensaje = "mensaje('','error','Username es obligatorio','"+ TOP_END_BIG.ToString() +"')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            Response.Redirect("sitio.aspx");
        }
    }
}