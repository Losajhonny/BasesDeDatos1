using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BD_p1.apps
{
    public partial class usuario : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                et_cuenta.Text = Session["cuenta"].ToString();
            }
            else
            {
                et_cuenta.Text = "corusac@dominio.com";
            }
        }

        protected void lb_redactar_Click(object sender, EventArgs e)
        {
            Response.Redirect("redactar.aspx");
        }

        protected void lb_iniciouser_Click(object sender, EventArgs e)
        {
            Response.Redirect("usuario.aspx");
        }

        protected void Lb_salir_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("default.aspx");
        }
    }
}