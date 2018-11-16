using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class administrador1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_jugadores_Click(object sender, EventArgs e)
        {
            Response.Redirect("abcjugadores.aspx");
        }

        protected void btn_carga_masiva_Click(object sender, EventArgs e)
        {
            Response.Redirect("carga.aspx");
        }

        protected void btn_image_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("administrador.aspx");
        }
    }
}