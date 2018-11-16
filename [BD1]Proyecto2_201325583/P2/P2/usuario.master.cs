using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class usuario1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("sitio.aspx");
        }

        protected void btn_image_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("usuario.aspx");
        }
    }
}